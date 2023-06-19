import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:grambunny_customer/hm_root/hm_root.dart';
import 'package:grambunny_customer/side_navigation/bloc/bloc.dart';
import 'package:grambunny_customer/utils/utils.dart';

class SideNavigatBloc extends Bloc<SideNavigatEvent, SideNavigatState> {
  UserRepository? _userRepository;

  SideNavigatBloc({required UserRepository userRepository})
      : super(SideNavigationDefaultState(selectedTab: SideNavigationTab.HOME,orderId: "0",driverId: "0")) {
    _userRepository = userRepository;

    on<SideNavigationEventTabChanged>(mapTabChangedToState);
    on<SideNavigationEventGoToHomePage>(mapNavigationEventGoToHomePage);
    on<SideNavigationEventGoToHomePageFromHistory>(
        mapSideNavigationEventGoToHomePageFromHistory);
    on<SideNavigationEventToggleLoadingAnimation>(mapToggleLoadingAnimation);
    on<SideNavigationEventSettingPage>(mapSideNavigationEventSettingPage);
    on<SideNavigationEventSettingPageReset>(
        mapSideNavigationEventSettingPageReset);
    on<SideNavigationEventGoToOrderHistoryList>(
        mapSideNavigationEventGoToOrderHistoryList);
    on<SideNavigationEventGoToOrderDetailPage>(
        mapSideNavigationEventGoToOrderDetailPage);
    on<SideNavigationEventGoToOrderDetailPageHandel>(
        mapSideNavigationEventGoToOrderDetailPageHandel);
  }

  Future<void> mapSideNavigationEventGoToOrderDetailPageHandel(
      SideNavigationEventGoToOrderDetailPageHandel event,
      Emitter<SideNavigatState> emitter) async {
    emitter((state as SideNavigationDefaultState).copyWith(
        selectedTab: SideNavigationTab.ORDERHISTORY,
        driverId: "",
        orderId: "",
        goToOrderDetail: false,
        fromNotification: false));
  }

  Future<void> mapSideNavigationEventGoToOrderDetailPage(
      SideNavigationEventGoToOrderDetailPage event,
      Emitter<SideNavigatState> emitter) async {
    print("order history change");
    emitter((state as SideNavigationDefaultState).copyWith(
        selectedTab: SideNavigationTab.ORDERHISTORY,
        driverId: event.driverId,
        orderId: event.orderId,
        goToOrderDetail: true,
        fromNotification: event.isFromNotification));
  }

  Future<void> mapToggleLoadingAnimation(
      SideNavigationEventToggleLoadingAnimation event,
      Emitter<SideNavigatState> emitter) async {
    emitter((state as SideNavigationDefaultState)
        .copyWith(showLoadingAnimation: event.needToShow));
  }

  Future<void> mapSideNavigationEventGoToOrderHistoryList(
      SideNavigationEventGoToOrderHistoryList event,
      Emitter<SideNavigatState> emitter) async {
    emitter((state as SideNavigationDefaultState).copyWith(
      selectedTab: SideNavigationTab.ORDERHISTORY,
    ));
  }

  Future<void> mapSideNavigationEventSettingPage(
      SideNavigationEventSettingPage event,
      Emitter<SideNavigatState> emitter) async {
    print("Tab changed in cart ");

    emitter((state as SideNavigationDefaultState)
        .copyWith(selectedTab: SideNavigationTab.HOME, goToCart: true));
  }

  Future<void> mapSideNavigationEventSettingPageReset(
      SideNavigationEventSettingPageReset event,
      Emitter<SideNavigatState> emitter) async {
    print("Tab changed");
    //  print(event.selectedTab);
    emitter((state as SideNavigationDefaultState)
        .copyWith(selectedTab: SideNavigationTab.HOME, goToCart: false));
  }

  Future<void> mapNavigationEventGoToHomePage(
      SideNavigationEventGoToHomePage event,
      Emitter<SideNavigatState> emitter) async {
    emitter((state as SideNavigationDefaultState)
        .copyWith(selectedTab: SideNavigationTab.HOME));
    _userRepository!.ScreenName = ScreenNavigation.HomeMainPageScreen;
  }

  Future<void> mapTabChangedToState(SideNavigationEventTabChanged event,
      Emitter<SideNavigatState> emitter) async {
    emitter((state as SideNavigationDefaultState)
        .copyWith(selectedTab: event.selectedTab));
  }

  Future<void> mapSideNavigationEventGoToHomePageFromHistory(
      SideNavigationEventGoToHomePageFromHistory event,
      Emitter<SideNavigatState> emitter) async {
    print("Tab from history changed");
    _userRepository!.ScreenName = ScreenNavigation.HomeMainPageScreen;
    //yield SideNavigationDefaultState(selectedTab: SideNavigationTab.HOME);
    emitter((state as SideNavigationDefaultState)
        .copyWith(selectedTab: SideNavigationTab.HOME));
  }
}
