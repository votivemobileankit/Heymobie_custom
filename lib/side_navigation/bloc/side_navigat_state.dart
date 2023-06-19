import 'package:equatable/equatable.dart';
import 'package:grambunny_customer/utils/utils.dart';

abstract class SideNavigatState extends Equatable {
  const SideNavigatState();
}

class SideNavigationDefaultState extends SideNavigatState {
   SideNavigationTab? selectedTab;
   bool showLoadingAnimation;
   bool goToHomepage;
   bool goToCart;
   bool goToOrderDetail;
   bool fromNotification;
   String? orderId;
   String? driverId;

  SideNavigationDefaultState({
      this.selectedTab,
      this.showLoadingAnimation = false,
      this.goToHomepage = false,
      this.goToCart = false,
      this.goToOrderDetail = false,
      this.fromNotification = false,
      this.orderId,
      this.driverId});

  @override
  List<Object> get props => [
        selectedTab!,
        showLoadingAnimation,
        goToHomepage,
        goToCart,
        goToOrderDetail,
        fromNotification,
        orderId!,
        driverId!
      ];

  SideNavigationDefaultState copyWith(
      { SideNavigationTab? selectedTab,
      bool? showLoadingAnimation,
         bool? goToHomepage,
      bool? goToCart,
         bool? fromNotification,
         bool? goToOrderDetail,
         String? orderId,
         String ?driverId}) {
    return SideNavigationDefaultState(
        selectedTab: selectedTab ?? this.selectedTab,
        showLoadingAnimation: showLoadingAnimation ?? this.showLoadingAnimation,
        goToHomepage: goToHomepage ?? this.goToHomepage,
        goToCart: goToCart ?? this.goToCart,
        goToOrderDetail: goToOrderDetail ?? this.goToOrderDetail,
        fromNotification: fromNotification ?? this.fromNotification,
        orderId: orderId ?? this.orderId,
        driverId: driverId ?? this.driverId);
  }
}
