import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:grambunny_customer/hm_root/hm_root.dart';
import 'package:grambunny_customer/networking/networking.dart';
import 'package:grambunny_customer/services/services.dart';
import 'package:grambunny_customer/utils/utils.dart';

import '../orderhistory.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  UserRepository _userRepository;

  OrderHistoryBloc({UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(OrderHistoryInitial());

  @override
  Stream<OrderHistoryState> mapEventToState(
    OrderHistoryEvent event,
  ) async* {
    switch (event.runtimeType) {
      case OrderHistoryEventRowItemClick:
        yield* mapOrderHistoryEventRowItemClick(event);
        break;
      case OrderEventBackBtnClicked:
        yield* mapOrderEventBackBtnClicked();
        break;
      case OrderHistoryEventReset:
        yield* mapOrderHistoryEventReset();
        break;
      case OrderHistoryEventForOrderList:
        yield* mapOrderHistoryEventForOrderList(event);
        break;
      case OrderHistoryEventRefreshOrderList:
        yield* mapOrderHistoryEventRefreshOrderList(event);
        break;
      case OrderHistoryEventForOrderDeatil:
        yield* mapOrderDetailEventForOrderDeatil(event);
        break;
      case OrderHistoryEventNavigateFromNoticationToOrderDetail:
        yield* mapOrderHistoryEventNavigateFromNoticationToOrderDetail(event);
        break;

      case OrderTrackEventForMapScreen:
        yield* mapOrderTrackEventForMapScreen(event);
        break;
      case MapScreenEventForVendorUpdateLocation:
        yield* mapMapScreenEventForVendorUpdateLocation(event);
        break;
      case MapScreenResetEvent:
        yield* mapMapScreenResetEvent(event);
        break;
      case OrderHistoryRatingButtonClick:
        yield* mapOrderHistoryRatingButtonClick(event);
        break;
    }
  }

  Stream<OrderHistoryState> mapOrderHistoryRatingButtonClick(
      OrderHistoryRatingButtonClick event) async* {
    NetworkApiCallState<bool> apiCallState =
        await _userRepository.postMerchantRatingReviewApi(
            '${event.vendorId}', '${event.ratingCount}', event.reviewText);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        yield OrderMerchantRatingSubmitState(apiCallState.message);
      } else {
        yield OrderDetailLoadingErrorState("Something went wrong");
      }
    } else if (apiCallState.status == NetworkRequestStatus.ERROR) {
      if (apiCallState.message == "Unknown Error") {
        yield OrderDetailLoadingErrorState("Something went wrong");
      } else {
        yield OrderDetailLoadingErrorState("Something went wrong");
      }
    }
  }

  Stream<OrderHistoryState> mapMapScreenResetEvent(
      MapScreenResetEvent event) async* {
    //print("emailllllll===>>>" + event.email);
    yield MapOrderTrackPageState(event.driverLat, event.driverLong,
        event.userLat, event.userLong, event.vendorId);
  }

  Stream<OrderHistoryState> mapMapScreenEventForVendorUpdateLocation(
      MapScreenEventForVendorUpdateLocation event) async* {
    NetworkApiCallState<bool> apiCallState =
        await _userRepository.vendorLocationUpdate(vendorID: event.vendorId);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        yield vendorUpdateLocationApiLoadingCompleteState(
            apiCallState.message, _userRepository.getVendorLatLong());
      } else {
        yield vendorUpdateLocationApiErrorState(apiCallState.message);
      }
    } else if (apiCallState.status == NetworkRequestStatus.ERROR) {
      if (apiCallState.message == "Unknown Error") {
        yield vendorUpdateLocationApiErrorState("Something went wrong");
      } else {
        yield vendorUpdateLocationApiErrorState("Something went wrong");
      }
    }
  }

  Stream<OrderHistoryState>
      mapOrderHistoryEventNavigateFromNoticationToOrderDetail(
          OrderHistoryEventNavigateFromNoticationToOrderDetail event) async* {
    NetworkApiCallState<bool> apiCallState =
        await _userRepository.getOrderDetail(event.orderID, event.vendorId);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      print("Complete state");
      _userRepository.ScreenName =
          ScreenNavigation.OrderHistoryDetailPageScreen;
      if (apiCallState.statusValue == "1") {
        yield OrderDetailApiLoadingCompleteState(
            _userRepository.getOrderDetailData(),
            _userRepository.getOrderDetailMenuItem(),
            _userRepository.getVendorDetailData());
      } else {
        yield OrderDetailLoadingErrorState(apiCallState.message);
      }
    } else {
      print("OrderDetailLoadingErrorState state");
      yield OrderDetailLoadingErrorState("Server Error");
    }
  }

  Stream<OrderHistoryState> mapOrderDetailEventForOrderDeatil(
      OrderHistoryEventForOrderDeatil event) async* {
    NetworkApiCallState<bool> apiCallState =
        await _userRepository.getOrderDetail(event.orderID, event.vendorId);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      print("Complete state");
      _userRepository.ScreenName =
          ScreenNavigation.OrderHistoryDetailPageScreen;
      if (apiCallState.statusValue == "1") {
        yield OrderDetailApiLoadingCompleteState(
            _userRepository.getOrderDetailData(),
            _userRepository.getOrderDetailMenuItem(),
            _userRepository.getVendorDetailData());
      } else {
        yield OrderDetailLoadingErrorState(apiCallState.message);
      }
    } else {
      print("OrderDetailLoadingErrorState state");
      yield OrderDetailLoadingErrorState("Server Error");
    }
  }

  Stream<OrderHistoryState> mapOrderHistoryEventForOrderList(
      OrderHistoryEventForOrderList event) async* {
    NetworkApiCallState<bool> apiCallState =
        await _userRepository.getOrderHistoryList(event.pageNumber);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      print("Complete state");
      _userRepository.ScreenName = ScreenNavigation.OrderHistoryPageScreen;
      if (apiCallState.statusValue == "1") {
        yield OrderHistoryListApiLoadingCompleteState(
            _userRepository.getOrderHistory(), 0);
      } else {
        yield OrderHistoryListApiLoadingCompleteState(
            _userRepository.getOrderHistory(), 0);
      }
    } else {
      print("OrderHistoryListLoadingErrorState state");
      yield OrderHistoryListLoadingErrorState("Server Error");
    }
  }

  Stream<OrderHistoryState> mapOrderHistoryEventRefreshOrderList(
      OrderHistoryEventRefreshOrderList event) async* {
    NetworkApiCallState<bool> apiCallState =
        await _userRepository.getOrderHistoryList(sharedPrefs.getUserId);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      print("Complete state");
      _userRepository.ScreenName = ScreenNavigation.OrderHistoryPageScreen;
      if (apiCallState.statusValue == "1") {
        yield OrderHistoryListApiLoadingCompleteState(
            _userRepository.getOrderHistory(), 1);
      } else {
        yield OrderHistoryListApiLoadingCompleteState(
            _userRepository.getOrderHistory(), 0);
      }
    } else {
      print("OrderHistoryListLoadingErrorState state");
      yield OrderHistoryListLoadingErrorState("Server Error");
    }
  }

  Stream<OrderHistoryState> mapOrderHistoryEventRowItemClick(
      OrderHistoryEventRowItemClick event) async* {
    _userRepository.ScreenName = ScreenNavigation.OrderHistoryDetailPageScreen;
    yield OrderHistoryDetailPageState(
        event.vendorId, event.orderId, event.vendorlastName, event.vendorName);
  }

  Stream<OrderHistoryState> mapOrderTrackEventForMapScreen(
      OrderTrackEventForMapScreen event) async* {
    _userRepository.ScreenName = ScreenNavigation.MapOrderTrackScreen;
    yield MapOrderTrackPageState(event.driverLat, event.driverLong,
        event.userLat, event.userLong, event.vendorID);
  }

  Stream<OrderHistoryState> mapOrderHistoryEventReset() async* {
    // _userRepository.ScreenName = OrderHistoryPageScreen;
    yield OrderHistoryInitial();
  }

  Stream<OrderHistoryState> mapOrderEventBackBtnClicked() async* {
    if (state is OrderHistoryDetailPageState) {
      _userRepository.ScreenName = ScreenNavigation.OrderHistoryPageScreen;
      yield OrderHistoryInitial();
    }
    if (state is OrderHistoryInitial) {
      // print("back call");
      // _userRepository.ScreenName = HomeMainPageScreen;
      yield OrderHistoryToNavigateHomeResetPageState();
    }
    if (state is OrderDetailApiLoadingCompleteState) {
      yield OrderHistoryInitial();
    }
    if (state is MapOrderTrackPageState) {
      yield OrderHistoryDetailPageState("", "", "", "");
    }
  }
}
