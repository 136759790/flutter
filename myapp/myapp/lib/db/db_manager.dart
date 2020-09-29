import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

class DBManager {
  static const DBNAME = "xiaodian";
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
      version: 1,
      onCreate: (db, version) async {
        String sql_icon = await rootBundle.loadString('assets/sql/icon.sql');
        await db.execute(sql_icon);
        String sql_user_icon =
            await rootBundle.loadString('assets/sql/user_icon.sql');
        await db.execute(sql_user_icon);
        String sql_icon_data =
            await rootBundle.loadString('assets/sql/icon_data.sql');
        await db.execute(sql_icon_data);
        String sql_user_icon_data =
            await rootBundle.loadString('assets/sql/user_icon_data.sql');
        await db.execute(sql_user_icon_data);
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
