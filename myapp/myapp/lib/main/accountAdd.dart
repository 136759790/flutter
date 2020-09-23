import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AccountAddState();
  }
}

class AccountAddState extends State<AccountAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('记账'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => {Navigator.pop(context)}),
      ),
      body: Form(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: TextFormField(
                decoration: new InputDecoration(
                    labelText: 'Your Name', icon: Icon(Icons.person)),
                onSaved: (val) {},
              ),
            ),
            Expanded(
              child: TextFormField(
                decoration: new InputDecoration(
                  labelText: 'Your Name',
                ),
                onSaved: (val) {},
              ),
            )
          ],
        ),
      )),
    );
  }
}
