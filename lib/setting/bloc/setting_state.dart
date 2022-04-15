import 'package:equatable/equatable.dart';
import 'package:grambunny_customer/orderhistory/orderhistory.dart';
import 'package:grambunny_customer/profile/profile.dart';
import 'package:grambunny_customer/setting/model/model.dart';

abstract class SettingState extends Equatable {
  const SettingState();

  @override
  List<Object> get props => [];
}

class SettingInitial extends SettingState {
  @override
  List<Object> get props => [];
}

class SettingGetUserSettingDataState extends SettingState {
  UserDetailResponseModel userDetailInfo;

  SettingGetUserSettingDataState(this.userDetailInfo);

  @override
  List<Object> get props => [userDetailInfo];
}

class SettingErrorState extends SettingState {
  String message;

  SettingErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class SettingNavigateToHomePageState extends SettingState {
  SettingNavigateToHomePageState();

  @override
  List<Object> get props => [];
}

class SettingUpdateUserSettingState extends SettingState {
  UserDetailResponseModel userDetailInfo;

  SettingUpdateUserSettingState(this.userDetailInfo);

  @override
  List<Object> get props => [userDetailInfo];
}

class SettingNotificationDataListState extends SettingState {
  NotificationDetail notificationDataList;
  String isRefresh;

  SettingNotificationDataListState(this.notificationDataList, this.isRefresh);

  @override
  List<Object> get props => [notificationDataList, isRefresh];
}

class SettingNotificationListPageState extends SettingState {
  @override
  List<Object> get props => [];
}

class SettingNotificationDetailPageState extends SettingState {
  List<OrderDetail> orderDetailData;
  List<OrderItems> orderDetailMenuItem;
  List<Vendor1> vendorDetailData;

  SettingNotificationDetailPageState(
      this.orderDetailData, this.orderDetailMenuItem, this.vendorDetailData);

  @override
  List<Object> get props =>
      [orderDetailData, orderDetailMenuItem, vendorDetailData];
}
