import 'package:flutter/cupertino.dart';
import 'package:myapp/db/db_manager.dart';
import 'package:sqflite/sqflite.dart';

abstract class DBProvider {
  bool isTableExits = false;
  createTableString();
  tableName();

  ///创建表sql语句
  tableBaseString(String sql) {
    return sql;
  }

  Future<Database> getDataBase() async {
    return await open();
  }

  ///super 函数对父类进行初始化
  @mustCallSuper
  prepare(name, String createSql) async {
    isTableExits = await DBManager.isTableExits(name);
    if (!isTableExits) {
      Database db = await DBManager.getDb();
      return await db.execute(createSql);
    }
  }

  @mustCallSuper
  open() async {
    if (!isTableExits) {
      await prepare(tableName(), createTableString());
    }
    return await DBManager.getDb();
  }
}
