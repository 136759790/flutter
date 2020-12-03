import 'package:flutter/material.dart';
import 'package:myapp/api/hair.dart';
import 'package:myapp/common/notifier.dart';
import 'package:provider/provider.dart';

class VipEdit extends StatefulWidget {
  VipEdit({Key key}) : super(key: key);

  @override
  _VipEditState createState() => _VipEditState();
}

class _VipEditState extends State<VipEdit> {
  TextEditingController _name = TextEditingController();
  TextEditingController _phone = TextEditingController();
  GlobalKey _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('会员编辑'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 100.0, left: 50.0, right: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _name,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    filled: true,
                    counterStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.transparent,
                    border: UnderlineInputBorder(),
                    hintText: '请输入会员姓名'),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _phone,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    filled: true,
                    counterStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.transparent,
                    border: UnderlineInputBorder(),
                    hintText: '请输入会员手机'),
              ),
              Container(
                width: 1000,
                padding: EdgeInsets.all(20),
                child: FlatButton(
                  onPressed: () {
                    if ((_formKey.currentState as FormState).validate()) {
                      _saveVip();
                    }
                  },
                  child: Text(
                    '保存',
                  ),
                  color: Theme.of(context).primaryColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _saveVip() {
    var data = {
      'name': _name.text,
      'phone': _phone.text,
      'shop_id': Provider.of<ShopModel>(context, listen: false).shop.id
    };
    HairApi.saveVip(data).then((value) {
      Navigator.of(context).pop(_name.text);
    });
  }
}