import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/api/hair.dart';

class ShopEdit extends StatefulWidget {
  ShopEdit({Key key}) : super(key: key);

  @override
  _ShopEditState createState() => _ShopEditState();
}

class _ShopEditState extends State<ShopEdit> {
  TextEditingController _name = TextEditingController();
  TextEditingController _ctime = TextEditingController(
      text: DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()));
  GlobalKey _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('编辑店铺'),
        ),
        body: Stack(children: [
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
                            labelText: '店铺名称',
                            prefixIcon: Icon(Icons.shop)),
                        validator: (value) =>
                            value.trim().isNotEmpty ? null : '店铺名称不能为空',
                      ),
                      Divider(),
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
                  _saveShop(name, ctime.millisecondsSinceEpoch / 1000);
                }
              },
              child: Text(
                '保存',
                style: TextStyle(color: Colors.white),
              ),
              color: Theme.of(context).primaryColor,
            ),
          )
        ]));
  }

  void _saveShop(var name, var ctime) {
    HairApi.saveShop({'name': name, 'ctime': ctime}).then((value) {
      Navigator.of(context).pop();
    });
  }
}
