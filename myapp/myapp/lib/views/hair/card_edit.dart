import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/api/hair.dart';
import 'package:myapp/models/hair/set.dart';

class ShopCard extends StatefulWidget {
  ShopCard({Key key}) : super(key: key);

  @override
  _ShopCardState createState() => _ShopCardState();
}

class _ShopCardState extends State<ShopCard> {
  List<Set> _sets = [];
  TextEditingController _name = TextEditingController();
  TextEditingController _ctime = TextEditingController(
      text: DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()));
  GlobalKey _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    HairApi.getSets({}).then((data) {
      this.setState(() {
        _sets = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('添加会员卡'),
        centerTitle: true,
      ),
      body: Builder(builder: (BuildContext context) {
        return Stack(children: [
          Positioned(
            child: Container(
              padding: EdgeInsets.all(12),
              child: Form(
                  key: _formKey,
                  autovalidate: true,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _name,
                        autofocus: false,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '姓名：',
                            prefixIcon: Icon(Icons.person)),
                        validator: (value) =>
                            value.trim().isNotEmpty ? null : '姓名不能为空',
                      ),
                      Divider(),
                      TextFormField(
                        controller: _name,
                        autofocus: false,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '手机号码：',
                            prefixIcon: Icon(Icons.phone)),
                        validator: (value) =>
                            value.trim().isNotEmpty ? null : '手机号码不能为空',
                      ),
                      Divider(),
                      TextFormField(
                        controller: _ctime,
                        readOnly: true,
                        onTap: () {
                          showBottomSheet(
                              context: context,
                              builder: (_) => Container(
                                    height: 400,
                                    child: ListView.separated(
                                      itemCount: _sets.length,
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return Divider();
                                      },
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        Set set = _sets[index];
                                        return ListTile(
                                          title: Text(set.name),
                                          subtitle: Text(set.description),
                                          trailing: Icon(Icons.touch_app),
                                        );
                                      },
                                    ),
                                  ));
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '创建时间',
                            prefixIcon: Icon(Icons.date_range)),
                        validator: (value) =>
                            value.trim().isNotEmpty ? null : '创建时间不能为空',
                      ),
                    ],
                  )),
            ),
          ),
          Positioned(
            bottom: 70,
            height: 60,
            left: 20,
            right: 20,
            child: FlatButton(
              onPressed: () {
                if ((_formKey.currentState as FormState).validate()) {
                  DateTime ctime =
                      DateFormat('yyyy-MM-dd HH:mm:ss').parse(_ctime.text);
                  String name = _name.text;
                }
              },
              child: Text(
                '保存',
                style: TextStyle(color: Colors.white),
              ),
              color: Theme.of(context).primaryColor,
            ),
          )
        ]);
      }),
    );
  }
}
