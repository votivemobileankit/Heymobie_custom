import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grambunny_customer/components/a_widget_extensions.dart';
import 'package:grambunny_customer/utils/image_paths.dart';
import 'package:grambunny_customer/utils/ui_utils.dart';

import '../../components/a_header_back_button.dart';
import '../../components/a_horizontal_space.dart';
import '../../components/a_rounded_button.dart';
import '../../components/a_rounded_buttonimage.dart';
import '../../components/a_vertical_space.dart';
import '../../orderhistory/components/my_order_list_item.dart';
import '../../services/herbarium_cust_shared_preferences.dart';
import '../../side_navigation/bloc/side_navigat_bloc.dart';
import '../../side_navigation/bloc/side_navigat_event.dart';
import '../../theme/ft_theme_colors.dart';
import '../../theme/ft_theme_size_const.dart';
import '../../theme/ft_theme_styles.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../home_navigator.dart';
import '../model/driver_list_model.dart';
import '../model/product_list_model.dart';
import '../model/ps_list_model.dart';
import '../model/rating_review_list_model.dart';
import '../model/related_product_model.dart';
import '../model/statelist_reponse_model.dart';

bool timerOnListener = true;
BuildContext? _contextLoad;

class MenuRideDetailPage extends StatefulWidget {
  const MenuRideDetailPage({Key? key}) : super(key: key);

  @override
  _MenuRideDetailPageState createState() => _MenuRideDetailPageState();
}

class _MenuRideDetailPageState extends State<MenuRideDetailPage> {
  //TextEditingController textFiledPickUpAddress = TextEditingController();
  TextEditingController textFiledDropOffAddress = TextEditingController();
  TextEditingController _textFiledUserSpecialInstruction =
      TextEditingController();
  List<dynamic> _placeList = [];
  String? _cartCount;
  List<EventDetailsList> eventdetaillist = [];

  Position? _currentPosition;
  Position? _previousPosition;
  double? firstlat;
  double? firstlong;
  double? secondlat;
  double? secondlong;
  double? _totalDistance;
  double? metertomile;
  double? meter1 = 0;
  int? meter2 = 0;
  int? estimatedPrice1 = 0;

  double? estimatedPrice = 0;
  bool eventSelect = false;
  String distance = "";
  List<Position> locations = <Position>[];
  ProductListDriver? _productListDriverModel;
  Vendor? _vendorDetails;
  String? strScreen;
  String? vendorId;
  late List<AddonProductList> _addOnProductList;
  List<StatesList> stateArrayList = [];
  late List<RelatedProductList> _relatedProductList;

  String? _driverId;
  List<RatingReviewData>? ratingReviewList;
  DriverList? _driverDetail;
  String? name;
  int? productID;
  ProductListMenu? _productListModel;
  double _price = 0;
  String pick_address = "";
  String drop_address = "";

  String estimate_price = "";
  int qty = 1;

  int pageCount = 1;

  void showHideProgress(bool show) {
    BlocProvider.of<SideNavigatBloc>(context)
        .add(SideNavigationEventToggleLoadingAnimation(needToShow: show));
  }

