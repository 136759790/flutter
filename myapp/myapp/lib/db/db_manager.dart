import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

class DBManager {
  static const DBNAME = "zhaoxt";
  static Database _db;

  static init() async {
    var dbPath = await getDatabasesPath();
    String path = dbPath + DBNAME;
    if (Platform.isIOS) {
      path = dbPath + "/" + DBNAME;
    }
    print('db path=$path');
    _db = await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        String dataStr = await rootBundle.loadString('assets/data/sql.json');
        List<dynamic> data = json.decode(dataStr);
        for (var i = 0; i < data.length; i++) {
          await db.execute(data[i].toString());
        }
      },
    );
  }

  static Future<Database> getDb() async {
    if (_db == null) {
      await init();
    }
    return _db;
  }

  static close() {
    _db?.close();
    _db = null;
  }

  static isTableExits(name) async {
    await getDb();
    var res = await _db.rawQuery(
        "select * from Sqlite_master where type = 'table' and name = '$name'");
    return res != null && res.length > 0;
  }

  static reset() async {}
}
