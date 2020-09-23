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
        body: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                scrollDirection: Axis.horizontal,
                slivers: [
                  SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 8),
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return Container(
                        color:
                            Colors.primaries[index % Colors.primaries.length],
                      );
                    }, childCount: 20),
                  )
                ],
              ),
              flex: 2,
            ),
            Expanded(child: Text('data')),
          ],
        ));
  }
}
