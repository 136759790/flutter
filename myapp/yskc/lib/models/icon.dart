import 'package:yskc/db/db_manager.dart';
import 'package:sqflite/sqflite.dart';

class IconModel {
  int id, code, type;
  IconModel(this.id, this.code, this.type);
  static Future<List<IconModel>> getAllIcons() async {
    Database db = await DBManager.getDb();
    var value = await db.rawQuery('''
      select i.* from user_icon u  left join icon i on u.icon_id = i.id order by id asc
    ''');
    print(value);
  }
}
