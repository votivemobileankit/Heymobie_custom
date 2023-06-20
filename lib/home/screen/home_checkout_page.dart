import 'dart:io';

import 'package:credit_card_validator/credit_card_validator.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:grambunny_customer/components/components.dart';
import 'package:grambunny_customer/dialogs/dlg_two_button_withImage.dart';
import 'package:grambunny_customer/hm_root/bloc/bloc.dart';
import 'package:grambunny_customer/home/home.dart';
import 'package:grambunny_customer/home/model/product_list_model.dart';
import 'package:grambunny_customer/services/services.dart';
import 'package:grambunny_customer/side_navigation/side_navigation.dart';
import 'package:grambunny_customer/theme/theme.dart';
import 'package:grambunny_customer/utils/utils.dart';

import '../model/driver_list_model.dart';

const double _kFontSizeHeadingText = 17.0;
const double _kFontSizeMedium = 14.0;
const double _kFontSizeEditFieldHint = 13.0;
const double _kHeightTextFieldState = 55.0;
const double _kHeightBtnCheckout = 45.0;

const double _kTextBirthdateField = 327.0;
String strSubtotal = "";
String strFinaltotal = "";
String strCitytax = "";
String strSalestax = "";
String strExcisetax = "";
String strDeliveryfee = "";
String strCouponAmount = "";

class HomeCheckOutPage extends StatefulWidget {
  @override
  _HomeCheckOutPageState createState() => _HomeCheckOutPageState();
}

class _HomeCheckOutPageState extends State<HomeCheckOutPage> {
  late TextEditingController _textFiledAddressaprtment;
  late TextEditingController _textFiledCity;

  late TextEditingController _textFiledZip;
  late TextEditingController _textFiledMobile;
  late String strPaymentType = '';
  late String strState = '';
  late String strApartment = '';
  String strCity = '';
  String strZipCode = '';
  String strMobile = '';
  String cardNumber = '';
  String expiryDate = '';
  String expiryMonth = '';
  String expiryYear = '';
  String cardHolderName = '';
  String cvvCode = '';
  String cardType = '';
  String comment = '';
  bool isCvvFocused = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _isCodSelect = false;
  bool _isCouponApplied = false;
  bool _isCreditSelect = false;
  late String _strScreen;
  late DriverList _driverDetail;
  late ProductListMenu _productListModel;
  bool showPerformance = false;
  late List<Couponlist> couponArrayList;
  late DataResponse _checkOutCalculation;
  bool oneTimeCall = true;
  late List<StatesList> _stateArrayList;
  late String _osName;
  late String _deviceType;
  late String _vendorId;

  onSettingCallback() {
    setState(() {
      showPerformance = !showPerformance;
    });
  }

  late ScrollController scrollController;

  ///The controller of sliding up panel
  SlidingUpPanelController panelController = SlidingUpPanelController();

  void showHideProgress(bool show) {
    BlocProvider.of<SideNavigatBloc>(context)
        .add(SideNavigationEventToggleLoadingAnimation(needToShow: show));
  }

  late CreditCardValidator _ccValidator;

