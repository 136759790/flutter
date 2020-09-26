import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
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
          autovalidate: true,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    labelText: '手机号',
                    hintText: '请输入手机号码',
                    prefixIcon: Icon(Icons.person)),
                validator: (value) =>
                    value.trim().isNotEmpty ? null : '手机号码不能为空',
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: '密码',
                    hintText: '请输入密码',
                    prefixIcon: Icon(Icons.visibility_off)),
                validator: (value) => value.trim().isNotEmpty ? null : '密码不能为空',
              ),
              Padding(
                padding: EdgeInsets.all(40),
                child: FlatButton(
                  onPressed: () {},
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