  @override
  void initState() {
    print("TicketPrice===>");
    //
    // sharedPrefs.searchLocation = "";
    // sharedPrefs.searchDropLocation = "";
    // TODO: implement initState
    HomeState state = BlocProvider.of<HomeBloc>(context).state;
    if (state is HomeEventDriverRideListClickPageState) {
      eventdetaillist = state.eventdetaillist!;
      _driverId = eventdetaillist[0].vendorId;
      pick_address = sharedPrefs.searchLocation;
      drop_address = sharedPrefs.searchDropLocation;

      print("PicAdd===>${pick_address}");
      print("dropAdd===>${drop_address}");

      print("rateMile====>${eventdetaillist[0].rateMile}");
      print("price====>${eventdetaillist[0].price}");

      _productListDriverModel = state.driverProductList;
      _vendorDetails = state.vendor;
      strScreen = state.screen;
      _addOnProductList = state.addonProductlist;
      _relatedProductList = state.relatedproductList;
      _driverId = "${_vendorDetails?.vendorId}";
      ratingReviewList = state.ratingList;
      _driverDetail = DriverList(
        state: _vendorDetails!.state,
        city: _vendorDetails!.city,
        address: _vendorDetails!.address,
        vendorId: "${_vendorDetails!.vendorId}",
        type: _vendorDetails!.type,
        subCategoryId: _vendorDetails!.subCategoryId,
        categoryId: _vendorDetails!.categoryId,
        zipcode: _vendorDetails!.zipcode,
        profileImg1: _vendorDetails!.profileImg1,
        description: _vendorDetails!.description,
        address1: _vendorDetails!.address,
        mobNo: _vendorDetails!.mobNo,
        avgRating: _vendorDetails!.avgRating,
        deviceid: _vendorDetails!.deviceid,
        email: _vendorDetails!.email,
        username: _vendorDetails!.username,
        name: _vendorDetails!.name,
        lastName: _vendorDetails!.lastName,
        marketArea: _vendorDetails!.marketArea,
        vendorStatus: _vendorDetails!.vendorStatus,
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
        lng: "",
        txnId: '',
        type_of_merchant: '',
      );
      name = _driverDetail!.name + " " + _driverDetail!.lastName;
      productID = _productListDriverModel!.id;
      _productListModel = ProductListMenu(
          name: _productListDriverModel!.name,
          avgRating: _productListDriverModel!.avgRating,
          description: _productListDriverModel!.description,
          categoryId: _productListDriverModel!.categoryId,
          subCategoryId: _productListDriverModel!.subCategoryId,
          vendorId: _productListDriverModel!.vendorId,
          id: _productListDriverModel!.id,
          status: _productListDriverModel!.status,
          type: _productListDriverModel!.type,
          potencyThc: _productListDriverModel!.potencyThc,
          potencyCbd: _productListDriverModel!.potencyCbd,
          brands: _productListDriverModel!.brands,
          categoryname: _productListDriverModel!.categoryname,
          image: _productListDriverModel!.image,
          imageURL: _productListDriverModel!.imageURL,
          price: _productListDriverModel!.price,
          productCode: _productListDriverModel!.productCode,
          quantity: _productListDriverModel!.quantity,
          ratingCount: _productListDriverModel!.ratingCount,
          types: _productListDriverModel!.types,
          subcategoryname: _productListDriverModel!.subcategoryname,
          unit: _productListDriverModel!.unit,
          slug: '',
          createdAt: "",
          updatedAt: "",
          loginStatus: "",
          images: [],
          keyword: "",
          stock: "");
      _price = double.parse(_productListModel?.price ?? "");
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

  Future _calculateDistance() async {
    print("=========");
    List<Location> address1 =
        await locationFromAddress(sharedPrefs.searchLocation).then((value) {
      var first = value.first;
      firstlat = first.latitude;
      firstlong = first.longitude;

      print(first.latitude);
      print(first.longitude);

      return value;
    });

    List<Location> address2 =
        await locationFromAddress(sharedPrefs.searchDropLocation).then((value) {
      var second = value.first;
      secondlat = second.latitude;
      secondlong = second.longitude;

      print(second.latitude);
      print(second.longitude);
      var _distanceBetweenLastTwoLocations = Geolocator.distanceBetween(
        firstlat!,
        firstlong!,
        secondlat!,
        secondlong!,
      );
      _totalDistance = _distanceBetweenLastTwoLocations;
      print('Total Distance===> $_totalDistance');

      metertomile = _totalDistance! * 0.000621;
      String meter = metertomile!.toStringAsFixed(0);
      meter1 = double.parse(meter);
      meter2 = meter1?.round();
      print('Total Distance in int ===> $meter2');
      print('Total Distance in miles ===> $meter1');
      print('Total Distance in miles ===> $meter');
      distance = "${meter2}";
      estimate_price = "${estimatedPrice}";
      setState(() {
        estimatedPrice = double.parse(eventdetaillist[0].price!) +
            (double.parse(eventdetaillist[0].rateMile!) * double.parse(meter));

        estimatedPrice1 = estimatedPrice?.round();
        print("estimate price=====>${estimatedPrice1}");
      });

      print('Estimated price ===> $estimatedPrice');
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _cartCount = sharedPrefs.getCartCount;
    });

    return BlocListener<HomeBloc, HomeState>(
      listenWhen: (prevState, curState) => ModalRoute.of(context)!.isCurrent,
      listener: (context, state) {
        if (state is HomeCategoryProductPageState) {
          Navigator.of(context).pop(true);
        } else if (state is HomeInitial) {
          Navigator.of(context).pop(true);
        } else if (state is HomeMenuItemDetailsPageState) {
          _productListModel = state.productListModel;
          _driverId = state.driverId;
          print("driver Id ${_driverId}");
          _price = double.parse(_productListModel?.price ?? "");
          _driverDetail = state.driverDetail;
          name = _driverDetail!.name + " " + _driverDetail!.lastName;
        } else if (state is HomeFromDriverProductListDetailsPageState) {
          showHideProgress(false);
          setState(() {
            List<RatingReviewData> ratingReviewListData =
                state.ratingReviewList!;
            ratingReviewList!.addAll(ratingReviewListData);
            //ratingReviewList = state.ratingReviewList;
          });
          print("driver Id ${_driverId}");
          BlocProvider.of<HomeBloc>(context).add(
              HomeEventProductDetailPageReset(
                  _productListModel!, _driverId!, _driverDetail!));
        }
        if (state is HomeRideCheckOutPageState) {
          //showHideProgress(false);
          Navigator.of(context).pushNamed(HomeNavigator.homeRideCheckoutPage);
        }
        if (state is HomeRideLocationSearchPageState) {
          Navigator.of(context).pushNamed(HomeNavigator.homeRidelocationPage);
        }
      },
      child: SafeArea(
          bottom: false,
          child: Scaffold(
            body: Column(mainAxisSize: MainAxisSize.max, children: [
              AHeaderWidget(
                  strBackbuttonName: 'ic_red_btn_back.png',
                  backBtnVisibility: true,
                  btnBackOnPressed: () {
                    timerOnListener = false;
                    _contextLoad = null;
                    // BlocProvider.of<HomeBloc>(context)
                    //     .add(HomeEventBackBtnClick());
                    Navigator.pop(context);
                  },
                  strBtnRightImageName: 'ic_cart_white.png',
                  rightEditButtonVisibility: false,
                  headerSigninText: _cartCount!,
                  btnEditOnPressed: () {}),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  AVerticalSpace(10.0.scale()),
                  CachedNetworkImage(
                    imageUrl: eventdetaillist[0].imageURL!,
                    width: MediaQuery.of(context).size.width,
                    height: 200.0.scale(),
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ).topPadding(2.0.scale()),
                  AVerticalSpace(15.0.scale()),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 0.5, color: Colors.black54),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      // border color
                                      shape: BoxShape.circle,
                                    ),
                                  ).topPadding(3.0.scale()),
                                  Container(
                                    width: 1.5,
                                    height: 65,
                                    color: Colors.grey,
                                  ),
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      // border color
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ],
                              ).leftPadding(15.0.scale()),
                              AHorizontalSpace(10.0.scale()),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Pick Up Address*",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ).leftPadding(10.0.scale()),
                                      ],
                                    ),
                                    AVerticalSpace(5.0.scale()),
                                    Container(
                                        height: 45.0.scale(),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              5.0.scale()),
                                          border: Border.all(
                                              color: Colors.black,
                                              width: 1.0.scale()),
                                          color: Colors.white,
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            print("pickup====?");
                                            BlocProvider.of<HomeBloc>(context).add(
                                                HomeEventRideSearchTextFieldClick(
                                                    "Pickup"));
                                            // BlocProvider.of<HomeBloc>(context).add(
                                            //     HomeEevntLoctionSearchPageBtnClick());
                                          },
                                          child: Text(
                                            sharedPrefs.searchLocation,
                                            maxLines: 5,
                                            overflow: TextOverflow.ellipsis,
                                            style: textStyleCustomColor(
                                              14.0.scale(),
                                              Colors.black,
                                            ),
                                          )
                                              .leftPadding(10.0.scale())
                                              .align(Alignment.centerLeft),
                                        )),
                                    AVerticalSpace(10.0.scale()),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Drop Off Address*",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ).leftPadding(10.0.scale()),
                                      ],
                                    ),
                                    AVerticalSpace(5.0.scale()),
                                    Container(
                                        height: 45.0.scale(),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              5.0.scale()),
                                          border: Border.all(
                                              color: Colors.black,
                                              width: 1.0.scale()),
                                          color: Colors.white,
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            print("Droplocation====?");
                                            BlocProvider.of<HomeBloc>(context).add(
                                                HomeEventRideSearchTextFieldClick(
                                                    "Drop"));
                                          },
                                          child: Text(
                                            sharedPrefs.searchDropLocation,
                                            maxLines: 5,
                                            overflow: TextOverflow.ellipsis,
                                            style: textStyleCustomColor(
                                              14.0.scale(),
                                              Colors.black,
                                            ),
                                          )
                                              .leftPadding(10.0.scale())
                                              .align(Alignment.centerLeft),
                                        )),
                                    Row(
                                      children: [
                                        ARoundedButton(
                                          btnBgColor: kColorCommonButton,
                                          btnTextColor: Colors.white,
                                          btnOnPressed: () {
                                            _calculateDistance();
                                          },
                                          btnText: "Estimated Price",
                                          btnHeight:
                                              kHeightBtnAddToCart.scale(),
                                          btnWidth: 140.0.scale(),
                                          btnFontSize:
                                              kFontSizeBtnLarge.scale(),
                                          btnElevation: 0,
                                          btnBorderSideColor:
                                              kColorCommonButton,
                                        )
                                            .align(Alignment.centerLeft)
                                            .topPadding(10.0.scale()),
                                        AHorizontalSpace(10.0.scale()),
                                        // if (eventSelect == true)
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Text(
                                                "Estimated Price:",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              AHorizontalSpace(5.0.scale()),
                                              Expanded(
                                                child: Text(
                                                    "\$${estimatedPrice1}",
                                                    maxLines: 5,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    AVerticalSpace(20.0.scale()),
                                  ],
                                ).rightPadding(10.0.scale()),
                              )
                            ]).topPadding(10.0.scale()),
                        Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Container(
                                  height: 70,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: const Offset(
                                          0.0,
                                          0.0,
                                        ),
                                        blurRadius: 1.0,
                                        spreadRadius: 1.0,
                                      ), //BoxShadow
                                      BoxShadow(
                                        color: Colors.white,
                                        offset: const Offset(0.0, 0.0),
                                        blurRadius: 1.0,
                                        spreadRadius: 1.0,
                                      ), //BoxShadow
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Base Fee",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      )
                                          .leftPadding(5.0.scale())
                                          .topPadding(10.0.scale()),
                                      AVerticalSpace(5.0.scale()),
                                      Container(
                                        height: 30,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              width: 1, color: Colors.grey),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              offset: const Offset(
                                                0.0,
                                                0.0,
                                              ),
                                              blurRadius: 2.0,
                                              spreadRadius: 0.0,
                                            ), //BoxShadow
                                            BoxShadow(
                                              color: Colors.white,
                                              offset: const Offset(0.0, 0.0),
                                              blurRadius: 1.0,
                                              spreadRadius: 0.0,
                                            ), //BoxShadow
                                          ],
                                        ),
                                        child: Text(
                                                "\$${eventdetaillist[0].price}",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.bold))
                                            .align(Alignment.center),
                                      ),
                                    ],
                                  )),
                              AHorizontalSpace(10.0.scale()),
                              // Container(
                              //     height: 70,
                              //     width: 100,
                              //     decoration: BoxDecoration(
                              //       color: Colors.white,
                              //       borderRadius: BorderRadius.circular(10),
                              //       border: Border.all(color: Colors.grey),
                              //       boxShadow: [
                              //         BoxShadow(
                              //           color: Colors.grey,
                              //           offset: const Offset(
                              //             0.0,
                              //             0.0,
                              //           ),
                              //           blurRadius: 1.0,
                              //           spreadRadius: 1.0,
                              //         ), //BoxShadow
                              //         BoxShadow(
                              //           color: Colors.white,
                              //           offset: const Offset(0.0, 0.0),
                              //           blurRadius: 1.0,
                              //           spreadRadius: 1.0,
                              //         ), //BoxShadow
                              //       ],
                              //     ),
                              //     child: Column(
                              //       children: [
                              //         Text(
                              //           "Rate/Minute",
                              //           overflow: TextOverflow.ellipsis,
                              //           style: TextStyle(
                              //               color: Colors.black,
                              //               fontSize: 14,
                              //               fontWeight: FontWeight.bold),
                              //         )
                              //             .leftPadding(5.0.scale())
                              //             .topPadding(10.0.scale()),
                              //         AVerticalSpace(5.0.scale()),
                              //         Container(
                              //           height: 30,
                              //           width: 60,
                              //           decoration: BoxDecoration(
                              //             color: Colors.white,
                              //             borderRadius:
                              //                 BorderRadius.circular(15),
                              //             border: Border.all(
                              //                 width: 1, color: Colors.grey),
                              //             boxShadow: [
                              //               BoxShadow(
                              //                 color: Colors.grey,
                              //                 offset: const Offset(
                              //                   0.0,
                              //                   0.0,
                              //                 ),
                              //                 blurRadius: 2.0,
                              //                 spreadRadius: 0.0,
                              //               ), //BoxShadow
                              //               BoxShadow(
                              //                 color: Colors.white,
                              //                 offset: const Offset(0.0, 0.0),
                              //                 blurRadius: 1.0,
                              //                 spreadRadius: 0.0,
                              //               ), //BoxShadow
                              //             ],
                              //           ),
                              //           child: Text(
                              //                   "\$${eventdetaillist[0].rateMinute}",
                              //                   maxLines: 1,
                              //                   overflow: TextOverflow.ellipsis,
                              //                   style: TextStyle(
                              //                       color: Colors.black54,
                              //                       fontSize: 10,
                              //                       fontWeight:
                              //                           FontWeight.bold))
                              //               .align(Alignment.center),
                              //         ),
                              //       ],
                              //     )),
                              AHorizontalSpace(10.0.scale()),
                              Container(
                                  height: 70,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: const Offset(
                                          0.0,
                                          0.0,
                                        ),
                                        blurRadius: 1.0,
                                        spreadRadius: 1.0,
                                      ), //BoxShadow
                                      BoxShadow(
                                        color: Colors.white,
                                        offset: const Offset(0.0, 0.0),
                                        blurRadius: 1.0,
                                        spreadRadius: 1.0,
                                      ), //BoxShadow
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Rate/Mile",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      )
                                          .leftPadding(5.0.scale())
                                          .topPadding(10.0.scale()),
                                      AVerticalSpace(5.0.scale()),
                                      Container(
                                        height: 30,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              width: 1, color: Colors.grey),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              offset: const Offset(
                                                0.0,
                                                0.0,
                                              ),
                                              blurRadius: 2.0,
                                              spreadRadius: 0.0,
                                            ), //BoxShadow
                                            BoxShadow(
                                              color: Colors.white,
                                              offset: const Offset(0.0, 0.0),
                                              blurRadius: 1.0,
                                              spreadRadius: 0.0,
                                            ), //BoxShadow
                                          ],
                                        ),
                                        child: Text(
                                                "\$${eventdetaillist[0].rateMile}",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.bold))
                                            .align(Alignment.center),
                                      ),
                                    ],
                                  ))
                            ])
                            .leftPadding(10.0.scale())
                            .rightPadding(10.0.scale())
                            .topPadding(5.0.scale()),
                        AVerticalSpace(10.0.scale()),
                        Text(
                          "Distance:  ${meter2} (Miles)",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ).align(Alignment.centerLeft).leftPadding(10.0.scale()),
                        AVerticalSpace(15.0.scale()),
                        Container(
                                height: 30,
                                width: 170,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius:
                                      BorderRadius.circular(15.0.scale()),
                                ),
                                child: Text(
                                  "Car Information",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ).align(Alignment.center))
                            .leftPadding(10.0.scale()),
                        AVerticalSpace(15.0.scale()),
                        Row(
                          children: [
                            Image.asset(
                              "${imgPathGeneral}ic_ride.png",
                              color: Colors.black,
                            ).leftPadding(10.0.scale()),
                            Text(
                              "Test Description",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ).leftPadding(5.0.scale()),
                          ],
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  // Image.asset(
                                  //   "${imgPathGeneral}ic_ride.png",
                                  //   color: Colors.purple,
                                  // ),
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      // border color
                                      shape: BoxShape.circle,
                                    ),
                                  ).topPadding(3.0.scale()),
                                  Container(
                                    width: 2,
                                    height: 20,
                                    color: Colors.grey,
                                  ),
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      // border color
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Container(
                                    width: 2,
                                    height: 20,
                                    color: Colors.grey,
                                  ),
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      // border color
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Container(
                                    width: 2,
                                    height: 20,
                                    color: Colors.grey,
                                  ),
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      // border color
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ],
                              ).leftPadding(15.0.scale()),
                              AHorizontalSpace(10.0.scale()),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Make :",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ).leftPadding(10.0.scale()),
                                        Container(
                                          height: 20,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                                width: 1, color: Colors.grey),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey,
                                                offset: const Offset(
                                                  0.0,
                                                  0.0,
                                                ),
                                                blurRadius: 2.0,
                                                spreadRadius: 0.0,
                                              ), //BoxShadow
                                              BoxShadow(
                                                color: Colors.white,
                                                offset: const Offset(0.0, 0.0),
                                                blurRadius: 1.0,
                                                spreadRadius: 0.0,
                                              ), //BoxShadow
                                            ],
                                          ),
                                          child: Text(
                                                  "${eventdetaillist[0].vendor?.make}",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold))
                                              .align(Alignment.center),
                                        ),
                                      ],
                                    ),
                                    AVerticalSpace(10.0.scale()),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Model",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ).leftPadding(10.0.scale()),
                                        Container(
                                          height: 20,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                                width: 1, color: Colors.grey),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey,
                                                offset: const Offset(
                                                  0.0,
                                                  0.0,
                                                ),
                                                blurRadius: 2.0,
                                                spreadRadius: 0.0,
                                              ), //BoxShadow
                                              BoxShadow(
                                                color: Colors.white,
                                                offset: const Offset(0.0, 0.0),
                                                blurRadius: 1.0,
                                                spreadRadius: 0.0,
                                              ), //BoxShadow
                                            ],
                                          ),
                                          child: Text(
                                                  "${eventdetaillist[0].vendor?.model}",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold))
                                              .align(Alignment.center),
                                        ),
                                      ],
                                    ),
                                    AVerticalSpace(12.0.scale()),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Color :",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ).leftPadding(10.0.scale()),
                                        Container(
                                          height: 20,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                                width: 1, color: Colors.grey),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey,
                                                offset: const Offset(
                                                  0.0,
                                                  0.0,
                                                ),
                                                blurRadius: 2.0,
                                                spreadRadius: 0.0,
                                              ), //BoxShadow
                                              BoxShadow(
                                                color: Colors.white,
                                                offset: const Offset(0.0, 0.0),
                                                blurRadius: 1.0,
                                                spreadRadius: 0.0,
                                              ), //BoxShadow
                                            ],
                                          ),
                                          child: Text(
                                                  "${eventdetaillist[0].vendor?.color}",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold))
                                              .align(Alignment.center),
                                        ),
                                      ],
                                    ),
                                    AVerticalSpace(12.0.scale()),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "License Plate Number : ",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ).leftPadding(10.0.scale()),
                                        Container(
                                          height: 20,
                                          width: 90,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                                width: 1, color: Colors.grey),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey,
                                                offset: const Offset(
                                                  0.0,
                                                  0.0,
                                                ),
                                                blurRadius: 2.0,
                                                spreadRadius: 0.0,
                                              ), //BoxShadow
                                              BoxShadow(
                                                color: Colors.white,
                                                offset: const Offset(0.0, 0.0),
                                                blurRadius: 1.0,
                                                spreadRadius: 0.0,
                                              ), //BoxShadow
                                            ],
                                          ),
                                          child: Text(
                                                  "${eventdetaillist[0].vendor?.licensePlate}",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold))
                                              .align(Alignment.center),
                                        ),
                                      ],
                                    ),
                                    AVerticalSpace(20.0.scale()),
                                  ],
                                ).rightPadding(10.0.scale()),
                              )
                            ]).topPadding(10.0.scale()),
                        AVerticalSpace(10.0.scale()),
                      ],
                    ),
                  ),
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
                  AVerticalSpace(15.0.scale()),
                  ARoundedButtonImage(
                    btnBgColor: kColorCommonButton,
                    btnTextColor: Colors.white,
                    btnOnPressed: () {
                      print("Distance===>${distance}");
                      print("Price===>${estimate_price}");
                      BlocProvider.of<HomeBloc>(context)
                          .add(HomeEventRideBookRideNowBtnClick(
                        qty,
                        eventdetaillist[0].id,
                        eventdetaillist[0].vendorId!,
                        "0",
                        _textFiledUserSpecialInstruction.text,
                        pick_address,
                        drop_address,
                        distance,
                        estimate_price,
                        _driverDetail!,
                        _productListModel!,
                      ));
                    },
                    btnText: "Book Ride Now",
                    btnHeight: kHeightBtnAddToCart.scale(),
                    btnWidth: 160.0.scale(),
                    btnFontSize: kFontSizeBtnLarge.scale(),
                    btnElevation: 0,
                    btnBorderSideColor: kColorCommonButton,
                    btnIconImagePath: '${imgPathGeneral}ic_cart_white.png',
                    btnIconData: ImageIcon(AssetImage('')),
                    btnDisabledColor: kColorCommonButton,
                    btnDisabledTextColor: kColorCommonButton,
                  ).align(Alignment.centerLeft),
                  AVerticalSpace(20.0.scale())
                ],
              )
                  .leftPadding(8.0.scale())
                  .rightPadding(8.0.scale())
                  .scroll()
                  .expand()
            ]).widgetBgColor(Colors.white),
          )).pageBgColor(kColorAppBgColor),
    );
  }
}
