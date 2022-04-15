import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grambunny_customer/components/components.dart';
import 'package:grambunny_customer/profile/profile.dart';
import 'package:grambunny_customer/setting/setting.dart';
import 'package:grambunny_customer/side_navigation/side_navigation.dart';
import 'package:grambunny_customer/theme/theme.dart';
import 'package:grambunny_customer/utils/ui_utils.dart';
import 'package:grambunny_customer/utils/utils.dart';

import 'package:permission_handler/permission_handler.dart';

const double _kNormalFontSize = 14.0;
const double _kHeadingFontSize = 18.0;

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool emailReminderCheck;
  UserDetailResponseModel userDetailInfo;

  @override
  void initState() {
    showHideProgress(true);
    BlocProvider.of<SettingBloc>(context).add(SettingEventCallSettingApi());
    super.initState();
  }

  void showHideProgress(bool show) {
    BlocProvider.of<SideNavigatBloc>(context)
        .add(SideNavigationEventToggleLoadingAnimation(needToShow: show));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocListener<SettingBloc, SettingState>(
      listenWhen: (prevState, curState) => ModalRoute.of(context).isCurrent,
      listener: (context, state) {
        if (state is SettingGetUserSettingDataState) {
          showHideProgress(false);
          setState(() {
            userDetailInfo = state.userDetailInfo;
          });
        } else if (state is SettingUpdateUserSettingState) {
          showHideProgress(false);
          setState(() {
            userDetailInfo = state.userDetailInfo;
          });
        } else if (state is SettingErrorState) {
          showHideProgress(false);
        } else if (state is SettingNavigateToHomePageState) {
          BlocProvider.of<SettingBloc>(context)
              .add(SettingEventResetInitialState());
          BlocProvider.of<SideNavigatBloc>(context)
              .add(SideNavigationEventGoToHomePageFromHistory());
        } else if (state is SettingNotificationListPageState) {
          Navigator.of(context).pushNamed(SettingNavigator.notificationPage);
        }
      },
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            AHeaderWidget(
              strBackbuttonName: 'ic_red_btn_back.png',
              backBtnVisibility: true,
              btnBackOnPressed: () {
                //Scaffold.of(context).openDrawer();

                BlocProvider.of<SettingBloc>(context)
                    .add(SettingEventBackBtnClick());
              },
              strBtnRightImageName: 'ic_search_logo.png',
              rightEditButtonVisibility: false,
            ),
            Column(
              children: [
                AVerticalSpace(15.0.scale()),
                Text(
                  "Notification Settings:",
                  style: textStyleBoldCustomColor(
                      _kHeadingFontSize, KColorCommonText),
                ).align(Alignment.centerLeft),
                AVerticalSpace(15.0.scale()),
                Text(
                  "We will send you messages after complete your order, and also inform you about your order status. Please choose how you want to receive these messages.",
                  style: textStyleBoldCustomColor(
                      _kNormalFontSize, KColorCommonText),
                ),
                AVerticalSpace(15.0.scale()),
                if (userDetailInfo != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Push Notification:",
                        style: textStyleCustomColor(
                            _kNormalFontSize, KColorCommonText),
                      ),
                      _SwitchWidgetPushNotification(
                          userDetailInfo.data.userInfo.notification)
                    ],
                  ),
                AVerticalSpace(15.0.scale()),
                // if (userDetailInfo != null)
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         "Email Notification:",
                //         style: textStyleCustomColor(
                //             _kNormalFontSize, KColorCommonText),
                //       ),
                //       _SwitchWidgetEmailNotification(
                //           userDetailInfo.data.userInfo.emailNotification)
                //     ],
                //   ),
                //
                // AVerticalSpace(15.0.scale()),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<SettingBloc>(context)
                        .add(SettingNotificationButtonClick());
                  },
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage(
                            '${imgPathGeneral}ic_notification_icon.png'),
                      ),
                      AHorizontalSpace(5.0.scale()),
                      Text(
                        "Notification List",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: KColorCommonText,
                          fontSize: _kNormalFontSize,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Quicksand",
                        ),
                      ).align(Alignment.centerLeft),
                    ],
                  ),
                )
              ],
            ).leftPadding(14.0.scale()).rightPadding(14.0.scale())
          ],
        ).pageBgColor(Colors.white),
      ).lightStatusBarText().pageBgColor(kColorAppBgColor),
    );
  }
}

class _SwitchWidgetPushNotification extends StatefulWidget {
  bool _pushReminderCheck = false;
  String notification;

  _SwitchWidgetPushNotification(String notification) {
    if (notification == "1") {
      _pushReminderCheck = true;
    } else {
      _pushReminderCheck = false;
    }
  }

  @override
  SwitchWidgetClass createState() => new SwitchWidgetClass(_pushReminderCheck);
}

bool _pushSwitchControlMain = false;
String _pushNotification = "0";
const double _kImageIconWidth = 22.0;
const double _kImageIconHeight = 22.0;
const double _kMarginTop1 = 16.0;
const double _kCommonTitlepadding = 40.0;
const double _kBtnBorderShape = 16.0;

