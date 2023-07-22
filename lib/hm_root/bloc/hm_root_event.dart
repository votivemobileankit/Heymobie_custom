import 'package:equatable/equatable.dart';

abstract class HmRootEvent extends Equatable {
  const HmRootEvent();

  @override
  List<Object> get props => [];
}

class HmSplashEventloading extends HmRootEvent {}

class HmBackPressed extends HmRootEvent {}

class HmRootEventLoginLoadingComplete extends HmRootEvent {}

class HmRootEventSettingScreenSelectFromRoot extends HmRootEvent {}

class HmRootEventSettingScreenUnSelectFromRoot extends HmRootEvent {}

class HmRootEventBackButtonOrderHistory extends HmRootEvent {}

class HmRootEventBackButtonOrderHistoryReset extends HmRootEvent {}

class HmRootEventBackButtonEventOrderHistoryReset extends HmRootEvent {}

class HmRootEventBackButtonProfile extends HmRootEvent {}

class HmRootEventBackButtonHome extends HmRootEvent {}

class HmRootEventBackButtonHomeReset extends HmRootEvent {}

class HmRootEventBackButtonProfileReset extends HmRootEvent {}

class HmRootEventLogoutClick extends HmRootEvent {}

class HmRootEventHomePageBack extends HmRootEvent {}

class HmRootEventPushReceived extends HmRootEvent {}

class HmRootEventPushHandeled extends HmRootEvent {}
