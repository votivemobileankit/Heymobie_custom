import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grambunny_customer/components/components.dart';
import 'package:grambunny_customer/home/home.dart';
import 'package:grambunny_customer/services/services.dart';
import 'package:grambunny_customer/side_navigation/side_navigation.dart';
import 'package:grambunny_customer/theme/theme.dart';
import 'package:grambunny_customer/utils/utils.dart';

import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

const double _kVerticalSpaceTopHeartLogo = 40.0;
const double _kEnterCodeTextFontSize = 40.0;
const double _kVerticalSpaceBeforeEnterCodeText = 40.0;

class OtpPage extends StatefulWidget {
  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  late String email;
  late String from;

  @override
  void initState() {
    // TODO: implement initState

    HomeState homeState = BlocProvider.of<HomeBloc>(context).state;
    if (homeState is OTPpageState) {
      email = homeState.email_id;
      from = homeState.from;
    }
    super.initState();
  }

  void showHideProgress(bool show) {
    BlocProvider.of<SideNavigatBloc>(context)
        .add(SideNavigationEventToggleLoadingAnimation(needToShow: show));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocListener<HomeBloc, HomeState>(
      listenWhen: (prevState, curState) => ModalRoute.of(context)!.isCurrent,
      listener: (context, state) {
        if (state is HomeInitial) {
          Navigator.of(context).pushNamed(HomeNavigator.homeDriverMainPage);
        }
        if (state is ResetPasswordPageState) {
          Navigator.of(context).pushNamed(HomeNavigator.resetPasswordPage);
        }
        if (state is OtpApiLoadingCompleteState) {
          showHideProgress(false);
          if (from == "signin") {
            BlocProvider.of<HomeBloc>(context).add(HomeEventBackBtnClick());
          } else if (from == "signup") {
            sharedPrefs.setUserId = "${state.userArray.id}";
            sharedPrefs.isLogin = true;
            sharedPrefs.setUserName = state.userArray.name;
            BlocProvider.of<HomeBloc>(context).add(HomeEventBackBtnClick());
          } else if (from == "forgetpwd") {
            BlocProvider.of<HomeBloc>(context)
                .add(ResetPasswordPageEvent(state.email));
          }
          showSnackBar(state.message, context);
        }
        if (state is OtpApiLoadingErrorState) {
          showHideProgress(false);
          BlocProvider.of<HomeBloc>(context)
              .add(HomeEventForOTPScreen(email, from));
          showSnackBar(state.message, context);
        }
        if (state is OtpResendApiLoadingCompleteState) {
          showHideProgress(false);
          showSnackBar(state.message, context);
          BlocProvider.of<HomeBloc>(context)
              .add(HomeEventForOTPScreen(email, from));
        }
        if (state is OtpResendApiLoadingErrorState) {
          showHideProgress(false);
          showSnackBar(state.message, context);
          BlocProvider.of<HomeBloc>(context)
              .add(HomeEventForOTPScreen(email, from));
        }
      },
      child: SafeArea(
          child: Stack(
        children: [
          Scaffold(
            body: Column(mainAxisSize: MainAxisSize.max, children: [
              Column(children: [
                AVerticalSpace(_kVerticalSpaceTopHeartLogo.scale()),
                // Image(
                //   image: AssetImage('${imgPathGeneral}ic_login_top_heart.png'),
                // ).align(Alignment.center),
                AVerticalSpace(_kVerticalSpaceBeforeEnterCodeText.scale()),
                Text(
                  "Enter OTP",
                  style: textStyleBoldCustomLargeColor(
                      _kEnterCodeTextFontSize.scale(), KColorAppThemeColor),
                ).align(Alignment.center),
                AVerticalSpace(_kVerticalSpaceBeforeEnterCodeText.scale()),
                OTPTextField(
                  length: 6,
                  width: MediaQuery.of(context).size.width,
                  textFieldAlignment: MainAxisAlignment.spaceEvenly,
                  //fieldWidth: 40.0.scale(),

                  fieldStyle: FieldStyle.underline,
                  outlineBorderRadius: 15,
                  style: TextStyle(fontSize: 17),
                  onChanged: (pin) {
                    print("Changed: " + pin);
                  },
                  onCompleted: (pin) {
                    print("Completed: " + pin);
                    showHideProgress(true);
                    BlocProvider.of<HomeBloc>(context)
                        .add(OTPEventOTPVerifyButton(email, pin, from));
                  },
                ),
                AVerticalSpace(_kVerticalSpaceBeforeEnterCodeText.scale()),
                ARoundedButton(
                  btnBorderSideColor: kColorCommonButton,btnDisabledColor: Color(0xFF5e6163),btnIconSize:15 ,
                  btnDisabledTextColor:Color(0xFFFFFFFF) ,
                  btnFontWeight: FontWeight.normal,
                  btnBgColor: kColorAppBgColor,
                  btnTextColor: Colors.white,
                  btnOnPressed: () {
                    showHideProgress(true);
                    BlocProvider.of<HomeBloc>(context)
                        .add(OTPEventOTPResendButton(email, "reset"));
                  },
                  btnText: "Resend OTP",
                  btnHeight: kHeightBtnSplashNormal.scale(),
                  btnWidth: kWidthBtnNormal.scale(),
                  btnFontSize: kFontSizeBtnLarge.scale(),
                ),
              ]),
            ]),
          ),
        ],
      )).widgetBgColor(Colors.white),
    );
  }
}
