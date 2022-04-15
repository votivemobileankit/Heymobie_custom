import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:grambunny_customer/hm_root/bloc/bloc.dart';
import 'package:grambunny_customer/hm_root/hm_root.dart';

class HmRootBloc extends Bloc<HmRootEvent, HmRootState> {
  UserRepository _userRepository;

  HmRootBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(HmRootInitial());

  @override
  Stream<HmRootState> mapEventToState(
    HmRootEvent event,
  ) async* {
    switch (event.runtimeType) {
      case HmSplashEventloading:
        yield* mapLoadingCompletedEvent();
        break;

      case HmRootEventLoginLoadingComplete:
        yield* mapRootEventLoginLoadingComplete();
        break;
      case HmRootEventSettingScreenSelectFromRoot:
        yield* mapHmRootEventSettingScreenSelectFromRoot();
        break;
      case HmRootEventSettingScreenUnSelectFromRoot:
        yield* mapHmRootEventSettingScreenUnSelectFromRoot();
        break;
      case HmRootEventBackButtonOrderHistory:
        yield* mapHmRootEventBackButtonOrderHistory();
        break;
      case HmRootEventBackButtonOrderHistoryReset:
        yield* mapHmRootEventBackButtonOrderHistoryReset();
        break;
      case HmRootEventBackButtonProfile:
        yield* mapHmRootEventBackButtonProfile();
        break;
      case HmRootEventBackButtonProfileReset:
        yield* mapHmRootEventBackButtonProfileReset();
        break;
      case HmRootEventBackButtonHome:
        yield* mapHmRootHmRootEventBackButtonHome();
        break;
      case HmRootEventBackButtonHomeReset:
        yield* mapHmRootEventBackButtonHomeReset();
        break;
      case HmRootEventLogoutClick:
        yield* mapHmRootEventLogoutClick();
        break;
      case HmRootEventHomePageBack:
        yield* mapHmRootEventHomePageBack();
        break;
      case HmRootEventPushReceived:
        yield* mapPushReceived();
        break;
      case HmRootEventPushHandeled:
        yield* mapRootEventPushHandeled();
        break;
    }
  }

  Stream<HmRootState> mapPushReceived() async* {
    print("call home root from profile ");
    yield HmRootHomeState(
        isBackOrderHistory: false,
        isFromSetting: false,
        isBackProfile: false,
        isBackHome: false,
        isPushNotificationSending: true);
  }

  Stream<HmRootState> mapRootEventPushHandeled() async* {
    print("call home root from profile ");
    yield HmRootHomeState(
        isBackOrderHistory: false,
        isFromSetting: false,
        isBackProfile: false,
        isBackHome: false,
        isPushNotificationSending: false);
  }

  Stream<HmRootState> mapHmRootEventLogoutClick() async* {
    print("call home root from profile ");
    yield HmRootInitial();
  }

  Stream<HmRootState> mapHmRootEventHomePageBack() async* {
    print("call home root from profile ");
    yield HmRootInitial();
  }

  Stream<HmRootState> mapHmRootEventBackButtonHomeReset() async* {
    print("call home root from profile ");
    yield HmRootHomeState(
        isBackOrderHistory: false,
        isFromSetting: false,
        isBackProfile: false,
        isBackHome: false,
        isPushNotificationSending: false);
  }

  Stream<HmRootState> mapHmRootHmRootEventBackButtonHome() async* {
    print("call home root from profile ");
    yield HmRootHomeState(
        isBackOrderHistory: false,
        isFromSetting: false,
        isBackProfile: false,
        isBackHome: true);
  }

  Stream<HmRootState> mapHmRootEventBackButtonProfile() async* {
    print("call home root from profile ");
    yield HmRootHomeState(
        isBackOrderHistory: false,
        isFromSetting: false,
        isBackProfile: true,
        isBackHome: false);
  }

  Stream<HmRootState> mapHmRootEventBackButtonProfileReset() async* {
    print("call home root ");
    yield HmRootHomeState(
        isBackOrderHistory: false,
        isFromSetting: false,
        isBackProfile: false,
        isBackHome: false,
        isPushNotificationSending: false);
  }

  Stream<HmRootState> mapHmRootEventBackButtonOrderHistoryReset() async* {
    print("call home root");
    yield HmRootHomeState(
        isBackProfile: false,
        isFromSetting: false,
        isBackOrderHistory: false,
        isBackHome: false,
        isPushNotificationSending: false);
  }

  Stream<HmRootState> mapHmRootEventBackButtonOrderHistory() async* {
    //print("call home root for history");
    yield HmRootHomeState(
        isBackProfile: false,
        isBackOrderHistory: true,
        isFromSetting: false,
        isBackHome: false,
        isPushNotificationSending: false);
  }

  Stream<HmRootState> mapHmRootEventSettingScreenSelectFromRoot() async* {
    print("call home for cart root");
    yield HmRootHomeState(
        isBackOrderHistory: false,
        isFromSetting: true,
        isBackProfile: false,
        isBackHome: false,
        isPushNotificationSending: false);
  }

  Stream<HmRootState> mapHmRootEventSettingScreenUnSelectFromRoot() async* {
    // print("setting un select home root");
    yield HmRootHomeState(
        isFromSetting: false,
        isBackOrderHistory: false,
        isBackProfile: false,
        isBackHome: false,
        isPushNotificationSending: false);
  }

  Stream<HmRootState> mapLoadingCompletedEvent() async* {
    //if (sharedPrefs.isAgeAbove21 == false) {
    yield HmRootSplashLoadingComplete();
    // }

    // else {
    //   yield HmRootHomeState(
    //       isFromSetting: false,
    //       isBackProfile: false,
    //       isBackOrderHistory: false,
    //       isBackHome: false);
    // }
  }

  Stream<HmRootState> mapRootEventLoginLoadingComplete() async* {
    yield HmRootHomeState(
        isFromSetting: false,
        isBackProfile: false,
        isBackOrderHistory: false,
        isBackHome: false,
        isPushNotificationSending: false);
  }

  Stream<HmRootState> mapEventFtBackPressed() async* {
    print("call Root");

    //yield FtRootLoginLoadingComplete();
  }
}
