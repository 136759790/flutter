import 'dart:convert';
import 'dart:developer';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:myapp/common/global.dart';
import 'package:myapp/models/project.dart';
import 'package:myapp/models/shop.dart';
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
    if (str == null) {
      return null;
    }
    return User.fromJson(json.decode(str));
  }

  void clear() {
    Hive.box(Global.CONFIG).delete('user');
  }
}

class ShopModel extends ChangeNotifier {
  set shop(Shop shop) {
    Hive.box(Global.CONFIG).put("shop", shop.toJson());
    notifyListeners();
  }

  get shop {
    var json = Hive.box(Global.CONFIG).get('shop');
    return json != null ? Shop.fromJson(new Map.from(json)) : null;
  }

  void clear() {
    Hive.box(Global.CONFIG).delete('shop');
  }
}

class ProjectModel extends ChangeNotifier {
  set project(Project project) {
    Hive.box(Global.CONFIG).put("project", project.toJson());
    notifyListeners();
  }

  get project {
    var json = Hive.box(Global.CONFIG).get('project');
    return json != null ? Project.fromJson(new Map.from(json)) : null;
  }
}
