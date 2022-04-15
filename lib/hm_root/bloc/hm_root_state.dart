import 'package:equatable/equatable.dart';

abstract class HmRootState extends Equatable {
  const HmRootState();

  @override
  List<Object> get props => [];
}

class HmRootInitial extends HmRootState {
  @override
  List<Object> get props => [];
}

class HmRootSplashLoadingComplete extends HmRootState {}

class HmRootHomeState extends HmRootState {
  bool isFromSetting = false;
  bool isBackOrderHistory = false;
  bool isBackProfile = false;
  bool isBackHome = false;
  bool isPushNotificationSending = false;

  HmRootHomeState(
      {this.isFromSetting,
      this.isBackOrderHistory,
      this.isBackProfile,
      this.isBackHome,
      this.isPushNotificationSending});

  List<Object> get props => [
        isFromSetting,
        isBackOrderHistory,
        isBackProfile,
        isBackHome,
        isPushNotificationSending
      ];
}
