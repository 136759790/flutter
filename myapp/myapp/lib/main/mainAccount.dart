import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:myapp/common/eventBus.dart';
import 'package:myapp/db/db_manager.dart';
import 'package:myapp/models/account.dart';
import 'package:sqflite/sqlite_api.dart';

class AccountMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AccountMainState();
}

class AccountMainState extends State<AccountMain> {
  List<Account> _data = [];
  Map<int, Map> _icons = {};
  void _getData() async {
    List<Account> result = [];
    Database db = await DBManager.getDb();
    List<Map> data =
        await db.rawQuery('select * from account order by id desc');
    if (data != null && data.length > 0) {
      for (var item in data) {
        result.add(Account.fromJson(new Map.from(item)));
      }
      setState(() {
        _data.addAll(result);
      });
    }
  }

  void _initData() async {
    List<Account> result = [];
    Database db = await DBManager.getDb();
    List<Map> data =
        await db.rawQuery('select * from account order by id desc');
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
  }

  @override
  void initState() {
    bus.on<AccountRefreshEvent>().listen((event) {
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
          '小店记账',
        ),
        centerTitle: true,
        leading: Icon(Icons.home),
      ),
      body: Container(
        child: Column(
          children: [
            // this._sectionTitle(),
            Expanded(
              child: Row(
                children: [
                  Expanded(
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
                                                            .icon_id]['code']),
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
                                              child: Text(_data[index].remark),
                                              flex: 5,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "${_data[index].num}",
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
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _chooseDate(BuildContext context) async {
    Picker(
        adapter: DateTimePickerAdapter(
            isNumberMonth: true,
            yearBegin: 2015,
            yearEnd: 2021,
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
          print(value.toString());
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
