import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:grambunny_customer/components/a_widget_extensions.dart';
import 'package:grambunny_customer/utils/ui_utils.dart';

import '../../components/a_header_back_button.dart';
import '../../components/a_horizontal_space.dart';
import '../../components/a_rounded_button.dart';
import '../../components/a_separator_line.dart';
import '../../components/a_vertical_space.dart';
import '../../dialogs/dlg_two_button_withImage.dart';
import '../../hm_root/bloc/hm_root_bloc.dart';
import '../../hm_root/bloc/hm_root_event.dart';
import '../../services/herbarium_cust_shared_preferences.dart';
import '../../side_navigation/bloc/side_navigat_bloc.dart';
import '../../side_navigation/bloc/side_navigat_event.dart';
import '../../theme/ft_theme_colors.dart';
import '../../theme/ft_theme_size_const.dart';
import '../../theme/ft_theme_styles.dart';
import '../../utils/image_paths.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../model/checkout_calculation_reponse_model.dart';
import '../model/driver_list_model.dart';
import '../model/home_coupon_code_model.dart';
import '../model/product_list_model.dart';
import '../model/ps_list_model.dart';
import '../model/statelist_reponse_model.dart';

const double _kFontSizeHeadingText = 17.0;
const double _kFontSizeMedium = 14.0;
const double _kFontSizeEditFieldHint = 13.0;
const double _kHeightTextFieldState = 55.0;
const double _kHeightBtnCheckout = 45.0;

const double _kTextBirthdateField = 327.0;
String _couponCodeId = "";
String _couponAmount = "";
String _strSubtotal = "";
String _strFinaltotal = "";
String _strCitytax = "";
String _strSalestax = "";
String _strExcisetax = "";
String _strDeliveryfee = "";
String _strTicketFee = "";
String _strTicketServiceFee = "";
String _strCouponAmount = "";

class HomeRideCheckOutPage extends StatefulWidget {
  const HomeRideCheckOutPage({Key? key}) : super(key: key);

  @override
  _HomeRideCheckOutPageState createState() => _HomeRideCheckOutPageState();
}

class _HomeRideCheckOutPageState extends State<HomeRideCheckOutPage> {
  TextEditingController? _textFiledFirstName;
  TextEditingController? _textFiledLastName;
  TextEditingController? _textFiledPhone;
  TextEditingController? _textFiledEmail;
  TextEditingController? _textFiledAddress;
  TextEditingController? _textFiledCity;
  TextEditingController? _textFiledZipCode;
  TextEditingController? _textFiledCountry;

  List<StatesList>? _stateArrayList;
  String strState = '';
  String? _strScreen;
  String distance = "";
  ProductListMenu? _productListModel;
  String? _vendorId;
  DriverList? _driverDetail;
  TextEditingController _textFiledCoupon = TextEditingController();

  String? strScreen;
  DriverList? driverDetail;
  ProductListMenu? productListModel;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _isCodSelect = false;
  bool _isCouponApplied = false;
  bool _isCreditSelect = false;
  String? strPaymentType = '';
  bool? showPerformance = false;
  String? _osName;
  String? _deviceType;
  List<Couponlist>? couponArrayList;
  DataResponse? _checkOutCalculation;
  List<EventDetailsList> eventdetaillist = [];
  String strApartment = '';
  String strCity = '';
  String strZipCode = '';
  String strMobile = '';
  String serverStrFirstName = "";
  String serverStrLastName = "";
  String strdeliveryFee = "";
  String strticketFee = "";
  String strticketServiceFee = "";
  String stremail = "";
  String strcountry = "";
  double distance1 = 0;
  int? distance2 = 0;
  bool oneTimeCall = true;

  onSettingCallback() {
    setState(() {
      showPerformance = !showPerformance!;
    });
  }

  ScrollController? scrollController;
  SlidingUpPanelController panelController = SlidingUpPanelController();