  @override
  void initState() {
    getDeviceVersion();
    couponArrayList = [];
    _ccValidator = CreditCardValidator();
    // TODO: implement initState
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        panelController.expand();
      } else if (scrollController.offset <=
              scrollController.position.minScrollExtent &&
          !scrollController.position.outOfRange) {
        panelController.anchor();
      } else {}
    });

    HomeState homeState = BlocProvider.of<HomeBloc>(context).state;
    if (homeState is HomeCheckOutPageState) {
      _strScreen = homeState.strScreen;
      _productListModel = homeState.productListModel;
      _vendorId = homeState.vendorId;
      _driverDetail = homeState.driverDetail;
      _stateArrayList = homeState.stateArrayList;
    }
    _textFiledAddressaprtment = TextEditingController();
    _textFiledCity = TextEditingController();
    _textFiledZip = TextEditingController();
    _textFiledMobile = TextEditingController();

    if (oneTimeCall) {
      oneTimeCall = false;
      showHideProgress(true);
      BlocProvider.of<HomeBloc>(context).add(HomeEventCouponListbtnClick(
          _vendorId, _strScreen, _driverDetail, _productListModel, ""));
    }

    super.initState();
  }

  Future<void> getDeviceVersion() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      _osName = "Android " + androidInfo.version.release;
      _deviceType = "Android";
    } else {
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      _osName = "IOS " + iosInfo.systemVersion;
      _deviceType = "IOS";
    }
    print("deviceType:" + _deviceType + "  osName:" + _osName);
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      if (expiryDate != null && expiryDate != "") {
        expiryMonth = expiryDate.split("/")[0];
        if (expiryMonth != null && expiryMonth != "") {
          expiryYear = expiryDate.split("/")[1];
        }
      }
      // expiryMonth = expiryDate.split("/")[0];
      // expiryYear = expiryDate.split("/")[1];
      // print(expiryMonth);
      print(expiryDate);
      cardHolderName = creditCardModel.cardHolderName;
      print(cardHolderName);
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
    var ccNumResults = _ccValidator.validateCCNum(cardNumber);
    if (ccNumResults.ccType == "CreditCardType.discover") {
      cardType = "discover";
    } else if (ccNumResults.ccType == "CreditCardType.visa") {
      cardType = "Visa";
    } else if (ccNumResults.ccType == "CreditCardType.mastercard") {
      cardType = "Mastercard";
    } else if (ccNumResults.ccType == "CreditCardType.amex") {
      cardType = "American Express";
    } else {
      cardType = "";
    }
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
        } else if (state is HomeCartPageState) {
          Navigator.of(context).pop();
        } else if (state is HomeCheckOutPageState) {
          setState(() {
            _strScreen = state.strScreen;
            _productListModel = state.productListModel;
            _driverDetail = state.driverDetail;
            _stateArrayList = state.stateArrayList;
          });
        } else if (state is HomeCheckOutCalculateState) {
          showHideProgress(false);

          setState(() {
            _checkOutCalculation = state.checkOutCalculation;
            strSubtotal = _checkOutCalculation.subtotal;
            strFinaltotal = _checkOutCalculation.grandtotal;
            strCitytax = _checkOutCalculation.cityTax;
            strSalestax = _checkOutCalculation.salesTax;
            strExcisetax = _checkOutCalculation.exciseTax;
            strDeliveryfee = _checkOutCalculation.deliveryFee;
            strCouponAmount = _checkOutCalculation.couponAmount;
            couponCodeId = "";
            couponAmount = "";
            couponArrayList = state.couponArrayList;
            _isCouponApplied = false;
          });

          print("Before page Reset");
          BlocProvider.of<HomeBloc>(context).add(HomeEventResetCheckOutState(
              _strScreen, _driverDetail, _productListModel, _vendorId));
        } else if (state is HomeCheckOutCouponApplyState) {
          showHideProgress(false);

          setState(() {
            _checkOutCalculation = state.checkOutCalculation;
            strSubtotal = _checkOutCalculation.subtotal;
            strFinaltotal = _checkOutCalculation.grandtotal;
            strCitytax = _checkOutCalculation.cityTax;
            strSalestax = _checkOutCalculation.salesTax;
            strExcisetax = _checkOutCalculation.exciseTax;
            strDeliveryfee = _checkOutCalculation.deliveryFee;
            strCouponAmount = _checkOutCalculation.couponAmount;
            couponCodeId = state.couponId;
            couponAmount = state.couponAmount;
            print("coupon amount" + couponAmount);
            couponArrayList = state.couponArrayList;
          });
          if (state.message == "Invalid Coupon code or expired") {
            showSnackBar(state.message, context);
          } else {
            setState(() {
              _isCouponApplied = true;
            });
          }

          print("Before page Reset");
          BlocProvider.of<HomeBloc>(context).add(HomeEventResetCheckOutState(
              _strScreen, _driverDetail, _productListModel, _vendorId));
        } else if (state is HomeCheckOutOrderCompleteState) {
          showHideProgress(false);
          thankYouDialog(
              context: context,
              btnHome: () {
                BlocProvider.of<HmRootBloc>(context)
                    .add(HmRootEventHomePageBack());
              },
              btnOrderHistory: () {
                BlocProvider.of<SideNavigatBloc>(context)
                    .add(SideNavigationEventGoToOrderHistoryList(true));
              },
              titleText: '',
              descText: "",
              btnTitleText: "");
        } else if (state is HomeCheckOutOrderErrorState) {
          showHideProgress(false);
          showSnackBar(state.message, context);
          BlocProvider.of<HomeBloc>(context).add(HomeEventResetCheckOutState(
              _strScreen, _driverDetail, _productListModel, _vendorId));
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
                  print("in back pressed " + _strScreen);
                  if (_strScreen == "ProductDetail") {
                    BlocProvider.of<HomeBloc>(context).add(
                        HomeEventBackForProductDetailPage(
                            _driverDetail, _productListModel));
                  } else if (_strScreen == "CategoryPage") {
                    BlocProvider.of<HomeBloc>(context)
                        .add(HomeEventBackForCategoryPage(_driverDetail));
                  } else if (_strScreen == "DriverList") {
                    BlocProvider.of<HomeBloc>(context)
                        .add(HomeEventBackBtnClick());
                  } else if (_strScreen == "HomeCartpage") {
                    BlocProvider.of<HomeBloc>(context)
                        .add(HomeEventBackForProductListpage());
                  }
                },
                strBtnRightImageName: 'ic_search_logo.png',
                rightEditButtonVisibility: false,
                btnEditOnPressed: () {},
              ),
              Column(
                children: [
                  Stack(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Column(
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white, width: 2.0),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5.0),
                                        ),
                                        boxShadow: <BoxShadow>[
                                          new BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 3.0,
                                            offset: new Offset(0.0, 3.0),
                                          ),
                                        ],
                                      ),
                                      child: Column(children: [
                                        Text(
                                          "Delivery Address",
                                          style: textStyleBoldCustomColor(
                                              _kFontSizeHeadingText,
                                              KColorCommonText),
                                        ).align(Alignment.centerLeft),
                                        AVerticalSpace(10.0.scale()),
                                        Text(
                                          "Address with Apartment or Suite",
                                          style: textStyleBoldCustomColor(
                                              _kFontSizeEditFieldHint,
                                              KColorTextGrey),
                                        ).align(Alignment.centerLeft),
                                        AVerticalSpace(5.0.scale()),
                                        TextField(
                                          controller: _textFiledAddressaprtment,
                                          autofocus: false,
                                          cursorColor:
                                              KColorTextFieldCommonHint,
                                          decoration: InputDecoration(
                                            hintText: "",
                                            hintStyle: textStyleCustomColor(
                                                _kFontSizeEditFieldHint.scale(),
                                                KColorTextGrey),
                                            fillColor: Colors.white,
                                            filled: true,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                        ),
                                        AVerticalSpace(10.0.scale()),
                                        Text(
                                          "City",
                                          style: textStyleBoldCustomColor(
                                              _kFontSizeEditFieldHint,
                                              KColorTextGrey),
                                        ).align(Alignment.centerLeft),
                                        AVerticalSpace(5.0.scale()),
                                        TextField(
                                          controller: _textFiledCity,
                                          autofocus: false,
                                          cursorColor:
                                              KColorTextFieldCommonHint,
                                          decoration: InputDecoration(
                                            hintText: "",
                                            hintStyle: textStyleCustomColor(
                                                _kFontSizeEditFieldHint.scale(),
                                                KColorTextGrey),
                                            fillColor: Colors.white,
                                            filled: true,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                        ),
                                        AVerticalSpace(10.0.scale()),
                                        Text(
                                          "Mobile Number",
                                          style: textStyleBoldCustomColor(
                                              _kFontSizeEditFieldHint,
                                              KColorTextGrey),
                                        ).align(Alignment.centerLeft),
                                        AVerticalSpace(5.0.scale()),
                                        TextField(
                                          controller: _textFiledMobile,
                                          autofocus: false,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(
                                                10),
                                          ],
                                          cursorColor:
                                              KColorTextFieldCommonHint,
                                          decoration: InputDecoration(
                                            hintText: "",
                                            hintStyle: textStyleCustomColor(
                                                _kFontSizeEditFieldHint.scale(),
                                                KColorTextGrey),
                                            fillColor: Colors.white,
                                            filled: true,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                        ),
                                        AVerticalSpace(10.0.scale()),
                                        Text(
                                          "State",
                                          style: textStyleBoldCustomColor(
                                              _kFontSizeEditFieldHint,
                                              KColorTextGrey),
                                        ).align(Alignment.centerLeft),
                                        AVerticalSpace(5.0.scale()),
                                        InkWell(
                                            splashColor: Colors.transparent,
                                            onTap: () {
                                              if (_stateArrayList.length > 0) {
                                                showModalBottomSheet(
                                                    context: context,
                                                    builder: (BuildContext bc) {
                                                      return GestureDetector(
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              ListView.builder(
                                                                physics:
                                                                    ClampingScrollPhysics(),
                                                                shrinkWrap:
                                                                    true,
                                                                itemCount:
                                                                    _stateArrayList
                                                                        .length,
                                                                itemBuilder:
                                                                    (BuildContext
                                                                            context,
                                                                        int index) {
                                                                  return InkWell(
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          strState =
                                                                              _stateArrayList[index].name;
                                                                        });

                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          AVerticalSpace(
                                                                              15.0.scale()),
                                                                          Text(
                                                                              _stateArrayList[index].name,
                                                                              style: textStyleCustomColor(14.0.scale(), KColorCommonText)),
                                                                          AVerticalSpace(
                                                                              15.0.scale()),
                                                                          ASeparatorLine(
                                                                              height: .5.scale(),
                                                                              color: KColorCommonText)
                                                                        ],
                                                                      ).align(Alignment
                                                                              .center));
                                                                },
                                                              ).expand()
                                                            ],
                                                          ));
                                                    });
                                              }
                                            },
                                            child: Container(
                                              padding:
                                                  EdgeInsets.all(10.0.scale()),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: Colors.black),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        8.0.scale()),
                                                shape: BoxShape.rectangle,
                                              ),
                                              child: Text(
                                                strState,
                                                style: textStyleCustomColor(
                                                    _kFontSizeEditFieldHint
                                                        .scale(),
                                                    KColorTextGrey),
                                                textAlign: TextAlign.center,
                                              ).align(Alignment.centerLeft),
                                            ).size(
                                                _kTextBirthdateField.scale(),
                                                _kHeightTextFieldState
                                                    .scale())),
                                        AVerticalSpace(10.0.scale()),
                                        Text(
                                          "Zip Code",
                                          style: textStyleBoldCustomColor(
                                              _kFontSizeEditFieldHint,
                                              KColorTextGrey),
                                        ).align(Alignment.centerLeft),
                                        AVerticalSpace(5.0.scale()),
                                        TextField(
                                          controller: _textFiledZip,
                                          keyboardType: TextInputType.number,
                                          autofocus: false,
                                          cursorColor:
                                              KColorTextFieldCommonHint,
                                          decoration: InputDecoration(
                                            hintText: "",
                                            hintStyle: textStyleCustomColor(
                                                _kFontSizeEditFieldHint.scale(),
                                                KColorTextGrey),
                                            fillColor: Colors.white,
                                            filled: true,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                        ),
                                      ])
                                          .leftPadding(10.0.scale())
                                          .rightPadding(10.0.scale())
                                          .topPadding(6.0.scale())
                                          .bottomPadding(6.0.scale())),

                                  AVerticalSpace(10.0.scale()),
                                  // ASeparatorLine(
                                  //     height: .5.scale(), color: KColorTextGrey),
                                  AVerticalSpace(15.0.scale()),
                                  if (_checkOutCalculation != null)
                                    _OrderDetailWidget(
                                        panelController,
                                        _strScreen,
                                        _productListModel,
                                        _driverDetail,
                                        _checkOutCalculation,
                                        couponArrayList,
                                        showHideProgress,
                                        _isCouponApplied,
                                        _vendorId),
                                  AVerticalSpace(15.0.scale()),

                                  Text(
                                    "Payment Method",
                                    style: textStyleBoldCustomColor(
                                        _kFontSizeHeadingText,
                                        KColorCommonText),
                                  ).align(Alignment.centerLeft),
                                  AVerticalSpace(15.0.scale()),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _isCodSelect = true;
                                        _isCreditSelect = false;
                                        strPaymentType = "cash";
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Image(
                                            image: _isCodSelect
                                                ? AssetImage(
                                                    '${imgPathGeneral}ic_home_select_radio_btn.png')
                                                : AssetImage(
                                                    '${imgPathGeneral}ic_home_unselect_radio_btn.png')),
                                        AHorizontalSpace(5.0.scale()),
                                        Text(
                                          "Cash / Debit / Credit On Delivery To Cash / Debit Card On Delivery",
                                          style: textStyleBoldCustomColor(
                                              _kFontSizeHeadingText,
                                              KColorCommonText),
                                        ).expand()
                                      ],
                                    ),
                                  ),

                                  AVerticalSpace(15.0.scale()),
                                  Visibility(
                                    visible: true,
                                    child: Column(
                                      children: [
                                        CreditCardWidget(
                                          cardBgColor: kColorAppBgColor,
                                          cardNumber: cardNumber,
                                          expiryDate: expiryDate,
                                          cardHolderName: cardHolderName,
                                          cvvCode: cvvCode,
                                          showBackView: isCvvFocused,
                                          obscureCardNumber: true,
                                          obscureCardCvv: true,
                                          onCreditCardWidgetChange:
                                              (CreditCardBrand) {
                                            print(CreditCardBrand.brandName);
                                          },
                                        ),
                                        Column(
                                          children: <Widget>[
                                            CreditCardForm(
                                              formKey: formKey,
                                              obscureCvv: true,
                                              obscureNumber: true,
                                              cardNumber: cardNumber,
                                              cvvCode: cvvCode,
                                              cardHolderName: cardHolderName,
                                              expiryDate: expiryDate,
                                              themeColor: Colors.blue,
                                              cardNumberDecoration:
                                                  const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Number',
                                                hintText: 'XXXX XXXX XXXX XXXX',
                                              ),
                                              expiryDateDecoration:
                                                  const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Expired Date',
                                                hintText: 'XX/XX',
                                              ),
                                              cvvCodeDecoration:
                                                  const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'CVV',
                                                hintText: 'XXX',
                                              ),
                                              cardHolderDecoration:
                                                  const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Card Holder',
                                              ),
                                              onCreditCardModelChange:
                                                  onCreditCardModelChange,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  ARoundedButton(
                                    btnBorderSideColor: kColorCommonButton,
                                    btnDisabledColor: Color(0xFF5e6163),
                                    btnIconSize: 15,
                                    btnDisabledTextColor: Color(0xFFFFFFFF),
                                    btnFontWeight: FontWeight.normal,
                                    btnBgColor: kColorCommonButton,
                                    btnTextColor: Colors.white,
                                    btnOnPressed: () {
                                      if (_textFiledAddressaprtment
                                          .text.isEmpty) {
                                        showSnackBar(
                                            "Please fill Appartment/suite field ",
                                            context);
                                      } else if (_textFiledCity.text == null ||
                                          _textFiledCity.text.isEmpty) {
                                        showSnackBar(
                                            "Please fill city field ", context);
                                      } else if (strState == null ||
                                          strState.isEmpty) {
                                        showSnackBar("Please fill state field ",
                                            context);
                                      } else if (_textFiledZip.text == null ||
                                          _textFiledZip.text.isEmpty) {
                                        showSnackBar(
                                            "Please fill ZipCode field ",
                                            context);
                                      } else if (_textFiledMobile.text ==
                                              null ||
                                          _textFiledMobile.text.isEmpty) {
                                        showSnackBar(
                                            "Please fill Mobile Number field ",
                                            context);
                                      } else if (_textFiledMobile.text.length ==
                                          9) {
                                        showSnackBar(
                                            "Please fill Mobile Number field ",
                                            context);
                                      } else if (_isCodSelect == false &&
                                          _isCreditSelect == false) {
                                        showSnackBar(
                                            "Please Select payment method first ",
                                            context);
                                      } else {
                                        if (_isCodSelect) {
                                          showHideProgress(true);
                                          print("PaymentSuccess");
                                          strApartment =
                                              _textFiledAddressaprtment.text;
                                          strCity = _textFiledCity.text;
                                          strZipCode = _textFiledZip.text;
                                          strMobile = _textFiledMobile.text;
                                          strApartment =
                                              _textFiledAddressaprtment.text;
                                          print("=======" +
                                              _checkOutCalculation.salesTax);
                                          BlocProvider.of<HomeBloc>(context)
                                              .add(HomeEventSubmitOrderBtnClick(
                                                  payMethod: strPaymentType,
                                                  address: strApartment,
                                                  city: strCity,
                                                  state: strState,
                                                  mobile: strMobile,
                                                  zip: strZipCode,
                                                  comment: sharedPrefs
                                                      .getUserComment,
                                                  saletax: _checkOutCalculation
                                                      .salesTax,
                                                  citytax: "0",
                                                  excisetax: "0",
                                                  sub_total: strSubtotal,
                                                  final_amount: strFinaltotal,
                                                  cc_number: "",
                                                  creditcardtype: "",
                                                  cc_cvv: "",
                                                  cc_expiration: "",
                                                  cc_expire_month: "",
                                                  cc_expire_year: "",
                                                  cc_name: "",
                                                  coupon_id: couponCodeId,
                                                  promo_amount: couponAmount,
                                                  vendorId: _vendorId,
                                                  deviceType: _deviceType,
                                                  osName: _osName));
                                        } else {
                                          if (formKey.currentState!
                                              .validate()) {
                                            print("PaymentSuccess");

                                            strApartment =
                                                _textFiledAddressaprtment.text;
                                            strCity = _textFiledCity.text;
                                            strZipCode = _textFiledZip.text;
                                            strMobile = _textFiledMobile.text;
                                            strApartment =
                                                _textFiledAddressaprtment.text;

                                            BlocProvider.of<HomeBloc>(context)
                                                .add(
                                                    HomeEventSubmitOrderBtnClick(
                                                        payMethod:
                                                            strPaymentType,
                                                        address: strApartment,
                                                        city: strCity,
                                                        state: strState,
                                                        mobile: strMobile,
                                                        zip: strZipCode,
                                                        comment: "",
                                                        saletax: strSalestax,
                                                        citytax: strCitytax,
                                                        excisetax: strExcisetax,
                                                        sub_total: strSubtotal,
                                                        final_amount:
                                                            strFinaltotal,
                                                        cc_number: cardNumber,
                                                        creditcardtype:
                                                            cardType,
                                                        cc_cvv: cvvCode,
                                                        cc_expiration:
                                                            expiryDate,
                                                        cc_expire_month:
                                                            expiryMonth,
                                                        cc_expire_year:
                                                            expiryYear,
                                                        cc_name: cardHolderName,
                                                        coupon_id: couponCodeId,
                                                        promo_amount:
                                                            couponAmount,
                                                        vendorId: _vendorId,
                                                        deviceType: _deviceType,
                                                        osName: _osName));
                                          } else {
                                            showSnackBar(
                                                "Please enter valid card info ",
                                                context);
                                          }
                                        }
                                      }
                                    },
                                    btnText: "Order Now",
                                    btnHeight: _kHeightBtnCheckout.scale(),
                                    btnWidth: kWidthBtnNormal.scale(),
                                    btnFontSize: kFontSizeBtnLarge.scale(),
                                    btnElevation: 0,
                                  ),
                                  AVerticalSpace(15.0.scale())
                                ],
                              )
                                  .leftPadding(8.0.scale())
                                  .rightPadding(8.0.scale())
                                  .topPadding(10.0.scale())
                                  .bottomPadding(10.0.scale()),
                            ],
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ).expand()
            ],
          ).widgetBgColor(Colors.white)),
    ).lightStatusBarText().pageBgColor(kColorAppBgColor);
  }
}

