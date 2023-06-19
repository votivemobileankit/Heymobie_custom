import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:grambunny_customer/hm_root/hm_root.dart';
import 'package:grambunny_customer/networking/networking.dart';
import 'package:grambunny_customer/services/services.dart';
import 'package:grambunny_customer/utils/utils.dart';

import '../orderhistory.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  late UserRepository _userRepository;

  OrderHistoryBloc({required UserRepository userRepository}): super(OrderHistoryInitial()){

        _userRepository = userRepository;

        on<OrderHistoryEventRowItemClick>(mapOrderHistoryEventRowItemClick);
        on<OrderEventBackBtnClicked>(mapOrderEventBackBtnClicked);
        on<OrderHistoryEventReset>(mapOrderHistoryEventReset);
        on<OrderHistoryEventForOrderList>(mapOrderHistoryEventForOrderList);
        on<OrderHistoryEventRefreshOrderList>(mapOrderHistoryEventRefreshOrderList);
        on<OrderHistoryEventForOrderDeatil>(mapOrderDetailEventForOrderDeatil);
        on<OrderHistoryEventNavigateFromNoticationToOrderDetail>(mapOrderHistoryEventNavigateFromNoticationToOrderDetail);
        on<OrderTrackEventForMapScreen>(mapOrderTrackEventForMapScreen);
         on<MapScreenResetEvent>(mapMapScreenResetEvent);
         on<OrderHistoryRatingButtonClick>(mapOrderHistoryRatingButtonClick);














  }

 mapOrderHistoryRatingButtonClick(
     OrderHistoryRatingButtonClick event,Emitter<OrderHistoryState> emitter) async* {
    NetworkApiCallState<bool> apiCallState =
        await _userRepository.postMerchantRatingReviewApi(
            '${event.vendorId}', '${event.ratingCount}', event.reviewText);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        emitter( OrderMerchantRatingSubmitState(apiCallState.message!));
      } else {
        emitter( OrderDetailLoadingErrorState("Something went wrong"));
      }
    } else if (apiCallState.status == NetworkRequestStatus.ERROR) {
      if (apiCallState.message == "Unknown Error") {
        emitter( OrderDetailLoadingErrorState("Something went wrong"));
      } else {
        emitter( OrderDetailLoadingErrorState("Something went wrong"));
      }
    }
  }

  Stream<OrderHistoryState> mapMapScreenResetEvent(
      MapScreenResetEvent event,Emitter<OrderHistoryState> emitter) async* {
    //print("emailllllll===>>>" + event.email);
    emitter (MapOrderTrackPageState(event.driverLat, event.driverLong,
        event.userLat, event.userLong, event.vendorId));
  }

 mapMapScreenEventForVendorUpdateLocation(
      MapScreenEventForVendorUpdateLocation event,Emitter<OrderHistoryState> emitter) async* {
    NetworkApiCallState<bool> apiCallState =
        await _userRepository.vendorLocationUpdate(vendorID: event.vendorId);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        emitter (vendorUpdateLocationApiLoadingCompleteState(
            apiCallState.message!, _userRepository.getVendorLatLong()!));
      } else {
        emitter ( vendorUpdateLocationApiErrorState(apiCallState.message!));
      }
    } else if (apiCallState.status == NetworkRequestStatus.ERROR) {
      if (apiCallState.message == "Unknown Error") {
        emitter ( vendorUpdateLocationApiErrorState("Something went wrong"));
      } else {
        emitter ( vendorUpdateLocationApiErrorState("Something went wrong"));
      }
    }
  }


      mapOrderHistoryEventNavigateFromNoticationToOrderDetail(
          OrderHistoryEventNavigateFromNoticationToOrderDetail event,Emitter<OrderHistoryState> emitter) async {
    NetworkApiCallState<bool> apiCallState =
        await _userRepository.getOrderDetail(event.orderID, event.vendorId);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      print("Complete state");
      _userRepository.ScreenName =
          ScreenNavigation.OrderHistoryDetailPageScreen;
      if (apiCallState.statusValue == "1") {
        emitter (OrderDetailApiLoadingCompleteState(
            _userRepository.getOrderDetailData()!,
            _userRepository.getOrderDetailMenuItem()!,
            _userRepository.getVendorDetailData()!));
      } else {
        emitter ( OrderDetailLoadingErrorState(apiCallState.message!));
      }
    } else {
      print("OrderDetailLoadingErrorState state");
      emitter ( OrderDetailLoadingErrorState("Server Error"));
    }
  }

  mapOrderDetailEventForOrderDeatil(
      OrderHistoryEventForOrderDeatil event,Emitter<OrderHistoryState> emitter) async {
    NetworkApiCallState<bool> apiCallState =
        await _userRepository.getOrderDetail(event.orderID, event.vendorId);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      print("Complete state");
      _userRepository.ScreenName =
          ScreenNavigation.OrderHistoryDetailPageScreen;
      if (apiCallState.statusValue == "1") {
        emitter(OrderDetailApiLoadingCompleteState(
            _userRepository.getOrderDetailData()!,
            _userRepository.getOrderDetailMenuItem()!,
            _userRepository.getVendorDetailData()!));
      } else {
        emitter( OrderDetailLoadingErrorState(apiCallState.message!));
      }
    } else {
      print("OrderDetailLoadingErrorState state");
      emitter( OrderDetailLoadingErrorState("Server Error"));
    }
  }

  Stream<OrderHistoryState> mapOrderHistoryEventForOrderList(
      OrderHistoryEventForOrderList event,Emitter<OrderHistoryState> emitter) async* {
    NetworkApiCallState<bool> apiCallState =
        await _userRepository.getOrderHistoryList(event.pageNumber);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      print("Complete state");
      _userRepository.ScreenName = ScreenNavigation.OrderHistoryPageScreen;
      if (apiCallState.statusValue == "1") {
        emitter (OrderHistoryListApiLoadingCompleteState(
            _userRepository.getOrderHistory()!, 0));
      } else {
        emitter ( OrderHistoryListApiLoadingCompleteState(
            _userRepository.getOrderHistory()!, 0));
      }
    } else {
      print("OrderHistoryListLoadingErrorState state");
      emitter (  OrderHistoryListLoadingErrorState("Server Error"));
    }
  }

  Stream<OrderHistoryState> mapOrderHistoryEventRefreshOrderList(
      OrderHistoryEventRefreshOrderList event,Emitter<OrderHistoryState> emitter) async* {
    NetworkApiCallState<bool> apiCallState =
        await _userRepository.getOrderHistoryList(sharedPrefs.getUserId);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      print("Complete state");
      _userRepository.ScreenName = ScreenNavigation.OrderHistoryPageScreen;
      if (apiCallState.statusValue == "1") {
        emitter( OrderHistoryListApiLoadingCompleteState(
            _userRepository.getOrderHistory()!, 1));
      } else {
        emitter( OrderHistoryListApiLoadingCompleteState(
            _userRepository.getOrderHistory()!, 0));
      }
    } else {
      print("OrderHistoryListLoadingErrorState state");
      emitter( OrderHistoryListLoadingErrorState("Server Error"));
    }
  }

  mapOrderHistoryEventRowItemClick(
      OrderHistoryEventRowItemClick event,Emitter<OrderHistoryState> emitter) async {
    _userRepository.ScreenName = ScreenNavigation.OrderHistoryDetailPageScreen;
    emitter (OrderHistoryDetailPageState(
        event.vendorId, event.orderId, event.vendorlastName, event.vendorName));
  }

   mapOrderTrackEventForMapScreen(
      OrderTrackEventForMapScreen event,Emitter<OrderHistoryState> emitter) async* {
    _userRepository.ScreenName = ScreenNavigation.MapOrderTrackScreen;
    emitter( MapOrderTrackPageState(event.driverLat, event.driverLong,
        event.userLat, event.userLong, event.vendorID));
  }

   mapOrderHistoryEventReset(OrderHistoryEventReset event, Emitter<OrderHistoryState> emitter) async {
    // _userRepository.ScreenName = OrderHistoryPageScreen;
    emitter (OrderHistoryInitial());
  }

   mapOrderEventBackBtnClicked(OrderEventBackBtnClicked event,Emitter<OrderHistoryState> emitter) async* {
    if (state is OrderHistoryDetailPageState) {
      _userRepository.ScreenName = ScreenNavigation.OrderHistoryPageScreen;
      emitter( OrderHistoryInitial());
    }
    if (state is OrderHistoryInitial) {
      // print("back call");
      // _userRepository.ScreenName = HomeMainPageScreen;
      emitter( OrderHistoryToNavigateHomeResetPageState());
    }
    if (state is OrderDetailApiLoadingCompleteState) {
      emitter( OrderHistoryInitial());
    }
    if (state is MapOrderTrackPageState) {
      emitter( OrderHistoryDetailPageState("", "", "", ""));
    }
  }
}
