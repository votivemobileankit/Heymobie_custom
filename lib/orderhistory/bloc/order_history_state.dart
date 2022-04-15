import 'package:equatable/equatable.dart';
import 'package:grambunny_customer/orderhistory/orderhistory.dart';

abstract class OrderHistoryState extends Equatable {
  const OrderHistoryState();

  @override
  List<Object> get props => [];
}

class OrderHistoryInitial extends OrderHistoryState {
  @override
  List<Object> get props => [];
}

class OrderHistoryDetailPageState extends OrderHistoryState {
  String vendorId;
  String orderId;
  String vendorlastName;
  String vendorName;

  OrderHistoryDetailPageState(
      this.vendorId, this.orderId, this.vendorlastName, this.vendorName);

  @override
  List<Object> get props => [vendorId, orderId, vendorlastName, vendorName];
}

class MapOrderTrackPageState extends OrderHistoryState {
  String driverLat;
  String driverLong;
  String userLat;
  String userLong;
  String vendorID;

  MapOrderTrackPageState(this.driverLat, this.driverLong, this.userLat,
      this.userLong, this.vendorID);

  @override
  List<Object> get props =>
      [driverLat, driverLong, userLat, userLong, vendorID];
}

class OrderHistoryToNavigateHomePageState extends OrderHistoryState {}

class OrderHistoryToNavigateHomeResetPageState extends OrderHistoryState {}

class OrderHistoryListApiLoadingCompleteState extends OrderHistoryState {
  List<HistoryList> historyList;
  int refresh;

  OrderHistoryListApiLoadingCompleteState(this.historyList, this.refresh);

  @override
  List<Object> get props => [historyList, refresh];
}

class vendorUpdateLocationApiLoadingCompleteState extends OrderHistoryState {
  String msg;
  List<VendorLatlng> vendorLatLong;

  vendorUpdateLocationApiLoadingCompleteState(this.msg, this.vendorLatLong);

  @override
  List<Object> get props => [msg, vendorLatLong];
}

class vendorUpdateLocationApiErrorState extends OrderHistoryState {
  String message;

  vendorUpdateLocationApiErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class OrderDetailApiLoadingCompleteState extends OrderHistoryState {
  List<OrderDetail> orderDetailData;
  List<OrderItems> orderDetailMenuItem;
  List<Vendor1> vendorDetailData;

  OrderDetailApiLoadingCompleteState(
      this.orderDetailData, this.orderDetailMenuItem, this.vendorDetailData);

  @override
  List<Object> get props =>
      [orderDetailData, orderDetailMenuItem, vendorDetailData];
}

class OrderMerchantRatingSubmitState extends OrderHistoryState {
  String message;

  OrderMerchantRatingSubmitState(this.message);

  @override
  List<Object> get props => [message];
}

class OrderDetailLoadingErrorState extends OrderHistoryState {
  String message;

  OrderDetailLoadingErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class OrderHistoryListLoadingErrorState extends OrderHistoryState {
  String message;

  OrderHistoryListLoadingErrorState(this.message);

  @override
  List<Object> get props => [message];
}
