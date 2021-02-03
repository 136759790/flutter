import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/api/user.dart';
import 'package:myapp/common/notifier.dart';
import 'package:myapp/common/route.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/routes/home.dart';
import 'package:myapp/routes/register.dart';
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('登录'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: _uname,
                  decoration: InputDecoration(
                      hintText: '请输入账号', prefixIcon: Icon(Icons.person)),
                  validator: (value) =>
                      value.trim().isNotEmpty ? null : '手机号码不能为空',
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  obscureText: true,
                  controller: _pwd,
                  decoration: InputDecoration(
                      hintText: '请输入密码',
                      prefixIcon: Icon(Icons.visibility_off)),
                  validator: (value) =>
                      value.trim().isNotEmpty ? null : '密码不能为空',
                ),
              ),
              Container(
                width: 1000,
                padding: EdgeInsets.all(20),
                child: FlatButton(
                  onPressed: () async {
                    if ((_formKey.currentState as FormState).validate()) {
                      var data = await UserApi.login(_uname.text, _pwd.text);
                      if (data.status == 1) {
                        Map<String, dynamic> map = new Map.from(data.data);
                        map['password'] = _pwd.text;
                        map['account'] = _uname.text;
                        Provider.of<UserNotifier>(context, listen: false).user =
                            User.fromJson(map);
                        Provider.of<ShopModel>(context, listen: false).clear();
                        Rt.to(context, HomePage());
                      }
                    }
                  },
                  child: Text('登录'),
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Container(
                child: GestureDetector(
                  onTap: () {
                    Rt.to(context, Register());
                  },
                  child: Text(
                    '没有账号？点击注册！',
                    style: TextStyle(color: Colors.black38),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
