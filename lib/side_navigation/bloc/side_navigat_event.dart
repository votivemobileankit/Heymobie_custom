import 'package:equatable/equatable.dart';
import 'package:grambunny_customer/utils/utils.dart';

abstract class SideNavigatEvent extends Equatable {
  const SideNavigatEvent();

  @override
  List<Object> get props => [];
}

class SideNavigationEventTabChanged extends SideNavigatEvent {
  SideNavigationTab selectedTab;

  SideNavigationEventTabChanged({required this.selectedTab});

  @override
  List<Object> get props => [selectedTab];
}

class SideNavigationEventGoToHomePage extends SideNavigatEvent {
  bool isFromProfile;

  SideNavigationEventGoToHomePage(this.isFromProfile);

  @override
  List<Object> get props => [isFromProfile];
}

class SideNavigationEventGoToHomePageFromHistory extends SideNavigatEvent {}

class SideNavigationEventSettingPage extends SideNavigatEvent {
  SideNavigationEventSettingPage();

  @override
  List<Object> get props => [];
}

class SideNavigationEventSettingPageReset extends SideNavigatEvent {
  SideNavigationEventSettingPageReset();

  @override
  List<Object> get props => [];
}

class SideNavigationEventToggleLoadingAnimation extends SideNavigatEvent {
  bool needToShow;

  SideNavigationEventToggleLoadingAnimation({
    required this.needToShow,
  });

  @override
  List<Object> get props => [
        needToShow,
      ];
}

class SideNavigationEventGoToOrderHistoryList extends SideNavigatEvent {
  bool isOrderHistory;

  SideNavigationEventGoToOrderHistoryList(this.isOrderHistory);

  @override
  List<Object> get props => [isOrderHistory];
}

class SideNavigationEventGoToEventOrderHistoryList extends SideNavigatEvent {
  bool isEventOrderHistory;

  SideNavigationEventGoToEventOrderHistoryList(this.isEventOrderHistory);

  @override
  List<Object> get props => [isEventOrderHistory];
}

class SideNavigationEventGoToRideOrderHistoryList extends SideNavigatEvent {
  bool isRideOrderHistory;

  SideNavigationEventGoToRideOrderHistoryList(this.isRideOrderHistory);

  @override
  List<Object> get props => [isRideOrderHistory];
}

class SideNavigationEventGoToOrderDetailPage extends SideNavigatEvent {
  bool isFromNotification;
  String orderId;
  String driverId;

  SideNavigationEventGoToOrderDetailPage(
      this.isFromNotification, this.orderId, this.driverId);

  @override
  List<Object> get props => [isFromNotification, orderId, driverId];
}

class SideNavigationEventGoToOrderDetailPageHandel extends SideNavigatEvent {}
