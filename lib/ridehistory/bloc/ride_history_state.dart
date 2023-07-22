part of 'ride_history_bloc.dart';

@immutable
abstract class RideHistoryState extends Equatable {
  const RideHistoryState();

  @override
  List<Object> get props => [];
}

class RideHistoryInitial extends RideHistoryState {}

class RideHistoryApiLoadingCompleteState extends RideHistoryState {
  List<RideHistoryListData> rideHistoryList;
  int refresh;

  RideHistoryApiLoadingCompleteState(this.rideHistoryList, this.refresh);

  List<Object> get props => [rideHistoryList ?? [], refresh];
}

class RideHisyoryLoadingErrorState extends RideHistoryState {
  String message;

  RideHisyoryLoadingErrorState(this.message);

  List<Object> get props => [message];
}

class RideListDatailPageState extends RideHistoryState {
  String order_id;

  RideListDatailPageState(this.order_id);

  @override
  List<Object> get props => [];
}

class RideListDetailApiLoadingCompleteState extends RideHistoryState {
  RideDetailResponseModel? ridedetailmodel;
  List<RideViewDetail>? rideDetail;
  List<RideViewItems>? rideItems;
  String? timeresponse;

  RideListDetailApiLoadingCompleteState(
      this.rideDetail, this.rideItems, this.timeresponse, this.ridedetailmodel);

  List<Object> get props =>
      [rideDetail!, rideItems!, timeresponse!, ridedetailmodel!];
}

class RideListDetailLoadingErrorState extends RideHistoryState {
  String message;

  RideListDetailLoadingErrorState(this.message);

  List<Object> get props => [message];
}
