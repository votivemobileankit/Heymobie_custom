import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grambunny_customer/components/components.dart';
import 'package:grambunny_customer/home/home.dart';
import 'package:grambunny_customer/side_navigation/side_navigation.dart';
import 'package:grambunny_customer/theme/theme.dart';
import 'package:grambunny_customer/utils/utils.dart';


const double _kVerticalSpaceTopHeartLogo = 40.0;
const double _kVerticalSpaceAfterHeartLogo = 35.0;
const double _kVerticalSpaceAfterUserNameField = 25.0;
const double _kCommonPadding = 14.0;
const double _kCommonHintTextFieldFontSize = 14.0;
const double _kWelcomeTextFont = 30.0;

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPageState createState() => _ResetPageState();
}

TextEditingController _textFiledPassword;
TextEditingController _textFiledConfirmPassword;
String email;

class _ResetPageState extends State<ResetPasswordPage> {
  @override
  void initState() {
    // TODO: implement initState
    _textFiledPassword = TextEditingController();
    _textFiledConfirmPassword = TextEditingController();

    HomeState homeState = BlocProvider.of<HomeBloc>(context).state;
    if (homeState is OtpApiLoadingCompleteState) {
      email = homeState.email;
      print("email==>" + email);
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
      listenWhen: (prevState, curState) => ModalRoute.of(context).isCurrent,
      listener: (context, state) {
        if (state is ResetPasswordApiLoadingCompleteState) {
          showHideProgress(false);
          showSnackBar(state.message, context);
          Navigator.of(context).pushNamed(HomeNavigator.loginPage);
        }
        if (state is OtpApiLoadingCompleteState) {
          email = state.email;
        }
        if (state is ResetPasswordApiLoadingErrorState) {
          showHideProgress(false);
          showSnackBar(state.message, context);
          BlocProvider.of<HomeBloc>(context)
              .add(ResetPasswordPageResetPageEvent(state.email));
        }
      },
      child: SafeArea(
        bottom: false,
        top: false,
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                AHeaderWidget(
                  backBtnVisibility: false,
                ),
                Column(
                  children: [
                    AVerticalSpace(_kVerticalSpaceAfterHeartLogo.scale()),
                    Text(
                      "Reset Password",
                      style: textStyleCustomColor(
                          _kWelcomeTextFont.scale(), KColorAppThemeColor),
                    ).align(Alignment.center),
                    AVerticalSpace(_kVerticalSpaceAfterUserNameField.scale()),
                    TextField(
                      controller: _textFiledPassword,
                      autofocus: false,
                      obscureText: true,
                      cursorColor: kColorDialogNameTitle,
                      decoration: InputDecoration(
                          hintText: "New Password",
                          hintStyle: textStyleCustomColor(
                              _kCommonHintTextFieldFontSize.scale(),
                              Colors.black),
                          fillColor: Colors.white,
                          filled: true,
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black)),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 1.0),
                          )),
                    ),
                    AVerticalSpace(_kVerticalSpaceAfterUserNameField.scale()),
                    TextField(
                      controller: _textFiledConfirmPassword,
                      autofocus: false,
                      obscureText: true,
                      cursorColor: kColorDialogNameTitle,
                      decoration: InputDecoration(
                          hintText: "Confirm Password",
                          hintStyle: textStyleCustomColor(
                              _kCommonHintTextFieldFontSize.scale(),
                              Colors.black),
                          fillColor: Colors.white,
                          filled: true,
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black)),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 1.0),
                          )),
                    ),
                    AVerticalSpace(_kVerticalSpaceAfterUserNameField.scale()),
                    ARoundedButton(
                      btnBgColor: kColorAppBgColor,
                      btnTextColor: Colors.white,
                      btnOnPressed: () {
                        if (_textFiledPassword.text.toString().isEmpty) {
                          showSnackBar(
                              "Please enter your new password.", context);
                        } else if (_textFiledPassword.text.toString() !=
                            _textFiledConfirmPassword.text.toString()) {
                          showSnackBar(
                              "Password and confirm password do not match.",
                              context);
                        } else {
                          showHideProgress(true);
                          BlocProvider.of<HomeBloc>(context).add(
                              ResetPasswordEventResetBtnClick(
                                  email, _textFiledPassword.text.toString()));
                        }
                      },
                      btnText: "Reset",
                      btnHeight: kHeightBtnSplashNormal.scale(),
                      btnWidth: kWidthBtnNormal.scale(),
                      btnFontSize: kFontSizeBtnLarge.scale(),
                      btnElevation: 0,
                    ),
                  ],
                ).leftPadding(_kCommonPadding).rightPadding(_kCommonPadding)
              ],
            ).scroll(),
          ],
        ),
      ).pageBgColor(Colors.white),
    );
  }
}
