part of 'ride_history_bloc.dart';

@immutable
abstract class RideHistoryEvent extends Equatable {
  const RideHistoryEvent();

  @override
  List<Object> get props => [];
}

class RideHistorybtnEvent extends RideHistoryEvent {
  String pageNumber;

  RideHistorybtnEvent(this.pageNumber);

  @override
  List<Object> get props => [pageNumber];
}

class RideHistoryStateReset extends RideHistoryEvent {}

class RideViewDetailEventClicked extends RideHistoryEvent {
  String order_id;

  RideViewDetailEventClicked(this.order_id);

  @override
  List<Object> get props => [order_id];
}

class RideListDetailEventForViewDetail extends RideHistoryEvent {
  String order_id;
  String vendorId;

  RideListDetailEventForViewDetail(this.order_id, this.vendorId);

  @override
  List<Object> get props => [order_id, vendorId];
}

class RideDetailStateReset extends RideHistoryEvent {}
