import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/db/db_manager.dart';
import 'package:sqflite/sqlite_api.dart';

class Setting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SettingState();
}

class SettingState extends State<Setting> {
  TextEditingController _sqlController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('系统设置'),
      ),
      body: Column(
        children: [
          TextField(
            maxLines: 8,
            controller: _sqlController,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              onLongPress: () async {
                ClipboardData data =
                    await Clipboard.getData(Clipboard.kTextPlain);
                print(data.text);
              },
              onPressed: () async {
                var text = _sqlController.text;
                await _exeSql(text);
                Fluttertoast.showToast(msg: '执行成功');
              },
              child: Text('初始化数据库'),
              color: Colors.blue,
              textColor: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  void _exeSql(String sql) async {
    Database d = await DBManager.getDb();
    await d.execute(sql);
  }
}
