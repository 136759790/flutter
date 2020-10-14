import 'package:hive/hive.dart';
import 'package:myapp/common/global.dart';
import 'package:hive_flutter/hive_flutter.dart';

main() async {
  await Hive.initFlutter();
  await Hive.openBox(Global.CONFIG);
  await Hive.box(Global.CONFIG).delete("project");
}
