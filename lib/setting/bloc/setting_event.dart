import 'package:equatable/equatable.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object> get props => [];
}

class SettingEventCallSettingApi extends SettingEvent {
  @override
  List<Object> get props => [];
}

class SettingEventBackBtnClick extends SettingEvent {
  @override
  List<Object> get props => [];
}

class SettingEventResetInitialState extends SettingEvent {
  @override
  List<Object> get props => [];
}

class SettingNotificationItemClick extends SettingEvent {
  @override
  List<Object> get props => [];
}

class SettingEventUpdateNotification extends SettingEvent {
  String pushNotiStatus;
  String emailStatus;
  String smsStatus;

  SettingEventUpdateNotification(
      this.pushNotiStatus, this.emailStatus, this.smsStatus);

  @override
  List<Object> get props => [pushNotiStatus, emailStatus, smsStatus];
}

class SettingEventErrorState extends SettingEvent {
  String message;

  SettingEventErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class NotificationListItemClick extends SettingEvent {
  String order_id;
  String vendorId;

  NotificationListItemClick(this.order_id, this.vendorId);

  @override
  List<Object> get props => [order_id, vendorId];
}

class SettingNotificationListApiCall extends SettingEvent {
  String pageCount;
  String isRefresh;

  SettingNotificationListApiCall(this.pageCount, this.isRefresh);

  @override
  List<Object> get props => [pageCount, isRefresh];
}

class SettingNotificationButtonClick extends SettingEvent {
  SettingNotificationButtonClick();

  @override
  List<Object> get props => [];
}

class SettingEventNotificationStateReset extends SettingEvent {
  SettingEventNotificationStateReset();

  @override
  List<Object> get props => [];
}
