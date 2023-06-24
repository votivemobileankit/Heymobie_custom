import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:grambunny_customer/components/components.dart';
import 'package:grambunny_customer/dialogs/dlg_two_button.dart';
import 'package:grambunny_customer/home/bloc/bloc.dart';
import 'package:grambunny_customer/home/home.dart';
import 'package:grambunny_customer/home/model/model.dart';
import 'package:grambunny_customer/home/model/product_list_model.dart';
import 'package:grambunny_customer/services/herbarium_cust_shared_preferences.dart';
import 'package:grambunny_customer/side_navigation/side_navigation.dart';
import 'package:grambunny_customer/theme/theme.dart';
import 'package:grambunny_customer/utils/utils.dart';

import '../model/driver_list_model.dart';

const double _kMenuItemNameFontSize = 16.0;
const double _kCommonFontSize = 15.0;
const double _kCommonSmallFontSize = 12.0;
const kHeightBtnAddToCart = 40.0;
const double _kMenuitemNameTextFontSize = 16.0;

class MenuProductDetailPage extends StatefulWidget {
  @override
  _MenuProductDetailPageState createState() => _MenuProductDetailPageState();
}

class _MenuProductDetailPageState extends State<MenuProductDetailPage> {
  GlobalKey keydemo = new GlobalKey();
  late ProductListMenu _productListModel;
  late List<RelatedProductList> _relatedProductList;
  String? _driverId;
  late DriverList _driverDetail;
  late Vendor _vendorDetails;
  late String name;
  late ProductListDriver _productListDriverModel;
  int _counter = 1;
  double ratingCountSend = 5;
  double _price = 0;
  int pageCount = 1;
  late String _cartCount;
  late String strScreen;
  late int productID;
  late List<AddonProductList> _addOnProductList;
  late List<AddonProductListBool> _addOnProductLocalList;
  TextEditingController _textFiledUserSpecialInstruction =
      TextEditingController();

  void showHideProgress(bool show) {
    BlocProvider.of<SideNavigatBloc>(context)
        .add(SideNavigationEventToggleLoadingAnimation(needToShow: show));
  }

  final TextEditingController _textReview = TextEditingController();
  late List<RatingReviewData> ratingReviewList;

  @override
  void initState() {
    HomeState homeState = BlocProvider.of<HomeBloc>(context).state;
    ratingReviewList = [];
    if (homeState is HomeMenuItemDetailsPageState) {
      _productListModel = homeState.productListModel;
      _driverId = homeState.driverId;
      print("driver Id ${_driverId}");
      _price = double.parse(_productListModel.price ?? "");
      _driverDetail = homeState.driverDetail;
      _productListModel.brands;
      name = _driverDetail.name! + " " + _driverDetail.lastName!;
      strScreen = "";
      print("HomeMenuItemDetailsPageState");
    } else if (homeState is HomeFromDriverProductListDetailsPageState) {
      print("productlistdetailPage");
      _productListDriverModel = homeState.driverProductList;
      _vendorDetails = homeState.driverDetail;
      _relatedProductList = homeState.relatedProductList!;
      _addOnProductList = homeState.addOnProductList!;
      _driverId = "${_vendorDetails.vendorId}";
      strScreen = homeState.screen;
      _driverDetail = DriverList(
          state: _vendorDetails.state,
          city: _vendorDetails.city,
          address: _vendorDetails.address,
          vendorId: "${_vendorDetails.vendorId}",
          type: _vendorDetails.type,
          subCategoryId: _vendorDetails.subCategoryId,
          categoryId: _vendorDetails.categoryId,
          zipcode: _vendorDetails.zipcode,
          profileImg1: _vendorDetails.profileImg1,
          description: _vendorDetails.description,
          address1: _vendorDetails.address,
          mobNo: _vendorDetails.mobNo,
          avgRating: _vendorDetails.avgRating,
          deviceid: _vendorDetails.deviceid,
          email: _vendorDetails.email,
          username: _vendorDetails.username,
          name: _vendorDetails.name,
          lastName: _vendorDetails.lastName,
          marketArea: _vendorDetails.marketArea,
          vendorStatus: _vendorDetails.vendorStatus,
          uniqueId: '',
          loginStatus: "",
          updatedAt: "",
          createdAt: "",
          devicetype: "",
          year: "",
          walletAmount: "",
          views: "",
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
          licensePlate: "",
          licenseFront: "",
          licenseExpiry: "",
          licenseBack: "",
          forgetpassRequestStatus: "",
          forgetpassRequest: "",
          driverLicense: "",
          distance: "",
          vendorType: "",
          salesTax: "",
          ratingCount: "",
          exciseTax: "",
          dob: "",
          deliveryFee: "",
          commissionRate: "",
          color: "",
          cityTax: "",
          businessName: "",
          lat: "",
          lng: "");
      name = _driverDetail.name! + " " + _driverDetail.lastName!;
      productID = _productListDriverModel.id!;
      _productListModel = ProductListMenu(
          name: _productListDriverModel.name!,
          avgRating: _productListDriverModel.avgRating!,
          description: _productListDriverModel.description!,
          categoryId: _productListDriverModel.categoryId!,
          subCategoryId: _productListDriverModel.subCategoryId!,
          vendorId: _productListDriverModel.vendorId!,
          id: _productListDriverModel.id!,
          status: _productListDriverModel.status!,
          type: _productListDriverModel.type!,
          potencyThc: _productListDriverModel.potencyThc!,
          potencyCbd: _productListDriverModel.potencyCbd!,
          brands: _productListDriverModel.brands!,
          categoryname: _productListDriverModel.categoryname!,
          image: _productListDriverModel.image!,
          imageURL: _productListDriverModel.imageURL!,
          price: _productListDriverModel.price!,
          productCode: _productListDriverModel.productCode!,
          quantity: _productListDriverModel.quantity!,
          ratingCount: _productListDriverModel.ratingCount!,
          types: _productListDriverModel.types!,
          subcategoryname: _productListDriverModel.subcategoryname!,
          unit: _productListDriverModel.unit!,
          slug: '',
          createdAt: "",
          updatedAt: "",
          loginStatus: "",
          images: [],
          keyword: "",
          stock: "");
      _price = double.parse(_productListModel.price ?? "");
      ratingReviewList = homeState.ratingReviewList!;
    }

    super.initState();
  }

