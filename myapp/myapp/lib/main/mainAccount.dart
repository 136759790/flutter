import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:intl/intl.dart';
import 'package:myapp/common/eventBus.dart';
import 'package:myapp/common/notifier.dart';
import 'package:myapp/db/db_manager.dart';
import 'package:myapp/models/account.dart';
import 'package:myapp/models/accountGroup.dart';
import 'package:myapp/models/project.dart';
import 'package:myapp/views/account/view.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqlite_api.dart';

class AccountMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AccountMainState();
}

class AccountMainState extends State<AccountMain> {
  List _data = [];
  Map<int, Map> _icons = {};
  NumberFormat nf = NumberFormat('###.##', 'zh_CN');
  DateTime _date = DateTime(DateTime.now().year, DateTime.now().month);

  Future<Null> _initData() async {
    print('initData');
    List result = [];
    Database db = await DBManager.getDb();
    Project p = Provider.of<ProjectModel>(context, listen: false).project;
    List<Map> data = await db.rawQuery(
        'select * from account where project_id = 1 order by id desc');
    Map<String, AccountGroup> map = {};
    if (data != null && data.length > 0) {
      for (var item in data) {
        Account acc = Account.fromJson(new Map.from(item));
        int ctime = acc.ctime;
        DateTime cdate = DateTime.fromMillisecondsSinceEpoch(ctime);
        String sdate = DateFormat('yyyy-MM-dd').format(cdate);
        AccountGroup ag = null;
        if (!map.containsKey(sdate)) {
          ag = AccountGroup.init(sdate, cdate.weekday);
          map[sdate] = ag;
          result.add(ag);
        } else {
          ag = map[sdate];
        }
        if (acc.value > 0) {
          ag.expense = ag.expense + acc.value;
        } else {
          ag.income = ag.income + acc.value;
        }
        result.add(acc);
      }
      print("-------------------------------------------");
      print(result);
      if (mounted) {
        setState(() {
          _data = result;
        });
      }
    }
    return null;
  }

