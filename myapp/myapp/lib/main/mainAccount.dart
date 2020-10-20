import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:myapp/db/db_manager.dart';
import 'package:myapp/models/account.dart';
import 'package:sqflite/sqlite_api.dart';

class AccountMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AccountMainState();
}

class AccountMainState extends State<AccountMain> {
  List<Account> _data = [];
  void _getData() async {
    Database db = await DBManager.getDb();
    db.rawQuery('select * from account order by id desc limit 0,9');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     '小店记账',
      //   ),
      //   centerTitle: true,
      //   leading: Icon(Icons.settings),
      // ),
      body: Container(
        child: Column(
          children: [
            // this._sectionTitle(),
            Expanded(
              child: Row(
                children: [Expanded(child: this._sectionList())],
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

  Row _sectionTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              this._chooseDate(context);
            },
            child: Container(
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '2020年',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  Row(
                    children: [
                      Text(
                        '09月',
                        style: TextStyle(fontSize: 15),
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
          height: 20,
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
                  style: TextStyle(fontSize: 10),
                ),
                Text(
                  '200000',
                  style: TextStyle(fontSize: 15),
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
                  style: TextStyle(fontSize: 10),
                ),
                Text(
                  '200000',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          flex: 2,
        ),
      ],
    );
  }

  CustomScrollView _sectionList() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          centerTitle: true,
          leading: Icon(Icons.settings),
          actions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '2020年',
                  style: TextStyle(fontSize: 10),
                ),
                Row(
                  children: [Text('9月'), Icon(Icons.arrow_drop_down)],
                )
              ],
            )
          ],
          floating: true,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '收：20000',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '支：15000',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverSafeArea(
            sliver: SliverPadding(
          padding: EdgeInsets.all(8),
          sliver: this._sectionList2(),
        ))
      ],
    );
  }

  SliverList _sectionList2() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        if (index % 10 == 0) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 1, 4),
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
                            child: Text('9月21日 星期一'),
                            flex: 2,
                          ),
                          Expanded(
                            child: Text('收入：20000'),
                            flex: 1,
                          ),
                          Expanded(
                            child: Text('支出：140'),
                            flex: 1,
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
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
                              Icons.home,
                              color: Colors.blue,
                            ),
                            flex: 1,
                          ),
                          Expanded(
                            child: Text('test'),
                            flex: 7,
                          ),
                          Expanded(
                            child: Text('-99'),
                            flex: 1,
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
        }
      }, childCount: 150),
    );
  }

  Widget _lineChart() {
    return Card(
      child: Column(children: [
        ListTile(
          title: Text('近三个月流水'),
        ),
        LineChart(LineChartData(
            borderData: FlBorderData(
                show: true,
                border: Border.all(color: const Color(0xff37434d), width: 1)),
            titlesData: FlTitlesData(
              show: true,
            ),
            lineBarsData: [
              LineChartBarData(show: true, spots: [
                FlSpot(1, 1.4),
                FlSpot(2, 2.4),
                FlSpot(3, 3.4),
                FlSpot(4, 4.4),
                FlSpot(5, 5.4),
              ])
            ])),
      ]),
    );
  }
}