  callLoadMore() {
    showHideProgress(true);
    pageCount = pageCount + 1;
    BlocProvider.of<HomeBloc>(context).add(HomeEventLoadMoreBtnClick(
        '$pageCount',
        '$productID',
        _productListDriverModel,
        strScreen,
        _vendorDetails));
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _cartCount = sharedPrefs.getCartCount;
    });
    // TODO: implement build
    return BlocListener<HomeBloc, HomeState>(
      listenWhen: (prevState, curState) => ModalRoute.of(context)!.isCurrent,
      listener: (context, state) {
        if (state is HomeCategoryProductPageState) {
          Navigator.of(context).pop(true);
        } else if (state is HomeMenuItemDetailsPageState) {
          _productListModel = state.productListModel;
          _driverId = state.driverId;
          print("driver Id ${_driverId}");
          _price = double.parse(_productListModel.price ?? "");
          _driverDetail = state.driverDetail;
          name = _driverDetail.name! + " " + _driverDetail.lastName!;
        } else if (state is HomeFromDriverProductListDetailsPageState) {
          showHideProgress(false);
          setState(() {
            List<RatingReviewData> ratingReviewListData =
                state.ratingReviewList!;
            ratingReviewList.addAll(ratingReviewListData);
            //ratingReviewList = state.ratingReviewList;
          });
          print("driver Id ${_driverId}");
          BlocProvider.of<HomeBloc>(context).add(
              HomeEventProductDetailPageReset(
                  _productListModel, _driverId!, _driverDetail));
        } else if (state is HomeEventMessageShowState) {
          print("Add to cart data =========");
          try {
            if (_contextLoad != null) {
              Navigator.of(_contextLoad!, rootNavigator: true).pop();
            }
          } catch (v) {
            print(v.toString());
          }
          _textFiledUserSpecialInstruction.text = "";
          showHideProgress(false);
          showSnackBar(state.message, context);
          print("driver Id ${_driverId}");
          BlocProvider.of<HomeBloc>(context).add(
              HomeEventProductDetailPageReset(
                  _productListModel, _driverId!, _driverDetail));
        } else if (state is HomeCustomerRatingReviewSubmitState) {
          showHideProgress(false);
          showSnackBar(state.message, context);
          print("driver Id ${_driverId}");
          BlocProvider.of<HomeBloc>(context).add(
              HomeEventProductDetailPageReset(
                  _productListModel, _driverId!, _driverDetail));
        } else if (state is HomeMenuItemDetailsPageState) {
          _productListModel = state.productListModel;
          _driverId = state.driverId;
          print("driver Id ${_driverId}");
          _price = double.parse(_productListModel.price ?? "");
          _driverDetail = state.driverDetail;
          name = _driverDetail.name! + " " + _driverDetail.lastName!;
          setState(() {
            _counter = 1;
          });
        } else if (state is HomeFromProductDetailCartPageState) {
          showHideProgress(false);
          Navigator.of(context).pushNamed(HomeNavigator.homeShowCartPage);
        } else if (state is HomeEventErrorHandelState) {
          showHideProgress(false);
          showSnackBar(state.message, context);
          BlocProvider.of<HomeBloc>(context).add(
              HomeEventProductItemDetailPageReset(
                  _productListModel, _driverDetail));
        } else if (state is HomeEventAddtocartSuccessState) {
          showHideProgress(false);
          showTwoButtonDialog(
              context: context,
              titleText: "Alert!",
              descText:
                  "You want to delete your cart product and add new driver product?",
              btn1TitleText: "Yes",
              btn2TitleText: "No i don't",
              btn2OnPressed: () {
                BlocProvider.of<HomeBloc>(context).add(
                    HomeEventProductItemDetailPageReset(
                        _productListModel, _driverDetail));
              },
              btn1OnPressed: () {
                BlocProvider.of<HomeBloc>(context).add(
                    HomeEventItemClickAddToCartBtnClick(
                        _counter,
                        state.productId,
                        _productListModel.vendorId!,
                        0,
                        _driverDetail,
                        "1",
                        state.specialInstruction));
              });
        } else if (state is HomeInitial) {
          Navigator.of(context).pop(true);
        }
      },
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              AHeaderWidget(
                  strBackbuttonName: 'ic_red_btn_back.png',
                  backBtnVisibility: true,
                  btnBackOnPressed: () {
                    Navigator.pop(context);
                    timerOnListener = false;
                    _contextLoad = null;
                    BlocProvider.of<HomeBloc>(context)
                        .add(HomeEventBackBtnClick());
                  },
                  strBtnRightImageName: 'ic_cart_white.png',
                  rightEditButtonVisibility: true,
                  headerSigninText: _cartCount,
                  btnEditOnPressed: () {
                    if (sharedPrefs.getCartCount != "0") {
                      showHideProgress(true);
                      print(strScreen);
                      if (strScreen == "DriverList") {
                        BlocProvider.of<HomeBloc>(context).add(
                            HomeEventProductDetailPageCartBtnClick(
                                _driverDetail, _productListModel, strScreen));
                      } else {
                        BlocProvider.of<HomeBloc>(context).add(
                            HomeEventProductDetailPageCartBtnClick(
                                _driverDetail, _productListModel, strScreen));
                      }
                      // _contextLoad = null!;
                    }
                  }),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  CachedNetworkImage(
                    imageUrl: _productListModel == null
                        ? _productListDriverModel.imageURL ?? ""
                        : _productListModel.imageURL ?? "",
                    width: MediaQuery.of(context).size.width,
                    height: 200.0.scale(),
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ).topPadding(2.0.scale()),
                  AVerticalSpace(5.0.scale()),
                  Text(
                    _productListModel == null
                        ? _productListDriverModel.name ?? ""
                        : _productListModel.name ?? "",
                    style: textStyleBoldCustomLargeColor(
                        _kMenuItemNameFontSize, KColorCommonText),
                  ).align(Alignment.centerLeft),
                  AVerticalSpace(5.0.scale()),
                  Text(
                    _productListModel == null
                        ? "UPC#" + _productListDriverModel.productCode!
                        : "UPC#" + "${_productListModel.productCode}",
                    style: textStyleBoldCustomLargeColor(
                        _kCommonFontSize, KColorCommonText),
                  ).align(Alignment.centerLeft),
                  AVerticalSpace(5.0.scale()),
                  Row(
                    children: [
                      Text(
                          _productListModel == null
                              ? _productListDriverModel.categoryname ?? ""
                              : _productListModel.categoryname ?? "",
                          style: textStyleCustomColor(
                              _kCommonFontSize, KColorCommonText)),
                      AHorizontalSpace(5.0.scale()),
                      AVerticalSeparatorLine(
                          width: 1,
                          height: 15.0.scale(),
                          color: KColorCommonText),
                      AHorizontalSpace(5.0.scale()),
                      Row(
                        children: [
                          Text(
                            name,
                            style: textStyleBoldCustomLargeColor(
                                _kCommonFontSize.scale(), KColorCommonText),
                          ).leftPadding(5.0.scale()),
                          AHorizontalSpace(3.0.scale()),
                          Image(
                            image:
                                AssetImage('${imgPathGeneral}ic_bluetick.png'),
                          ),
                        ],
                      )
                    ],
                  ),
                  AVerticalSpace(5.0.scale()),
                  Row(
                    children: [
                      Container(
                        width: 200.0.scale(),
                        child: Row(
                          children: [
                            Text(
                              '\$ ${_productListModel == null ? _productListDriverModel.price : _price}',
                              style: textStyleBoldCustomLargeColor(
                                  _kMenuItemNameFontSize.scale(),
                                  KColorCommonText),
                            ),
                            Text(
                              _productListModel == null
                                  ? ", (" + _productListDriverModel.unit! + ")"
                                  : ", (" + _productListModel.unit! + ")",
                              style: textStyleBoldCustomLargeColor(
                                  _kCommonFontSize.scale(), KColorCommonText),
                            ),
                          ],
                        ),
                      ),
                      AHorizontalSpace(20.0.scale()),
                    ],
                  ).leftPadding(3.0.scale()),
                  AVerticalSpace(10.0.scale()),
                  TextField(
                    controller: _textFiledUserSpecialInstruction,
                    keyboardType: TextInputType.text,
                    autofocus: false,
                    cursorColor: KColorTextFieldCommonHint,
                    decoration: InputDecoration(
                      hintText: "Special Instructions",
                      hintStyle: textStyleCustomColor(
                          14.0.scale().scale(), KColorTextGrey),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  AVerticalSpace(10.0.scale()),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: KColorTextGrey, width: 1.0),
                          color: KColorTextGrey,
                        ),
                        padding: EdgeInsets.all(5.0.scale()),
                        width: 130.0.scale(),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                if (_counter > 1) {
                                  _counter--;
                                  print(_counter);
                                  setState(() {
                                    _price = double.parse(_productListModel ==
                                                null
                                            ? _productListDriverModel.price ??
                                                ""
                                            : _productListModel.price ?? "") *
                                        _counter;
                                    String value = _price.toStringAsFixed(2);
                                    _price = double.parse(value);
                                  });
                                }
                              },
                              child: Container(
                                  padding: EdgeInsets.all(3.0.scale()),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(
                                        color: KColorTextGrey, width: 3.0),
                                    color: KColorTextGrey,
                                  ),
                                  child: Image(
                                    color: Colors.white,
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                        '${imgPathGeneral}ic_minus_icon.png'),
                                    width: 15.0.scale(),
                                    height: 15.0.scale(),
                                  )).align(Alignment.centerLeft),
                            ).rightPadding(7.0.scale()),
                            Container(
                              child: Row(
                                children: [
                                  AHorizontalSpace(4.0.scale()),
                                  // AVerticalSeparatorLine(
                                  //     width: 1,
                                  //     height: 20.0.scale(),
                                  //     color: kColorCommonButton),

                                  Text(
                                    ' ${_counter}',
                                    style: textStyleBoldCustomLargeColor(
                                        _kMenuitemNameTextFontSize.scale(),
                                        Colors.white),
                                  ),
                                  AHorizontalSpace(5.0.scale()),
                                  // AVerticalSeparatorLine(
                                  //     width: 1,
                                  //     height: 20,
                                  //     color: kColorCommonButton),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (_counter <
                                    int.parse(_productListModel == null
                                        ? _productListDriverModel.quantity ?? ""
                                        : _productListModel.quantity ?? "")) {
                                  _counter++;
                                  print(_counter);
                                  setState(() {
                                    _price = double.parse(_productListModel ==
                                                null
                                            ? _productListDriverModel.price ??
                                                ""
                                            : _productListModel.price ?? "") *
                                        _counter;
                                    String value = _price.toStringAsFixed(2);
                                    _price = double.parse(value);
                                  });
                                } else {
                                  showSnackBar(
                                      "Product available quantity is ${_productListModel == null ? _productListDriverModel.quantity : _productListModel.quantity}",
                                      context);
                                }
                              },
                              child: Container(
                                  padding: EdgeInsets.fromLTRB(
                                      9.0.scale(), 0, 9.0.scale(), 0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(
                                        color: KColorTextGrey, width: 3.0),
                                    color: KColorTextGrey,
                                  ),
                                  child: Image(
                                    color: Colors.white,
                                    fit: BoxFit.fill,
                                    width: 15.0.scale(),
                                    height: 15.0.scale(),
                                    image: AssetImage(
                                        '${imgPathGeneral}ic_add_icon.png'),
                                  )).align(Alignment.centerLeft),
                            ).leftPadding(8.0.scale()),
                          ],
                        ),
                      ),
                      AHorizontalSpace(10.0.scale()),
                      ARoundedButton(
                        btnDisabledColor: Color(0xFF5e6163),
                        btnIconSize: 15,
                        btnDisabledTextColor: Color(0xFFFFFFFF),
                        btnFontWeight: FontWeight.normal,
                        btnBgColor: kColorCommonButton,
                        btnTextColor: Colors.white,
                        btnOnPressed: () {
                          if (int.parse(_productListModel.quantity!) > 0) {
                            showHideProgress(true);

                            BlocProvider.of<HomeBloc>(context).add(
                                HomeEventItemClickAddToCartBtnClick(
                                    _counter,
                                    _productListModel.id!,
                                    _productListModel.vendorId!,
                                    0,
                                    _driverDetail,
                                    "0",
                                    _textFiledUserSpecialInstruction.text));
                          } else {
                            showSnackBar("Product is out of stock!", context);
                          }
                        },
                        btnText: "Add to Cart",
                        btnHeight: kHeightBtnAddToCart.scale(),
                        btnWidth: 110.0.scale(),
                        btnFontSize: kFontSizeBtnLarge.scale(),
                        btnElevation: 0,
                        btnBorderSideColor: kColorCommonButton,
                      ).align(Alignment.centerLeft)
                    ],
                  ),

                  AVerticalSpace(10.0.scale()),
                  Text(
                    "Description",
                    style: textStyleCustomColor(14.0.scale(), KColorCommonText),
                  ).align(Alignment.centerLeft),
                  AVerticalSpace(5.0.scale()),
                  Text(
                    _productListModel == null
                        ? _productListDriverModel.description ?? ""
                        : _productListModel.description ?? "",
                    style: textStyleCustomColor(
                        _kCommonSmallFontSize.scale(), KColorTextGrey),
                  ).align(Alignment.centerLeft),
                  AVerticalSpace(15.0.scale()),
                  ASeparatorLine(height: 1, color: KColorAppThemeColor),
                  AVerticalSpace(15.0.scale()),
                  if (_addOnProductList.length > 0)
                    InkWell(
                      onTap: () {
                        _addOnProductLocalList = [];
                        for (int i = 0; i < _addOnProductList.length; i++) {
                          AddonProductListBool addonlistModel =
                              new AddonProductListBool(
                                  pid: _addOnProductList[i].pid,
                                  avgRating: _addOnProductList[i].avgRating,
                                  categoryId: _addOnProductList[i].categoryId,
                                  description: _addOnProductList[i].description,
                                  imageURL: _addOnProductList[i].imageURL,
                                  ischecked: false,
                                  name: _addOnProductList[i].name,
                                  price: _addOnProductList[i].price,
                                  productCode: _addOnProductList[i].productCode,
                                  quantity: _addOnProductList[i].quantity,
                                  slug: _addOnProductList[i].slug,
                                  stock: _addOnProductList[i].stock,
                                  subCategoryId:
                                      _addOnProductList[i].subCategoryId,
                                  unit: _addOnProductList[i].unit,
                                  vendorId: _addOnProductList[i].vendorId);

                          _addOnProductLocalList.add(addonlistModel);
                        }

                        showDialog(
                          context: context,
                          builder: (BuildContext context1) {
                            return getDialogAddOnProductList(
                                context1: context,
                                addOnProductLocalList: _addOnProductLocalList,
                                vendorId: _productListModel.vendorId!,
                                driverDetail: _driverDetail,
                                titleText: '',
                                btn1TitleText: '',
                                btn1OnPressed: () {});
                          },
                        );
                      },
                      child: Container(
                        width: 125.0.scale(),
                        padding: EdgeInsets.fromLTRB(
                            5.0.scale(), 5.0.scale(), 5.0.scale(), 5.0.scale()),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: KColorTextGrey, width: 1.0),
                          color: KColorAppThemeColor,
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Add option',
                              style: textStyleBoldCustomLargeColor(
                                  _kMenuItemNameFontSize.scale(), Colors.white),
                            ),
                            AHorizontalSpace(4.0.scale()),
                            Image(
                              color: Colors.white,
                              fit: BoxFit.fill,
                              width: 15.0.scale(),
                              height: 15.0.scale(),
                              image: AssetImage(
                                  '${imgPathGeneral}ic_menu_dropdown_icon.png'),
                            )
                          ],
                        ),
                      ),
                    ).align(Alignment.centerLeft),

                  // if (_addOnProductList.length > 0)
                  //   _AddonProductListContainer(
                  //       _addOnProductList, _driverDetail, showHideProgress),
                  Text(
                    'Related Products',
                    style: textStyleBoldCustomLargeColor(
                        _kMenuItemNameFontSize.scale(), KColorCommonText),
                  ).align(Alignment.centerLeft),
                  AVerticalSpace(15.0.scale()),
                  _RelatedProductListWidget(
                          _relatedProductList, _driverDetail, showHideProgress)
                      .align(Alignment.centerLeft),
                  AVerticalSpace(15.0.scale()),
                  Row(
                    children: [
                      Text(
                        "Product Rating",
                        style: textStyleBoldCustomColor(
                            18.0.scale(), KColorCommonText),
                      ).align(Alignment.centerLeft),
                      AHorizontalSpace(10.0.scale()),
                      Container(
                        padding: EdgeInsets.all(7.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                              color: KColorAppThemeColor, width: 4.0),
                          color: KColorAppThemeColor,
                        ),
                        child: Text(
                          "${_productListModel.avgRating}/5",
                          style: textStyleBoldCustomColor(
                              18.0.scale(), Colors.white),
                        ),
                      )
                    ],
                  ),
                  AVerticalSpace(15.0.scale()),
                  Text(
                    "Write Your Review",
                    style: textStyleBoldCustomColor(
                        18.0.scale(), KColorCommonText),
                  ).align(Alignment.centerLeft),
                  AVerticalSpace(15.0.scale()),
                  RatingBar.builder(
                    initialRating: 5,
                    minRating: 1,
                    itemSize: 50,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                      setState(() {
                        ratingCountSend = rating;
                      });
                    },
                  ),
                  AVerticalSpace(8.0.scale()),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0.scale()),
                      border: Border.all(
                          color: KColorAppThemeColor, width: 4.0.scale()),
                      color: KColorAppThemeColor,
                    ),
                    height: 56.0.scale(),
                    width: double.infinity,
                    child: Column(
                      children: [
                        TextField(
                          controller: _textReview,
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          cursorColor: KColorTextFieldCommonHint,
                          decoration: InputDecoration(
                            hintText: "Enter your review here",
                            hintStyle: textStyleCustomColor(
                                12.0.scale(), KColorTextGrey),
                            fillColor: Colors.white,
                            filled: true,
                            border: InputBorder.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AVerticalSpace(15.0.scale()),
                  ARoundedButton(
                    btnBorderSideColor: kColorCommonButton,
                    btnDisabledColor: Color(0xFF5e6163),
                    btnIconSize: 15,
                    btnDisabledTextColor: Color(0xFFFFFFFF),
                    btnFontWeight: FontWeight.normal,
                    btnBgColor: kColorCommonButton,
                    btnTextColor: Colors.white,
                    btnText: "Submit Review",
                    btnOnPressed: () {
                      if (_textReview.text.isEmpty) {
                        showSnackBar("Please add your review for this product!",
                            context);
                      } else {
                        showHideProgress(true);
                        BlocProvider.of<HomeBloc>(context).add(
                            HomeEventSubmitRatingBtnClick("${ratingCountSend}",
                                _textReview.text, _productListModel.id!));
                      }
                    },
                    btnHeight: 40.0.scale(),
                    btnWidth: kWidthBtnNormal.scale(),
                    btnFontSize: kFontSizeBtnLarge.scale(),
                    btnElevation: 0,
                  ),
                  AVerticalSpace(15.0.scale()),
                  ASeparatorLine(height: 1, color: KColorAppThemeColor),
                  AVerticalSpace(15.0.scale()),
                  if (ratingReviewList != null && ratingReviewList.isNotEmpty)
                    Text(
                      "Customer Rating",
                      style: textStyleBoldCustomColor(
                          18.0.scale(), KColorCommonText),
                    ).align(Alignment.centerLeft),
                  AVerticalSpace(15.0.scale()),
                  if (ratingReviewList != null && ratingReviewList.isNotEmpty)
                    // for (int i = 0; i < ratingReviewList.length; i++)
                    UserReviewList(ratingReviewList, callLoadMore)
                  else
                    Text(
                      "Customer Review Not Available!",
                      style: textStyleBoldCustomColor(
                          18.0.scale(), KColorCommonText),
                    ).align(Alignment.center),
                  AVerticalSpace(25.0.scale()),
                ],
              )
                  .leftPadding(8.0.scale())
                  .rightPadding(8.0.scale())
                  .scroll()
                  .expand()
            ],
          ).widgetBgColor(Colors.white),
        ),
      ).pageBgColor(kColorAppBgColor),
    );
  }
}