  @override
  void initState() {
    getDeviceVersion();
    scrollController = ScrollController();
    scrollController!.addListener(() {
      if (scrollController!.offset >=
              scrollController!.position.maxScrollExtent &&
          !scrollController!.position.outOfRange) {
        panelController.expand();
      } else if (scrollController!.offset <=
              scrollController!.position.minScrollExtent &&
          !scrollController!.position.outOfRange) {
        panelController.anchor();
      } else {}
    });

    HomeState state = BlocProvider.of<HomeBloc>(context).state;
    if (state is HomeCheckOutPageState) {
      _strScreen = state.strScreen;
      _productListModel = state.productListModel;
      _vendorId = state.vendorId;
      print("id---->${_vendorId}");
      _driverDetail = state.driverDetail;
      _stateArrayList = state.stateArrayList;
    } else if (state is HomeRideCheckOutPageState) {
      eventdetaillist = state.eventdetaillist!;
      print("oredrid====${eventdetaillist[0].vendorId}");
      print("distance=====>${distance}");
      distance = state.distance;
      _strScreen = state.strScreen;
      _productListModel = state.productListModel;
      _vendorId = state.vendorId;
      print("vendorid====>${_vendorId}");
      _driverDetail = state.driverDetail;
      _stateArrayList = state.stateArrayList;
      print("STATE LIST ===>${_stateArrayList}");
      print("rateMile====>${eventdetaillist[0].rateMile}");
      print("price====>${eventdetaillist[0].price}");
      print("distance====>${distance}");
    }

    _textFiledFirstName = TextEditingController();
    _textFiledLastName = TextEditingController();
    _textFiledEmail = TextEditingController();
    _textFiledPhone = TextEditingController();
    _textFiledAddress = TextEditingController();
    _textFiledCity = TextEditingController();
    _textFiledZipCode = TextEditingController();
    _textFiledCountry = TextEditingController();

    setState(() {
      distance1 =
          double.parse(eventdetaillist[0].rateMile!) * double.parse(distance);
      distance2 = distance1.round();
      print("distance1===== ${distance1}");
      print("distance2===== ${distance2}");
    });

    if (oneTimeCall) {
      oneTimeCall = false;
      showHideProgress(true);
      BlocProvider.of<HomeBloc>(context).add(HomeEventCouponListbtnClick(
        _vendorId!,
        _strScreen!,
        _driverDetail!,
        _productListModel!,
        "",
      ));
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
    print("deviceType:" + _deviceType! + "  osName:" + _osName!);
  }

  void showHideProgress(bool show) {
    BlocProvider.of<SideNavigatBloc>(context)
        .add(SideNavigationEventToggleLoadingAnimation(needToShow: show));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
            listenWhen: (prevState, curState) =>
                ModalRoute.of(context)!.isCurrent,
            listener: (context, state) {
              if (state is HomeCheckOutPageState) {
                setState(() {
                  _strScreen = state.strScreen;
                  _productListModel = state.productListModel;
                  _driverDetail = state.driverDetail;
                  _stateArrayList = state.stateArrayList;
                });
              } else if (state is HomeInitial) {
                Navigator.of(context).pop();
              } else if (state is HomeCheckOutCalculateState) {
                showHideProgress(false);

                setState(() {
                  _checkOutCalculation = state.checkOutCalculation;
                  _strSubtotal = _checkOutCalculation!.subtotal;
                  print("Subtotal=====${_strSubtotal}");
                  _strFinaltotal = _checkOutCalculation!.grandtotal;
                  print("total=====${_strFinaltotal}");
                  _strCitytax = _checkOutCalculation!.cityTax.toString();
                  _strSalestax = _checkOutCalculation!.salesTax;
                  print("Salestax=====${_strSalestax}");
                  _strExcisetax = _checkOutCalculation!.exciseTax.toString();
                  _strDeliveryfee =
                      _checkOutCalculation!.delivery_fee.toString();
                  print("fee=====${_strDeliveryfee}");
                  _strTicketFee = _checkOutCalculation!.ticket_fee ?? "";
                  print("TicketFee=====${_strTicketFee}");
                  _strTicketServiceFee =
                      _checkOutCalculation!.ticket_service_fee ?? "";
                  print("TicketServiceFee=====${_strTicketServiceFee}");
                  _strCouponAmount = _checkOutCalculation!.couponAmount;
                  _couponCodeId = "";
                  _couponAmount = "";
                  couponArrayList = state.couponArrayList;
                  _isCouponApplied = false;
                  print("_strCouponAmount=====${_strCouponAmount}");
                });

                print("Before page Reset");
                BlocProvider.of<HomeBloc>(context).add(
                    HomeEventResetCheckOutState(_strScreen!, _driverDetail!,
                        _productListModel!, _vendorId!));
              } else if (state is HomeCheckOutCouponApplyState) {
                showHideProgress(false);

                setState(() {
                  _checkOutCalculation = state.checkOutCalculation;
                  _strSubtotal = _checkOutCalculation!.subtotal;
                  _strFinaltotal = _checkOutCalculation!.grandtotal;
                  _strCitytax = _checkOutCalculation!.cityTax;
                  _strSalestax = _checkOutCalculation!.salesTax;
                  _strExcisetax = _checkOutCalculation!.exciseTax;
                  _strDeliveryfee = _checkOutCalculation!.delivery_fee;
                  _strTicketFee = _checkOutCalculation!.ticket_fee ?? "";
                  _strTicketServiceFee =
                      _checkOutCalculation!.ticket_service_fee ?? "";
                  _strCouponAmount = _checkOutCalculation!.couponAmount;
                  _couponCodeId = state.couponId;
                  _couponAmount = state.couponAmount;
                  print("coupon amount" + _couponAmount);
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
                BlocProvider.of<HomeBloc>(context).add(
                    HomeEventResetCheckOutState(_strScreen!, _driverDetail!,
                        _productListModel!, _vendorId!));
              } else if (state is HomeCheckOutOrderCompleteState) {
                showHideProgress(false);
                thankYouDialog(
                    context: context,
                    btnHome: () {
                      BlocProvider.of<HmRootBloc>(context)
                          .add(HmRootEventHomePageBack());
                    },
                    btnOrderHistory: () {
                      BlocProvider.of<SideNavigatBloc>(context).add(
                          SideNavigationEventGoToRideOrderHistoryList(true));
                    },
                    titleText: '',
                    descText: "",
                    btnTitleText: "");
              } else if (state is HomeCheckOutOrderErrorState) {
                showHideProgress(false);
                showSnackBar(state.message, context);
                BlocProvider.of<HomeBloc>(context).add(
                    HomeEventResetCheckOutState(_strScreen!, _driverDetail!,
                        _productListModel!, _vendorId!));
              }
            },
            child: SafeArea(
                bottom: false,
                child: Column(children: [
                  AHeaderWidget(
                    strBackbuttonName: 'ic_red_btn_back.png',
                    backBtnVisibility: true,
                    btnBackOnPressed: () {
                      Navigator.pop(context);
                    },
                    strBtnRightImageName: 'ic_search_logo.png',
                    rightEditButtonVisibility: false,
                    btnEditOnPressed: () {},
                  ),
                  Column(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Pick Up Address",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ).align(Alignment.centerLeft),
                          AVerticalSpace(10.0.scale()),
                          Text(
                            sharedPrefs.searchLocation,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ).align(Alignment.centerLeft),
                          AVerticalSpace(10.0.scale()),
                          Text(
                            "Drop Off Address",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ).align(Alignment.centerLeft),
                          AVerticalSpace(10.0.scale()),
                          Text(
                            sharedPrefs.searchDropLocation,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ).align(Alignment.centerLeft),
                          AVerticalSpace(15.0.scale()),
                          Text(
                            "Customer Information",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ).align(Alignment.centerLeft),
                          const Divider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
                          AVerticalSpace(10.0.scale()),
                          Text(
                            "First Name",
                            style: textStyleBoldCustomColor(
                                _kFontSizeEditFieldHint, KColorTextGrey),
                          ).align(Alignment.centerLeft),
                          AVerticalSpace(5.0.scale()),
                          TextField(
                            controller: _textFiledFirstName,
                            autofocus: false,
                            cursorColor: KColorTextFieldCommonHint,
                            decoration: InputDecoration(
                              hintText: "",
                              hintStyle: textStyleCustomColor(
                                  _kFontSizeEditFieldHint.scale(),
                                  KColorTextGrey),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          AVerticalSpace(10.0.scale()),
                          Text(
                            "Last Name",
                            style: textStyleBoldCustomColor(
                                _kFontSizeEditFieldHint, KColorTextGrey),
                          ).align(Alignment.centerLeft),
                          AVerticalSpace(5.0.scale()),
                          TextField(
                            controller: _textFiledLastName,
                            autofocus: false,
                            cursorColor: KColorTextFieldCommonHint,
                            decoration: InputDecoration(
                              hintText: "",
                              hintStyle: textStyleCustomColor(
                                  _kFontSizeEditFieldHint.scale(),
                                  KColorTextGrey),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          AVerticalSpace(10.0.scale()),
                          Text(
                            "Email",
                            style: textStyleBoldCustomColor(
                                _kFontSizeEditFieldHint, KColorTextGrey),
                          ).align(Alignment.centerLeft),
                          AVerticalSpace(5.0.scale()),
                          TextField(
                            controller: _textFiledEmail,
                            autofocus: false,
                            cursorColor: KColorTextFieldCommonHint,
                            decoration: InputDecoration(
                              hintText: "",
                              hintStyle: textStyleCustomColor(
                                  _kFontSizeEditFieldHint.scale(),
                                  KColorTextGrey),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          AVerticalSpace(10.0.scale()),
                          Text(
                            "Mobile Number",
                            style: textStyleBoldCustomColor(
                                _kFontSizeEditFieldHint, KColorTextGrey),
                          ).align(Alignment.centerLeft),
                          AVerticalSpace(5.0.scale()),
                          TextField(
                            controller: _textFiledPhone,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(12)
                            ],
                            autofocus: false,
                            cursorColor: KColorTextFieldCommonHint,
                            decoration: InputDecoration(
                              hintStyle: textStyleCustomColor(
                                  _kFontSizeEditFieldHint.scale(),
                                  KColorTextFieldCommonHint),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          AVerticalSpace(10.0.scale()),
                          Text(
                            "Address",
                            style: textStyleBoldCustomColor(
                                _kFontSizeEditFieldHint, KColorTextGrey),
                          ).align(Alignment.centerLeft),
                          AVerticalSpace(5.0.scale()),
                          TextField(
                            controller: _textFiledAddress,
                            autofocus: false,
                            cursorColor: KColorTextFieldCommonHint,
                            decoration: InputDecoration(
                              hintText: "",
                              hintStyle: textStyleCustomColor(
                                  _kFontSizeEditFieldHint.scale(),
                                  KColorTextGrey),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          AVerticalSpace(10.0.scale()),
                          Text(
                            "City",
                            style: textStyleBoldCustomColor(
                                _kFontSizeEditFieldHint, KColorTextGrey),
                          ).align(Alignment.centerLeft),
                          AVerticalSpace(5.0.scale()),
                          TextField(
                            controller: _textFiledCity,
                            autofocus: false,
                            cursorColor: KColorTextFieldCommonHint,
                            decoration: InputDecoration(
                              hintText: "",
                              hintStyle: textStyleCustomColor(
                                  _kFontSizeEditFieldHint.scale(),
                                  KColorTextGrey),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          AVerticalSpace(10.0.scale()),
                          Text(
                            "State",
                            style: textStyleBoldCustomColor(
                                _kFontSizeEditFieldHint, KColorTextGrey),
                          ).align(Alignment.centerLeft),
                          AVerticalSpace(5.0.scale()),
                          InkWell(
                              splashColor: Colors.transparent,
                              onTap: () {
                                if (_stateArrayList!.length > 0) {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext bc) {
                                        return GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                ListView.builder(
                                                  physics:
                                                      ClampingScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      _stateArrayList!.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            strState =
                                                                _stateArrayList![
                                                                        index]
                                                                    .name;
                                                          });

                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Column(
                                                          children: [
                                                            AVerticalSpace(
                                                                15.0.scale()),
                                                            Text(
                                                                _stateArrayList![
                                                                        index]
                                                                    .name,
                                                                style: textStyleCustomColor(
                                                                    14.0.scale(),
                                                                    KColorCommonText)),
                                                            AVerticalSpace(
                                                                15.0.scale()),
                                                            ASeparatorLine(
                                                                height:
                                                                    .5.scale(),
                                                                color:
                                                                    KColorCommonText)
                                                          ],
                                                        ).align(
                                                            Alignment.center));
                                                  },
                                                ).expand()
                                              ],
                                            ));
                                      });
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black),
                                  borderRadius:
                                      BorderRadius.circular(8.0.scale()),
                                  shape: BoxShape.rectangle,
                                ),
                                child: Text(
                                  strState,
                                  style: textStyleCustomColor(
                                      _kFontSizeEditFieldHint.scale(),
                                      KColorTextGrey),
                                  textAlign: TextAlign.center,
                                ).align(Alignment.centerLeft),
                              ).size(_kTextBirthdateField.scale(),
                                  _kHeightTextFieldState.scale())),
                          AVerticalSpace(10.0.scale()),
                          Text(
                            "Zip Code",
                            style: textStyleBoldCustomColor(
                                _kFontSizeEditFieldHint, KColorTextGrey),
                          ).align(Alignment.centerLeft),
                          AVerticalSpace(5.0.scale()),
                          TextField(
                            controller: _textFiledZipCode,
                            autofocus: false,
                            cursorColor: KColorTextFieldCommonHint,
                            decoration: InputDecoration(
                              hintText: "",
                              hintStyle: textStyleCustomColor(
                                  _kFontSizeEditFieldHint.scale(),
                                  KColorTextGrey),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          AVerticalSpace(10.0.scale()),
                          Text(
                            "Country",
                            style: textStyleBoldCustomColor(
                                _kFontSizeEditFieldHint, KColorTextGrey),
                          ).align(Alignment.centerLeft),
                          AVerticalSpace(5.0.scale()),
                          TextField(
                            controller: _textFiledCountry,
                            autofocus: false,
                            cursorColor: KColorTextFieldCommonHint,
                            decoration: InputDecoration(
                              hintText: "",
                              hintStyle: textStyleCustomColor(
                                  _kFontSizeEditFieldHint.scale(),
                                  KColorTextGrey),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          AVerticalSpace(20.0.scale()),
                          //   if (_checkOutCalculation != null)
                          Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2.0),
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Test Ride",
                                          style: textStyleBoldCustomColor(
                                              _kFontSizeHeadingText,
                                              KColorCommonText),
                                        ),
                                        Text(
                                          "Total",
                                          style: textStyleBoldCustomColor(
                                              _kFontSizeHeadingText,
                                              KColorCommonText),
                                        )
                                      ],
                                    ),
                                    AVerticalSpace(6.0.scale()),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Base Fee",
                                          style: textStyleBoldCustomColor(
                                              _kFontSizeMedium,
                                              KColorCommonText),
                                        ),
                                        Text(
                                          " \$${eventdetaillist[0].price}",
                                          style: textStyleBoldCustomColor(
                                              _kFontSizeMedium,
                                              KColorCommonText),
                                        )
                                      ],
                                    ),
                                    AVerticalSpace(6.0.scale()),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Rate Per Mile",
                                          style: textStyleBoldCustomColor(
                                              _kFontSizeMedium,
                                              KColorCommonText),
                                        ),
                                        Text(
                                          "\$${eventdetaillist[0].rateMile}",
                                          style: textStyleBoldCustomColor(
                                              _kFontSizeMedium,
                                              KColorCommonText),
                                        )
                                      ],
                                    ),
                                    AVerticalSpace(6.0.scale()),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Distance:",
                                              style: textStyleBoldCustomColor(
                                                  _kFontSizeMedium,
                                                  KColorCommonText),
                                            ),
                                            Text(
                                              " \$${distance} (Miles)",
                                              style: textStyleBoldCustomColor(
                                                  _kFontSizeMedium,
                                                  KColorCommonText),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "\$${distance1}",
                                          style: textStyleBoldCustomColor(
                                              _kFontSizeMedium,
                                              KColorCommonText),
                                        ),
                                      ],
                                    ),
                                    AVerticalSpace(10.0.scale()),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0.scale()),
                                                border: Border.all(
                                                    color: KColorAppThemeColor,
                                                    width: 4.0.scale()),
                                                color: KColorAppThemeColor,
                                              ),
                                              child: TextField(
                                                controller: _textFiledCoupon,
                                                keyboardType:
                                                    TextInputType.text,
                                                autofocus: false,
                                                cursorColor:
                                                    KColorTextFieldCommonHint,
                                                decoration: InputDecoration(
                                                  hintText: "Enter coupon",
                                                  hintStyle:
                                                      textStyleCustomColor(
                                                          _kFontSizeEditFieldHint
                                                              .scale(),
                                                          KColorTextGrey),
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                ),
                                              ).align(Alignment.center),
                                            ).size(150.0.scale(), 50.0.scale()),
                                            AVerticalSpace(4.0.scale()),
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              onTap: () {},
                                              child: Container(
                                                padding:
                                                    EdgeInsets.all(5.0.scale()),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: Colors.black),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0.scale()),
                                                  shape: BoxShape.rectangle,
                                                ),
                                                child: InkWell(
                                                    onTap: () {
                                                      if (_textFiledCoupon
                                                          .text.isNotEmpty) {
                                                        showHideProgress(true);
                                                        if (_isCouponApplied) {
                                                          _textFiledCoupon
                                                              .text = "";
                                                          BlocProvider.of<
                                                                      HomeBloc>(
                                                                  context)
                                                              .add(
                                                                  HomeEventCouponListbtnClick(
                                                            _vendorId!,
                                                            strScreen!,
                                                            driverDetail!,
                                                            productListModel!,
                                                            "",
                                                          ));
                                                        } else {
                                                          BlocProvider.of<
                                                                      HomeBloc>(
                                                                  context)
                                                              .add(
                                                                  HomeEventCouponListbtnApply(
                                                            _vendorId!,
                                                            strScreen!,
                                                            driverDetail!,
                                                            productListModel!,
                                                            _textFiledCoupon
                                                                .text,
                                                            "",
                                                            "",
                                                          ));
                                                          _textFiledCoupon
                                                              .text = "";
                                                        }
                                                      } else {
                                                        if (_isCouponApplied) {
                                                          showHideProgress(
                                                              true);
                                                          _textFiledCoupon
                                                              .text = "";
                                                          BlocProvider.of<
                                                                      HomeBloc>(
                                                                  context)
                                                              .add(
                                                                  HomeEventCouponListbtnClick(
                                                            _vendorId!,
                                                            strScreen!,
                                                            driverDetail!,
                                                            productListModel!,
                                                            "",
                                                          ));
                                                        } else {
                                                          showSnackBar(
                                                              "Please enter coupon code!",
                                                              context);
                                                        }
                                                      }
                                                    },
                                                    child: Text(
                                                      _isCouponApplied == true
                                                          ? "Remove Coupon"
                                                          : "Apply Coupon",
                                                      style:
                                                          textStyleCustomColor(
                                                              _kFontSizeMedium
                                                                  .scale(),
                                                              KColorTextGrey),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ).align(Alignment.center)),
                                              ).align(Alignment.center).size(
                                                    140.0.scale(),
                                                    35.0.scale(),
                                                  ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '\$ ' + _strCouponAmount,
                                          style: textStyleBoldCustomColor(
                                              _kFontSizeMedium,
                                              KColorCommonText),
                                        )
                                      ],
                                    ),
                                    AVerticalSpace(10.0.scale()),
                                    AVerticalSpace(10.0.scale()),
                                    ASeparatorLine(
                                        height: .7.scale(),
                                        color: KColorTextGrey),
                                    AVerticalSpace(6.0.scale()),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Sub Total",
                                          style: textStyleBoldCustomLargeColor(
                                              _kFontSizeHeadingText,
                                              KColorCommonText),
                                        ),
                                        Text(
                                          '\$' + _strSubtotal,
                                          style: textStyleBoldCustomLargeColor(
                                              _kFontSizeHeadingText,
                                              KColorCommonText),
                                        )
                                      ],
                                    ),
                                    AVerticalSpace(6.0.scale()),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Sales Tax",
                                          style: textStyleBoldCustomLargeColor(
                                              _kFontSizeHeadingText,
                                              KColorCommonText),
                                        ),
                                        Text(
                                          '\$ ' + _strSalestax,
                                          style: textStyleBoldCustomLargeColor(
                                              _kFontSizeHeadingText,
                                              KColorCommonText),
                                        )
                                      ],
                                    ),
                                    AVerticalSpace(10.0.scale()),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Total",
                                          style: textStyleBoldCustomLargeColor(
                                              _kFontSizeHeadingText,
                                              KColorCommonText),
                                        ),
                                        Text(
                                          '\$ ' + _strFinaltotal,
                                          style: textStyleBoldCustomLargeColor(
                                              _kFontSizeHeadingText,
                                              KColorCommonText),
                                        )
                                      ],
                                    ),
                                    AVerticalSpace(15.0.scale()),
                                  ]).leftPadding(10.0.scale()).rightPadding(
                                  10.0.scale())),
                          AVerticalSpace(15.0.scale()),
                          Text(
                            "Payment Method",
                            style: textStyleBoldCustomColor(
                                _kFontSizeHeadingText, KColorCommonText),
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
                                    width: 20.0.scale(),
                                    height: 20.0.scale(),
                                    image: _isCodSelect
                                        ? AssetImage(
                                            '${imgPathGeneral}ic_home_select_radio_btn.png')
                                        : AssetImage(
                                            '${imgPathGeneral}ic_home_unselect_radio_btn.png')),
                                AHorizontalSpace(5.0.scale()),
                                Text(
                                  "Cash / Debit / Credit On Delivery To Cash / Debit Card On Delivery",
                                  style: textStyleBoldCustomColor(
                                      _kFontSizeHeadingText, KColorCommonText),
                                ).expand()
                              ],
                            ),
                          ),
                          AVerticalSpace(20.0.scale()),
                          ARoundedButton(
                            btnBorderSideColor: kColorCommonButton,
                            btnDisabledColor: Color(0xFF5e6163),
                            btnIconSize: 15,
                            btnDisabledTextColor: Color(0xFFFFFFFF),
                            btnFontWeight: FontWeight.normal,
                            btnBgColor: kColorCommonButton,
                            btnTextColor: Colors.white,
                            btnOnPressed: () {
                              if (_textFiledFirstName?.text == null ||
                                  _textFiledFirstName!.text.isEmpty) {
                                showSnackBar(
                                    "Please fill first name field ", context);
                              } else if (_textFiledLastName?.text == null ||
                                  _textFiledLastName!.text.isEmpty) {
                                showSnackBar(
                                    "Please fill last name field ", context);
                              } else if (_textFiledCity?.text == null ||
                                  _textFiledCity!.text.isEmpty) {
                                showSnackBar(
                                    "Please fill city field ", context);
                              } else if (_textFiledAddress!.text.isEmpty) {
                                showSnackBar(
                                    "Please fill address field ", context);
                              }
                              // else if (strState == null || strState.isEmpty) {
                              //   showSnackBar(
                              //       "Please fill state field ", context);
                              // }
                              else if (_textFiledZipCode?.text == null ||
                                  _textFiledZipCode!.text.isEmpty) {
                                showSnackBar(
                                    "Please fill ZipCode field ", context);
                              } else if (_textFiledPhone?.text == null ||
                                  _textFiledPhone!.text.isEmpty) {
                                showSnackBar("Please fill Mobile Number field ",
                                    context);
                              } else if (_textFiledCountry?.text == null ||
                                  _textFiledCountry!.text.isEmpty) {
                                showSnackBar(
                                    "Please fill Country field ", context);
                              } else if (_textFiledPhone?.text == null ||
                                  _textFiledPhone!.text.isEmpty) {
                                showSnackBar("Please fill Mobile Number field ",
                                    context);
                              } else if (_textFiledPhone?.text.length == 9) {
                                showSnackBar("Please fill Mobile Number field ",
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
                                  serverStrFirstName =
                                      _textFiledFirstName!.text;
                                  serverStrLastName = _textFiledLastName!.text;
                                  strMobile = _textFiledPhone!.text;
                                  stremail = _textFiledEmail!.text;
                                  strApartment = _textFiledAddress!.text;
                                  strCity = _textFiledCity!.text;
                                  strZipCode = _textFiledZipCode!.text;
                                  strcountry = _textFiledCountry!.text;

                                  // print("=======" +
                                  //     _checkOutCalculation!.salesTax);
                                  print("fname====>${serverStrFirstName}");
                                  print("lname===>${serverStrLastName}");
                                  print("deliveryFee====>${_strDeliveryfee}");
                                  print(
                                      "ticketServiceFee==>${_strTicketServiceFee}");
                                  print("ticketFee===>${_strTicketFee}");
                                  print("Zipcode====>${strZipCode}");

                                  BlocProvider.of<HomeBloc>(context).add(
                                      HomeEventSubmitRideOrderBtnClick(
                                          payMethod: strPaymentType!,
                                          address: strApartment,
                                          city: strCity,
                                          state: strState,
                                          mobile: strMobile,
                                          zip: strZipCode,
                                          comment: sharedPrefs.getUserComment,
                                          saletax:
                                              _checkOutCalculation!.salesTax,
                                          citytax: "0",
                                          excisetax: "0",
                                          sub_total: _strSubtotal,
                                          final_amount: _strFinaltotal,
                                          cc_number: "",
                                          creditcardtype: "",
                                          cc_cvv: "",
                                          cc_expiration: "",
                                          cc_expire_month: "",
                                          cc_expire_year: "",
                                          cc_name: "",
                                          coupon_id: _couponCodeId,
                                          promo_amount: _couponAmount,
                                          vendorId: _vendorId!,
                                          deviceType: _deviceType!,
                                          osName: _osName!,
                                          delivery_fee: _strDeliveryfee,
                                          firstNameT: serverStrFirstName,
                                          lastNameT: serverStrLastName,
                                          ticket_fee: _strTicketFee,
                                          ticket_service_fee:
                                              _strTicketServiceFee,
                                          ps_type: "2",
                                          country: strcountry,
                                          total: _strFinaltotal
                                          // total :
                                          ));
                                } else {
                                  if (formKey.currentState!.validate()) {
                                    print("PaymentSuccess");
                                    serverStrFirstName =
                                        _textFiledFirstName!.text;
                                    serverStrLastName =
                                        _textFiledLastName!.text;
                                    strMobile = _textFiledPhone!.text;
                                    stremail = _textFiledEmail!.text;
                                    strApartment = _textFiledAddress!.text;
                                    strCity = _textFiledCity!.text;
                                    strZipCode = _textFiledZipCode!.text;
                                    strcountry = _textFiledCountry!.text;
                                    BlocProvider.of<HomeBloc>(context).add(
                                        HomeEventSubmitRideOrderBtnClick(
                                            payMethod: strPaymentType!,
                                            address: strApartment,
                                            city: strCity,
                                            state: strState,
                                            mobile: strMobile,
                                            zip: strZipCode,
                                            comment: sharedPrefs.getUserComment,
                                            saletax:
                                                _checkOutCalculation!.salesTax,
                                            citytax: "0",
                                            excisetax: "0",
                                            sub_total: _strSubtotal,
                                            final_amount: _strFinaltotal,
                                            cc_number: "",
                                            creditcardtype: "",
                                            cc_cvv: "",
                                            cc_expiration: "",
                                            cc_expire_month: "",
                                            cc_expire_year: "",
                                            cc_name: "",
                                            coupon_id: _couponCodeId,
                                            promo_amount: _couponAmount,
                                            vendorId: _vendorId!,
                                            deviceType: _deviceType!,
                                            osName: _osName!,
                                            delivery_fee: _strDeliveryfee,
                                            firstNameT: serverStrFirstName,
                                            lastNameT: serverStrLastName,
                                            ticket_fee: _strTicketFee,
                                            ticket_service_fee:
                                                _strTicketServiceFee,
                                            ps_type: "2",
                                            country: strcountry,
                                            total: _strFinaltotal));
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
                          AVerticalSpace(20.0.scale())
                        ],
                      )
                          .leftPadding(10.0.scale())
                          .rightPadding(10.0.scale())
                          .topPadding(10.0.scale())
                          .bottomPadding(10.0.scale()),
                    ],
                  )
                ]).widgetBgColor(Colors.white)))
        .scroll()
        .lightStatusBarText()
        .pageBgColor(kColorAppBgColor);
  }
}
