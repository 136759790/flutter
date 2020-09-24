import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AccountAddState();
  }
}

class AccountAddState extends State<AccountAdd>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    super.initState();
    this.tabController = TabController(length: 2, vsync: this);
  }

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
        body: Column(children: [
          TabBar(
            labelColor: Colors.blue,
            labelStyle: TextStyle(fontSize: 18),
            controller: this.tabController,
            tabs: <Widget>[
              Tab(
                text: '支出',
              ),
              Tab(
                text: '收入',
              ),
            ],
          ),
          Expanded(
              child: TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 20, 8, 10),
                child: CustomScrollView(
                  slivers: [
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 1,
                          mainAxisSpacing: 1),
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return Column(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              child: IconButton(
                                icon: Icon(
                                  Icons.scatter_plot,
                                  size: 30,
                                ),
                                onPressed: () {},
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100))),
                            ),
                            Text('餐饮')
                          ],
                        );
                      }, childCount: 50),
                    )
                  ],
                ),
              ),
              Text('data'),
            ],
            controller: this.tabController,
          )),
          Expanded(
              child: Offstage(
            offstage: false,
            child: this._keyboard(),
          ))
        ]));
  }

  Column _keyboard() {
    return Column(
      children: [
        Expanded(
            child: Row(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '备注:',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                ],
              ),
              flex: 2,
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                    hintText: '点击填写备注', border: InputBorder.none),
                autocorrect: true,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              flex: 8,
            ),
            Expanded(
              child: Text(
                '0.00',
                style: TextStyle(fontSize: 20),
              ),
              flex: 2,
            )
          ],
        )),
        Expanded(
          child: Row(
            children: [
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(border: _getBorder(true, true, true, true)),
                child: SizedBox.expand(
                  child: FlatButton(onPressed: () {}, child: Text('7')),
                ),
              )),
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(border: _getBorder(false, true, true, true)),
                child: SizedBox.expand(
                  child: FlatButton(onPressed: () {}, child: Text('8')),
                ),
              )),
              Expanded(
                  child: Container(
                decoration:
                    BoxDecoration(border: _getBorder(false, true, true, true)),
                alignment: Alignment.center,
                child: SizedBox.expand(
                  child: FlatButton(onPressed: () {}, child: Text('9')),
                ),
              )),
              Expanded(
                  child: Container(
                decoration:
                    BoxDecoration(border: _getBorder(false, true, true, true)),
                alignment: Alignment.center,
                child: SizedBox.expand(
                  child: FlatButton.icon(
                    onPressed: () {},
                    label: Text('今天'),
                    icon: Icon(Icons.date_range),
                  ),
                ),
              )),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(border: _getBorder(true, true, true, true)),
                child: SizedBox.expand(
                  child: FlatButton(onPressed: () {}, child: Text('4')),
                ),
              )),
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(border: _getBorder(false, true, true, true)),
                child: SizedBox.expand(
                  child: FlatButton(onPressed: () {}, child: Text('5')),
                ),
              )),
              Expanded(
                  child: Container(
                decoration:
                    BoxDecoration(border: _getBorder(false, true, true, true)),
                alignment: Alignment.center,
                child: SizedBox.expand(
                  child: FlatButton(onPressed: () {}, child: Text('6')),
                ),
              )),
              Expanded(
                  child: Container(
                decoration:
                    BoxDecoration(border: _getBorder(false, true, true, true)),
                alignment: Alignment.center,
                child: SizedBox.expand(
                  child: FlatButton(
                    onPressed: () {},
                    child: Icon(Icons.add),
                  ),
                ),
              )),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(border: _getBorder(true, false, true, true)),
                child: SizedBox.expand(
                  child: FlatButton(onPressed: () {}, child: Text('1')),
                ),
              )),
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(border: _getBorder(false, false, true, true)),
                child: SizedBox.expand(
                  child: FlatButton(onPressed: () {}, child: Text('2')),
                ),
              )),
              Expanded(
                  child: Container(
                decoration:
                    BoxDecoration(border: _getBorder(false, false, true, true)),
                alignment: Alignment.center,
                child: SizedBox.expand(
                  child: FlatButton(onPressed: () {}, child: Text('3')),
                ),
              )),
              Expanded(
                  child: Container(
                decoration:
                    BoxDecoration(border: _getBorder(false, false, true, true)),
                alignment: Alignment.center,
                child: SizedBox.expand(
                  child: FlatButton(
                    onPressed: () {},
                    child: Icon(Icons.remove),
                  ),
                ),
              )),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(border: _getBorder(true, false, true, true)),
                child: SizedBox.expand(
                  child: FlatButton(onPressed: () {}, child: Text('.')),
                ),
              )),
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(border: _getBorder(false, false, true, true)),
                child: SizedBox.expand(
                  child: FlatButton(onPressed: () {}, child: Text('0')),
                ),
              )),
              Expanded(
                  child: Container(
                decoration:
                    BoxDecoration(border: _getBorder(false, false, true, true)),
                alignment: Alignment.center,
                child: SizedBox.expand(
                  child: FlatButton(
                      onPressed: () {}, child: Icon(Icons.backspace)),
                ),
              )),
              Expanded(
                  child: Container(
                decoration:
                    BoxDecoration(border: _getBorder(false, false, true, true)),
                alignment: Alignment.center,
                child: SizedBox.expand(
                  child: FlatButton(
                    onPressed: () {},
                    child: Text('完成'),
                  ),
                ),
              )),
            ],
          ),
        ),
      ],
    );
  }

  Border _getBorder(bool left, bool top, bool right, bool bottom) {
    return Border(
      left: left ? BorderSide(width: 0.1) : BorderSide.none,
      top: top ? BorderSide(width: 0.1) : BorderSide.none,
      right: right ? BorderSide(width: 0.1) : BorderSide.none,
      bottom: bottom ? BorderSide(width: 0.1) : BorderSide.none,
    );
  }
}
