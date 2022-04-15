import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grambunny_customer/components/components.dart';
import 'package:grambunny_customer/profile/profile.dart';
import 'package:grambunny_customer/side_navigation/side_navigation.dart';
import 'package:grambunny_customer/theme/theme.dart';
import 'package:grambunny_customer/utils/utils.dart';


const double _kVerticalSpaceAfterHeartLogo = 35.0;
const double _kVerticalSpaceAfterUserNameField = 25.0;
const double _kCommonPadding = 14.0;
const double _kCommonHintTextFieldFontSize = 14.0;
const double _kWelcomeTextFont = 30.0;

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

TextEditingController _textFiledOldPassword;
TextEditingController _textFiledNewPassword;
TextEditingController _textFiledConfirmPassword;
String userid;

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  void initState() {
    // TODO: implement initState
    _textFiledOldPassword = TextEditingController();
    _textFiledNewPassword = TextEditingController();
    _textFiledConfirmPassword = TextEditingController();

    super.initState();
  }

  void showHideProgress(bool show) {
    BlocProvider.of<SideNavigatBloc>(context)
        .add(SideNavigationEventToggleLoadingAnimation(needToShow: show));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocListener<ProfileBloc, ProfileState>(
      listenWhen: (prevState, curState) => ModalRoute.of(context).isCurrent,
      listener: (context, state) {
        if (state is ChangePasswordApiCompleteState) {
          showHideProgress(false);
          showSnackBar(state.msg, context);
          BlocProvider.of<ProfileBloc>(context).add(ProfileEventBackBtnClick());
        }
        if (state is ProfileInitial) {
          Navigator.of(context).pop(true);
        }
        if (state is ChangePasswordApiErrorState) {
          showHideProgress(false);
          showSnackBar(state.msg, context);
          BlocProvider.of<ProfileBloc>(context)
              .add(ChangePasswordPageResetPageEvent());
        }
      },
      child: SafeArea(
        bottom: false,
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            AHeaderWidget(
              strBackbuttonName: 'ic_red_btn_back.png',
              backBtnVisibility: true,
              btnBackOnPressed: () {
                //Scaffold.of(context).openDrawer();
                BlocProvider.of<ProfileBloc>(context)
                    .add(ProfileEventBackBtnClick());
              },
              strBtnRightImageName: 'ic_search_logo.png',
              rightEditButtonVisibility: false,
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                AVerticalSpace(_kVerticalSpaceAfterHeartLogo.scale()),
                Text(
                  "Change Password",
                  style: textStyleCustomColor(
                      _kWelcomeTextFont.scale(), KColorAppThemeColor),
                ).align(Alignment.center),
                AVerticalSpace(_kVerticalSpaceAfterUserNameField.scale()),
                TextField(
                  controller: _textFiledOldPassword,
                  autofocus: false,
                  obscureText: true,
                  cursorColor: kColorDialogNameTitle,
                  decoration: InputDecoration(
                      hintText: "Old Password",
                      hintStyle: textStyleCustomColor(
                          _kCommonHintTextFieldFontSize.scale(), Colors.black),
                      fillColor: Colors.white,
                      filled: true,
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black)),
                      enabledBorder: const OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 1.0),
                      )),
                ),
                AVerticalSpace(_kVerticalSpaceAfterUserNameField.scale()),
                TextField(
                  controller: _textFiledNewPassword,
                  autofocus: false,
                  obscureText: true,
                  cursorColor: kColorDialogNameTitle,
                  decoration: InputDecoration(
                      hintText: "New Password",
                      hintStyle: textStyleCustomColor(
                          _kCommonHintTextFieldFontSize.scale(), Colors.black),
                      fillColor: Colors.white,
                      filled: true,
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black)),
                      enabledBorder: const OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 1.0),
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
                          _kCommonHintTextFieldFontSize.scale(), Colors.black),
                      fillColor: Colors.white,
                      filled: true,
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black)),
                      enabledBorder: const OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 1.0),
                      )),
                ),
                AVerticalSpace(_kVerticalSpaceAfterUserNameField.scale()),
                ARoundedButton(
                  btnBgColor: kColorCommonButton,
                  btnTextColor: Colors.white,
                  btnOnPressed: () {
                    if (_textFiledOldPassword.text.toString().isEmpty) {
                      showSnackBar("Please enter your old password.", context);
                    } else if (_textFiledNewPassword.text.toString().isEmpty) {
                      showSnackBar("Please enter your new password.", context);
                    } else if (_textFiledNewPassword.text.toString() !=
                        _textFiledConfirmPassword.text.toString()) {
                      showSnackBar(
                          "Password and confirm password do not match.",
                          context);
                    } else {
                      showHideProgress(true);
                      BlocProvider.of<ProfileBloc>(context).add(
                          ChangePasswordEventForSubmitButton(
                              _textFiledOldPassword.text,
                              _textFiledNewPassword.text));
                    }
                  },
                  btnText: "Submit",
                  btnHeight: kHeightBtnSplashNormal.scale(),
                  btnWidth: kWidthBtnNormal.scale(),
                  btnFontSize: kFontSizeBtnLarge.scale(),
                  btnElevation: 0,
                ),
              ],
            )
                .leftPadding(_kCommonPadding.scale())
                .rightPadding(_kCommonPadding.scale())
                .expand()
          ],
        ).widgetBgColor(Colors.white),
      ),
    ).pageBgColor(kColorAppBgColor);
  }
}
