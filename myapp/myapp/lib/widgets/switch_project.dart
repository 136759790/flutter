import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/db/db_manager.dart';
import 'package:myapp/models/project.dart';

class SwitchProject extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SwitchProjectState();
  }
}

class SwitchProjectState extends State<SwitchProject> {
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddProject()));
              },
              child: Icon(Icons.add),
            ),
          )
        ],
      ),
      body: CustomScrollView(
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
                        content: Text('要切换到项目【旋转小火锅吗】?'),
                        actions: [
                          FlatButton(
                              onPressed: () => Navigator.pop(context, "cancel"),
                              child: Text('取消')),
                          FlatButton(
                            onPressed: () => Navigator.pop(context, "cancel"),
                            child: Text('确定'),
                          ),
                        ],
                      ));
                },
                child: Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.access_alarm),
                        trailing: Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                        ),
                        title: Text('旋转小火锅'),
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
            }, childCount: 10)),
          ))
        ],
      ),
    );
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
                              [name, ctime]);
                        }).then((value) {
                          showDialog(
                              context: context,
                              child: AlertDialog(
                                content: Text('保存成功'),
                                actions: [
                                  FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('确定')),
                                ],
                              ));
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
