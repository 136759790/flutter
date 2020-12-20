import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  ErrorPage({this.msg});
  String msg;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('错误页面'),
      ),
      body: Center(
        child: Text(msg),
      ),
    );
  }
}
