import 'dart:async';

import 'package:myapp/common/state/state.dart';

class StatusManager {
  StreamController<Status> controller;
  StatusManager() {
    controller = StreamController();
  }

  void dispose() {
    if (controller != null) {
      controller.close();
    }
  }

  void loading() {
    controller.sink.add(LoadingStatus());
  }

  void error() {
    controller.sink.add(ErrorStatus());
  }

  void success<T>(T t) {
    controller.sink.add(SuccessStatus(t));
  }
}
