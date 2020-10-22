import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:myapp/common/eventBus.dart';
import 'package:myapp/common/notifier.dart';
import 'package:myapp/db/db_manager.dart';
import 'package:myapp/models/project.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class SwitchProject extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SwitchProjectState();
  }
}

class SwitchProjectState extends State<SwitchProject> {
  Future future;
  @override
  void initState() {
    super.initState();
    future = _futureProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('项目列表'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 30),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddProject(),
                            maintainState: false))
                    .then((value) {
                  setState(() {
                    future = _futureProjects();
                  });
                });
              },
              child: Icon(Icons.add),
            ),
          )
        ],
      ),
      body: FutureBuilder<dynamic>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<Map<String, dynamic>> result = snapshot.data;
              return CustomScrollView(
                slivers: [
                  SliverSafeArea(
                      sliver: SliverPadding(
                    padding: EdgeInsets.all(8),
                    sliver: SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                      return GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              child: AlertDialog(
                                title: Text('提示'),
                                content:
                                    Text('要切换到项目【${result[index]['name']}】?'),
                                actions: [
                                  FlatButton(
                                      onPressed: () =>
                                          Navigator.pop(context, false),
                                      child: Text('取消')),
                                  FlatButton(
                                    onPressed: () {
                                      bus.fire(AccountRefreshEvent());
                                      Navigator.pop(context, true);
                                    },
                                    child: Text('确定'),
                                  ),
                                ],
                              )).then((value) {
                            if (value) {
                              Provider.of<ProjectModel>(context, listen: false)
                                  .project = Project.fromJson(result[index]);
                              Navigator.of(context).pop();
                            }
                          });
                        },
                        child: Card(
                          child: Column(
                            children: [
                              ListTile(
                                leading: Icon(Icons.access_alarm),
                                trailing: IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          child: AlertDialog(
                                            title: Text('提醒'),
                                            content: Text(
                                                '确认要删除项目【${result[index]['name']}】'),
                                            actions: [
                                              FlatButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, false),
                                                  child: Text('取消')),
                                              FlatButton(
                                                onPressed: () => Navigator.pop(
                                                    context, true),
                                                child: Text('确定'),
                                              ),
                                            ],
                                          )).then((value) async {
                                        if (value) {
                                          var re = await _deleteProject(
                                              result[index]['id']);
                                          print('object$re');
                                          setState(() {
                                            future = _futureProjects();
                                          });
                                        }
                                      });
                                    },
                                    icon: Icon(Icons.delete),
                                    color: Colors.red),
                                title: Text(result[index]['name']),
                              ),
                              Divider(),
                              ListTile(
                                title: Text('本月支出：96732元'),
                              ),
                              ListTile(
                                title: Text('本月营收：96732元'),
                              )
                            ],
                          ),
                        ),
                      );
                    }, childCount: result.length)),
                  ))
                ],
              );
            } else {
              return Padding(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Future _deleteProject(int id) async {
    Database db = await DBManager.getDb();
    var result = await db.rawDelete("delete from project where id =$id");
    return result;
  }

  Future<List<Map<String, dynamic>>> _futureProjects() async {
    Database db = await DBManager.getDb();
    var result = await db.rawQuery("select * from project order by ctime desc");
    print(result);
    return result;
  }
}

class AddProject extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddProjectState();
  }
}

class AddProjectState extends State<AddProject> {
  TextEditingController _name = TextEditingController();
  TextEditingController _ctime = TextEditingController(
      text: DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()));
  GlobalKey _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('创建项目'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
            key: _formKey,
            autovalidate: true,
            child: Column(
              children: [
                TextFormField(
                  controller: _name,
                  autofocus: false,
                  decoration: InputDecoration(
                      labelText: '项目名称', prefixIcon: Icon(Icons.near_me)),
                  validator: (value) =>
                      value.trim().isNotEmpty ? null : '项目名称不能为空',
                ),
                TextFormField(
                  controller: _ctime,
                  readOnly: true,
                  onTap: () async {
                    DateTime date = await showDatePicker(
                      context: context,
                      initialDate: new DateTime.now(),
                      firstDate: new DateTime.now()
                          .subtract(new Duration(days: 30)), // 减 30 天
                      lastDate: new DateTime.now()
                          .add(new Duration(days: 30)), // 加 30 天
                    );
                    if (date != null) {
                      _ctime.text =
                          DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
                    }
                  },
                  decoration: InputDecoration(
                      labelText: '创建时间', prefixIcon: Icon(Icons.nature_people)),
                  validator: (value) =>
                      value.trim().isNotEmpty ? null : '创建时间不能为空',
                ),
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: FlatButton(
                    onPressed: () {
                      if ((_formKey.currentState as FormState).validate()) {
                        DateTime ctime = DateFormat('yyyy-MM-dd HH:mm:ss')
                            .parse(_ctime.text);
                        String name = _name.text;
                        DBManager.getDb().then((db) {
                          db.rawInsert(
                              'insert into project(name,ctime)values(?,?)',
                              [name, ctime.millisecondsSinceEpoch]);
                        }).then((value) {
                          Fluttertoast.showToast(msg: "保存成功").then((value) {
                            Navigator.of(context).pop(true);
                          });
                        });
                      }
                    },
                    child: Text('保存'),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
