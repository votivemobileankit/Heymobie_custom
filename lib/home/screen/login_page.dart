import 'dart:io' show Platform;

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grambunny_customer/components/components.dart';
import 'package:grambunny_customer/generated/l10n.dart';
import 'package:grambunny_customer/home/home.dart';
import 'package:grambunny_customer/home/model/product_list_model.dart';
import 'package:grambunny_customer/side_navigation/side_navigation.dart';
import 'package:grambunny_customer/theme/theme.dart';
import 'package:grambunny_customer/utils/utils.dart';

import '../model/driver_list_model.dart';

const double _kVerticalSpaceTopHeartLogo = 45.0;
const double _kVerticalSpaceAfterHeartLogo = 10.0;
const double _kVerticalSpaceAfterUserNameField = 25.0;
const double _kVerticalSpaceBeforeUserNameField = 55.0;
const double _kCommonPadding = 14.0;
const double _kCommonHintTextFieldFontSize = 14.0;
const double _kWelcomeTextFont = 40.0;
const double _kSignInTextFont = 15.0;

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _textFiledUserName;
  late TextEditingController _textFiledPassword;
  String? _deviceType;
  String? _osName;
  String? _card_id;
  String? _deviceToken;
  String? strScreen;
  List<ItemsCart>? _productList;

  late DriverList _driverDetail;
  late ProductListMenu productListModel;

  late DataCart _cartDataModel;

  @override
  void initState() {
    // TODO: implement initState
    HomeState homeState = BlocProvider.of<HomeBloc>(context).state;
    if (homeState is LoginPageState) {
      strScreen = homeState.strScreen;
    } else if (homeState is LoginPageStateFromCheckOut) {
      strScreen = homeState.strScreen;
      _productList = homeState.productList;
      _driverDetail = homeState.driverDetail;
      productListModel = homeState.productListModel;
      _cartDataModel = homeState.cartDataModel;
    }
    print(strScreen);
    setDarkStatusBarOverlay();
    _textFiledUserName = TextEditingController();
    _textFiledPassword = TextEditingController();
    _card_id = "";
    _deviceToken = "";

    getDeviceVersion();

    super.initState();
  }

  Future<void> getDeviceVersion() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      _osName = "Android " + androidInfo.version.release;
      _deviceType = "Android";
    } else {
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      _osName = "IOS " + iosInfo.systemName;
      _deviceType = "IOS";
    }
    print("deviceType:" + _deviceType! + "  osName:" + _osName!);
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
          if (state is HomeMenuItemDetailsPageState) {
            Navigator.of(context).pop();
          } else if (state is HomeCategoryProductPageState) {
            print("call state");
            Navigator.of(context).pop();
          } else if (state is HomeCategoryListPageState) {
            print("call state");
            Navigator.of(context).pop();
          } else if (state is HomeInitial) {
            Navigator.of(context).pop();
          } else if (state is HomeCheckOutPageState) {
            Navigator.of(context).pushNamed(HomeNavigator.homeCheckoutPage);
          } else if (state is SignUpPageState) {
            showHideProgress(false);
            Navigator.of(context).pushNamed(HomeNavigator.signUpPage);
          } else if (state is ForgetPwdPageState) {
            Navigator.of(context).pushNamed(HomeNavigator.forgotPage);
          } else if (state is HomeInitial) {
            Navigator.of(context).pop(true);
          } else if (state is HomeCheckOutPageState) {
            Navigator.of(context).pop(true);
          } else if (state is OTPpageState) {
            Navigator.of(context).pushNamed(HomeNavigator.otpPage);
          } else if (state is LoginLoadingCompleteState) {
            showHideProgress(false);
            if (state.userDetail.userStatus == "0") {
              BlocProvider.of<HomeBloc>(context).add(HomeEventForOTPScreen(
                  state.userDetail.email ?? "", "signin"));
            } else {
              BlocProvider.of<HomeBloc>(context).add(HomeEventBackBtnClick());
            }
            showSnackBar(state.message, context);
          } else if (state is LoginLoadingErrorState) {
            showHideProgress(false);
            BlocProvider.of<HomeBloc>(context).add(LoginEventLoginStateReset());
            showSnackBar(state.message, context);
          }
          // if (state is LoginLoadingCompleteState) {
          //   BlocProvider.of<HmRootBloc>(context)
          //       .add(HmRootEventLoginLoadingComplete());
          // }
        },
        child: SafeArea(
          bottom: false,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              AHeaderWidget(
                btnEditOnPressed: () {},
                rightEditButtonVisibility: false,
                headerText: "",
                headerSigninText: "",
                strBtnRightImageName: "",
                strBackbuttonName: 'ic_red_btn_back.png',
                backBtnVisibility: true,
                btnBackOnPressed: () {
                  print(strScreen);

                  if (strScreen == "ProductDetail") {
                    BlocProvider.of<HomeBloc>(context).add(
                        HomeEventBackForProductDetailPage(
                            _driverDetail, productListModel));
                  } else if (strScreen == "CategoryPage") {
                    BlocProvider.of<HomeBloc>(context)
                        .add(HomeEventBackForCategoryPage(_driverDetail));
                  } else if (strScreen == "DriverList") {
                    BlocProvider.of<HomeBloc>(context)
                        .add(HomeEventBackBtnClick());
                  } else if (strScreen == "HomeCartpage") {
                    BlocProvider.of<HomeBloc>(context)
                        .add(HomeEventBackForProductListpage());
                  } else {
                    //Navigator.pop(context);
                    print("Back==");
                    BlocProvider.of<HomeBloc>(context)
                        .add(HomeEventBackBtnClick());
                  }
                },
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AVerticalSpace(_kVerticalSpaceTopHeartLogo.scale()),
                  // Image(
                  //   image:
                  //       AssetImage('${imgPathGeneral}ic_app_logo_splash.png'),
                  // ).align(Alignment.center),
                  //AVerticalSpace(_kVerticalSpaceAfterHeartLogo.scale()),

                  Image(
                    image: AssetImage(
                      '${imgPathGeneral}ic_app_name_logo.png',
                    ),
                    height: 120.0.scale(),
                  ).align(Alignment.center),
                  AVerticalSpace(_kVerticalSpaceBeforeUserNameField.scale()),
                  TextField(
                    controller: _textFiledUserName,
                    keyboardType: TextInputType.emailAddress,
                    inputFormatters: [
                      NoLeadingSpaceFormatter(),
                    ],
                    autofocus: false,
                    cursorColor: KColorTextFieldCommonHint,
                    decoration: InputDecoration(
                      hintText: Stringss.current.txtHintUserName,
                      hintStyle: textStyleCustomColor(
                          _kCommonHintTextFieldFontSize.scale(),
                          KColorTextFieldCommonHint),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  AVerticalSpace(_kVerticalSpaceAfterUserNameField.scale()),
                  TextField(
                      controller: _textFiledPassword,
                      inputFormatters: [
                        NoLeadingSpaceFormatter(),
                      ],
                      autofocus: false,
                      obscureText: true,
                      cursorColor: KColorTextFieldCommonHint,
                      decoration: InputDecoration(
                        hintText: Stringss.current.txtHintPassword,
                        hintStyle: textStyleCustomColor(
                            _kCommonHintTextFieldFontSize.scale(),
                            KColorTextFieldCommonHint),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      )),
                  AVerticalSpace(_kVerticalSpaceAfterUserNameField.scale()),
                  ARoundedButton(
                    btnBorderSideColor: kColorCommonButton,
                    btnDisabledColor: Color(0xFF5e6163),
                    btnIconSize: 15,
                    btnDisabledTextColor: Color(0xFFFFFFFF),
                    btnFontWeight: FontWeight.normal,
                    btnBgColor: kColorAppBgColor,
                    btnTextColor: Colors.white,
                    btnOnPressed: () {
                      if (_textFiledUserName.text.toString().isEmpty) {
                        showSnackBar("Please enter your Email id.", context);
                      } else if (_textFiledPassword.text.toString().isEmpty) {
                        showSnackBar("Please enter your Password.", context);
                      } else {
                        showHideProgress(true);
                        BlocProvider.of<HomeBloc>(context).add(
                            LoginEventBtnLoginClicked(
                                _textFiledUserName.text.toString(),
                                _textFiledPassword.text.toString(),
                                _card_id!,
                                _deviceType!,
                                _osName!,
                                _deviceToken!));
                      }
                    },
                    btnText: Stringss.current.txtBtnLogin,
                    btnHeight: kHeightBtnSplashNormal.scale(),
                    btnWidth: kWidthBtnNormal.scale(),
                    btnFontSize: kFontSizeBtnLarge.scale(),
                    btnElevation: 0,
                  ),
                  AVerticalSpace(_kVerticalSpaceAfterHeartLogo.scale()),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TextButton(
                          onPressed: () {
                            BlocProvider.of<HomeBloc>(context)
                                .add(LoginEventForgetPasswordClick());
                          },
                          style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                          ),
                          child: RichText(
                            text: TextSpan(
                                text: Stringss.current.txtForgotPwd,
                                style: TextStyle(
                                  backgroundColor: Colors.transparent,
                                  color: kColorTextFieldText,
                                  fontSize: _kSignInTextFont.scale(),
                                ),
                                children: [
                                  TextSpan(
                                      text: Stringss.current.txtBtnForgotPwd,
                                      style: TextStyle(
                                          color: kColorAppBgColor,
                                          fontSize: _kSignInTextFont.scale()))
                                ]),
                          )).align(Alignment.centerLeft).expand(),
                    ],
                  ).widgetBgColor(kColorScreenBgColor),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      AVerticalSeparatorLine(
                        height: .50.scale(),
                        color: KColorTextGrey,
                        width: 130.0.scale(),
                      ),
                      Text("or"),
                      AVerticalSeparatorLine(
                        height: .50.scale(),
                        color: KColorTextGrey,
                        width: 130.0.scale(),
                      ),
                    ],
                  ),
                  AVerticalSpace(_kVerticalSpaceTopHeartLogo.scale()),
                  TextButton(
                      onPressed: () {
                        showHideProgress(true);
                        BlocProvider.of<HomeBloc>(context)
                            .add(LoginEventSignUpButtonClick());
                      },
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: RichText(
                        text: TextSpan(
                            text: Stringss.current.txtBtnSignup,
                            style: TextStyle(
                              backgroundColor: Colors.transparent,
                              color: kColorTextFieldText,
                              fontSize: _kSignInTextFont.scale(),
                            ),
                            children: [
                              TextSpan(
                                  text: Stringss.current.txtBtnSignupNow,
                                  style: TextStyle(
                                      color: kColorAppBgColor,
                                      fontSize: _kSignInTextFont.scale()))
                            ]),
                      )).align(Alignment.centerLeft),
                  AVerticalSpace(_kVerticalSpaceAfterHeartLogo.scale()),
                ],
              ).leftPadding(_kCommonPadding).rightPadding(_kCommonPadding)
            ],
          ).widgetBgColor(kColorScreenBgColor).scroll(),
        )).pageBgColor(kColorScreenBgColor);
  }
}
