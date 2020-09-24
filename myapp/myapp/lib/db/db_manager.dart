import 'package:sqflite/sqflite.dart';

class DBManager {
  static const DBNAME = "xiaodian";

  static init() async {
    var dbPath = await getDatabasesPath();
    print(dbPath);
  }
}
