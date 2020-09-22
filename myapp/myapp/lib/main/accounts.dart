import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpandAccounts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ExpandAccountsState();
}

class ExpandAccountsState extends State<ExpandAccounts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            ExpansionPanelList(
              children: [
                ExpansionPanel(
                    isExpanded: true,
                    body: Container(
                      padding: EdgeInsets.all(16.0),
                      child: Container(
                        width: 600,
                        height: 300,
                        child: MainAccounts(),
                      ),
                    ),
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: Text('data'),
                      );
                    }),
              ],
              expansionCallback: (panelIndex, isExpanded) => {},
            )
          ],
        ),
      ),
    );
  }
}

class MainAccounts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) => ListTile(
        isThreeLine: true,
        title:
            Text('支付宝、微信支付是开发中经常需要用到的功能，那么如何集成支付功能到应用中呢？支付结果亦是异步的，又如何传递结果呢？'),
        subtitle: Text('2020-09-21'),
        dense: true,
        leading: Icon(Icons.add, color: Colors.green),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {},
        onLongPress: () {},
      ),
    );
  }
}