class SwitchWidgetClass extends State<_SwitchWidgetPushNotification>
    with WidgetsBindingObserver {
  SwitchWidgetClass(bool pushReminderCheck) {
    _pushSwitchControlMain = pushReminderCheck;
  }

  void toggleSwitch(bool value) {
    setState(() {
      _pushSwitchControlMain = !_pushSwitchControlMain;
      if (_pushSwitchControlMain == false) {
        _pushNotification = "0";
        BlocProvider.of<SettingBloc>(context).add(
            SettingEventUpdateNotification(
                _pushNotification, _emailStatus, _smsStatus));
      } else {
        _pushNotification = "1";
        BlocProvider.of<SettingBloc>(context).add(
            SettingEventUpdateNotification(
                _pushNotification, _emailStatus, _smsStatus));
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    if (this.mounted) {}

    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: 500), () {
        _handleUseNotificationRequest(context);
      });
    });
    super.initState();
  }

  Future<void> _handleUseNotificationRequest(BuildContext context) async {
    var statusBeforeRequest = await Permission.notification.status;

    if (statusBeforeRequest.isGranted) {
      if (_pushSwitchControlMain == false) {
        // showOneButtonDialogWithImage(
        //     context: context,
        //     titleText: Strings.current.txtDialogTitleReviewAndroidInfo,
        //     descText: Strings.current.txtDialogDescriptionReviewAndroidInfo,
        //     btnTitleText: Strings.current.btnOk,
        //     btnOnPressed: () {
        //       setState(() {
        //         _pushSwitchControlMain = true;
        //         widget.onValueChanged();
        //       });
        //     });
      }
    } else if (statusBeforeRequest.isDenied) {
      var statusAfterRequest = await Permission.notification.request();
      if (statusAfterRequest.isGranted) {
        if (_pushSwitchControlMain == false) {
          setState(() {
            _pushSwitchControlMain = true;
          });
        }
      } else {
        if (Platform.isAndroid) {
          // showTwoButtonDialogWithImage(
          //     context: context,
          //     titleText: Strings.current.txtDialogTitleReviewAndroidInfo,
          //     descText: Strings.current.txtDialogDescriptionReviewAndroidInfo,
          //     btnTitleText: Strings.current.btnOk,
          //     btnOnPressed: () {
          //       setState(() {
          //         _pushSwitchControlMain = false;
          //         widget.onValueChanged();
          //       });
          //     },
          //     btnOnPressedSetting: () {
          //       openAppSettings()
          //           .then((value) => _handleUseNotificationRequest(context));
          //     });
        } else {
          // showTwoButtonDialogWithImage(
          //     context: context,
          //     titleText: Strings.current.txtDialogTitleReviewIosInfo,
          //     descText: Strings.current.txtDialogDescriptionReviewIosInfo,
          //     btnTitleText: Strings.current.btnOk,
          //     btnOnPressed: () {
          //       setState(() {
          //         _pushSwitchControlMain = false;
          //         widget.onValueChanged();
          //       });
          //     },
          //     btnOnPressedSetting: () {
          //       openAppSettings()
          //           .then((value) => _handleUseNotificationRequest(context));
          //     });
        }
      }
    } else if (statusBeforeRequest.isPermanentlyDenied) {
      var statusAfterRequest = await Permission.notification.request();
      if (statusAfterRequest.isGranted) {
        if (_pushSwitchControlMain == false) {
          setState(() {
            _pushSwitchControlMain = true;
          });
        }
      } else {
        if (Platform.isAndroid) {
          // showTwoButtonDialogWithImage(
          //     context: context,
          //     titleText: Strings.current.txtDialogTitleReviewAndroidInfo,
          //     descText: Strings.current.txtDialogDescriptionReviewAndroidInfo,
          //     btnTitleText: Strings.current.btnOk,
          //     btnOnPressed: () {},
          //     btnOnPressedSetting: () {
          //       openAppSettings()
          //           .then((value) => _handleUseNotificationRequest(context));
          //     });
        } else {
          // showTwoButtonDialogWithImage(
          //     context: context,
          //     titleText: Strings.current.txtDialogTitleReviewIosInfo,
          //     descText: Strings.current.txtDialogDescriptionReviewIosInfo,
          //     btnTitleText: Strings.current.btnOk,
          //     btnOnPressed: () {},
          //     btnOnPressedSetting: () {
          //       openAppSettings()
          //           .then((value) => _handleUseNotificationRequest(context));
          //     });
        }
      }
    } else if (statusBeforeRequest.isRestricted) {
      var statusAfterRequest = await Permission.notification.request();
      if (statusAfterRequest.isGranted) {
        if (_pushSwitchControlMain == false) {
          setState(() {
            _pushSwitchControlMain = true;
          });
        }
      } else {
        if (Platform.isAndroid) {
          // showTwoButtonDialogWithImage(
          //     context: context,
          //     titleText: Strings.current.txtDialogTitleReviewAndroidInfo,
          //     descText: Strings.current.txtDialogDescriptionReviewAndroidInfo,
          //     btnTitleText: Strings.current.btnOk,
          //     btnOnPressed: () {},
          //     btnOnPressedSetting: () {
          //       openAppSettings()
          //           .then((value) => _handleUseNotificationRequest(context));
          //     });
        } else {
          // showTwoButtonDialogWithImage(
          //     context: context,
          //     titleText: Strings.current.txtDialogTitleReviewIosInfo,
          //     descText: Strings.current.txtDialogDescriptionReviewIosInfo,
          //     btnTitleText: Strings.current.btnOk,
          //     btnOnPressed: () {},
          //     btnOnPressedSetting: () {
          //       openAppSettings()
          //           .then((value) => _handleUseNotificationRequest(context));
          //     });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Transform.scale(
          scale: 1.5,
          child: Switch(
            onChanged: toggleSwitch,
            value: _pushSwitchControlMain,
            activeColor: Colors.white,
            activeTrackColor: kColorAppBgColor,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: kColorGreyEditTextDisabled,
          ))
    ]);
  }
}

