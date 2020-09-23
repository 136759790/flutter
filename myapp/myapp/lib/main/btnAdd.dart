import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/main/accountAdd.dart';

class BtnAdd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => new AccountAdd()));
      },
      child: Icon(Icons.add),
    );
  }
}
