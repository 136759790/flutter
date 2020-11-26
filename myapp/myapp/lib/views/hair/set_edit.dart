import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:myapp/api/hair.dart';
import 'package:myapp/common/notifier.dart';
import 'package:provider/provider.dart';

class SetEdit extends StatefulWidget {
  SetEdit({Key key}) : super(key: key);

  @override
  _SetEditState createState() => _SetEditState();
}

class _SetEditState extends State<SetEdit> {
  GlobalKey _formKey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _time = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('data'),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  _body() {
    return Padding(
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
                  labelText: '套餐名称',
                  prefixIcon: Icon(Icons.shop)),
              validator: (value) => value.trim().isNotEmpty ? null : '套餐名称不能为空',
            ),
            Divider(),
            TextFormField(
              controller: _price,
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              autofocus: false,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '套餐价格',
                  prefixIcon: Icon(Icons.shop)),
              validator: (value) => value.trim().isNotEmpty ? null : '套餐价格不能为空',
            ),
            Divider(),
            TextFormField(
              controller: _time,
              keyboardType: TextInputType.number,
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              autofocus: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '服务次数',
                  prefixIcon: Icon(Icons.shop)),
              validator: (value) => value.trim().isNotEmpty ? null : '服务次数不能为空',
            ),
            Divider(),
            TextFormField(
              controller: _description,
              autofocus: false,
              maxLength: 128,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '套餐简介',
                  prefixIcon: Icon(Icons.description)),
            ),
            Divider(),
            FlatButton.icon(
                color: Colors.blue,
                onPressed: _saveSet,
                icon: Icon(Icons.save),
                label: Text('保存'))
          ],
        ),
      ),
    );
  }

  _saveSet() {
    if ((this._formKey.currentState as FormState).validate()) {
      var data = {
        'shop_id': Provider.of<ShopModel>(context, listen: false).shop.id,
        'name': _name.text,
        'price': _price.text,
        'time': _time.text,
        'description': _description.text,
      };
      HairApi.saveSet(data).then((value) {
        Navigator.of(context).pop(true);
      });
    }
  }
}
