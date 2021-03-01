import 'package:flutter/material.dart';

class Rt {
  static Future to(BuildContext context, Object obj) {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => obj));
  }

  static Future toDelay(BuildContext context, Object obj) {
    return Future.delayed(Duration.zero, () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => obj));
    });
  }
}
