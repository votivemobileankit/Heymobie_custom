import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grambunny_customer/components/components.dart';
import 'package:grambunny_customer/hm_root/hm_root.dart';
import 'package:grambunny_customer/login/login.dart';
import 'package:grambunny_customer/theme/theme.dart';
import 'package:grambunny_customer/utils/ui_utils.dart';
import 'package:grambunny_customer/utils/utils.dart';

const double _kTitleBottomMargin = 20.0;
const double _kDescBottomMargin = 20.0;
const double _kBtnWidth = 89.0;
const double _kBtnSettingwidth = 120.0;
const double _kImageIconWidth = 22.0;
const double _kImageIconHeight = 22.0;
const double _kCommonTitlepadding = 30.0;
const double _kBtnBorderShape = 16.0;
const double _kMarginTop1 = 16.0;

class AgeAskToUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocListener<LoginBloc, LoginState>(
        listenWhen: (prevState, curState) => ModalRoute.of(context)!.isCurrent,
        listener: (context, state) {
          if (state is LoginPageState) {
            // showHideProgress(false);
            //Navigator.of(context, rootNavigator: true).pop(context);
            //Navigator.of(context).pushNamed(LoginNavigator.loginMainPage);
            BlocProvider.of<HmRootBloc>(context)
                .add(HmRootEventLoginLoadingComplete());
          }
        },
        child: SafeArea(
          bottom: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AVerticalSpace(20.0.scale()),
                  Image(
                    image: AssetImage('${imgPathGeneral}ic_app_name_logo.png'),
                  )
                      .leftPadding(_kCommonTitlepadding.scale())
                      .rightPadding(_kCommonTitlepadding.scale()),
                  AVerticalSpace(_kMarginTop1.scale()),
                  AVerticalSpace(_kTitleBottomMargin.scale()),
                  Text(
                    "Are you 21 year old ?",
                    style: textStyleBoldCustomLargeColor(
                        20.0.scale(), kColorAppBgColor),
                    textAlign: TextAlign.center,
                  ).horPadding(kDialogDescHorPadding.scale()),
                  AVerticalSpace(_kDescBottomMargin.scale()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ARoundedButton(
                        btnBorderSideColor: kColorCommonButton,btnDisabledColor: Color(0xFF5e6163),btnIconSize:15 ,
                        btnDisabledTextColor:Color(0xFFFFFFFF) ,
                        btnFontWeight: FontWeight.normal,
                        btnBgColor: kColorAppBgColor,
                        btnTextColor: Colors.white,
                        btnOnPressed: () {
                          BlocProvider.of<LoginBloc>(context)
                              .add(LoginAgeVerifyYesButtonClicked());
                          // sharedPrefs.isAgeAbove21 = true;
                        },
                        btnText: "Yes",
                        btnHeight: kHeightBtnNormal.scale(),
                        btnWidth: _kBtnWidth.scale(),
                        btnFontSize: kFontSizeBtnLarge.scale(),
                        btnElevation: 0,
                      ),
                      AHorizontalSpace(15.0.scale()),
                      ARoundedButton(
                        btnBorderSideColor: kColorCommonButton,btnDisabledColor: Color(0xFF5e6163),btnIconSize:15 ,
                        btnDisabledTextColor:Color(0xFFFFFFFF) ,
                        btnFontWeight: FontWeight.normal,
                        btnBgColor: kColorAppBgColor,
                        btnTextColor: Colors.white,
                        btnOnPressed: () {
                          // sharedPrefs.isAgeAbove21 = false;
                          //   exit(0);
                          if (Platform.isAndroid) {
                            SystemNavigator.pop();
                          }

                          // WidgetsBinding.instance.handlePopRoute;
                        },
                        btnText: "No",
                        btnHeight: kHeightBtnNormal.scale(),
                        btnWidth: _kBtnWidth.scale(),
                        btnFontSize: kFontSizeBtnLarge.scale(),
                        btnElevation: 0,
                      ),
                    ],
                  )
                ],
              )
            ],
          ).widgetBgColor(Colors.white),
        ).pageBgColor(kColorAppBgColor));
  }
}
