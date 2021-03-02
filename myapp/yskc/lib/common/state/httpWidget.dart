import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yskc/common/state/state.dart';

typedef HttpBuilder<T> = Widget Function(BuildContext context, T t);

class HttpWidget<T> extends StatefulWidget {
  HttpBuilder httpBuilder;
  Widget loading = Center(
    child: CircularProgressIndicator(),
  );
  Widget error = Center(
    child: Text('error'),
  );
  StreamController controller;
  HttpWidget({this.controller, this.httpBuilder, this.loading, this.error});
  @override
  _HttpWidgetState createState() => _HttpWidgetState();
}

class _HttpWidgetState extends State<HttpWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<Status>(
          stream: widget.controller.stream,
          builder: (context, snap) {
            Widget result;
            if (snap.data != null) {
              if (snap.data is LoadingStatus) {
                return LoadingWidget();
              } else if (snap.data is ErrorStatus) {
                return ErrorStatusWidget();
              } else if (snap.data is SuccessStatus) {
                result = widget.httpBuilder(context, (snap.data as SuccessStatus).t);
              }
            } else {
              return Center(
                child: Text('null'),
              );
            }
            return result;
          }),
    );
  }
}
