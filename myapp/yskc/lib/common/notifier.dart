import 'dart:convert';
import 'dart:developer';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:yskc/common/global.dart';
import 'package:yskc/models/project.dart';
import 'package:yskc/models/user.dart';

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
