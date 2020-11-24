import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red
];

class Global {
  static String CONFIG = 'config';
  static String PROJECTS = 'projects';
  static String SHOP = 'shop';
  static List<MaterialColor> get themes => _themes;
  static Future init() async {
    await Hive.initFlutter();
    await Hive.openBox(CONFIG);
    await Hive.openBox(PROJECTS);
    await Hive.openBox(SHOP);
  }
}