Dialog getDialogAddOnProductList({
  required List<AddonProductListBool> addOnProductLocalList,
  required String vendorId,
  required DriverList driverDetail,
  required BuildContext context1,
  required String titleText,
  required String btn1TitleText,
  required VoidCallback btn1OnPressed,
}) {
  return Dialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_kAddtoCartDialogRadius.scale())),
    elevation: 8,
    insetAnimationDuration: Duration(milliseconds: 30),
    insetPadding: EdgeInsets.all(10.0.scale()),
    child: _AddonProductListWidget(
        addOnProductLocalList, context1, vendorId, driverDetail),
  );
}

class _AddonProductListWidget extends StatefulWidget {
  List<AddonProductListBool> addOnProductLocalList;
  BuildContext context1;
  String vendorId;
  DriverList driverDetail;

  _AddonProductListWidget(this.addOnProductLocalList, this.context1,
      this.vendorId, this.driverDetail);

  @override
  State<_AddonProductListWidget> createState() =>
      _AddonProductListWidgetState();
}

class _AddonProductListWidgetState extends State<_AddonProductListWidget> {
  int productId = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        for (int i = 0; i < widget.addOnProductLocalList.length; i++)
          InkWell(
              onTap: () {
                setState(() {
                  for (int j = 0;
                      j < widget.addOnProductLocalList.length;
                      j++) {
                    widget.addOnProductLocalList[j].ischecked = false;
                  }

                  if (widget.addOnProductLocalList[i].ischecked == true) {
                    widget.addOnProductLocalList[i].ischecked = false;
                  } else {
                    widget.addOnProductLocalList[i].ischecked = true;
                  }

                  for (int i = 0;
                      i < widget.addOnProductLocalList.length;
                      i++) {
                    if (widget.addOnProductLocalList[i].ischecked == true) {
                      productId = widget
                          .addOnProductLocalList[i].pid; //  isChecked = true;
                    }
                  }
                });
              },
              child: _RadioViewSelectA(widget.addOnProductLocalList[i])),
        AVerticalSpace(10.0.scale()),
        ARoundedButton(
          btnBorderSideColor: kColorCommonButton,
          btnDisabledColor: Color(0xFF5e6163),
          btnIconSize: 15,
          btnDisabledTextColor: Color(0xFFFFFFFF),
          btnFontWeight: FontWeight.normal,
          btnBgColor: kColorCommonButton,
          btnTextColor: Colors.white,
          btnText: "Add",
          btnOnPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            if (productId != 0) {
              showSnackBar("Please wait....", context);
              BlocProvider.of<HomeBloc>(widget.context1).add(
                  HomeEventItemClickAddToCartBtnClick(1, productId,
                      widget.vendorId, 0, widget.driverDetail, "0", ""));
            }
          },
          btnHeight: 40.0.scale(),
          btnWidth: kWidthBtnNormal.scale(),
          btnFontSize: kFontSizeBtnLarge.scale(),
          btnElevation: 0,
        ),
        AVerticalSpace(20.0.scale())
      ],
    );
  }
}

