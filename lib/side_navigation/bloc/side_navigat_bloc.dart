import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:grambunny_customer/hm_root/hm_root.dart';
import 'package:grambunny_customer/side_navigation/bloc/bloc.dart';
import 'package:grambunny_customer/utils/utils.dart';

class SideNavigatBloc extends Bloc<SideNavigatEvent, SideNavigatState> {
  UserRepository _userRepository;

  SideNavigatBloc({UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(SideNavigationDefaultState(selectedTab: SideNavigationTab.HOME));

  @override
  Stream<SideNavigatState> mapEventToState(
    SideNavigatEvent event,
  ) async* {
    // TODO: implement mapEventToState
    switch (event.runtimeType) {
      case SideNavigationEventTabChanged:
        yield* mapTabChangedToState(event);
        break;
      case SideNavigationEventGoToHomePage:
        yield* mapNavigationEventGoToHomePage(event);
        break;
      case SideNavigationEventGoToHomePageFromHistory:
        yield* mapSideNavigationEventGoToHomePageFromHistory();
        break;
      case SideNavigationEventToggleLoadingAnimation:
        yield* mapToggleLoadingAnimation(event);
        break;
      case SideNavigationEventSettingPage:
        yield* mapSideNavigationEventSettingPage();
        break;
      case SideNavigationEventSettingPageReset:
        yield* mapSideNavigationEventSettingPageReset();
        break;
      case SideNavigationEventGoToOrderHistoryList:
        yield* mapSideNavigationEventGoToOrderHistoryList(event);
        break;
      case SideNavigationEventGoToOrderDetailPage:
        yield* mapSideNavigationEventGoToOrderDetailPage(event);
        break;
      case SideNavigationEventGoToOrderDetailPageHandel:
        yield* mapSideNavigationEventGoToOrderDetailPageHandel(event);
        break;
    }
  }

  Stream<SideNavigatState> mapSideNavigationEventGoToOrderDetailPageHandel(
      SideNavigationEventGoToOrderDetailPageHandel event) async* {
    yield (state as SideNavigationDefaultState).copyWith(
        selectedTab: SideNavigationTab.ORDERHISTORY,
        driverId: "",
        orderId: "",
        goToOrderDetail: false,
        fromNotification: false);
  }

  Stream<SideNavigatState> mapSideNavigationEventGoToOrderDetailPage(
      SideNavigationEventGoToOrderDetailPage event) async* {
    print("order history change");
    yield (state as SideNavigationDefaultState).copyWith(
        selectedTab: SideNavigationTab.ORDERHISTORY,
        driverId: event.driverId,
        orderId: event.orderId,
        goToOrderDetail: true,
        fromNotification: event.isFromNotification);
  }

  Stream<SideNavigatState> mapToggleLoadingAnimation(
      SideNavigationEventToggleLoadingAnimation event) async* {
    yield (state as SideNavigationDefaultState)
        .copyWith(showLoadingAnimation: event.needToShow);
  }

  Stream<SideNavigatState> mapSideNavigationEventGoToOrderHistoryList(
      SideNavigationEventGoToOrderHistoryList event) async* {
    yield (state as SideNavigationDefaultState).copyWith(
      selectedTab: SideNavigationTab.ORDERHISTORY,
    );
  }

  Stream<SideNavigatState> mapSideNavigationEventSettingPage() async* {
    print("Tab changed in cart ");
    //  print(event.selectedTab);
    // yield (state as SideNavigationDefaultState)
    //     .copyWith(selectedTab: SideNavigationTab.PROFILE);
    yield (state as SideNavigationDefaultState)
        .copyWith(selectedTab: SideNavigationTab.HOME, goToCart: true);
    // yield (state as SideNavigationDefaultState)
    //     .copyWith(selectedTab: SideNavigationTab.PROFILE);
  }

  Stream<SideNavigatState> mapSideNavigationEventSettingPageReset() async* {
    print("Tab changed");
    //  print(event.selectedTab);
    yield (state as SideNavigationDefaultState)
        .copyWith(selectedTab: SideNavigationTab.HOME, goToCart: false);
  }

  Stream<SideNavigatState> mapNavigationEventGoToHomePage(
      SideNavigationEventGoToHomePage event) async* {
    print("Tab changed");
    //  print(event.selectedTab);
    _userRepository.ScreenName = ScreenNavigation.HomeMainPageScreen;
    yield (state as SideNavigationDefaultState)
        .copyWith(selectedTab: SideNavigationTab.HOME);
  }

  Stream<SideNavigatState>
      mapSideNavigationEventGoToHomePageFromHistory() async* {
    print("Tab from history changed");
    _userRepository.ScreenName = ScreenNavigation.HomeMainPageScreen;
    //yield SideNavigationDefaultState(selectedTab: SideNavigationTab.HOME);
    yield (state as SideNavigationDefaultState)
        .copyWith(selectedTab: SideNavigationTab.HOME);
  }

  Stream<SideNavigatState> mapTabChangedToState(
      SideNavigationEventTabChanged event) async* {
    print("Tab changed");
    print(event.selectedTab);
    // if (event.selectedTab == "SideNavigationTab.ORDERHISTORY") {
    //   _userRepository.ScreenName = OrderHistoryPageScreen;
    // }
    yield (state as SideNavigationDefaultState)
        .copyWith(selectedTab: event.selectedTab);
  }
}
