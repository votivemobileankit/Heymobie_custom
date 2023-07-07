part of 'event_history_bloc.dart';

@immutable
abstract class EventHistoryEvent extends Equatable {
  const EventHistoryEvent();

  @override
  List<Object> get props => [];
}

class EventHistoryEventReset extends EventHistoryEvent {}

class EventViewDetailEventClicked extends EventHistoryEvent {
  String order_id;

  EventViewDetailEventClicked(this.order_id);

  @override
  List<Object> get props => [order_id];
}

class EventHistorybtnEvent extends EventHistoryEvent {
  String pageNumber;

  EventHistorybtnEvent(this.pageNumber);

  @override
  List<Object> get props => [pageNumber];
}

class EventHistoryStateReset extends EventHistoryEvent {}

class EventListDetailEventForViewDetail extends EventHistoryEvent {
  String order_id;
  String vendorId;

  EventListDetailEventForViewDetail(this.order_id, this.vendorId);

  @override
  List<Object> get props => [order_id, vendorId];
}

class EventDetailStateReset extends EventHistoryEvent {}