class _RadioViewSelectA extends StatefulWidget {
  AddonProductListBool addOnProductLocalList;

  _RadioViewSelectA(this.addOnProductLocalList);

  @override
  __RadioViewSelectAState createState() => __RadioViewSelectAState();
}

class __RadioViewSelectAState extends State<_RadioViewSelectA> {
  @override
  void initState() {
    // print(""widget.dataAnswerModelList.isSelectA);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        AVerticalSpace(5.0.scale()),
        Row(
          children: [
            AHorizontalSpace(20),
            Image(
              height: 35.0.scale(),
              width: 35.0.scale(),
              image: widget.addOnProductLocalList.ischecked == true
                  ? AssetImage('${imgPathGeneral}ic_home_select_checkbox.png')
                  : AssetImage(
                      '${imgPathGeneral}ic_home_unselect_checkbox.png'),
            ),
            AHorizontalSpace(5.0.scale()),
            Column(
              children: [
                Text(
                  widget.addOnProductLocalList.name,
                  style: textStyleBoldCustomLargeColor(
                      20.0.scale(), KColorAppThemeColor),
                ),
                Text(
                  "\$" + widget.addOnProductLocalList.price,
                  style: textStyleBoldCustomLargeColor(
                      20.0.scale(), KColorAppThemeColor),
                )
              ],
            )
          ],
        ),
        AVerticalSpace(5.0.scale()),
      ],
    );
  }
}

