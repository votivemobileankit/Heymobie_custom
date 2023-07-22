import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grambunny_customer/ridehistory/model/ride_detail_model.dart';
import 'package:meta/meta.dart';

import '../../hm_root/user_repository.dart';
import '../../networking/network_api_call_state.dart';
import '../../utils/enumerations.dart';
import '../model/ride_history_model.dart';

part 'ride_history_event.dart';

part 'ride_history_state.dart';

class RideHistoryBloc extends Bloc<RideHistoryEvent, RideHistoryState> {
  UserRepository? _userRepository;

  RideHistoryBloc({required UserRepository userRepository})
      : super(RideHistoryInitial()) {
    _userRepository = userRepository;
    on<RideHistorybtnEvent>(mapRideHistorybtnEvent);

    on<RideHistoryStateReset>(mapRideHistoryStateReset);

    on<RideViewDetailEventClicked>(mapRideViewDetailEventClicked);

    on<RideListDetailEventForViewDetail>(mapRideListDetailEventForViewDetail);
    on<RideDetailStateReset>(mapRideDetailStateReset);
  }

  mapRideHistorybtnEvent(
      RideHistorybtnEvent event, Emitter<RideHistoryState> emitter) async {
    NetworkApiCallState<bool> apiCallState =
        await _userRepository!.getRideHistoryApi(event.pageNumber);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      print("Complete state");
      _userRepository!.ScreenName = ScreenNavigation.EventHistoryPage;
      emit(RideHistoryApiLoadingCompleteState(
          _userRepository!.getRideHistoryData()!, 0));
    } else {
      print("EventHostoryLoadingErrortate");
      emit(RideHisyoryLoadingErrorState(apiCallState.message!));
    }
  }

  mapRideHistoryStateReset(
      RideHistoryStateReset event, Emitter<RideHistoryState> emitter) async {
    emitter(RideHistoryInitial());
  }

  mapRideViewDetailEventClicked(RideViewDetailEventClicked event,
      Emitter<RideHistoryState> emitter) async {
    emitter(RideListDatailPageState(event.order_id));
  }

  mapRideListDetailEventForViewDetail(RideListDetailEventForViewDetail event,
      Emitter<RideHistoryState> emitter) async {
    NetworkApiCallState<bool> apiCallState =
        await _userRepository!.RideDetailAPi(event.order_id, event.vendorId);

    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      print("Complete state");
      emit(RideListDetailApiLoadingCompleteState(
          _userRepository!.rideDetail,
          _userRepository!.rideItems,
          _userRepository!.timeresponse,
          _userRepository!.ridedetailmodel));
    } else {
      print("RideListDetailLoadingErrorStatetate");
      emit(RideListDetailLoadingErrorState(apiCallState.message!));
    }
  }

  mapRideDetailStateReset(
      RideDetailStateReset event, Emitter<RideHistoryState> emitter) async {
    emitter(RideHistoryInitial());
  }
}
