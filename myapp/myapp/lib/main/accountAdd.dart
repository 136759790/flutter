import 'package:common_utils/common_utils.dart';
import 'package:expressions/expressions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grid_button/flutter_grid_button.dart';
import 'package:myapp/common/eventBus.dart';
import 'package:myapp/common/notifier.dart';
import 'package:myapp/db/db_manager.dart';
import 'package:myapp/models/account.dart';
import 'package:myapp/models/icon.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class AccountAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AccountAddState();
  }
}

class AccountAddState extends State<AccountAdd>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  TextEditingController _remarkController = TextEditingController();
  List<Map> icons = new List();
  bool _showKeyboard = false;
  Color _inactive = Colors.black12;
  Color _active = Colors.blue;
  int _active_index = -1;
  bool _showNumKey = true;
  String value = "0";
  String _numValue = "";
  String _labelDone = "完成";
  String _labelTime = "今天";
  DateTime _date = DateTime.now();
  final ex = ExpressionEvaluator();
  @override
  void initState() {
    super.initState();
    bus.on<AccountCalcuEvent>().listen((event) {
      print('event->${event.show}');
      setState(() {
        _showKeyboard = event.show;
      });
    });
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
                child: _keyBoard(),
                flex: _showNumKey ? 5 : 1,
              ))
        ]));
  }

  Widget _keyBoard() {
    return Column(children: [
      Expanded(
          child: Row(
        children: [
          Expanded(child: Icon(Icons.accessibility)),
          Expanded(
            child: Text('备注：'),
            flex: 2,
          ),
          Expanded(
            child: TextField(
              controller: _remarkController,
              decoration: InputDecoration(border: InputBorder.none),
              onTap: () {
                setState(() {
                  _showNumKey = false;
                });
              },
              onSubmitted: (value) {
                setState(() {
                  _showNumKey = true;
                });
              },
            ),
            flex: 8,
          ),
          Expanded(
            child: Text(
              _numValue,
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.end,
            ),
            flex: 5,
          ),
        ],
      )),
      Visibility(
        child: Expanded(
          child: GridButton(
            items: _getItems(),
            onPressed: (value) {
              _numCmd(value, context);
            },
          ),
          flex: 4,
        ),
        visible: _showNumKey,
      ),
    ]);
  }

  _numCmd(var value, var context) {
    print(value);
    if ("1234567890.".contains(value)) {
      setState(() {
        _numValue = _numValue + value;
      });
    } else if ("+-".contains(value)) {
      setState(() {
        _numValue = _numValue + value;
        _labelDone = "=";
      });
    } else if ("=" == value) {
      if (_numValue.endsWith(".") ||
          _numValue.endsWith("+") ||
          _numValue.endsWith("-")) {
        _numValue = _numValue.substring(0, _numValue.length - 1);
      }
      var aa = ex.eval(Expression.parse(_numValue), {"init": true}).toString();
      setState(() {
        _numValue = aa;
        _labelDone = "完成";
      });
    } else if ("del" == value) {
      setState(() {
        _numValue = _numValue.substring(0, _numValue.length - 1);
      });
    } else if ("time" == value) {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2050),
        locale: Locale('zh'),
      ).then((value) {
        if (value != null) {
          String date = DateUtil.formatDate(value, format: 'yyyy/MM/dd');
          String today =
              DateUtil.formatDate(DateTime.now(), format: 'yyyy/MM/dd');
          if (date != today) {
            setState(() {
              _date = value;
              _labelTime = date;
            });
          } else {
            setState(() {
              _date = value;
              _labelTime = '今天';
            });
          }
        }
      });
    } else if ('完成' == value) {
      Account acc = Account();
      acc.icon_id = icons[_active_index]['id'];
      print('num_value----$_numValue');
      acc.value = num.parse(_numValue);
      acc.remark = _remarkController.text;
      acc.ctime = _date.millisecondsSinceEpoch;
      acc.project_id =
          Provider.of<ProjectModel>(context, listen: false).project.id;
      _insertAccount(acc);
      bus.fire(AccountRefreshEvent());
      Navigator.of(context).pop();
    }
  }

  void _insertAccount(Account account) async {
    Database db = await DBManager.getDb();
    await db.rawInsert(
        "insert into account(ctime,icon_id,remark,value,project_id)values(${account.ctime},${account.icon_id},'${account.remark}',${account.value},${account.project_id})");
  }

  List<List<GridButtonItem>> _getItems() {
    return [
      [
        GridButtonItem(title: '7'),
        GridButtonItem(title: '8'),
        GridButtonItem(title: '9'),
        GridButtonItem(
            color: Colors.lightBlue,
            title: _labelTime,
            value: 'time',
            textStyle: TextStyle(fontSize: 10)),
      ],
      [
        GridButtonItem(title: '4'),
        GridButtonItem(title: '5'),
        GridButtonItem(title: '6'),
        GridButtonItem(title: '+')
      ],
      [
        GridButtonItem(title: '1'),
        GridButtonItem(title: '2'),
        GridButtonItem(title: '3'),
        GridButtonItem(title: '-')
      ],
      [
        GridButtonItem(title: '.'),
        GridButtonItem(title: '0'),
        GridButtonItem(title: 'del'),
        GridButtonItem(title: _labelDone)
      ]
    ];
  }
}
