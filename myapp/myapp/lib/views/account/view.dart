import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class AccountView extends StatefulWidget {
  AccountView({Key key, this.account}) : super(key: key);
  var account;

  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('详情'),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    print("666666666${widget.account}");
    DateFormat df = DateFormat('yyyy-MM-dd');
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(30, 10, 20, 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '类型：',
                      style: _keyTextStyle(),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Text(
                      '收入',
                      style: _valueTextStyle(),
                    ),
                    flex: 4,
                  )
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '金额：',
                      style: _keyTextStyle(),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Text(
                      '${widget.account.value}',
                      style: _valueTextStyle(),
                    ),
                    flex: 4,
                  )
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '日期：',
                      style: _keyTextStyle(),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Text(
                      '${df.format(DateTime.fromMillisecondsSinceEpoch(widget.account.ctime))}',
                      style: _valueTextStyle(),
                    ),
                    flex: 4,
                  )
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '备注：',
                      style: _keyTextStyle(),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Text(
                      '${widget.account.remark}',
                      style: _valueTextStyle(),
                    ),
                    flex: 4,
                  )
                ],
              ),
            ),
            Divider(),
          ],
        ),
      ),
      Positioned(
        bottom: 30,
        height: 50,
        left: 20,
        right: 20,
        child: Row(children: [
          Expanded(
              child: Container(
                  child: RaisedButton(
            child: Text(
              '编辑',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            onPressed: () {},
            elevation: 5,
          ))),
          Expanded(
              child: Container(
                  child: RaisedButton(
            color: Colors.red,
            child: Text(
              '删除',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            onPressed: () {},
            elevation: 5,
          ))),
        ]),
      ),
    ]);
  }

  TextStyle _keyTextStyle() {
    return TextStyle(fontSize: 18, color: Colors.grey);
  }

  TextStyle _valueTextStyle() {
    return TextStyle(fontSize: 18);
  }
}