  @override
  void initState() {
    bus.on<AccountRefreshEvent>().listen((event) {
      _initData();
    });
    super.initState();
    _initData();
    _getIcons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '小店记账-',
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      body: Container(
        child: Column(
          children: [
            _title(),
            Expanded(
              flex: 8,
              child: Row(
                children: [
                  Expanded(
                      child: RefreshIndicator(
                    onRefresh: () => _initData(),
                    child: _content(_data),
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _jine(var item) {
    var v = item.value;
    v = v * -1;
    return Text(
      "${nf.format(v)}",
      textAlign: TextAlign.end,
      style: TextStyle(color: v > 0 ? Colors.red : Colors.green),
    );
  }

  Widget _title() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              this._chooseDate(context);
            },
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_date.year}年',
                    style: TextStyle(fontSize: 10),
                    textAlign: TextAlign.right,
                  ),
                  Row(
                    children: [
                      Text(
                        '${_date.month}月',
                        style: TextStyle(fontSize: 15, height: 1.5),
                      ),
                      Icon(Icons.arrow_drop_down)
                    ],
                  )
                ],
              ),
            ),
          ),
          flex: 2,
        ),
        SizedBox(
          width: 1,
          height: 30,
          child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.grey),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '收入',
                  style: TextStyle(fontSize: 10, height: 1),
                ),
                Text(
                  '200000',
                  style: TextStyle(fontSize: 15, height: 1.5),
                ),
              ],
            ),
          ),
          flex: 3,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '支出',
                  style: TextStyle(fontSize: 10, height: 1),
                ),
                Text(
                  '200000',
                  style: TextStyle(fontSize: 15, height: 1.5),
                ),
              ],
            ),
          ),
          flex: 3,
        ),
      ],
    );
  }

  Widget _accountItem(var item) {
    bool isAccount = item is Account;
    if (!isAccount) {
      return Row(
        children: [
          Expanded(child: Text(item.date)),
          Expanded(child: Text(item.week)),
          Expanded(child: Text('支出${item.expense.abs()}')),
          Expanded(child: Text('收入${item.income.abs()}')),
        ],
      );
    } else {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (context) => new AccountView(account: item)));
        },
        child: Row(
          children: [
            Expanded(
              // child: Icon(
              //   IconData(int.parse(_icons[item.icon_id]['code']),
              //       fontFamily: 'IconFonts'),
              //   color: Colors.blue,
              //   size: 30,
              // ),
              child: Text('data'),
              flex: 1,
            ),
            Expanded(
              child: Text(
                _icons[item.icon_id]['title'],
                style: TextStyle(color: Colors.blue),
              ),
              flex: 2,
            ),
            Expanded(
              child: Text(item.remark),
              flex: 5,
            ),
            Expanded(
              child: _jine(item),
              flex: 2,
            ),
          ],
        ),
      );
    }
  }

  Widget _content(_data) {
    return CustomScrollView(
      slivers: [
        SliverSafeArea(
            sliver: SliverPadding(
          padding: EdgeInsets.all(8),
          sliver: SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              var item = _data[index];
              return Padding(
                padding: const EdgeInsets.fromLTRB(1, 8, 1, 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          _accountItem(item),
                          Divider(
                            thickness: 0.4,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }, childCount: _data.length),
          ),
        ))
      ],
    );
  }
  // Widget _content(_data) {
  //   return CustomScrollView(
  //     slivers: [
  //       SliverSafeArea(
  //           sliver: SliverPadding(
  //         padding: EdgeInsets.all(8),
  //         sliver: SliverList(
  //           delegate:
  //               SliverChildBuilderDelegate((BuildContext context, int index) {
  //             return Padding(
  //               padding: const EdgeInsets.fromLTRB(1, 8, 1, 4),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Expanded(
  //                     child: Column(
  //                       children: [
  //                         Row(
  //                           children: [
  //                             Expanded(
  //                               child: Icon(
  //                                 IconData(
  //                                     int.parse(
  //                                         _icons[_data[index].icon_id]['code']),
  //                                     fontFamily: 'IconFonts'),
  //                                 color: Colors.blue,
  //                                 size: 30,
  //                               ),
  //                               flex: 1,
  //                             ),
  //                             Expanded(
  //                               child: Text(
  //                                 _icons[_data[index].icon_id]['title'],
  //                                 style: TextStyle(color: Colors.blue),
  //                               ),
  //                               flex: 2,
  //                             ),
  //                             Expanded(
  //                               child: Text(_data[index].remark),
  //                               flex: 5,
  //                             ),
  //                             Expanded(
  //                               child: _jine(_data, index),
  //                               flex: 2,
  //                             ),
  //                           ],
  //                         ),
  //                         Divider(
  //                           thickness: 0.4,
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             );
  //           }, childCount: _data.length),
  //         ),
  //       ))
  //     ],
  //   );
  // }

  void _chooseDate(BuildContext context) async {
    Picker(
        title: Text('请选择时间'),
        adapter: DateTimePickerAdapter(
            isNumberMonth: true,
            yearBegin: 1990,
            yearEnd: 2100,
            yearSuffix: '年',
            monthSuffix: '月',
            customColumnType: [0, 1]),
        changeToFirst: true,
        textAlign: TextAlign.left,
        hideHeader: true,
        confirmText: '确定',
        cancelText: '取消',
        columnPadding: const EdgeInsets.all(8.0),
        onConfirm: (Picker picker, List value) {
          DateTime date = DateTime(1990 + value[0], value[1] + 1);
          setState(() {
            _date = date;
          });
          print(value.toString());
          print(date.toString());
          print(picker.getSelectedValues());
        }).showDialog(context);
  }

  Future<Map<int, Map>> _getIcons() async {
    Map<int, Map> result = {};
    Database db = await DBManager.getDb();
    List<Map> data = await db.rawQuery('select * from icon');
    print(data.toString());
    if (data != null && data.length > 0) {
      for (var item in data) {
        result[item['id']] = item;
      }
    }
    if (mounted) {
      setState(() {
        _icons = result;
      });
    }
  }
}
