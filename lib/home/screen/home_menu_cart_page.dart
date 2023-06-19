import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grambunny_customer/components/components.dart';
import 'package:grambunny_customer/home/components/component.dart';
import 'package:grambunny_customer/home/home.dart';
import 'package:grambunny_customer/home/model/product_list_model.dart';
import 'package:grambunny_customer/services/herbarium_cust_shared_preferences.dart';
import 'package:grambunny_customer/side_navigation/side_navigation.dart';
import 'package:grambunny_customer/theme/theme.dart';
import 'package:grambunny_customer/utils/utils.dart';

const kHeightBtnCheckout = 50.0;

class HomeMenuCartPage extends StatefulWidget {
  @override
  _HomeMenuCartPageState createState() => _HomeMenuCartPageState();
}

class _HomeMenuCartPageState extends State<HomeMenuCartPage> {
  late List<ItemsCart> _productList;
  TextEditingController _textFiledUserComment = TextEditingController();
  late DriverList _driverDetail;
  late ProductListMenu productListModel;
  late String strScreen;
  late DataCart _cartDataModel;

  void showHideProgress(bool show) {
    BlocProvider.of<SideNavigatBloc>(context)
        .add(SideNavigationEventToggleLoadingAnimation(needToShow: show));
  }

  @override
  void initState() {
    // TODO: implement initState
    _productList = [];
    HomeState homeState = BlocProvider.of<HomeBloc>(context).state;
    if (homeState is HomeCartPageState) {
      strScreen = "HomeCartpage";
      _productList = homeState.cartDataListArray;

      _driverDetail = DriverList(
          vendorId: '${homeState.vendor.vendorId}',
          lat: homeState.vendor.lat,
          city: homeState.vendor.city,
          address: homeState.vendor.address,
          lastName: homeState.vendor.lastName,
          dob: homeState.vendor.dob,
          ratingCount: homeState.vendor.ratingCount,
          type: homeState.vendor.type,
          subCategoryId: homeState.vendor.subCategoryId,
          categoryId: homeState.vendor.categoryId,
          description: homeState.vendor.description,
          avgRating: homeState.vendor.avgRating,
          name: homeState.vendor.name,
          vendorStatus: homeState.vendor.vendorStatus,
          marketArea: homeState.vendor.marketArea,
          username: homeState.vendor.username,
          email: homeState.vendor.email,
          deviceid: homeState.vendor.deviceid,
          mobNo: homeState.vendor.mobNo,
          state: homeState.vendor.state,
          address1: homeState.vendor.address1,
          profileImg1: homeState.vendor.profileImg1,
          zipcode: homeState.vendor.zipcode,
          businessName: homeState.vendor.businessName,
          cityTax: homeState.vendor.cityTax,
          color: homeState.vendor.color,
          deliveryFee: homeState.vendor.deliveryFee,
          commissionRate: homeState.vendor.commissionRate,
          exciseTax: homeState.vendor.exciseTax,
          lng: homeState.vendor.lng,
          salesTax: homeState.vendor.salesTax,
          vendorType: homeState.vendor.vendorType,
      createdAt: "",
        devicetype: "",
        distance: "",
        driverLicense: "",
        forgetpassRequest: "",
        forgetpassRequestStatus: "",
        licenseBack: "",
        licenseExpiry: "",

          licenseFront: "",
        licensePlate: "",
        loginStatus: "",
        mailingAddress: "",
        make: "",
        map_icon: "",
        model: "",
        otp: "",
        password: "",
        permitExpiry: "",
        permitNumber: "",
        permitType: "",
        planExpiry: "",
        planId: "",
        planPurchased: "",
        profileImg2: "",
        profileImg3: "",
        profileImg4: "",
        rememberToken: "",
        service: "",
        serviceRadius: "",
        ssn: "",
        stripeId: "",
        suburb: "",
        txnId: "",
        type_of_merchant: "",
        uniqueId: "",
        updatedAt: "",
        views: "",
        walletAmount: "",
        year: ""
      );
      _cartDataModel = homeState.cartDataModel;
    } else if (homeState is HomeFromCategoryCartPageState) {
      strScreen = "CategoryPage";
      _productList = homeState.cartDataListArray;
      _driverDetail = homeState.driverDetails;
      _cartDataModel = homeState.cartDataModel;
    } else if (homeState is HomeFromDriverListCartPageState) {
      strScreen = "DriverList";
      _productList = homeState.cartDataListArray;
      _driverDetail = homeState.driverDetails;
      _cartDataModel = homeState.cartDataModel;
    } else if (homeState is HomeFromProductDetailCartPageState) {
      // print(_driverDetail.vendorId);
      strScreen = homeState.strScreen;
      print(strScreen);
      _productList = homeState.cartDataListArray;
      _driverDetail = homeState.driverDetail;

      productListModel = homeState.productListModel;
      _cartDataModel = homeState.cartDataModel;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocListener<HomeBloc, HomeState>(
        listenWhen: (prevState, curState) => ModalRoute.of(context)!.isCurrent,
        listener: (context, state) {
          print(state.toString());
          if (state is HomeCartPageState) {
            showHideProgress(false);
            _productList = [];
            setState(() {
              _productList = state.cartDataListArray;
              if (state.vendor != null) {
                _driverDetail = DriverList(
                    vendorId: '${state.vendor.vendorId}',
                    lat: state.vendor.lat,
                    city: state.vendor.city,
                    address: state.vendor.address,
                    lastName: state.vendor.lastName,
                    dob: state.vendor.dob,
                    ratingCount: state.vendor.ratingCount,
                    type: state.vendor.type,
                    subCategoryId: state.vendor.subCategoryId,
                    categoryId: state.vendor.categoryId,
                    description: state.vendor.description,
                    avgRating: state.vendor.avgRating,
                    name: state.vendor.name,
                    vendorStatus: state.vendor.vendorStatus,
                    marketArea: state.vendor.marketArea,
                    username: state.vendor.username,
                    email: state.vendor.email,
                    deviceid: state.vendor.deviceid,
                    mobNo: state.vendor.mobNo,
                    state: state.vendor.state,
                    address1: state.vendor.address1,
                    profileImg1: state.vendor.profileImg1,
                    zipcode: state.vendor.zipcode,
                    businessName: state.vendor.businessName,
                    cityTax: state.vendor.cityTax,
                    color: state.vendor.color,
                    deliveryFee: state.vendor.deliveryFee,
                    commissionRate: state.vendor.commissionRate,
                    exciseTax: state.vendor.exciseTax,
                    lng: state.vendor.lng,
                    salesTax: state.vendor.salesTax,
                    vendorType: state.vendor.vendorType,
                year: "",
                walletAmount: "",
                views: "",
                updatedAt: "",
                uniqueId: "",
                type_of_merchant: "",
                txnId: "",
                suburb: "",
                stripeId: "",
                ssn: "",
                 serviceRadius: "",
                service: "",
                rememberToken: "",
                profileImg4: "",
                profileImg3: "",
                profileImg2: "",
                planPurchased: "",
                planId: "",
                planExpiry: "",
                permitType: "",
                permitNumber: "",
                permitExpiry: "",
                password: "",
                otp: "",
                model: "",
                map_icon: "",
                make: "",
                mailingAddress: "",
                loginStatus: "",
                licensePlate: "",
                licenseFront: "",
                licenseExpiry: "",
                licenseBack: "",
                forgetpassRequestStatus: "",
                forgetpassRequest: "",
                driverLicense: "",
                distance: "",
                  devicetype: "",
                  createdAt: ""
                );
              }

              _cartDataModel = state.cartDataModel;
            });
          } else if (state is HomeFromCategoryCartPageState) {
            showHideProgress(false);

            strScreen = "CategoryPage";
            setState(() {
              _productList = state.cartDataListArray;
              _driverDetail = state.driverDetails;
              _cartDataModel = state.cartDataModel;
            });
          } else if (state is HomeFromDriverListCartPageState) {
            showHideProgress(false);
            strScreen = "DriverList";
            setState(() {
              _productList = state.cartDataListArray;
              _driverDetail = state.driverDetails;
              _cartDataModel = state.cartDataModel;
            });
          } else if (state is HomeFromProductDetailCartPageState) {
            showHideProgress(false);
            strScreen = "ProductDetail";
            setState(() {
              _productList = state.cartDataListArray;
              _driverDetail = state.driverDetail;
              productListModel = state.productListModel;
              _cartDataModel = state.cartDataModel;
            });
          }
          if (state is HomeEventMessageShowState) {
            showHideProgress(false);
            showSnackBar(state.message, context);
            BlocProvider.of<HomeBloc>(context).add(HomeEventCartPageReset(
                _driverDetail, strScreen, productListModel, _cartDataModel));
          }
          if (state is HomeEventAfterDeleteMessageShowState) {
            showHideProgress(false);
            setState(() {
              _productList = state.cartDataListArray;
            });

            BlocProvider.of<HomeBloc>(context).add(HomeEventCartPageReset(
                _driverDetail, strScreen, productListModel, _cartDataModel));
          }
          if (state is HomeMenuItemDetailsPageState) {
            Navigator.of(context).pop();
          }

          if (state is HomeCategoryProductPageState) {
            print("call state");
            Navigator.of(context).pop();
          } else if (state is HomeCategoryListPageState) {
            print("call state");
            Navigator.of(context).pop();
          } else if (state is HomeInitial) {
            Navigator.of(context).pop();
          } else if (state is HomeCheckOutPageState) {
            Navigator.of(context).pushNamed(HomeNavigator.homeCheckoutPage);
          } else if (state is LoginPageStateFromCheckOut) {
            showHideProgress(false);
            Navigator.of(context).pushNamed(HomeNavigator.loginPage);
          } else if (state is HomeFromDriverProductListDetailsPageState) {
            Navigator.of(context).pop();
          } else if (state is HomeBeforeCheckOutPageState) {
            BlocProvider.of<HomeBloc>(context).add(HomeEventCartPageReset(
                _driverDetail, strScreen, productListModel, _cartDataModel));
            BlocProvider.of<HomeBloc>(context).add(
                HomeEventAfterRefreshToCheckOutPage(
                    state.strScreen,
                    state.vendorId,
                    state.stateArrayList,
                    state.driverDetail,
                    state.productListModel));
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
                  print(strScreen);
                  if (strScreen == "ProductDetail") {
                    BlocProvider.of<HomeBloc>(context).add(
                        HomeEventBackForProductDetailPage(
                            _driverDetail, productListModel));
                  } else if (strScreen == "CategoryPage") {
                    BlocProvider.of<HomeBloc>(context)
                        .add(HomeEventBackForCategoryPage(_driverDetail));
                  } else if (strScreen == "DriverList") {
                    BlocProvider.of<HomeBloc>(context).add(
                        HomeEventBackForProductDetailPage(
                            _driverDetail, productListModel));
                  } else if (strScreen == "HomeCartpage") {
                    BlocProvider.of<HomeBloc>(context)
                        .add(HomeEventBackForProductListpage());
                  }
                },
                strBtnRightImageName: 'ic_search_logo.png',
                rightEditButtonVisibility: false, btnEditOnPressed: () {  },
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (_productList != null && _productList.length > 0)
                    _CartMenuList(
                            _productList,
                            _driverDetail,
                            showHideProgress,
                            strScreen,
                            productListModel,
                            _cartDataModel.vendor_id)
                        .expand(),
                  if (_productList != null && _productList.length > 0)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 160.0.scale(),
                          color: KColorTextGrey,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              AVerticalSpace(4.0.scale()),
                              Text(
                                "Total Amount: ${_cartDataModel.grandtotal}",
                                style: textStyleCustomColor(
                                    14.0.scale(), Colors.white),
                              ).align(Alignment.centerLeft),
                              AVerticalSpace(5.0.scale()),
                              TextField(
                                controller: _textFiledUserComment,
                                keyboardType: TextInputType.text,
                                autofocus: false,
                                cursorColor: KColorTextFieldCommonHint,
                                decoration: InputDecoration(
                                  hintText: "Special Instructions",
                                  hintStyle: textStyleCustomColor(
                                      14.0.scale().scale(),
                                      KColorTextFieldCommonHint),
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                              AVerticalSpace(10.0.scale()),
                              ARoundedButton(
                                btnBorderSideColor: kColorCommonButton,btnDisabledColor: Color(0xFF5e6163),btnIconSize:15 ,
                                btnDisabledTextColor:Color(0xFFFFFFFF) ,
                                btnFontWeight: FontWeight.normal,
                                btnBgColor: kColorCommonButton,
                                btnTextColor: Colors.white,
                                btnOnPressed: () {
                                  if (sharedPrefs.isLogin) {
                                    if (_textFiledUserComment.text.isEmpty) {
                                      sharedPrefs.setUserComment = "";
                                    } else {
                                      sharedPrefs.setUserComment =
                                          _textFiledUserComment.text;
                                    }
                                    showHideProgress(true);
                                    BlocProvider.of<HomeBloc>(context).add(
                                        HomeEventCheckOutButtonClick(
                                            strScreen,
                                            _driverDetail,
                                            productListModel,
                                            _cartDataModel.vendor_id));
                                  } else {
                                    BlocProvider.of<HomeBloc>(context).add(
                                        LoginEventSignInFromCheckOutPage(
                                            strScreen,
                                            _productList,
                                            _driverDetail,
                                            productListModel,
                                            _cartDataModel));
                                  }
                                },
                                btnText: "Checkout",
                                btnHeight: kHeightBtnCheckout.scale(),
                                btnWidth: kWidthBtnNormal.scale(),
                                btnFontSize: kFontSizeBtnLarge.scale(),
                                btnElevation: 0,
                              ),
                              AVerticalSpace(10.0.scale()),
                            ],
                          ).leftPadding(4.0.scale()).rightPadding(4.0.scale()),
                        )
                      ],
                    ).widgetBgColor(kColorAppBgColor),
                  if (_productList.isEmpty) _NoProductFoundWidget()
                ],
              ).expand()
            ],
          ).widgetBgColor(Colors.white),
        ).lightStatusBarText().pageBgColor(kColorAppBgColor));
  }
}

class _NoProductFoundWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    sharedPrefs.setCartCount = "0";
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        AVerticalSpace(120.0.scale()),
        const Image(
          fit: BoxFit.fill,
          image: AssetImage('${imgPathGeneral}ic_empty_cart.png'),
        ),
        AVerticalSpace(20.0.scale()),
        Text("Your cart is empty!",
                style: textStyleBoldCustomColor(20.0.scale(), KColorCommonText))
            .leftPadding(12.0.scale())
            .align(Alignment.center)
      ],
    ).expand();
  }
}

class _CartMenuList extends StatelessWidget {
  List<ItemsCart> productList;
  DriverList driverDetail;
  Function showHideProgress;
  String strScreen;
  ProductListMenu productListModel;
  String vendor_id;

  _CartMenuList(this.productList, this.driverDetail, this.showHideProgress,
      this.strScreen, this.productListModel, this.vendor_id);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: productList.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              child: HomeCartMenuListRowItem(productList[index], driverDetail,
                  showHideProgress, strScreen, productListModel, vendor_id),
              onTap: () {},
            );
          },
        ).expand()
      ],
    );
  }
}
