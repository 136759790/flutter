import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
      appBar: AppBar(
        title: Text('编辑店铺'),
      ),
      body: Container(
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