class _RelatedProductListWidget extends StatelessWidget {
  List<RelatedProductList> relatedProductList;
  DriverList driverDetail;
  Function showHideProgress;

  _RelatedProductListWidget(
      this.relatedProductList, this.driverDetail, this.showHideProgress);

  @override
  Widget build(BuildContext context1) {
    // TODO: implement build
    return SizedBox(
      height: 210.0.scale(),
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: relatedProductList.length,
        itemBuilder: (BuildContext context, int index) => Ink(
          child: InkWell(
            splashColor: Colors.grey,
            onTap: () {
              showDialog(
                context: context,
                barrierColor: Colors.black26,
                barrierDismissible: true,
                builder: (context) {
                  return getAddToCartWidget(
                    context1: context1,
                    productlist: relatedProductList[index],
                    driverDetail: driverDetail,
                    titleText: '',
                    btn1TitleText: '',
                    btn1OnPressed: () {},
                    btn2TitleText: '',
                    btn2OnPressed: () {},
                  );
                },
              );
            },
            child: Container(
              height: 205.0.scale(),
              width: 170.0.scale(),
              child: Column(
                children: [
                  AVerticalSpace(6.0.scale()),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0.scale()),
                    child: CachedNetworkImage(
                      width: 100.0.scale(),
                      height: 80.0.scale(),
                      imageUrl: relatedProductList[index].imageURL,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error),
                    ),
                  ).align(Alignment.center),
                  AVerticalSpace(7.0.scale()),
                  Text(
                    relatedProductList[index].categoryname == null
                        ? ""
                        : relatedProductList[index].categoryname,
                    textAlign: TextAlign.center,
                    style: textStyleCustomColor(12.0.scale(), KColorTextGrey),
                  ),
                  AVerticalSpace(7.0.scale()),
                  Text(
                    relatedProductList[index].name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: textStyleBoldCustomColor(
                        14.0.scale(), KColorCommonText),
                  ),
                  AVerticalSpace(6.0.scale()),
                  Text(
                    relatedProductList[index].brands,
                    textAlign: TextAlign.center,
                    style:
                        textStyleBoldCustomColor(14.0.scale(), KColorTextGrey),
                  ),
                  AVerticalSpace(7.0.scale()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('${imgPathGeneral}ic_bluetick.png'),
                      ),
                      AHorizontalSpace(3.0.scale()),
                      Text(
                        relatedProductList[index].vendorname +
                            " " +
                            relatedProductList[index].lastName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textStyleBoldCustomColor(
                            12.0.scale(), KColorCommonText),
                      ),
                    ],
                  ),
                  AVerticalSpace(5.0.scale()),
                ],
              ),
            ),
          ),
        )
            .topPadding(3.0.scale())
            .leftPadding(4.0.scale())
            .rightPadding(4.0.scale())
            .bottomPadding(3.0.scale()),
      ),
    );
  }
}

