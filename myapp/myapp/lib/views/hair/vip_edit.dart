import 'package:flutter/material.dart';
import 'package:myapp/api/hair.dart';
import 'package:myapp/common/notifier.dart';
import 'package:myapp/models/hair/vip.dart';
import 'package:provider/provider.dart';

class VipEdit extends StatefulWidget {
  int id;
  VipEdit({this.id});

  @override
  _VipEditState createState() => _VipEditState();
}

class _VipEditState extends State<VipEdit> {
  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      HairApi.getVip(widget.id)
          .then((vip) => {_name.text = vip.name, _phone.text = vip.phone});
    }
  }

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
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                width: 1000,
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
              ),
              Container(
                width: 1000,
                child: FlatButton(
                  onPressed: () {},
                  child: Text(
                    '删除',
                  ),
                  color: Colors.grey[400],
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
      'id': widget.id,
      'name': _name.text,
      'phone': _phone.text,
      'shop_id': Provider.of<ShopModel>(context, listen: false).shop.id
    };
    HairApi.saveVip(data).then((value) {
      Navigator.of(context).pop(true);
    });
  }
}
