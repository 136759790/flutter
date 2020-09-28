import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/api/user.dart';
import 'package:myapp/common/notifier.dart';
import 'package:myapp/models/user.dart';
import 'package:provider/provider.dart';

class LoginRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  GlobalKey _formKey = new GlobalKey<FormState>();
  TextEditingController _uname = TextEditingController();
  TextEditingController _pwd = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Column(
            children: [
              TextFormField(
                controller: _uname,
                decoration: InputDecoration(
                    labelText: '手机号',
                    hintText: '请输入手机号码',
                    prefixIcon: Icon(Icons.person)),
                validator: (value) =>
                    value.trim().isNotEmpty ? null : '手机号码不能为空',
              ),
              TextFormField(
                controller: _pwd,
                decoration: InputDecoration(
                    labelText: '密码',
                    hintText: '请输入密码',
                    prefixIcon: Icon(Icons.visibility_off)),
                validator: (value) => value.trim().isNotEmpty ? null : '密码不能为空',
              ),
              Padding(
                padding: EdgeInsets.all(40),
                child: FlatButton(
                  onPressed: () {
                    if ((_formKey.currentState as FormState).validate()) {
                      UserApi.login(_uname.text, _pwd.text).then((data) {
                        if (data.status == 1) {
                          Provider.of<UserModel>(context, listen: false).user =
                              new User(_uname.text, _pwd.text);
                          Navigator.pushNamed(context, 'home');
                        }
                      });
                    }
                  },
                  child: Text('登录'),
                  color: Theme.of(context).primaryColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