const double _kFontSize16 = 16.0;
const double _kAddtoCartDialogRadius = 20.0;
const double _kCommonCartMediumFontSize = 14.0;

Dialog getAddToCartWidget({
  required BuildContext context1,
  required String titleText,
  required String btn1TitleText,
  required VoidCallback btn1OnPressed,
  required String btn2TitleText,
  required VoidCallback btn2OnPressed,
  required RelatedProductList productlist,
  required DriverList driverDetail,
}) {
  return Dialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_kAddtoCartDialogRadius.scale())),
    elevation: 8,
    insetAnimationDuration: Duration(milliseconds: 30),
    insetPadding: EdgeInsets.all(10.0.scale()),
    child: _AddToCartWidget(productlist, driverDetail, context1),
  );
}

class _AddToCartWidget extends StatefulWidget {
  RelatedProductList productlist;
  DriverList driverDetail;
  BuildContext context1;

  _AddToCartWidget(this.productlist, this.driverDetail, this.context1);

  @override
  __AddToCartWidgetState createState() => __AddToCartWidgetState();
}

class __AddToCartWidgetState extends State<_AddToCartWidget> {
  int _counter = 1;
  int decrease = 0;
  late double price;
  late BuildContext contexttext;

  @override
  void initState() {
    // TODO: implement initState
    price = double.parse(widget.productlist.price);
    contexttext = widget.context1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 380.0.scale(),
      child: Column(children: [
        AVerticalSpace(5.0.scale()),
        Card(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: CachedNetworkImage(
              imageUrl: widget.productlist.imageURL,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              errorWidget: (context, url, error) => new Icon(Icons.error),
            ),
          ).topPadding(2.0.scale()).setHeight(150.0.scale()),
        ),
        Column(
          children: [
            AVerticalSpace(5.0.scale()),
            Text(
              widget.productlist.name,
              style: textStyleBoldCustomLargeColor(
                  _kMenuitemNameTextFontSize.scale(), KColorCommonText),
            ).align(Alignment.centerLeft),
            AVerticalSpace(5.0.scale()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$ ${price}',
                  style: textStyleBoldCustomLargeColor(
                      _kMenuitemNameTextFontSize.scale(), KColorCommonText),
                ),
                Text(
                  widget.productlist.unit + ", ",
                  style: textStyleBoldCustomLargeColor(
                      _kMenuitemNameTextFontSize.scale(), KColorCommonText),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: KColorTextGrey, width: 1.0),
                    color: KColorTextGrey,
                  ),
                  padding: EdgeInsets.all(5.0.scale()),
                  width: 130.0.scale(),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          if (_counter > 1) {
                            _counter--;
                            print(_counter);
                            setState(() {
                              price = double.parse(widget.productlist.price) *
                                  _counter;
                              String value = price.toStringAsFixed(2);
                              price = double.parse(value);
                            });
                          }
                        },
                        child: Container(
                            padding: EdgeInsets.all(3.0.scale()),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border:
                                  Border.all(color: KColorTextGrey, width: 3.0),
                              color: KColorTextGrey,
                            ),
                            child: Image(
                              color: Colors.white,
                              fit: BoxFit.fill,
                              image: AssetImage(
                                  '${imgPathGeneral}ic_minus_icon.png'),
                              width: 15.0.scale(),
                              height: 15.0.scale(),
                            )).align(Alignment.centerLeft),
                      ).rightPadding(7.0.scale()),
                      Container(
                        child: Row(
                          children: [
                            AHorizontalSpace(4.0.scale()),
                            // AVerticalSeparatorLine(
                            //     width: 1,
                            //     height: 20.0.scale(),
                            //     color: kColorCommonButton),

                            Text(
                              ' ${_counter}',
                              style: textStyleBoldCustomLargeColor(
                                  _kMenuitemNameTextFontSize.scale(),
                                  Colors.white),
                            ),
                            AHorizontalSpace(5.0.scale()),
                            // AVerticalSeparatorLine(
                            //     width: 1,
                            //     height: 20,
                            //     color: kColorCommonButton),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (_counter <
                              int.parse(widget.productlist.quantity)) {
                            _counter++;
                            print(_counter);
                            setState(() {
                              price = double.parse(widget.productlist.price) *
                                  _counter;
                              String value = price.toStringAsFixed(2);
                              price = double.parse(value);
                            });
                          } else {
                            showSnackBar(
                                "Product available quantity is ${widget.productlist == null ? widget.productlist.quantity : widget.productlist.quantity}",
                                context);
                          }
                        },
                        child: Container(
                            padding: EdgeInsets.fromLTRB(
                                9.0.scale(), 0, 9.0.scale(), 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border:
                                  Border.all(color: KColorTextGrey, width: 3.0),
                              color: KColorTextGrey,
                            ),
                            child: Image(
                              color: Colors.white,
                              fit: BoxFit.fill,
                              width: 15.0.scale(),
                              height: 15.0.scale(),
                              image: AssetImage(
                                  '${imgPathGeneral}ic_add_icon.png'),
                            )).align(Alignment.centerLeft),
                      ).leftPadding(8.0.scale()),
                    ],
                  ),
                )
              ],
            ),
            AVerticalSpace(20.0.scale()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ARoundedButton(
                  btnBorderSideColor: kColorCommonButton,
                  btnDisabledColor: Color(0xFF5e6163),
                  btnIconSize: 15,
                  btnDisabledTextColor: Color(0xFFFFFFFF),
                  btnFontWeight: FontWeight.normal,
                  btnBgColor: kColorCommonButton,
                  btnTextColor: Colors.white,
                  btnOnPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    createNewMessage(contexttext);

                    BlocProvider.of<HomeBloc>(contexttext).add(
                        HomeEventItemClickAddToCartBtnClick(
                            _counter,
                            widget.productlist.id,
                            widget.productlist.vendorId,
                            0,
                            widget.driverDetail,
                            "0",
                            ""));
                  },
                  btnText: "Add to Cart",
                  btnHeight: kHeightBtnAddToCart.scale(),
                  btnWidth: 110.0.scale(),
                  btnFontSize: kFontSizeBtnLarge.scale(),
                  btnElevation: 0,
                ).align(Alignment.center),
                AVerticalSeparatorLine(
                    width: 1, height: 20, color: Colors.white),
                ARoundedButton(
                  btnBorderSideColor: kColorCommonButton,
                  btnDisabledColor: Color(0xFF5e6163),
                  btnIconSize: 15,
                  btnDisabledTextColor: Color(0xFFFFFFFF),
                  btnFontWeight: FontWeight.normal,
                  btnBgColor: kColorCommonButton,
                  btnTextColor: Colors.white,
                  btnOnPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  btnText: "Cancel",
                  btnHeight: kHeightBtnAddToCart.scale(),
                  btnWidth: 110.0.scale(),
                  btnFontSize: kFontSizeBtnLarge.scale(),
                  btnElevation: 0,
                ).align(Alignment.center),
              ],
            )
          ],
        ).leftPadding(14.0.scale()).rightPadding(14.0.scale())
      ]),
    );
  }
}

