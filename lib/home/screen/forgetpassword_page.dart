import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grambunny_customer/components/components.dart';
import 'package:grambunny_customer/generated/l10n.dart';
import 'package:grambunny_customer/home/home.dart';
import 'package:grambunny_customer/side_navigation/side_navigation.dart';

import '../../theme/theme.dart';
import '../../utils/utils.dart';

const double _kCommonHintTextFieldFontSize = 24.0;
const double _kEmailHintFontSize = 14.0;
const double _kCommonForgetPwdTopHint = 15.0;
const double _kVerticalSpaceBeforeForgetIcon = 25.0;
const double _kCommonPadding = 14.0;

class ForgetPasswordPage extends StatefulWidget {
  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  TextEditingController _textFiledEmailId = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
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
        listenWhen: (prevState, curState) => ModalRoute.of(context).isCurrent,
        listener: (context, state) {
          if (state is LoginPageState) {
            Navigator.of(context).pop(true);
          }
          if (state is OTPpageState) {
            Navigator.of(context).pushNamed(HomeNavigator.otpPage);
          }
          if (state is ForgotPasswordApiLoadingCompleteState) {
            showHideProgress(false);
            BlocProvider.of<HomeBloc>(context)
                .add(HomeEventForOTPScreen(state.email, "forgetpwd"));
            showSnackBar(state.message, context);
          }
          if (state is ForgotPasswordApiLoadingErrorState) {
            showHideProgress(false);
            showSnackBar(state.message, context);
            BlocProvider.of<HomeBloc>(context)
                .add(LoginEventForgetPasswordClick());
          }
        },
        child: SafeArea(
          bottom: false,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              AHeaderWidget(
                strBackbuttonName: 'ic_red_btn_back.png',
                backBtnVisibility: true,
                btnBackOnPressed: () {
                  BlocProvider.of<HomeBloc>(context)
                      .add(HomeEventBackBtnClick());
                },
              ),
              Column(
                children: [
                  AVerticalSpace(_kVerticalSpaceBeforeForgetIcon.scale()),
                  Text(
                    Stringss.current.txtForgotPassword,
                    style: textStyleBoldCustomLargeColor(
                        _kCommonHintTextFieldFontSize.scale(),
                        KColorAppThemeColor),
                  ).align(Alignment.center),

                  //  Image(
                  //   image: AssetImage('${imgPathGeneral}ic_forgot_pwd.png'),
                  // ).align(Alignment.center),
                  AVerticalSpace(_kVerticalSpaceBeforeForgetIcon.scale()),
                  // Text(
                  //   Stringss.current.txtMessageForgetPwd,
                  //   style: textStyleCustomColor(
                  //       _kCommonForgetPwdTopHint.scale(), Colors.black),
                  //   textAlign: TextAlign.center,
                  // ).align(Alignment.centerLeft),
                  AVerticalSpace(_kVerticalSpaceBeforeForgetIcon.scale()),
                  TextField(
                    controller: _textFiledEmailId,
                    keyboardType: TextInputType.text,
                    autofocus: false,
                    cursorColor: KColorTextFieldCommonHint,
                    decoration: InputDecoration(
                      hintText: Stringss.current.txtHintEmail,
                      hintStyle: textStyleCustomColor(
                          _kEmailHintFontSize.scale(),
                          KColorTextFieldCommonHint),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  AVerticalSpace(_kVerticalSpaceBeforeForgetIcon.scale()),
                  ARoundedButton(
                    btnBgColor: kColorAppBgColor,
                    btnTextColor: Colors.white,
                    btnOnPressed: () {
                      if (_textFiledEmailId.text.toString().isEmpty) {
                        showSnackBar(
                            "Please enter your registered email id", context);
                      } else {
                        showHideProgress(true);
                        BlocProvider.of<HomeBloc>(context).add(
                            ForgotPasswordEventVerifyBtnClick(
                                _textFiledEmailId.text.toString()));
                      }
                    },
                    btnText: Stringss.current.btnRetievePwd,
                    btnHeight: kHeightBtnSplashNormal.scale(),
                    btnWidth: kWidthBtnNormal.scale(),
                    btnFontSize: kFontSizeBtnLarge.scale(),
                    btnElevation: 0,
                  ),
                ],
              )
                  .leftPadding(_kCommonPadding.scale())
                  .rightPadding(_kCommonPadding.scale())
            ],
          ).widgetBgColor(kColorScreenBgColor),
        ).pageBgColor(kColorAppBgColor));
  }
}
