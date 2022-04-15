import 'package:equatable/equatable.dart';

abstract class OrderHistoryEvent extends Equatable {
  const OrderHistoryEvent();

  @override
  List<Object> get props => [];
}

class OrderHistoryEventRowItemClick extends OrderHistoryEvent {
  String orderId;
  String vendorName;
  String vendorlastName;
  String vendorId;

  OrderHistoryEventRowItemClick(
      this.orderId, this.vendorName, this.vendorlastName, this.vendorId);

  @override
  List<Object> get props => [orderId, vendorName, vendorlastName, vendorId];
}

class OrderEventBackBtnClicked extends OrderHistoryEvent {}

class OrderHistoryEventReset extends OrderHistoryEvent {}

class OrderHistoryEventForOrderList extends OrderHistoryEvent {
  String pageNumber;

  OrderHistoryEventForOrderList(this.pageNumber);

  @override
  List<Object> get props => [pageNumber];
}

class OrderHistoryEventRefreshOrderList extends OrderHistoryEvent {
  String pageNumber;

  OrderHistoryEventRefreshOrderList(this.pageNumber);

  @override
  List<Object> get props => [pageNumber];
}

class OrderHistoryEventForOrderDeatil extends OrderHistoryEvent {
  String orderID;
  String vendorId;

  OrderHistoryEventForOrderDeatil(this.orderID, this.vendorId);

  @override
  List<Object> get props => [orderID, vendorId];
}

class OrderHistoryEventNavigateFromNoticationToOrderDetail
    extends OrderHistoryEvent {
  String orderID;
  String vendorId;

  OrderHistoryEventNavigateFromNoticationToOrderDetail(
      this.orderID, this.vendorId);

  @override
  List<Object> get props => [orderID, vendorId];
}

class MapScreenResetEvent extends OrderHistoryEvent {
  String driverLat;
  String driverLong;
  String userLat;
  String userLong;
  String vendorId;

  MapScreenResetEvent(this.driverLat, this.driverLong, this.userLat,
      this.userLong, this.vendorId);

  @override
  List<Object> get props =>
      [driverLat, driverLong, userLat, userLong, vendorId];
}

class MapScreenEventForVendorUpdateLocation extends OrderHistoryEvent {
  String vendorId;

  MapScreenEventForVendorUpdateLocation(this.vendorId);

  @override
  List<Object> get props => [vendorId];
}

class OrderTrackEventForMapScreen extends OrderHistoryEvent {
  String driverLat;
  String driverLong;
  String userLat;
  String userLong;
  String vendorID;

  OrderTrackEventForMapScreen(this.driverLat, this.driverLong, this.userLat,
      this.userLong, this.vendorID);

  @override
  List<Object> get props =>
      [driverLat, driverLong, userLat, userLong, vendorID];
}

class OrderHistoryRatingButtonClick extends OrderHistoryEvent {
  String reviewText;
  double ratingCount;
  int vendorId;

  OrderHistoryRatingButtonClick(
      this.reviewText, this.ratingCount, this.vendorId);

  @override
  List<Object> get props => [reviewText, ratingCount, vendorId];
}

class OrderHistoryDetailPageReset extends OrderHistoryEvent {}
