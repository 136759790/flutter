import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/db/db_manager.dart';
import 'package:myapp/models/icon.dart';
import 'package:myapp/widgets/caculator_theme.dart';
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

  void _insertAccount(int icon_id, double num, int ctime, String remark) async {
    Database db = await DBManager.getDb();
    await db.rawInsert(
        'insert into account(ctime,icon_id,remark,num)values($ctime,$icon_id,$remark,$num)');
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
                  // hideSurroundingBorder: true,
                  hideExpression: true,
                  onChanged: (key, value, expression) async {
                    print(
                        'keu===$key,value====$value,expression----$expression');
                    if (key == '完成') {
                      await _insertAccount(icons[_active_index]['id'], value,
                          DateTime.now().millisecondsSinceEpoch, "'remark'");
                      Navigator.of(context).pop();
                    }
                  },
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
}
