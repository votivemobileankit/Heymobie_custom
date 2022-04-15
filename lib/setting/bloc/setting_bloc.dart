import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:grambunny_customer/hm_root/hm_root.dart';
import 'package:grambunny_customer/networking/networking.dart';
import 'package:grambunny_customer/utils/utils.dart';

import '../setting.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  UserRepository _userRepository;

  SettingBloc({UserRepository userRepository}) : super(SettingInitial()) {
    _userRepository = userRepository;
  }

  @override
  Stream<SettingState> mapEventToState(
    SettingEvent event,
  ) async* {
    switch (event.runtimeType) {
      case SettingEventCallSettingApi:
        yield* mapSettingEventCallSettingApi();
        break;
      case SettingEventBackBtnClick:
        yield* mapSettingEventBackBtnClick();
        break;
      case SettingEventResetInitialState:
        yield* mapSettingEventResetInitialState();
        break;
      case SettingEventUpdateNotification:
        yield* mapSettingEventUpdateNotificationState(event);
        break;
      case SettingNotificationListApiCall:
        yield* mapSettingNotificationListApiCall(event);
        break;
      case SettingNotificationButtonClick:
        yield* mapSettingNotificationButtonClick(event);
        break;
      case NotificationListItemClick:
        yield* mapNotificationListItemClick(event);
        break;
      case SettingEventNotificationStateReset:
        yield* mapSettingEventNotificationStateReset(event);
        break;
    }
  }

  Stream<SettingState> mapSettingEventNotificationStateReset(
      SettingEventNotificationStateReset event) async* {
    yield SettingNotificationListPageState();
  }

  Stream<SettingState> mapNotificationListItemClick(
      NotificationListItemClick event) async* {
    NetworkApiCallState<bool> apiCallState =
        await _userRepository.getOrderDetail(event.order_id, event.vendorId);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      print("Complete state");
      _userRepository.ScreenName =
          ScreenNavigation.OrderHistoryDetailPageScreen;
      if (apiCallState.statusValue == "1") {
        yield SettingNotificationDetailPageState(
            _userRepository.getOrderDetailData(),
            _userRepository.getOrderDetailMenuItem(),
            _userRepository.getVendorDetailData());
      } else {
        //yield OrderDetailLoadingErrorState(apiCallState.message);
      }
    } else {
      print("OrderDetailLoadingErrorState state");
      // yield OrderDetailLoadingErrorState("Server Error");
    }
  }

  Stream<SettingState> mapSettingNotificationButtonClick(
      SettingNotificationButtonClick event) async* {
    yield SettingNotificationListPageState();
  }

  Stream<SettingState> mapSettingNotificationListApiCall(
      SettingNotificationListApiCall event) async* {
    NetworkApiCallState<bool> apiCallState =
        await _userRepository.getNotificationListApiCall(event.pageCount);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        yield SettingNotificationDataListState(
            _userRepository.getNotificationDataList(), event.isRefresh);
      } else {
        yield SettingErrorState(apiCallState.message);
      }
    } else if (apiCallState.status == NetworkRequestStatus.ERROR) {
      if (apiCallState.message == "Unknown Error") {
        yield SettingErrorState("Something went wrong");
      } else {
        yield SettingErrorState("Something went wrong");
      }
    }
  }

  Stream<SettingState> mapSettingEventUpdateNotificationState(
      SettingEventUpdateNotification event) async* {
    NetworkApiCallState<bool> apiCallState =
        await _userRepository.getSettingUpdateApi(
            event.emailStatus, event.pushNotiStatus, event.smsStatus);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        NetworkApiCallState<bool> apiCallState =
            await _userRepository.getUserDetailApi();

        yield SettingUpdateUserSettingState(
            _userRepository.getUserDetailInfo());
      } else {
        yield SettingErrorState(apiCallState.message);
      }
    } else if (apiCallState.status == NetworkRequestStatus.ERROR) {
      if (apiCallState.message == "Unknown Error") {
        yield SettingErrorState("Something went wrong");
      } else {
        yield SettingErrorState("Something went wrong");
      }
    }
  }

  Stream<SettingState> mapSettingEventResetInitialState() async* {
    yield SettingInitial();
  }

  Stream<SettingState> mapSettingEventBackBtnClick() async* {
    print(state.toString());
    if (state is SettingGetUserSettingDataState) {
      print("profile back");
      yield SettingNavigateToHomePageState();
    } else if (state is SettingUpdateUserSettingState) {
      yield SettingNavigateToHomePageState();
    } else if (state is SettingNotificationDataListState) {
      yield SettingUpdateUserSettingState(_userRepository.getUserDetailInfo());
    } else if (state is SettingNotificationDetailPageState) {
      yield SettingNotificationDataListState(
          _userRepository.getNotificationDataList(), "0");
    } else if (state is SettingNotificationListPageState) {
      yield SettingUpdateUserSettingState(_userRepository.getUserDetailInfo());
    }
  }

  Stream<SettingState> mapSettingEventCallSettingApi() async* {
    //_userRepository.ScreenName = HomeMainPageScreen;
    NetworkApiCallState<bool> apiCallState =
        await _userRepository.getUserDetailApi();

    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        print("demo name");
        yield SettingGetUserSettingDataState(
            _userRepository.getUserDetailInfo());
      } else {
        yield SettingErrorState(apiCallState.message);
      }
    } else if (apiCallState.status == NetworkRequestStatus.ERROR) {
      if (apiCallState.message == "Unknown Error") {
        yield SettingErrorState("Something went wrong");
      } else {
        yield SettingErrorState("Something went wrong");
      }
    }
  }
}
