import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Status {}

class LoadingStatus extends Status {}

class ErrorStatus extends Status {}

class SuccessStatus<T> extends Status {
  T t;
  SuccessStatus(this.t);
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class ErrorStatusWidget extends StatelessWidget {
  const ErrorStatusWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('ERROR'),
    );
  }
}
