import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/models/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red
];

class Global {
  static SharedPreferences _prefs;
  static List<MaterialColor> get themes => _themes;
  static Profile profile = Profile();
  static bool get isRelease =>
      bool.fromEnvironment("dart.vm.product"); //是否release版本

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
    var _profile = _prefs.getString("profile");
    if (_profile != null) {
      try {
        profile = Profile.fromJson(jsonDecode(_profile));
      } catch (e) {
        print(e);
      }
    }
  }

  static saveProfile() =>
      {_prefs.setString("profile", jsonEncode(profile.toJson()))};
}