class _SwitchWidgetEmailNotification extends StatefulWidget {
  bool _emailReminderCheck = false;
  String notification;

  _SwitchWidgetEmailNotification(String notification) {
    this.notification = notification;
    if (this.notification == "1") {
      _emailReminderCheck = true;
    } else {
      _emailReminderCheck = false;
    }
  }

  @override
  SwitchWidgetEmailClass createState() =>
      new SwitchWidgetEmailClass(_emailReminderCheck);
}

bool _emailSwitchControlMain;
String _emailStatus = "0";

class SwitchWidgetEmailClass extends State<_SwitchWidgetEmailNotification> {
  SwitchWidgetEmailClass(bool _emailReminderCheck) {
    _emailSwitchControlMain = _emailReminderCheck;
  }

  @override
  void initState() {
    if (_emailSwitchControlMain == null || _emailSwitchControlMain == false) {
      _emailSwitchControlMain = false;
      // _isMarketingCheck = false;
    } else {
      _emailSwitchControlMain = true;
      // _isMarketingCheck = true;
    }
    if (_emailSwitchControlMain == false) {
      _emailStatus = "0";
    } else {
      _emailStatus = "1";
    }
    super.initState();
  }

  void toggleSwitch(bool value) {
    setState(() {
      _emailSwitchControlMain = !_emailSwitchControlMain;
      print(_emailSwitchControlMain);
      if (_emailSwitchControlMain == false) {
        _emailStatus = "0";
        BlocProvider.of<SettingBloc>(context).add(
            SettingEventUpdateNotification(
                _pushNotification, _emailStatus, _smsStatus));
      } else {
        _emailStatus = "1";
        BlocProvider.of<SettingBloc>(context).add(
            SettingEventUpdateNotification(
                _pushNotification, _emailStatus, _smsStatus));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Transform.scale(
          scale: 1.5,
          child: Switch(
            onChanged: toggleSwitch,
            value: _emailSwitchControlMain,
            activeColor: Colors.white,
            activeTrackColor: kColorAppBgColor,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: kColorGreyEditTextDisabled,
          ))
    ]);
  }
}

class _SwitchWidgetSmsNotification extends StatefulWidget {
  bool _smsReminderCheck = false;
  String smsnotification;

  _SwitchWidgetSmsNotification(String notification) {
    this.smsnotification = notification;
    if (this.smsnotification == "1") {
      _smsReminderCheck = true;
    } else {
      _smsReminderCheck = false;
    }
  }

  @override
  SwitchWidgetSmsClass createState() =>
      new SwitchWidgetSmsClass(_smsReminderCheck);
}

bool _smsSwitchControlMain;
String _smsStatus = "0";

class SwitchWidgetSmsClass extends State<_SwitchWidgetSmsNotification> {
  SwitchWidgetSmsClass(bool _smsReminderCheck) {
    _smsSwitchControlMain = _smsReminderCheck;
  }

  @override
  void initState() {
    if (_smsSwitchControlMain == null || _smsSwitchControlMain == false) {
      _smsSwitchControlMain = false;
      // _isMarketingCheck = false;
    } else {
      _smsSwitchControlMain = true;
      // _isMarketingCheck = true;
    }
    if (_smsSwitchControlMain == false) {
      _smsStatus = "0";
    } else {
      _smsStatus = "1";
    }
    super.initState();
  }

  void toggleSwitch(bool value) {
    setState(() {
      _smsSwitchControlMain = !_smsSwitchControlMain;
      if (_smsSwitchControlMain == false) {
        _smsStatus = "0";
        BlocProvider.of<SettingBloc>(context).add(
            SettingEventUpdateNotification(
                _pushNotification, _emailStatus, _smsStatus));
      } else {
        _smsStatus = "1";
        BlocProvider.of<SettingBloc>(context).add(
            SettingEventUpdateNotification(
                _pushNotification, _emailStatus, _smsStatus));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Transform.scale(
          scale: 1.5,
          child: Switch(
            onChanged: toggleSwitch,
            value: _smsSwitchControlMain,
            activeColor: Colors.white,
            activeTrackColor: kColorAppBgColor,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: kColorGreyEditTextDisabled,
          ))
    ]);
  }
}
