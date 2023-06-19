import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:grambunny_customer/hm_root/bloc/bloc.dart';
import 'package:grambunny_customer/hm_root/hm_root.dart';

class HmRootBloc extends Bloc<HmRootEvent, HmRootState> {
  late UserRepository _userRepository;

  HmRootBloc({required UserRepository userRepository})
      : super(HmRootInitial()) {
    _userRepository = userRepository;

    on<HmSplashEventloading>(mapLoadingCompletedEvent);
    on<HmRootEventLoginLoadingComplete>(mapRootEventLoginLoadingComplete);
    on<HmRootEventSettingScreenSelectFromRoot>(
        mapHmRootEventSettingScreenSelectFromRoot);
    on<HmRootEventSettingScreenUnSelectFromRoot>(
        mapHmRootEventSettingScreenUnSelectFromRoot);
    on<HmRootEventBackButtonOrderHistory>(mapHmRootEventBackButtonOrderHistory);
    on<HmRootEventBackButtonOrderHistoryReset>(
        mapHmRootEventBackButtonOrderHistoryReset);
    on<HmRootEventBackButtonProfile>(mapHmRootEventBackButtonProfile);
    on<HmRootEventBackButtonProfileReset>(mapHmRootEventBackButtonProfileReset);
    on<HmRootEventBackButtonHome>(mapHmRootHmRootEventBackButtonHome);
    on<HmRootEventBackButtonHomeReset>(mapHmRootEventBackButtonHomeReset);
    on<HmRootEventLogoutClick>(mapHmRootEventLogoutClick);
    on<HmRootEventHomePageBack>(mapHmRootEventHomePageBack);
    on<HmRootEventPushReceived>(mapPushReceived);
    on<HmRootEventPushHandeled>(mapRootEventPushHandeled);
  }

  mapPushReceived(
      HmRootEventPushReceived event, Emitter<HmRootState> emitter) async {
    print("call home root from profile ");
    emitter(HmRootHomeState(
        isBackOrderHistory: false,
        isFromSetting: false,
        isBackProfile: false,
        isBackHome: false,
        isPushNotificationSending: true));
  }

  mapRootEventPushHandeled(
      HmRootEventPushHandeled event, Emitter<HmRootState> emitter) async {
    print("call home root from profile ");
    emitter(HmRootHomeState(
        isBackOrderHistory: false,
        isFromSetting: false,
        isBackProfile: false,
        isBackHome: false,
        isPushNotificationSending: false));
  }

  mapHmRootEventLogoutClick(
      HmRootEventLogoutClick event, Emitter<HmRootState> emitter) async {
    print("call home root from profile ");
    emitter(HmRootInitial());
  }

  mapHmRootEventHomePageBack(
      HmRootEventHomePageBack event, Emitter<HmRootState> emitter) async {
    print("call home root from profile ");
    emitter(HmRootInitial());
  }

  mapHmRootEventBackButtonHomeReset(HmRootEventBackButtonHomeReset event,
      Emitter<HmRootState> emitter) async {
    print("call home root from profile ");
    emitter(HmRootHomeState(
        isBackOrderHistory: false,
        isFromSetting: false,
        isBackProfile: false,
        isBackHome: false,
        isPushNotificationSending: false));
  }

  mapHmRootHmRootEventBackButtonHome(
      HmRootEventBackButtonHome event, Emitter<HmRootState> emitter) async {
    print("call home root from profile ");
    emitter(HmRootHomeState(
        isBackOrderHistory: false,
        isFromSetting: false,
        isBackProfile: false,
        isBackHome: true,
        isPushNotificationSending: false));
  }

  mapHmRootEventBackButtonProfile(
      HmRootEventBackButtonProfile event, Emitter<HmRootState> emitter) async {
    print("call home root from profile ");
    emitter(HmRootHomeState(
        isBackOrderHistory: false,
        isFromSetting: false,
        isBackProfile: true,
        isBackHome: false,
        isPushNotificationSending: false));
  }

  mapHmRootEventBackButtonProfileReset(HmRootEventBackButtonProfileReset event,
      Emitter<HmRootState> emitter) async {
    print("call home root ");
    emitter(HmRootHomeState(
        isBackOrderHistory: false,
        isFromSetting: false,
        isBackProfile: false,
        isBackHome: false,
        isPushNotificationSending: false));
  }

  mapHmRootEventBackButtonOrderHistoryReset(
      HmRootEventBackButtonOrderHistoryReset event,
      Emitter<HmRootState> emitter) async {
    print("call home root");
    emitter(HmRootHomeState(
        isBackProfile: false,
        isFromSetting: false,
        isBackOrderHistory: false,
        isBackHome: false,
        isPushNotificationSending: false));
  }

  mapHmRootEventBackButtonOrderHistory(HmRootEventBackButtonOrderHistory event,
      Emitter<HmRootState> emitter) async {
    //print("call home root for history");
    emitter(HmRootHomeState(
        isBackProfile: false,
        isBackOrderHistory: true,
        isFromSetting: false,
        isBackHome: false,
        isPushNotificationSending: false));
  }

  mapHmRootEventSettingScreenSelectFromRoot(
      HmRootEventSettingScreenSelectFromRoot event,
      Emitter<HmRootState> emitter) async {
    print("call home for cart root");
    emitter(HmRootHomeState(
        isBackOrderHistory: false,
        isFromSetting: true,
        isBackProfile: false,
        isBackHome: false,
        isPushNotificationSending: false));
  }

  mapHmRootEventSettingScreenUnSelectFromRoot(
      HmRootEventSettingScreenUnSelectFromRoot event,
      Emitter<HmRootState> emitter) async {
    // print("setting un select home root");
    emitter(HmRootHomeState(
        isFromSetting: false,
        isBackOrderHistory: false,
        isBackProfile: false,
        isBackHome: false,
        isPushNotificationSending: false));
  }

  mapLoadingCompletedEvent(
      HmSplashEventloading event, Emitter<HmRootState> emitter) async {
    emitter(HmRootSplashLoadingComplete());
  }

  mapRootEventLoginLoadingComplete(HmRootEventLoginLoadingComplete event,
      Emitter<HmRootState> emitter) async {
    emitter(HmRootHomeState(
        isFromSetting: false,
        isBackProfile: false,
        isBackOrderHistory: false,
        isBackHome: false,
        isPushNotificationSending: false));
  }

  Stream<HmRootState> mapEventFtBackPressed() async* {
    print("call Root");

    //yield FtRootLoginLoadingComplete();
  }
}