BuildContext? _contextLoad;

createNewMessage(BuildContext context) {
  _contextLoad = context;
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return WillPopScope(
              onWillPop: () {
                return Future.value(true);
              },
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ).align(Alignment.center).size(double.infinity, double.infinity));
        },
      );
    },
  );
}

class UserReviewList extends StatefulWidget {
  List<RatingReviewData> ratingReviewList;
  Function callLoadMore;

  UserReviewList(this.ratingReviewList, this.callLoadMore);

  @override
  State<UserReviewList> createState() => _UserReviewListState();
}

class _UserReviewListState extends State<UserReviewList> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        for (int i = 0; i < widget.ratingReviewList.length; i++)
          Column(
            children: [
              Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.ratingReviewList[i].profileImage!,
                    width: 60.0.scale(),
                    height: 40.0.scale(),
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                  AHorizontalSpace(14.0.scale()),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.ratingReviewList[i].name! +
                            " " +
                            widget.ratingReviewList[i].lname!,
                        style: textStyleBoldCustomColor(
                            14.0.scale(), KColorCommonText),
                      ),
                      RatingBar.builder(
                        initialRating:
                            double.parse(widget.ratingReviewList[i].rating!),
                        minRating: 1,
                        itemSize: 20,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      Text(
                        widget.ratingReviewList[i].review!,
                        style: textStyleBoldCustomColor(
                            14.0.scale(), KColorCommonText),
                        maxLines: 1,
                      ),
                      AVerticalSpace(4.0.scale()),
                      Text(
                        widget.ratingReviewList[i].createdAt!,
                        style: textStyleBoldCustomColor(
                            14.0.scale(), KColorCommonText),
                      ).align(Alignment.center),
                    ],
                  ),
                ],
              ),
              AVerticalSpace(8.0.scale()),
              ASeparatorLine(height: 1, color: KColorTextGrey),
              AVerticalSpace(8.0.scale()),
            ],
          ),
        GestureDetector(
          onTap: () {
            print("call");
            widget.callLoadMore();
          },
          child: Text(
            "view more",
            style: textStyleBoldCustomColor(18.0.scale(), Colors.blue),
          ),
        ).align(Alignment.bottomRight).rightPadding(8.0.scale()),
      ],
    );
  }
}
