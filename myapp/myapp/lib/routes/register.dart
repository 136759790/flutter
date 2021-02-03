import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/api/user.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _account = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _password2 = TextEditingController();
  TextEditingController _nickname = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('账号注册'),
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.always,
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(40),
          child: Column(
            children: [
              TextFormField(
                controller: _account,
                validator: (value) => value.trim().isNotEmpty ? null : '账号不能为空',
                decoration: InputDecoration(
                    hintText: '请输入账号', prefixIcon: Icon(Icons.person)),
              ),
              TextFormField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: '请输入邮箱', prefixIcon: Icon(Icons.email)),
              ),
              TextFormField(
                controller: _phone,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    hintText: '请输入手机号码', prefixIcon: Icon(Icons.phone)),
              ),
              TextFormField(
                obscureText: true,
                controller: _password,
                validator: (value) => value.trim().isNotEmpty ? null : '密码不能为空',
                decoration: InputDecoration(
                    hintText: '请输入密码', prefixIcon: Icon(Icons.lock)),
              ),
              TextFormField(
                obscureText: true,
                controller: _password2,
                validator: (value) {
                  if (value != _password.text) {
                    return "两次密码不一致";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    hintText: '请再次输入密码', prefixIcon: Icon(Icons.lock)),
              ),
              Container(
                  width: 1000,
                  padding: EdgeInsets.all(10),
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        final data = {
                          "account": _account.text,
                          "password": _password.text,
                          "phone": _phone.text,
                          "email": _email.text,
                        };
                        var user = await UserApi.register(data);
                        print(user);
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('注册'),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
