import 'package:flutter/material.dart';

class Rt {
  static Future to(BuildContext context, Object obj) {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => obj));
  }
}