class _OrderDetailWidget extends StatelessWidget {
  SlidingUpPanelController panelController;
  String strScreen;
  ProductListMenu productListModel;
  DriverList driverDetail;
  DataResponse checkOutCalculation;
  List<Couponlist> couponArrayList;
  Function showHideProgress;
  bool isCouponApplied;
  TextEditingController _textFiledCoupon = TextEditingController();
  String vendorId;

  _OrderDetailWidget(
      this.panelController,
      this.strScreen,
      this.productListModel,
      this.driverDetail,
      this.checkOutCalculation,
      this.couponArrayList,
      this.showHideProgress,
      this.isCouponApplied,
      this.vendorId);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    strSubtotal = checkOutCalculation.subtotal;
    strFinaltotal = checkOutCalculation.grandtotal;
    strCitytax = checkOutCalculation.cityTax;
    strSalestax = checkOutCalculation.salesTax;
    strExcisetax = checkOutCalculation.exciseTax;
    strDeliveryfee = checkOutCalculation.deliveryFee;
    strCouponAmount = checkOutCalculation.couponAmount;
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2.0),
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
          boxShadow: <BoxShadow>[
            new BoxShadow(
              color: Colors.grey,
              blurRadius: 3.0,
              offset: new Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              "Order Detail",
              style: textStyleBoldCustomColor(
                  _kFontSizeHeadingText, KColorCommonText),
            ).align(Alignment.centerLeft),
            AVerticalSpace(6.0.scale()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sub Total",
                  style: textStyleBoldCustomColor(
                      _kFontSizeMedium, KColorCommonText),
                ),
                Text(
                  '\$' + strSubtotal,
                  style: textStyleBoldCustomColor(
                      _kFontSizeMedium, KColorCommonText),
                )
              ],
            ),
            AVerticalSpace(6.0.scale()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sales Tax",
                  style: textStyleBoldCustomColor(
                      _kFontSizeMedium, KColorCommonText),
                ),
                Text(
                  '\$ ' + strSalestax,
                  style: textStyleBoldCustomColor(
                      _kFontSizeMedium, KColorCommonText),
                )
              ],
            ),
            // AVerticalSpace(6.0.scale()),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       "Excise Tax",
            //       style: textStyleBoldCustomColor(
            //           _kFontSizeMedium, KColorCommonText),
            //     ),
            //     Text(
            //       '\$ ' + strExcisetax,
            //       style: textStyleBoldCustomColor(
            //           _kFontSizeMedium, KColorCommonText),
            //     )
            //   ],
            // ),
            // AVerticalSpace(6.0.scale()),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       "City Tax",
            //       style: textStyleBoldCustomColor(
            //           _kFontSizeMedium, KColorCommonText),
            //     ),
            //     Text(
            //       '\$ ' + strCitytax,
            //       style: textStyleBoldCustomColor(
            //           _kFontSizeMedium, KColorCommonText),
            //     )
            //   ],
            // ),
            // AVerticalSpace(6.0.scale()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Delivery fees",
                  style: textStyleBoldCustomColor(
                      _kFontSizeMedium, KColorCommonText),
                ),
                Text(
                  '\$ ' + strDeliveryfee,
                  style: textStyleBoldCustomColor(
                      _kFontSizeMedium, KColorCommonText),
                )
              ],
            ),
            AVerticalSpace(6.0.scale()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0.scale()),
                        border: Border.all(
                            color: KColorAppThemeColor, width: 4.0.scale()),
                        color: KColorAppThemeColor,
                      ),
                      child: TextField(
                        controller: _textFiledCoupon,
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        cursorColor: KColorTextFieldCommonHint,
                        decoration: InputDecoration(
                          hintText: "Enter coupon",
                          hintStyle: textStyleCustomColor(
                              _kFontSizeEditFieldHint.scale(), KColorTextGrey),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ).align(Alignment.center),
                    ).size(150.0.scale(), 50.0.scale()),
                    AVerticalSpace(4.0.scale()),
                    InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(5.0.scale()),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8.0.scale()),
                          shape: BoxShape.rectangle,
                        ),
                        child: InkWell(
                            onTap: () {
                              if (_textFiledCoupon.text.isNotEmpty) {
                                showHideProgress(true);
                                if (isCouponApplied) {
                                  _textFiledCoupon.text = "";
                                  BlocProvider.of<HomeBloc>(context).add(
                                      HomeEventCouponListbtnClick(
                                          vendorId,
                                          strScreen,
                                          driverDetail,
                                          productListModel,
                                          ""));
                                } else {
                                  BlocProvider.of<HomeBloc>(context).add(
                                      HomeEventCouponListbtnApply(
                                          vendorId,
                                          strScreen,
                                          driverDetail,
                                          productListModel,
                                          _textFiledCoupon.text,
                                          "",
                                          ""));
                                  _textFiledCoupon.text = "";
                                }
                              } else {
                                if (isCouponApplied) {
                                  showHideProgress(true);
                                  _textFiledCoupon.text = "";
                                  BlocProvider.of<HomeBloc>(context).add(
                                      HomeEventCouponListbtnClick(
                                          vendorId,
                                          strScreen,
                                          driverDetail,
                                          productListModel,
                                          ""));
                                } else {
                                  showSnackBar(
                                      "Please enter coupon code!", context);
                                }
                              }
                            },
                            child: Text(
                              isCouponApplied == true
                                  ? "Remove Coupon"
                                  : "Apply Coupon",
                              style: textStyleCustomColor(
                                  _kFontSizeMedium.scale(), KColorTextGrey),
                              textAlign: TextAlign.center,
                            ).align(Alignment.center)),
                      ).align(Alignment.center).size(
                            140.0.scale(),
                            35.0.scale(),
                          ),
                    ),
                  ],
                ),
                Text(
                  '\$ ' + strCouponAmount,
                  style: textStyleBoldCustomColor(
                      _kFontSizeMedium, KColorCommonText),
                )
              ],
            ),
            AVerticalSpace(10.0.scale()),
            ASeparatorLine(height: .7.scale(), color: KColorTextGrey),
            AVerticalSpace(6.0.scale()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Grand total",
                  style: textStyleBoldCustomLargeColor(
                      _kFontSizeHeadingText, KColorCommonText),
                ),
                Text(
                  '\$ ' + strFinaltotal,
                  style: textStyleBoldCustomLargeColor(
                      _kFontSizeHeadingText, KColorCommonText),
                )
              ],
            ),
            AVerticalSpace(13.0.scale()),
          ],
        )
            .leftPadding(10.0.scale())
            .rightPadding(10.0.scale())
            .topPadding(6.0.scale())
            .bottomPadding(6.0.scale()));
  }
}

