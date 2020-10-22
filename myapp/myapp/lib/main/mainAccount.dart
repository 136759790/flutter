import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:intl/intl.dart';
import 'package:myapp/common/eventBus.dart';
import 'package:myapp/common/notifier.dart';
import 'package:myapp/db/db_manager.dart';
import 'package:myapp/models/account.dart';
import 'package:myapp/models/project.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqlite_api.dart';

class AccountMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AccountMainState();
}

class AccountMainState extends State<AccountMain> {
  List<Account> _data = [];
  Map<int, Map> _icons = {};
  NumberFormat nf = NumberFormat('###.##', 'zh_CN');
  DateTime _date = DateTime(DateTime.now().year, DateTime.now().month);

  void _getData() async {
    print('_getData');
    print(
        'project_id = ${Provider.of<ProjectModel>(context, listen: false).project.id}');
    List<Account> result = [];
    Database db = await DBManager.getDb();
    List<Map> data = await db.rawQuery(
        'select * from account where project_id = ${Provider.of<ProjectModel>(context, listen: false).project.id} order by id desc');
    if (data != null && data.length > 0) {
      for (var item in data) {
        result.add(Account.fromJson(new Map.from(item)));
      }
      setState(() {
        _data.addAll(result);
      });
    }
  }

  Future<Null> _initData() async {
    print('initData');
    List<Account> result = [];
    Database db = await DBManager.getDb();
    Project p = Provider.of<ProjectModel>(context, listen: false).project;
    List<Map> data = await db.rawQuery(
        'select * from account where project_id = ${p.id} order by id desc');
    if (data != null && data.length > 0) {
      for (var item in data) {
        result.add(Account.fromJson(new Map.from(item)));
      }
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
      print('event----->$event');
      _initData();
    });
    super.initState();
    _getData();
    _getIcons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '小店记账-${Provider.of<ProjectModel>(context, listen: false).project.name}',
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
                    child: CustomScrollView(
                      slivers: [
                        SliverSafeArea(
                            sliver: SliverPadding(
                          padding: EdgeInsets.all(8),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(1, 8, 1, 4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Icon(
                                                  IconData(
                                                      int.parse(_icons[
                                                              _data[index]
                                                                  .icon_id]
                                                          ['code']),
                                                      fontFamily: 'IconFonts'),
                                                  color: Colors.blue,
                                                  size: 30,
                                                ),
                                                flex: 1,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  _icons[_data[index].icon_id]
                                                      ['title'],
                                                  style: TextStyle(
                                                      color: Colors.blue),
                                                ),
                                                flex: 2,
                                              ),
                                              Expanded(
                                                child:
                                                    Text(_data[index].remark),
                                                flex: 5,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "${nf.format(_data[index].value)}",
                                                  textAlign: TextAlign.end,
                                                ),
                                                flex: 2,
                                              ),
                                            ],
                                          ),
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
                    ),
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
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
          flex: 1,
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
          flex: 2,
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
          flex: 2,
        ),
      ],
    );
  }

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
