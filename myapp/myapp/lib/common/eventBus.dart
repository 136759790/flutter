import 'package:event_bus/event_bus.dart';

var bus = EventBus();

class AccountRefreshEvent {}

class AccountCalcuEvent {
  bool show;
  AccountCalcuEvent(this.show);
}
