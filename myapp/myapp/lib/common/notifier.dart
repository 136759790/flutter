import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:myapp/common/Global.dart';
import 'package:myapp/models/user.dart';

class UserNotifier extends ChangeNotifier {
  set user(User user) {
    String userInfo = json.encode(user);
    print('object=>$userInfo');
    Hive.box(Global.CONFIG).put('user', userInfo);
    notifyListeners();
  }

  get user {
    var str = Hive.box(Global.CONFIG).get('user');
    return User.fromJson(json.decode(str));
  }
}
