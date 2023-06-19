import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:grambunny_customer/hm_root/hm_root.dart';
import 'package:grambunny_customer/networking/networking.dart';
import 'package:grambunny_customer/utils/utils.dart';

import '../setting.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  UserRepository? _userRepository;

  SettingBloc({required UserRepository userRepository}) : super(SettingInitial()) {
    _userRepository = userRepository;

    on<SettingEventCallSettingApi>(mapSettingEventCallSettingApi);
    on<SettingEventBackBtnClick>(mapSettingEventBackBtnClick);
    on<SettingEventResetInitialState>(mapSettingEventResetInitialState);
    on<SettingEventUpdateNotification>(mapSettingEventUpdateNotificationState);
    on<SettingNotificationListApiCall>(mapSettingNotificationListApiCall);
    on<SettingNotificationButtonClick>(mapSettingNotificationButtonClick);
    on<NotificationListItemClick>(mapNotificationListItemClick);
    on<SettingEventNotificationStateReset>(mapSettingEventNotificationStateReset);





  }



 mapSettingEventNotificationStateReset(
      SettingEventNotificationStateReset event,Emitter<SettingState> emitter) async {
   emitter (SettingNotificationListPageState());
  }

 mapNotificationListItemClick(
      NotificationListItemClick event,Emitter<SettingState> emitter) async {
    NetworkApiCallState<bool> apiCallState =
        await _userRepository!.getOrderDetail(event.order_id, event.vendorId);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      print("Complete state");
      _userRepository!.ScreenName =
          ScreenNavigation.OrderHistoryDetailPageScreen;
      if (apiCallState.statusValue == "1") {
        emitter( SettingNotificationDetailPageState(
            _userRepository!.getOrderDetailData()!,
            _userRepository
                !.getOrderDetailMenuItem()!,
            _userRepository!.getVendorDetailData()!));
      } else {
        //yield OrderDetailLoadingErrorState(apiCallState.message);
      }
    } else {
      print("OrderDetailLoadingErrorState state");
      // yield OrderDetailLoadingErrorState("Server Error");
    }
  }

   mapSettingNotificationButtonClick(
      SettingNotificationButtonClick event,Emitter<SettingState> emitter) async {
     emitter (SettingNotificationListPageState());
  }

 mapSettingNotificationListApiCall(
      SettingNotificationListApiCall event,Emitter<SettingState> emitter) async {
    NetworkApiCallState<bool> apiCallState =
        await _userRepository!.getNotificationListApiCall(event.pageCount);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        emitter (SettingNotificationDataListState(
            _userRepository!.getNotificationDataList()!, event.isRefresh));
      } else {
        emitter (SettingErrorState(apiCallState.message!));
      }
    } else if (apiCallState.status == NetworkRequestStatus.ERROR) {
      if (apiCallState.message == "Unknown Error") {
        emitter (SettingErrorState("Something went wrong"));
      } else {
        emitter (SettingErrorState("Something went wrong"));
      }
    }
  }

   mapSettingEventUpdateNotificationState(
      SettingEventUpdateNotification event,Emitter<SettingState> emitter) async {
    NetworkApiCallState<bool> apiCallState =
        await _userRepository!.getSettingUpdateApi(
            event.emailStatus, event.pushNotiStatus, event.smsStatus);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        NetworkApiCallState<bool> apiCallState =
            await _userRepository!.getUserDetailApi();

        emitter( SettingUpdateUserSettingState(
            _userRepository!.getUserDetailInfo()!));
      } else {
        emitter( SettingErrorState(apiCallState.message!));
      }
    } else if (apiCallState.status == NetworkRequestStatus.ERROR) {
      if (apiCallState.message == "Unknown Error") {
        emitter(SettingErrorState("Something went wrong"));
      } else {
        emitter( SettingErrorState("Something went wrong"));
      }
    }
  }

   mapSettingEventResetInitialState(SettingEventResetInitialState event,Emitter<SettingState> emitter) async {
    emitter( SettingInitial());
  }

  mapSettingEventBackBtnClick(SettingEventBackBtnClick event,Emitter<SettingState> emitter) async {
    print(state.toString());
    if (state is SettingGetUserSettingDataState) {
      print("profile back");
      emitter( SettingNavigateToHomePageState());
    } else if (state is SettingUpdateUserSettingState) {
      emitter( SettingNavigateToHomePageState());
    } else if (state is SettingNotificationDataListState) {
      emitter( SettingUpdateUserSettingState(_userRepository!.getUserDetailInfo()!));
    } else if (state is SettingNotificationDetailPageState) {
      emitter( SettingNotificationDataListState(
          _userRepository!.getNotificationDataList()!, "0"));
    } else if (state is SettingNotificationListPageState) {
      emitter( SettingUpdateUserSettingState(_userRepository!.getUserDetailInfo()!));
    }
  }

  mapSettingEventCallSettingApi(SettingEventCallSettingApi event,Emitter<SettingState> emitter) async {
    //_userRepository.ScreenName = HomeMainPageScreen;
    NetworkApiCallState<bool> apiCallState =
        await _userRepository!.getUserDetailApi();

    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        print("demo name");
        emitter( SettingGetUserSettingDataState(
            _userRepository!.getUserDetailInfo()!));
      } else {
        emitter( SettingErrorState(apiCallState.message!));
      }
    } else if (apiCallState.status == NetworkRequestStatus.ERROR) {
      if (apiCallState.message == "Unknown Error") {
        emitter( SettingErrorState("Something went wrong"));
      } else {
        emitter( SettingErrorState("Something went wrong"));
      }
    }
  }
}
