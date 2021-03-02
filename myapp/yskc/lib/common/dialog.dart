import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dr {
  static Future show(BuildContext context, String content, {String title, String ok, String cancel}) {
    return showDialog(
        context: context,
        child: AlertDialog(
          title: Text(title ?? '提醒'),
          content: Text(content),
          actions: [
            FlatButton(onPressed: () => Navigator.pop(context, false), child: Text(cancel ?? '取消')),
            FlatButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text(ok ?? '确定'),
            ),
          ],
        ));
  }
}