const double _kButtonNextWidth = 102;
const double _kHeightBtnAddToCart = 35.0;
String couponCodeId = "";
String couponAmount = "";

class CouponCodeRowItemListModelNew extends StatefulWidget {
  Couponlist couponArrayList;
  Function showHideProgress;
  DriverList driverDetail;
  String strScreen;
  ProductListMenu productListModel;

  CouponCodeRowItemListModelNew(this.couponArrayList, this.showHideProgress,
      this.driverDetail, this.strScreen, this.productListModel);

  @override
  _CouponCodeRowItemListModelNewState createState() =>
      _CouponCodeRowItemListModelNewState();
}

class _CouponCodeRowItemListModelNewState
    extends State<CouponCodeRowItemListModelNew> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        height: 90.0.scale(),
        padding: EdgeInsets.only(
          top: 10.0.scale(),
          bottom: 10.0.scale(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.couponArrayList.name.toUpperCase(),
                  style: textStyleCustomColor(14.0.scale(), KColorCommonText),
                ),
                Text(
                  "discount amount \$" + widget.couponArrayList.amount,
                  style: textStyleCustomColor(14.0.scale(), KColorCommonText),
                ),
                Text(
                  "Expire on " + widget.couponArrayList.validTill,
                  style: textStyleCustomColor(14.0.scale(), KColorTextGrey),
                ),
              ],
            ),
            ARoundedButton(
              btnDisabledColor: Color(0xFF5e6163),
              btnIconSize: 15,
              btnDisabledTextColor: Color(0xFFFFFFFF),
              btnFontWeight: FontWeight.normal,
              btnBgColor: kColorCommonButtonBackGround,
              btnTextColor: kColorCommonButton,
              btnOnPressed: () {
                Navigator.of(context).pop();
                widget.showHideProgress(true);
                BlocProvider.of<HomeBloc>(context).add(
                    HomeEventCouponListbtnApply(
                        widget.driverDetail.vendorId!,
                        widget.strScreen,
                        widget.driverDetail,
                        widget.productListModel,
                        widget.couponArrayList.coupon,
                        widget.couponArrayList.amount,
                        widget.couponArrayList.id));
              },
              btnText: "Apply",
              btnHeight: _kHeightBtnAddToCart.scale(),
              btnWidth: _kButtonNextWidth.scale(),
              btnFontSize: kFontSizeBtnLarge.scale(),
              btnElevation: 0,
              btnBorderSideColor: kColorCommonButton,
            ),
          ],
        ).leftPadding(15.0.scale()).rightPadding(15.0.scale()));
  }
}
