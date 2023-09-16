import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:grambunny_customer/hm_root/hm_root.dart';
import 'package:grambunny_customer/networking/networking.dart';
import 'package:grambunny_customer/services/services.dart';
import 'package:grambunny_customer/utils/utils.dart';

import '../orderhistory.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  UserRepository? _userRepository;

  OrderHistoryBloc({required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(OrderHistoryInitial()) {
    on<OrderHistoryEvent>((event, emit) {
      if (event is OrderHistoryEventRowItemClick) {
        mapOrderHistoryEventRowItemClick(event);
      } else if (event is OrderEventBackBtnClicked) {
        mapOrderEventBackBtnClicked();
      } else if (event is OrderHistoryEventReset) {
        mapOrderHistoryEventReset();
      } else if (event is OrderHistoryEventForOrderList) {
        mapOrderHistoryEventForOrderList(event);
      } else if (event is OrderHistoryEventRefreshOrderList) {
        mapOrderHistoryEventRefreshOrderList(event);
      } else if (event is OrderHistoryEventForOrderDeatil) {
        mapOrderDetailEventForOrderDeatil(event);
      } else if (event
          is OrderHistoryEventNavigateFromNoticationToOrderDetail) {
        mapOrderHistoryEventNavigateFromNoticationToOrderDetail(event);
      } else if (event is OrderTrackEventForMapScreen) {
        mapOrderTrackEventForMapScreen(event);
      } else if (event is MapScreenEventForVendorUpdateLocation) {
        mapMapScreenEventForVendorUpdateLocation(event);
      } else if (event is MapScreenResetEvent) {
        mapMapScreenResetEvent(event);
      } else if (event is OrderHistoryRatingButtonClick) {
        mapOrderHistoryRatingButtonClick(event);
      }
    });
  }

  Future<void> mapOrderHistoryRatingButtonClick(
      OrderHistoryRatingButtonClick event) async {
    NetworkApiCallState<bool> apiCallState = await _userRepository!
        .postMerchantRatingReviewApi(
            '${event.vendorId}', '${event.ratingCount}', event.reviewText);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        emit(OrderMerchantRatingSubmitState(apiCallState.message!));
      } else {
        emit(OrderDetailLoadingErrorState("Something went wrong"));
      }
    } else if (apiCallState.status == NetworkRequestStatus.ERROR) {
      if (apiCallState.message == "Unknown Error") {
        emit(OrderDetailLoadingErrorState("Something went wrong"));
      } else {
        emit(OrderDetailLoadingErrorState("Something went wrong"));
      }
    }
  }

  Future<void> mapMapScreenResetEvent(MapScreenResetEvent event) async {
    //print("emailllllll===>>>" + event.email);
    emit(MapOrderTrackPageState(event.driverLat, event.driverLong,
        event.userLat, event.userLong, event.vendorId));
  }

  Future<void> mapMapScreenEventForVendorUpdateLocation(
      MapScreenEventForVendorUpdateLocation event) async {
    NetworkApiCallState<bool> apiCallState =
        await _userRepository!.vendorLocationUpdate(vendorID: event.vendorId);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        emit(vendorUpdateLocationApiLoadingCompleteState(
            apiCallState.message!, _userRepository!.getVendorLatLong()!));
      } else {
        emit(vendorUpdateLocationApiErrorState(apiCallState.message!));
      }
    } else if (apiCallState.status == NetworkRequestStatus.ERROR) {
      if (apiCallState.message == "Unknown Error") {
        emit(vendorUpdateLocationApiErrorState("Something went wrong"));
      } else {
        emit(vendorUpdateLocationApiErrorState("Something went wrong"));
      }
    }
  }

  Future<void> mapOrderHistoryEventNavigateFromNoticationToOrderDetail(
      OrderHistoryEventNavigateFromNoticationToOrderDetail event) async {
    NetworkApiCallState<bool> apiCallState =
        await _userRepository!.getOrderDetail(event.orderID, event.vendorId);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      print("Complete state");
      _userRepository!.ScreenName =
          ScreenNavigation.OrderHistoryDetailPageScreen;
      if (apiCallState.statusValue == "1") {
        emit(OrderDetailApiLoadingCompleteState(
            _userRepository!.getOrderDetailData()!,
            _userRepository!.getOrderDetailMenuItem()!,
            _userRepository!.getVendorDetailData()!));
      } else {
        emit(OrderDetailLoadingErrorState(apiCallState.message!));
      }
    } else {
      print("OrderDetailLoadingErrorState state");
      emit(OrderDetailLoadingErrorState("Server Error"));
    }
  }

  Future<void> mapOrderDetailEventForOrderDeatil(
      OrderHistoryEventForOrderDeatil event) async {
    NetworkApiCallState<bool> apiCallState =
        await _userRepository!.getOrderDetail(event.order_id, event.vendorId);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      print("Complete state");
      _userRepository!.ScreenName =
          ScreenNavigation.OrderHistoryDetailPageScreen;
      if (apiCallState.statusValue == "1") {
        emit(OrderDetailApiLoadingCompleteState(
            _userRepository!.getOrderDetailData()!,
            _userRepository!.getOrderDetailMenuItem()!,
            _userRepository!.getVendorDetailData()!));
      } else {
        emit(OrderDetailLoadingErrorState(apiCallState.message!));
      }
    } else {
      print("OrderDetailLoadingErrorState state");
      emit(OrderDetailLoadingErrorState("Server Error"));
    }
  }

  Future<void> mapOrderHistoryEventForOrderList(
      OrderHistoryEventForOrderList event) async {
    NetworkApiCallState<bool> apiCallState =
        await _userRepository!.getOrderHistoryList(event.pageNumber);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      print("Complete state");
      _userRepository!.ScreenName = ScreenNavigation.OrderHistoryPageScreen;
      if (apiCallState.statusValue == "1") {
        emit(OrderHistoryListApiLoadingCompleteState(
            _userRepository!.getOrderHistory()!, 0));
      } else {
        emit(OrderHistoryListApiLoadingCompleteState(
            _userRepository!.getOrderHistory()!, 0));
      }
    } else {
      print("OrderHistoryListLoadingErrorState state");
      emit(OrderHistoryListLoadingErrorState("Server Error"));
    }
  }

  Future<void> mapOrderHistoryEventRefreshOrderList(
      OrderHistoryEventRefreshOrderList event) async {
    NetworkApiCallState<bool> apiCallState =
        await _userRepository!.getOrderHistoryList(sharedPrefs.getUserId);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      print("Complete state");
      _userRepository!.ScreenName = ScreenNavigation.OrderHistoryPageScreen;
      if (apiCallState.statusValue == "1") {
        emit(OrderHistoryListApiLoadingCompleteState(
            _userRepository!.getOrderHistory()!, 1));
      } else {
        emit(OrderHistoryListApiLoadingCompleteState(
            _userRepository!.getOrderHistory()!, 0));
      }
    } else {
      print("OrderHistoryListLoadingErrorState state");
      emit(OrderHistoryListLoadingErrorState("Server Error"));
    }
  }

  Future<void> mapOrderHistoryEventRowItemClick(
      OrderHistoryEventRowItemClick event) async {
    _userRepository!.ScreenName = ScreenNavigation.OrderHistoryDetailPageScreen;
    emit(OrderHistoryDetailPageState(
        event.vendorId, event.orderId, event.vendorlastName, event.vendorName));
  }

  Future<void> mapOrderTrackEventForMapScreen(
      OrderTrackEventForMapScreen event) async {
    _userRepository!.ScreenName = ScreenNavigation.MapOrderTrackScreen;
    emit(MapOrderTrackPageState(event.driverLat, event.driverLong,
        event.userLat, event.userLong, event.vendorID));
  }

  Future<void> mapOrderHistoryEventReset() async {
    // _userRepository.ScreenName = OrderHistoryPageScreen;
    emit(OrderHistoryInitial());
  }

  Future<void> mapOrderEventBackBtnClicked() async {
    if (state is OrderHistoryDetailPageState) {
      // _userRepository!.ScreenName = ScreenNavigation.OrderHistoryPageScreen;
      emit(OrderHistoryInitial());
    }
    if (state is OrderHistoryInitial) {
      // print("back call");
      // _userRepository.ScreenName = HomeMainPageScreen;
      emit(OrderHistoryToNavigateHomeResetPageState());
    }
    if (state is OrderDetailApiLoadingCompleteState) {
      emit(OrderHistoryInitial());
    }
    if (state is MapOrderTrackPageState) {
      emit(OrderHistoryDetailPageState("", "", "", ""));
    }
  }
}
