import 'package:flutter/cupertino.dart';

class UtilDialog {
  static Future showDialog(BuildContext context, String content,
      {String title, String ok, String cancel}) {
    return showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title ?? '提醒'),
            content: Text(content ?? ''),
            actions: [
              CupertinoDialogAction(
                child: Text(ok ?? '确认'),
                onPressed: () => Navigator.pop(context, true),
              ),
              CupertinoDialogAction(
                child: Text(cancel ?? '取消'),
                onPressed: () => Navigator.pop(context, false),
              ),
            ],
          );
        });
  }
}
