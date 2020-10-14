import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';
import 'package:intl/intl.dart';
import 'package:myapp/db/db_manager.dart';
import 'package:myapp/models/icon.dart';

class AccountAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AccountAddState();
  }
}

class AccountAddState extends State<AccountAdd>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  List<Map> icons = new List();
  bool _showKeyboard = false;
  Color _inactive = Colors.black12;
  Color _active = Colors.blue;
  int _active_index = -1;
  bool _showNumKey = true;
  String value = "0";

  @override
  void initState() {
    super.initState();
    this.tabController = TabController(length: 2, vsync: this);
    DBManager.getDb().then((db) {
      db
          .rawQuery(
              'select i.* from user_icon u left join icon i on u.icon_id = i.id order by id asc;')
          .then((data) {
        this.setState(() {
          icons = data;
        });
      });
    });
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
                  child: FutureBuilder<List<IconModel>>(
                      future: null,
                      builder: (context, snapshot) {
                        return CustomScrollView(
                          slivers: [
                            SliverGrid(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
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
                                          IconData(
                                              int.parse(icons[index]['code']),
                                              fontFamily: 'IconFonts'),
                                          color: _active_index == index
                                              ? _active
                                              : _inactive,
                                          size: 30,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _showKeyboard = true;
                                            _active_index = index;
                                          });
                                        },
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(100))),
                                    ),
                                    Text(icons[index]['title'])
                                  ],
                                );
                              }, childCount: icons.length),
                            )
                          ],
                        );
                      }),
                ),
                Text('data'),
              ],
              controller: this.tabController,
            ),
            flex: 5,
          ),
          Visibility(
              visible: _showKeyboard,
              child: Expanded(
                child: SimpleCalculator(
                  hideSurroundingBorder: true,
                  hideExpression: true,
                  // numberFormat: NumberFormat.decimalPattern("zh_CN"),
                  theme: const CalculatorThemeData(
                    borderColor: Colors.grey,
                    borderWidth: 0.1,
                    displayColor: Colors.white,
                    displayStyle:
                        const TextStyle(fontSize: 40, color: Colors.black),
                    operatorColor: Colors.white,
                    operatorStyle:
                        const TextStyle(fontSize: 20, color: Colors.black),
                    commandColor: Colors.white,
                    commandStyle:
                        const TextStyle(fontSize: 20, color: Colors.black),
                    numColor: Colors.white,
                    numStyle:
                        const TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
                flex: _showNumKey ? 5 : 1,
              ))
        ]));
  }

  _fill(String num) {
    String t = "";
    if (num == '0') {
      if (value == "0") {
        t = "0";
      }
    } else if (num == '+' || num == "-") {
      if (value.endsWith("+") || value.endsWith("-")) {
        t = value.substring(0, value.length - 1) + num;
      } else if (value == "0") {
        t = value;
      }
    } else if (num == '.') {}

    if (value == "0") {
      if (num == "0" || num == '+' || num == "-") {
        t = "0";
      }
    }
    if ((num == '+' || num == "-") &&
        (value.endsWith("+") || value.endsWith("-"))) {
      t = value.substring(0, value.length - 1) + num;
    }
  }

  Column _keyboard() {
    return Column(
      children: [
        Expanded(
          child: Column(
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
                      maxLength: 16,
                      onTap: () {
                        setState(() {
                          this._showNumKey = false;
                        });
                      },
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                    ),
                    flex: 8,
                  ),
                  Expanded(
                    child: Text(
                      '$value',
                      style: TextStyle(fontSize: 20),
                    ),
                    flex: 2,
                  )
                ],
              ))
            ],
          ),
          flex: 1,
        ),
        Visibility(
          visible: _showNumKey,
          child: Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: _getBorder(false, true, true, true)),
                        child: SizedBox.expand(
                          child: FlatButton(
                              onPressed: () {
                                DBManager.init();
                              },
                              child: Text('7')),
                        ),
                      )),
                      Expanded(
                          child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: _getBorder(false, true, true, true)),
                        child: SizedBox.expand(
                          child: FlatButton(onPressed: () {}, child: Text('8')),
                        ),
                      )),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                            border: _getBorder(false, true, true, true)),
                        alignment: Alignment.center,
                        child: SizedBox.expand(
                          child: FlatButton(onPressed: () {}, child: Text('9')),
                        ),
                      )),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                            border: _getBorder(false, true, true, true)),
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
                        decoration: BoxDecoration(
                            border: _getBorder(false, false, true, true)),
                        child: SizedBox.expand(
                          child: FlatButton(onPressed: () {}, child: Text('4')),
                        ),
                      )),
                      Expanded(
                          child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: _getBorder(false, false, true, true)),
                        child: SizedBox.expand(
                          child: FlatButton(onPressed: () {}, child: Text('5')),
                        ),
                      )),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                            border: _getBorder(false, false, true, true)),
                        alignment: Alignment.center,
                        child: SizedBox.expand(
                          child: FlatButton(onPressed: () {}, child: Text('6')),
                        ),
                      )),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                            border: _getBorder(false, false, true, true)),
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
                        decoration: BoxDecoration(
                            border: _getBorder(true, false, true, true)),
                        child: SizedBox.expand(
                          child: FlatButton(onPressed: () {}, child: Text('1')),
                        ),
                      )),
                      Expanded(
                          child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: _getBorder(false, false, true, true)),
                        child: SizedBox.expand(
                          child: FlatButton(onPressed: () {}, child: Text('2')),
                        ),
                      )),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                            border: _getBorder(false, false, true, true)),
                        alignment: Alignment.center,
                        child: SizedBox.expand(
                          child: FlatButton(onPressed: () {}, child: Text('3')),
                        ),
                      )),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                            border: _getBorder(false, false, true, true)),
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
                        decoration: BoxDecoration(
                            border: _getBorder(true, false, true, true)),
                        child: SizedBox.expand(
                          child: FlatButton(onPressed: () {}, child: Text('.')),
                        ),
                      )),
                      Expanded(
                          child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: _getBorder(false, false, true, true)),
                        child: SizedBox.expand(
                          child: FlatButton(onPressed: () {}, child: Text('0')),
                        ),
                      )),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                            border: _getBorder(false, false, true, true)),
                        alignment: Alignment.center,
                        child: SizedBox.expand(
                          child: FlatButton(
                              onPressed: () {}, child: Icon(Icons.backspace)),
                        ),
                      )),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                            border: _getBorder(false, false, true, true)),
                        alignment: Alignment.center,
                        child: SizedBox.expand(
                          child: FlatButton(
                            onPressed: () {
                              IconModel.getAllIcons();
                            },
                            child: Text('完成'),
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
              ],
            ),
            flex: 4,
          ),
        )
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
