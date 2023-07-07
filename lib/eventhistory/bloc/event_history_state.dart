part of 'event_history_bloc.dart';

@immutable
abstract class EventHistoryState extends Equatable {
  const EventHistoryState();

  @override
  List<Object> get props => [];
}

class EventHistoryInitial extends EventHistoryState {
  @override
  List<Object> get props => [];
}

class EventHistoryListApiLoadingResetState extends EventHistoryState {}

class EventDetailPageState extends EventHistoryState {
  String order_id;

  EventDetailPageState(this.order_id);

  @override
  List<Object> get props => [];
}

class EventHistoryApiLoadingCompleteState extends EventHistoryState {
  List<EventHistoryListData>? eventHistoryList;
  int refresh;

  EventHistoryApiLoadingCompleteState(this.eventHistoryList, this.refresh);

  List<Object> get props => [eventHistoryList ?? [], refresh];
}

class EventHisyoryLoadingErrorState extends EventHistoryState {
  String message;

  EventHisyoryLoadingErrorState(this.message);

  List<Object> get props => [message];
}

class EventListDetailApiLoadingCompleteState extends EventHistoryState {
  List<EventViewDetail>? eventDetail;
  List<EventViewItems>? eventItems;
  List<EventMultipleDetail>? eventmultipleDetail;

  EventListDetailApiLoadingCompleteState(
      this.eventDetail, this.eventItems, this.eventmultipleDetail);

  List<Object> get props => [eventDetail!, eventItems!, eventmultipleDetail!];
}

class EventListDetailLoadingErrorState extends EventHistoryState {
  String message;

  EventListDetailLoadingErrorState(this.message);

  List<Object> get props => [message];
}
