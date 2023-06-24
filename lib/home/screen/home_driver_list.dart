import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';

//import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grambunny_customer/components/components.dart';
import 'package:grambunny_customer/home/bloc/bloc.dart';
import 'package:grambunny_customer/home/home.dart';
import 'package:grambunny_customer/services/services.dart';
import 'package:grambunny_customer/side_navigation/bloc/bloc.dart';
import 'package:grambunny_customer/theme/theme.dart';
import 'package:grambunny_customer/utils/ui_utils.dart';
import 'package:grambunny_customer/utils/utils.dart';

import '../model/driver_list_model.dart';
import '../model/ps_list_model.dart';

const double _kBtnWidth = 89.0;
const double _kHeightNormal = 35.0;
const double _kMenuitemNameTextFontSize = 16.0;

late List<DriverList> driverInfoList;
late List<ProductListDriver> driverProductList;
late List<Advertisement> advertisementArray;
late List<BitmapDescriptor> pinLocationIcon;
LatLng? pinPosition;
String? merchant_id;
String? ps_id;
String? type;
List<EventDetailsList> eventdetaillist = [];
CameraPosition _kGooglePlex = CameraPosition(
  target: LatLng(33.974514956322324, -117.77841125765117),
  zoom: 14.4746,
);
double Zoom = 9;
late BuildContext _dialogContext;
bool _dialogDriverOpen = true;

class HomeDriverListPage extends StatefulWidget {
  @override
  _HomeDriverListPageState createState() => _HomeDriverListPageState();
}

class _HomeDriverListPageState extends State<HomeDriverListPage>
    with WidgetsBindingObserver {
  Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController _cameraController;
  bool isListView = true;
  bool ontimeCall = false;
  double currentLat = 22.7196, currentLong = 75.8577;

  late double searchLat, searchLong;
  Set<Marker> _markers = {};
  late BitmapDescriptor pinLocationIcon;
  late BitmapDescriptor pinLocationIcon1;
  late CustomInfoWindowController _customInfoWindowController;
  String cartCountValue = "0";

  String bannerImage = "";
  late List<BitmapDescriptor> pinLocationImageMapArray;

  loadDriverData() {}

  @override
  void initState() {
    // TODO: implement initState
    showHideProgress(true);
    _customInfoWindowController = CustomInfoWindowController();
    moveCameraAsync();

    driverInfoList = [];
    driverProductList = [];
    advertisementArray = [];
    driverInfoList.add(new DriverList(
        name: "",
        username: "",
        lastName: "",
        lat: "33.974514956322324",
        lng: "-117.77841125765117",
        profileImg1:
            "https://news.artnet.com/app/news-upload/2016/04/Lemon-Kush-oakland-museum.jpg",
        address1: "",
        address: "",
        avgRating: "",
        businessName: "",
        categoryId: "",
        city: "",
        cityTax: "",
        color: "",
        commissionRate: "",
        createdAt: "",
        deliveryFee: "",
        description: "",
        deviceid: "",
        devicetype: "",
        distance: "",
        dob: "",
        driverLicense: "",
        email: "",
        exciseTax: "",
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
        marketArea: "",
        mobNo: "",
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
        ratingCount: "",
        rememberToken: "",
        salesTax: "",
        service: "",
        serviceRadius: "",
        ssn: "",
        state: "",
        stripeId: "",
        subCategoryId: "",
        suburb: "",
        txnId: "",
        type: "",
        uniqueId: "",
        updatedAt: "",
        vendorId: "",
        vendorStatus: "",
        vendorType: "",
        views: "",
        walletAmount: "",
        year: "",
        zipcode: ""));

    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: 200), () {
        getLocation();
        // updateLocation();
      });
    });

    super.initState();
  }

  void driverListCall(double currentLat, double currentLong) {
    showHideProgress(true);
    BlocProvider.of<HomeBloc>(context).add(
        HomeEventDriverListApiCallLoading(currentLat, currentLong, "", ""));
  }

  void showHideProgress(bool show) {
    BlocProvider.of<SideNavigatBloc>(context)
        .add(SideNavigationEventToggleLoadingAnimation(needToShow: show));
  }

  Future<void> handleDeniedLocationPermission() async {
    LocationPermission permissionAfterRequest =
        await Geolocator.requestPermission();
    switch (permissionAfterRequest) {
      case LocationPermission.whileInUse:
      case LocationPermission.always:
        await updateLocation();
        break;
      case LocationPermission.denied:
        if (Platform.isIOS) {
          await handleDeniedForeverLocationPermission();
        }
        break;
      case LocationPermission.deniedForever:
        await handleDeniedForeverLocationPermission();
        break;
      case LocationPermission.unableToDetermine:
        // TODO: Handle this case.
        break;
    }
  }

  Future<void> updateLocation() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        _dialogContext = context;
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AVerticalSpace(25.0.scale()),
              new CircularProgressIndicator(
                color: Colors.black45,
              ),
              AVerticalSpace(12.0.scale()),
              new Text("Searching for drivers closest to you!",
                      style: textStyleCustomColor(14.0.scale(), Colors.black))
                  .leftPadding(8.0.scale())
                  .rightPadding(8.0.scale()),
              AVerticalSpace(25.0.scale()),
            ],
          ).widgetBgColor(Colors.white),
        );
      },
    );
    bool locationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (locationServiceEnabled) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print("Location enabled ${position.latitude}${position.longitude}");
      currentLat = position.latitude;
      currentLong = position.longitude;
      driverListCall(currentLat, currentLong);
    } else {
      print("Location enabled not ======");
      driverListCall(currentLat, currentLong);
    }
  }

  Future<void> handleBackGroundcall() async {
    bool locationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (locationServiceEnabled) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print("Location enabled ${position.latitude}${position.longitude}");
      currentLat = position.latitude;
      currentLong = position.longitude;
      BlocProvider.of<HomeBloc>(context).add(HomeEventDriverListApiCallLoading(
          currentLat, currentLong, strCity, strProduct));
    } else {
      BlocProvider.of<HomeBloc>(context).add(HomeEventDriverListApiCallLoading(
          currentLat, currentLong, strCity, strProduct));
    }
  }

  Future<void> handleDeniedForeverLocationPermission() async {}

  Future<void> getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    switch (permission) {
      case LocationPermission.whileInUse:
      case LocationPermission.always:
        await updateLocation();
        break;
      case LocationPermission.denied:
        await handleDeniedLocationPermission();
        break;
      case LocationPermission.deniedForever:
        await handleDeniedForeverLocationPermission();
        break;
    }
  }

  Future<void> _markerPositionWidget(List<DriverList> driverInfoList,
      List<BitmapDescriptor> pinLocationImageMapArray) async {
    // if (pinLocationIcon == null) {
    //   await setCustomMapPin();
    // }
    // if (pinLocationIcon == null) {
    //   await setCustomMapPin1();
    // }
    setState(() {
      _markers.clear();
      for (int i = 0; i < driverInfoList.length; i++) {
        if (driverInfoList[i].lat != 0) {
          _markers.add(Marker(
              markerId: MarkerId("$i"),
              onTap: () {
                isTimerOn = false;
                _timer?.cancel();
                DriverList driverDetail = driverInfoList[i];
                print(driverInfoList[i].vendorId);
                BlocProvider.of<HomeBloc>(context)
                    .add(HomeEventDriverItemClick(driverDetail));
              },
              position: LatLng(double.parse(driverInfoList[i].lat!),
                  double.parse(driverInfoList[i].lng!)),
              icon: pinLocationImageMapArray[i]));
        }
      }
    });
  }

  Future<void> setCustomMapPin1() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: effectivePixelRatio()),
        '${imgPathGeneral}ic_marker_driver.png');
    print("created pin icon");
  }

  CameraPosition markerCenterPoint(double lat, double lon) {
    pinPosition = LatLng(lat, lon);
    _kGooglePlex = CameraPosition(target: pinPosition!, zoom: Zoom);
    CameraUpdate update = CameraUpdate.newCameraPosition(_kGooglePlex);

    _cameraController.animateCamera(update);

    return _kGooglePlex;
  }

  Future<void> moveCamera(double lat, double long) async {
    setState(() {
      _kGooglePlex = CameraPosition(target: new LatLng(lat, long), zoom: Zoom);

      CameraUpdate update = CameraUpdate.newCameraPosition(_kGooglePlex);
      _cameraController.animateCamera(update);
    });
  }

  Future<void> moveCameraAsync() async {
    _cameraController = await _controller.future;
  }

  findAddres(String search) async {
    print("Search =======: $search");
    List<Location>? address = await locationFromAddress(search).then((value) {
      var first = value.first;
      print("========== ${first.latitude},${first.longitude}");
      setState(() {
        if (first.latitude != null) {
          searchLat = first.latitude;
          searchLong = first.longitude;
          _kGooglePlex = CameraPosition(
              target: new LatLng(first.latitude, first.longitude), zoom: Zoom);

          CameraUpdate update = CameraUpdate.newCameraPosition(_kGooglePlex);
          _cameraController.animateCamera(update);
        }
      });
    }, onError: () {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    setState(() {
      cartCountValue = sharedPrefs.getCartCount;
      moveCameraAsync();
    });
    if (timerOnListener == false) {
      timerOnListener = true;
      print("call timer after back =====");
      _timer = Timer.periodic(Duration(seconds: 40), (_timer) {
        setState(() {
          handleBackGroundcall();
          // BlocProvider.of<HomeBloc>(context).add(
          //     HomeEventDriverListApiCallLoading(
          //         currentLat, currentLong, strCity, strProduct));
        });
      });
    }
    return BlocListener<HomeBloc, HomeState>(
      listenWhen: (prevState, curState) => ModalRoute.of(context)!.isCurrent,
      listener: (context, state) {
        //  print("state  ${state}");
        if (state is HomeFromDriverListCartPageState) {
          showHideProgress(false);
          Navigator.of(context).pushNamed(HomeNavigator.homeShowCartPage);
        }
        if (state is LoginPageState) {
          Navigator.of(context).pushNamed(HomeNavigator.loginPage);
        }
        if (state is HomeSettingPageState) {
          Navigator.of(context).pushNamed(HomeNavigator.homeSettingPage);
        }
        if (state is HomeCategoryListLoadingProgressState) {
          showHideProgress(true);
          BlocProvider.of<HomeBloc>(context)
              .add(HomeEventCategoryListLoadingComplete(state.driverDetail));
        }
        if (state is HomeFromDriverProductListDetailsPageState) {
          showHideProgress(false);
          Navigator.of(context).pushNamed(HomeNavigator.homeMenuDetailPage);
        }

        if (state is HomeEventDriverTicketListClickPageState) {
          showHideProgress(false);
          Navigator.of(context).pushNamed(HomeNavigator.homeMenuTicketPage);
        }

        if (state is HomeDriverListApiCallCompleteState) {
          if (_dialogDriverOpen == true) {
            _dialogDriverOpen = false;
            print("Dismiss=======");
            Navigator.pop(_dialogContext);
          } else {
            try {
              Navigator.pop(_dialogContext);
            } catch (e) {}
          }

          showHideProgress(false);
          setState(() {
            driverInfoList.clear();
            driverInfoList = [];
            driverProductList.clear();
            driverProductList = [];
            pinLocationImageMapArray = [];
            //advertisementArray.clear();
            //advertisementArray = [];
            driverInfoList = state.driverListArray;
            cartCountValue = state.updatedCartCount;
            driverProductList = state.driverProductListArray;
            advertisementArray = state.advertisementArray;
            bannerImage = state.bannerImage;
            pinLocationImageMapArray = state.pinLocationList;
            if (ontimeCall) {
              _markerPositionWidget(driverInfoList, pinLocationImageMapArray);
              searchLat = double.parse(driverInfoList[0].lat!);
              searchLong = double.parse(driverInfoList[0].lng!);
              moveCamera(double.parse(driverInfoList[0].lat!),
                  double.parse(driverInfoList[0].lng!));
            } else {
              isListView = false;
            }
            ontimeCall = true;

            print("in api call");
          });
        }

        if (state is HomeCategoryListPageState) {
          print("call state");
          showHideProgress(false);
          Navigator.of(context).pushNamed(HomeNavigator.homeCategoryListPage);
        }
        if (state is HomeEventErrorHandelState) {
          showHideProgress(false);
          if (_dialogDriverOpen == true) {
            _dialogDriverOpen = false;
            print("Dismiss=======");
            Navigator.pop(_dialogContext);
          }
          setState(() {
            if (strCity != "" && strCity != null) {
              findAddres(strCity);
            }
            isListView = false;
          });
          if (state.message == "data not found") {
            setState(() {
              driverProductList = [];
              driverInfoList = [];
              pinLocationImageMapArray = [];
              _markerPositionWidget(driverInfoList, pinLocationImageMapArray);
            });
          } else if (state.message == "Something went wrong") {
            setState(() {
              driverInfoList = [];
              driverProductList = [];
              pinLocationImageMapArray = [];
              _markerPositionWidget(driverInfoList, pinLocationImageMapArray);
            });
          }
          showSnackBar(state.message, context);
          BlocProvider.of<HomeBloc>(context).add(HomeEventDriverPageReset());
        }
        if (state is HomeEventDataNotFoundState) {
          showHideProgress(false);
          if (_dialogDriverOpen == true) {
            _dialogDriverOpen = false;
            print("Dismiss=======");
            Navigator.pop(_dialogContext);
          }
          setState(() {
            if (strCity != "" && strCity != null) {
              findAddres(strCity);
            }
            isListView = false;
          });
          if (state.message == "data not found") {
            setState(() {
              driverProductList = [];
              driverInfoList = [];
              pinLocationImageMapArray = [];
              advertisementArray = state.advertisementArray;
              _markerPositionWidget(driverInfoList, pinLocationImageMapArray);
            });
          }
          showSnackBar(state.message, context);
          BlocProvider.of<HomeBloc>(context).add(HomeEventDriverPageReset());
        }
      },
      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            AHeaderWidget(
              strBackbuttonName: 'ic_slide_menu_icon.png',
              backBtnVisibility: true,
              btnBackOnPressed: () {
                if (_timer != null) {
                  _timer?.cancel();
                }
                Scaffold.of(context).openDrawer();
              },
              headerSigninText: sharedPrefs.isLogin == false
                  ? "Sign In"
                  : sharedPrefs.getUserName,
              strBtnRightImageName: 'ic_profile_user.png',
              rightEditButtonVisibility: true,
              btnEditOnPressed: () {
                if (sharedPrefs.isLogin == false) {
                  if (_timer != null) {
                    _timer?.cancel();
                  }
                  isTimerOn = false;
                  BlocProvider.of<HomeBloc>(context)
                      .add(LoginEventSignInButtonClick());
                } else {}
              },
            ),
            ASeparatorLine(height: .50.scale(), color: Colors.white),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (bannerImage != null)
                  ClipRRect(
                    child: CachedNetworkImage(
                      width: MediaQuery.of(context).size.width,
                      height: 150.0.scale(),
                      imageUrl: bannerImage,
                      fit: BoxFit.fill,
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error),
                    ),
                  ).align(Alignment.center),
                Container(
                  color: KColorAppThemeColor,
                  height: 50.0.scale(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (driverInfoList.length == 0)
                        Text(
                          '${0} Driver${"'"}s Found in Your Area',
                          style:
                              textStyleCustomColor(16.0.scale(), Colors.white),
                        )
                      else
                        Text(
                          '${driverInfoList.length} Driver${"'"}s Found in Your Area',
                          style:
                              textStyleCustomColor(16.0.scale(), Colors.white),
                        ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                isListView = true;
                                _timer?.cancel();
                              });
                            },
                            child: isListView == true
                                ? Image(
                                    image: AssetImage(
                                        '${imgPathGeneral}ic_list_driver_icon.png'),
                                    color: Colors.white,
                                    height: 20.0.scale(),
                                    width: 20.0.scale(),
                                  ).align(Alignment.center)
                                : Image(
                                    image: AssetImage(
                                        '${imgPathGeneral}ic_list_driver_white_icon.png'),
                                    color: KColorTextGrey,
                                    height: 20.0.scale(),
                                    width: 20.0.scale(),
                                  ).align(Alignment.center),
                          ),
                          AHorizontalSpace(5.0.scale()),
                          InkWell(
                            onTap: () {
                              setState(() {
                                isListView = false;
                                BlocProvider.of<HomeBloc>(context)
                                    .add(HomeEventDriverPageReset());
                                _markerPositionWidget(
                                    driverInfoList, pinLocationImageMapArray);
                                if (driverInfoList != null)
                                  moveCamera(
                                      double.parse(driverInfoList[0].lat!),
                                      double.parse(driverInfoList[0].lng!));
                              });
                            },
                            child: isListView == false
                                ? Image(
                                    image: AssetImage(
                                        '${imgPathGeneral}ic_map_driver_icon.png'),
                                    color: Colors.white,
                                    height: 25.0.scale(),
                                    width: 25.0.scale(),
                                  ).align(Alignment.center)
                                : Image(
                                    image: AssetImage(
                                        '${imgPathGeneral}ic_map_driver_white_icon.png'),
                                    color: KColorTextGrey,
                                    height: 25.0.scale(),
                                    width: 25.0.scale(),
                                  ).align(Alignment.center),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Visibility(
                        visible: isListView == false ? true : false,
                        child: Container(
                          height: 360.0.scale(),
                          child: Stack(
                            children: [
                              GoogleMap(
                                onTap: (position) {
                                  // widget.customInfoWindowController.hideInfoWindow();
                                },
                                onCameraMove: (position) {
                                  // _customInfoWindowController.onCameraMove();
                                },
                                gestureRecognizers: Set()
                                  ..add(Factory<EagerGestureRecognizer>(
                                      () => EagerGestureRecognizer())),
                                zoomControlsEnabled: false,
                                zoomGesturesEnabled: true,
                                scrollGesturesEnabled: true,
                                myLocationButtonEnabled: false,
                                myLocationEnabled: pinPosition != null,
                                compassEnabled: false,
                                markers: _markers,
                                mapType: MapType.normal,
                                initialCameraPosition: _kGooglePlex,
                                onMapCreated: (GoogleMapController controller) {
                                  // if (oneTimeCall) {
                                  // _controller.complete(controller);
                                  //  oneTimeCall = false;
                                  // }

                                  _customInfoWindowController
                                      .googleMapController = controller;
                                  _cameraController = controller;

                                  setState(() {
                                    print("=====  in reset widget ");
                                    if (strCity == "") {
                                      markerCenterPoint(
                                          currentLat, currentLong);
                                    } else {
                                      markerCenterPoint(searchLat, searchLong);
                                    }

                                    _markerPositionWidget(driverInfoList,
                                        pinLocationImageMapArray);
                                  });
                                },
                              ),
                              // _SearchWidget(currentLat, currentLong,
                              //     _cameraController, _controller, isListView),
                            ],
                          ),
                        )),
                    AVerticalSpace(5.0.scale()),
                    if (driverInfoList != null)
                      if (driverInfoList.isNotEmpty)
                        Visibility(
                          visible: isListView == true ? true : false,
                          child: Column(children: [
                            // _SearchWidget(currentLat, currentLong,
                            //     _cameraController, _controller, isListView),
                            if (driverInfoList != null)
                              _DriverHorizontalList(driverInfoList)
                                  .align(Alignment.centerLeft)
                          ]),
                        ),
                    AVerticalSpace(12.0.scale()),
                    if (isListView == true)
                      if (advertisementArray != null &&
                          advertisementArray.isNotEmpty)
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 100.0.scale(),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: CachedNetworkImage(
                                  imageUrl: advertisementArray[0].url! +
                                      advertisementArray[0].image!,
                                  fit: BoxFit.fill,
                                  errorWidget: (context, url, error) =>
                                      new Icon(Icons.error),
                                ),
                              ),
                            )
                                .leftPadding(10.0.scale())
                                .rightPadding(10.0.scale()),
                            AVerticalSpace(6.0.scale()),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 100.0.scale(),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: CachedNetworkImage(
                                  imageUrl: advertisementArray[1].url! +
                                      advertisementArray[1].image!,
                                  fit: BoxFit.fill,
                                  errorWidget: (context, url, error) =>
                                      new Icon(Icons.error),
                                ),
                              ),
                            )
                                .leftPadding(10.0.scale())
                                .rightPadding(10.0.scale())
                          ],
                        ),
                    AVerticalSpace(12.0.scale()),
                    if (driverProductList.length == 0) _NoProductFoundWidget(),
                    if (driverProductList != null ||
                        driverProductList.length > 0)
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          _GridProductListWidget(
                              driverProductList, showHideProgress),
                        ],
                      )
                  ],
                )
              ],
            ).scroll().expand()
          ],
        ).widgetBgColor(Colors.white),
      ).lightStatusBarText(),
    ).pageBgColor(kColorAppBgColor);
  }
}

const double _kButtonNextWidth = 102;
const double _kHeightBtnAddToCart = 35.0;

class _DriverHorizontalList extends StatelessWidget {
  List<DriverList> driverInfoData;

  _DriverHorizontalList(this.driverInfoData);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      height: 150.0.scale(),
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: driverInfoData.length,
        itemBuilder: (BuildContext context, int index) => Container(
          width: 175.0.scale(),
          // decoration: BoxDecoration(
          //   border: Border.all(color: Colors.white, width: 2.0),
          //   color: Colors.white,
          //   borderRadius: BorderRadius.all(
          //     Radius.circular(5.0),
          //   ),
          //   boxShadow: <BoxShadow>[
          //     new BoxShadow(
          //       color: Colors.grey,
          //       blurRadius: 3.0,
          //       offset: new Offset(0.0, 3.0),
          //     ),
          //   ],
          // ),
          child: InkWell(
              onTap: () {
                if (driverInfoData[index].name != "") {
                  _timer?.cancel();
                  BlocProvider.of<HomeBloc>(context)
                      .add(HomeEventDriverItemClick(driverInfoData[index]));
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  AVerticalSpace(4.0.scale()),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Container(
                        width: 100.0.scale(),
                        height: 100.0.scale(),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: CachedNetworkImage(
                            imageUrl:
                                "https://heymobie.com/public/uploads/vendor/profile/" +
                                    driverInfoData[index].profileImg1!,
                            fit: BoxFit.fill,
                            errorWidget: (context, url, error) =>
                                new Icon(Icons.error),
                          ),
                        ),
                      ).align(Alignment.center)),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image:
                                AssetImage('${imgPathGeneral}ic_bluetick.png'),
                          ),
                          AHorizontalSpace(2.0.scale()),
                          if (driverInfoData[index].distance != null)
                            Container(
                                child: Text(
                              'Distance ${driverInfoData[index].distance} Miles',
                              style: textStyleBoldCustomColor(
                                  11.0.scale(), KColorCommonText),
                              textAlign: TextAlign.center,
                            )),
                        ],
                      ).align(Alignment.center),
                    ],
                  ).expand()
                ],
              )),
        ).leftPadding(6.0.scale()).rightPadding(7.0.scale()),
      ),
    );
  }
}

class MapListView extends StatefulWidget {
  List<DriverList> driverInfoData;

  List<ProductListDriver> driverProductList;

  double currentLat, currentLong;

  CustomInfoWindowController customInfoWindowController;

  Set<Marker> markers;

  GoogleMapController cameraController;

  Function markerPositionWidget;

  CameraPosition kGooglePlex;

  Completer<GoogleMapController> controller;

  bool isListView;

  MapListView(
      this.driverInfoData,
      this.driverProductList,
      this.currentLat,
      this.currentLong,
      this.customInfoWindowController,
      this.markers,
      this.cameraController,
      this.markerPositionWidget,
      this.kGooglePlex,
      this.controller,
      this.isListView);

  @override
  _MapListViewState createState() => _MapListViewState();
}

class _MapListViewState extends State<MapListView> {
  bool oneTimeCall = true;

  CameraPosition markerCenterPoint(double lat, double lon) {
    setState(() {
      pinPosition = LatLng(lat, lon);
      _kGooglePlex = CameraPosition(target: pinPosition!, zoom: Zoom);
      CameraUpdate update = CameraUpdate.newCameraPosition(_kGooglePlex);

      widget.cameraController.animateCamera(update);
    });
    return widget.kGooglePlex = _kGooglePlex;
  }

  // Future<void> moveCameraAsync() async {
  //   widget.cameraController = await widget.controller.future;
  // }

  @override
  Widget build(BuildContext context) {
    //moveCameraAsync();
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        _SearchWidget(widget.currentLat, widget.currentLong,
            widget.cameraController, widget.controller, widget.isListView),
        if (widget.isListView == false)
          Container(
            height: 300.0.scale(),
            child: Stack(
              children: [
                GoogleMap(
                  onTap: (position) {
                    // widget.customInfoWindowController.hideInfoWindow();
                  },
                  onCameraMove: (position) {
                    //  widget.customInfoWindowController.onCameraMove();
                  },
                  gestureRecognizers: Set()
                    ..add(Factory<EagerGestureRecognizer>(
                        () => EagerGestureRecognizer())),
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: true,
                  scrollGesturesEnabled: true,
                  myLocationButtonEnabled: false,
                  myLocationEnabled: pinPosition != null,
                  compassEnabled: false,
                  markers: widget.markers,
                  mapType: MapType.normal,
                  initialCameraPosition: widget.kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    // if (oneTimeCall) {
                    //   widget.controller.complete(controller);
                    //   oneTimeCall = false;
                    // }

                    widget.customInfoWindowController.googleMapController =
                        controller;
                    widget.cameraController = controller;

                    setState(() {
                      print("=====  in reset widget ");
                      markerCenterPoint(widget.currentLat, widget.currentLong);
                      widget.markerPositionWidget(widget.driverInfoData);
                    });
                  },
                ),
              ],
            ),
          ),
        AVerticalSpace(12.0.scale()),
        if (widget.isListView)
          if (widget.driverInfoData[0].name != "")
            _DriverHorizontalList(widget.driverInfoData),
        AVerticalSpace(12.0.scale()),
        if (widget.driverProductList.length == 0) _NoProductFoundWidget(),
        if (widget.driverProductList != null ||
            widget.driverProductList.length > 0)
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              //_GridProductListWidget(widget.driverProductList)
            ],
          )
      ],
    );
  }
}

class _NoProductFoundWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        AVerticalSpace(25.0.scale()),
        Text("No Products Found!",
                style: textStyleBoldCustomColor(20.0.scale(), KColorCommonText))
            .leftPadding(12.0.scale())
            .align(Alignment.center),
      ],
    );
  }
}

const double _kCommonTexFieldFontSize = 14.0;

class _GridProductListWidget extends StatefulWidget {
  Function showHideProgress;
  List<ProductListDriver> _driverProductList;

  _GridProductListWidget(this._driverProductList, this.showHideProgress);

  @override
  _GridProductListWidgetState createState() => _GridProductListWidgetState();
}

class _GridProductListWidgetState extends State<_GridProductListWidget> {
  int j = 0;
  List<String> _categoryList = [];

  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GoogleGrid(
      gap: 16.0.scale(),
      padding: const EdgeInsets.all(16.0),
      children: [
        for (int i = 0; i < widget._driverProductList.length; i++)
          Ink(
            height: 200.0.scale(),
            width: 200.0.scale(),
            color: Colors.blue,
            child: InkWell(
              splashColor: Colors.grey,
              onTap: () {
                isTimerOn = false;
                print("id=====${widget._driverProductList[i].id}");
                //_timer.cancel();
                widget.showHideProgress(true);

                // BlocProvider.of<HomeBloc>(context).add(
                //     HomeEventDriverProductListClick(
                //         widget._driverProductList[i],
                //         widget._driverProductList[i].vendor!,
                //         "DriverList",
                //         widget._driverProductList[i].id!));

                // BlocProvider.of<HomeBloc>(context).add(
                //     HomeEventDriverTicketListClick(
                //         widget._driverProductList[i],
                //         widget._driverProductList[i].vendor!,
                //         "DriverList",
                //         widget._driverProductList[i].id!));

                BlocProvider.of<HomeBloc>(context).add(
                    HomeEventDriverTicketListClick(
                        widget._driverProductList[i].vendorId!,
                        widget._driverProductList[i].id!.toString(),
                        widget._driverProductList[i].type!,
                        driverProductList[i]));
              },
              child: Container(
                height: 210.0.scale(),
                width: 200.0.scale(),
                child: Column(
                  children: [
                    AVerticalSpace(5.0.scale()),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0.scale()),
                      child: CachedNetworkImage(
                        width: 100.0.scale(),
                        height: 80.0.scale(),
                        imageUrl: widget._driverProductList[i].imageURL!,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) =>
                            new Icon(Icons.error),
                      ),
                    ).align(Alignment.center),
                    AVerticalSpace(4.0.scale()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget._driverProductList[i].productType == "0")
                          Image.asset(
                            "${imgPathGeneral}ic_product.png",
                            height: 15,
                            width: 15,
                          ),
                        if (widget._driverProductList[i].productType == "1")
                          Image.asset(
                            "${imgPathGeneral}ic_product.png",
                            height: 15,
                            width: 15,
                          ),
                        if (widget._driverProductList[i].productType == "2")
                          Image.asset(
                            "${imgPathGeneral}ic_ride.png",
                            height: 18,
                            width: 18,
                          ),
                        if (widget._driverProductList[i].productType == "3")
                          Image.asset(
                            "${imgPathGeneral}ic_ticket.png",
                            height: 15,
                            width: 15,
                          ),
                        AHorizontalSpace(7.0.scale()),

                        // if (widget._driverProductList[i].categoryname == "0")
                        //   Text(
                        //     "Product",
                        //     style: textStyleCustomColor(
                        //         14.0.scale(), KColorTextGrey),
                        //   ),
                        // if (widget._driverProductList[i].categoryname == "1")
                        //   Text(
                        //     "Product",
                        //     style: textStyleCustomColor(
                        //         14.0.scale(), KColorTextGrey),
                        //   ),
                        // if (widget._driverProductList[i].categoryname == "2")
                        //   Text(
                        //     "Ride",
                        //     style: textStyleCustomColor(
                        //         14.0.scale(), KColorTextGrey),
                        //   ),
                        // if (widget._driverProductList[i].categoryname  == "3")
                        //   Text(
                        //     "Event",
                        //     style: textStyleCustomColor(
                        //         14.0.scale(), KColorTextGrey),
                        //   )

                        Text(
                          widget._driverProductList[i].categoryname! == null
                              ? ""
                              : widget._driverProductList[i].categoryname!,
                          textAlign: TextAlign.center,
                          style: textStyleCustomColor(
                              14.0.scale(), KColorTextGrey),
                        ),
                      ],
                    ),
                    AVerticalSpace(4.0.scale()),
                    Text(
                      widget._driverProductList[i].name!,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: textStyleBoldCustomColor(
                          15.0.scale(), KColorCommonText),
                    ),
                    AVerticalSpace(4.0.scale()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image(
                          image: AssetImage('${imgPathGeneral}ic_bluetick.png'),
                          height: 15,
                        ),
                        AHorizontalSpace(3.0.scale()),
                        Text(
                          widget._driverProductList[i].vendorname! +
                              " " +
                              widget._driverProductList[i].lastName!,
                          overflow: TextOverflow.ellipsis,
                          style: textStyleBoldCustomColor(
                              12.0.scale(), KColorCommonText),
                        ),
                      ],
                    ).leftPadding(35.0.scale()),
                    AVerticalSpace(3.0.scale()),
                    if (widget._driverProductList[i].avgRating != "0")
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image(
                            image: AssetImage('${imgPathGeneral}ic_star.png'),
                            width: 10.0.scale(),
                            height: 10.0.scale(),
                          ),
                          AHorizontalSpace(3.0.scale()),
                          Text(
                            widget._driverProductList[i].avgRating!,
                            overflow: TextOverflow.ellipsis,
                            style: textStyleBoldCustomColor(
                                12.0.scale(), KColorCommonText),
                          ),
                        ],
                      ).leftPadding(35.0.scale())
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

const double _kTextBirthdateField = 128.0;
String strCity = "";
Timer? _timer;
bool isTimerOn = false;
String strProduct = "";

class _SearchWidget extends StatefulWidget {
  double currentLat;
  double currentLong;
  GoogleMapController cameraController;
  Completer<GoogleMapController> controller;
  bool isListView;

  _SearchWidget(this.currentLat, this.currentLong, this.cameraController,
      this.controller, this.isListView);

  @override
  __SearchWidgetState createState() => __SearchWidgetState();
}

class __SearchWidgetState extends State<_SearchWidget> {
  late TextEditingController _textSearchCity;
  late TextEditingController _textSearchByText;
  late String lastInputValue;

  @override
  void initState() {
    super.initState();

    if (widget.isListView == false) {
      if (_timer != null) {
        // print("timer on ===========");
        if (_timer?.isActive == false) {
          print("timer on ===========");
          timerOn();
        }
      } else {
        print("timer on else===========");
        timerOn();
      }
    }
    _textSearchCity = new TextEditingController();
    _textSearchCity.addListener(textListener);
    _textSearchByText = new TextEditingController();
    _textSearchByText.addListener(textListener);
  }

  timerOn() {
    //this.mounted;
    _timer = Timer.periodic(const Duration(seconds: 40), (_timer) {
      isTimerOn = true;

      print("mounted");
      setState(() {
        print("In api call ====== 45 second");
        if (strProduct.length > 2) {
          if (strCity.length > 2) {
            BlocProvider.of<HomeBloc>(context).add(
                HomeEventDriverListApiCallLoading(
                    0.0, 0.0, strCity, strProduct));
          } else {
            BlocProvider.of<HomeBloc>(context).add(
                HomeEventDriverListApiCallLoading(
                    widget.currentLat, widget.currentLong, "", strProduct));
          }
        } else if (strCity.length > 2) {
          if (strProduct.length > 2) {
            BlocProvider.of<HomeBloc>(context).add(
                HomeEventDriverListApiCallLoading(
                    0.0, 0.0, strCity, strProduct));
          } else {
            BlocProvider.of<HomeBloc>(context).add(
                HomeEventDriverListApiCallLoading(
                    widget.currentLat, widget.currentLong, strCity, ""));
          }
        } else if (strCity.length > 2 && strProduct.length > 2) {
          BlocProvider.of<HomeBloc>(context).add(
              HomeEventDriverListApiCallLoading(0.0, 0.0, strCity, strProduct));
        } else {
          BlocProvider.of<HomeBloc>(context).add(
              HomeEventDriverListApiCallLoading(
                  widget.currentLat, widget.currentLong, "", ""));
        }
      });
    });
  }

  textListener() {
    print("Current Text is ${_textSearchCity.text}");
  }

  @override
  void dispose() {
    if (isTimerOn == true) {
      print("timer cancel ======");
      // _timer.cancel();
    }

    print("timer isActive ====== ${_timer?.isActive}");
    if (_timer?.isActive == false) {
      print("is List${widget.isListView}");
      // timerOn();
      // if (widget.isListView == true) timerOn();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // if (_timer.isActive == null || _timer.isActive == false) {
    //   timerOn();
    // }
    return Container(
        color: Colors.transparent,
        height: _kTextBirthdateField.scale(),
        width: double.infinity,
        child: Column(
          children: [
            Container(
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
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('${imgPathGeneral}ic_search_logo.png'),
                    ).align(Alignment.center).leftPadding(5.0.scale()),
                    TextField(
                      onChanged: (text) {
                        if (_timer?.isActive != null) {
                          if (_timer?.isActive != true) {
                            if (isTimerOn == false) {
                              isTimerOn = true;
                              timerOn();
                            }
                          }
                        }

                        if (text.length > 2) {
                          setState(() {
                            strCity = text;
                          });

                          if (strProduct.length > 2) {
                            _dialogDriverOpen = true;
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                _dialogContext = context;
                                return Dialog(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      AVerticalSpace(25.0.scale()),
                                      new CircularProgressIndicator(
                                        color: Colors.black45,
                                      ),
                                      AVerticalSpace(12.0.scale()),
                                      new Text(
                                              "Searching for drivers closest to you!",
                                              style: textStyleCustomColor(
                                                  14.0.scale(), Colors.black))
                                          .leftPadding(8.0.scale())
                                          .rightPadding(8.0.scale()),
                                      AVerticalSpace(25.0.scale()),
                                    ],
                                  ).widgetBgColor(Colors.white),
                                );
                              },
                            );
                            FocusScope.of(context).unfocus();
                            BlocProvider.of<HomeBloc>(context).add(
                                HomeEventDriverListApiCallLoading(
                                    0.0, 0.0, strCity, strProduct));
                          } else {
                            _dialogDriverOpen = true;
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                _dialogContext = context;
                                return Dialog(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      AVerticalSpace(25.0.scale()),
                                      new CircularProgressIndicator(
                                        color: Colors.black45,
                                      ),
                                      AVerticalSpace(12.0.scale()),
                                      new Text(
                                              "Searching for drivers closest to you!",
                                              style: textStyleCustomColor(
                                                  14.0.scale(), Colors.black))
                                          .leftPadding(8.0.scale())
                                          .rightPadding(8.0.scale()),
                                      AVerticalSpace(25.0.scale()),
                                    ],
                                  ).widgetBgColor(Colors.white),
                                );
                              },
                            );
                            FocusScope.of(context).unfocus();
                            BlocProvider.of<HomeBloc>(context).add(
                                HomeEventDriverListApiCallLoading(
                                    widget.currentLat,
                                    widget.currentLong,
                                    strCity,
                                    ""));
                          }

                          // findAddres(strCity);

                          print("text $strCity");
                        } else if (text.length == 0) {
                          setState(() {
                            strCity = "";
                          });
                          if (strProduct.length > 2) {
                            _dialogDriverOpen = true;
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                _dialogContext = context;
                                return Dialog(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      AVerticalSpace(25.0.scale()),
                                      new CircularProgressIndicator(
                                        color: Colors.black45,
                                      ),
                                      AVerticalSpace(12.0.scale()),
                                      new Text(
                                              "Searching for drivers closest to you!",
                                              style: textStyleCustomColor(
                                                  14.0.scale(), Colors.black))
                                          .leftPadding(8.0.scale())
                                          .rightPadding(8.0.scale()),
                                      AVerticalSpace(25.0.scale()),
                                    ],
                                  ).widgetBgColor(Colors.white),
                                );
                              },
                            );
                            FocusScope.of(context).unfocus();
                            BlocProvider.of<HomeBloc>(context).add(
                                HomeEventDriverListApiCallLoading(
                                    0.0, 0.0, "", strProduct));
                          } else {
                            FocusScope.of(context).unfocus();
                            BlocProvider.of<HomeBloc>(context).add(
                                HomeEventDriverListApiCallLoading(
                                    widget.currentLat,
                                    widget.currentLong,
                                    "",
                                    ""));
                          }
                        }
                      },
                      controller: _textSearchCity,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      cursorColor: KColorTextFieldCommonHint,
                      decoration: InputDecoration(
                        hintText: "City or Zip",
                        hintStyle:
                            textStyleCustomColor(12.0.scale(), KColorTextGrey),
                        fillColor: Colors.white,
                        filled: true,
                        border: InputBorder.none,
                      ),
                    ).expand(),
                  ],
                ).widgetBgColor(Colors.white)),
            AVerticalSpace(7.0.scale()),
            Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2.0),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 3.0,
                      offset: new Offset(0.0, 3.0),
                    ),
                  ],
                ),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('${imgPathGeneral}ic_search_logo.png'),
                    ).align(Alignment.center).leftPadding(5.0.scale()),
                    TextField(
                      onChanged: (text) {
                        if (_timer?.isActive != null) {
                          if (_timer?.isActive != true) {
                            if (isTimerOn == false) {
                              isTimerOn = true;
                              timerOn();
                            }
                          }
                        }
                        if (text.length > 2) {
                          setState(() {
                            strProduct = text;
                          });

                          if (strCity.length > 2) {
                            _dialogDriverOpen = true;
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                _dialogContext = context;
                                return Dialog(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      AVerticalSpace(25.0.scale()),
                                      new CircularProgressIndicator(
                                        color: Colors.black45,
                                      ),
                                      AVerticalSpace(12.0.scale()),
                                      new Text(
                                              "Category search for available driver",
                                              style: textStyleCustomColor(
                                                  14.0.scale(), Colors.black))
                                          .leftPadding(8.0.scale())
                                          .rightPadding(8.0.scale()),
                                      AVerticalSpace(25.0.scale()),
                                    ],
                                  ).widgetBgColor(Colors.white),
                                );
                              },
                            );

                            BlocProvider.of<HomeBloc>(context).add(
                                HomeEventDriverListApiCallLoading(
                                    0.0, 0.0, strCity, strProduct));
                          } else {
                            BlocProvider.of<HomeBloc>(context).add(
                                HomeEventDriverListApiCallLoading(
                                    widget.currentLat,
                                    widget.currentLong,
                                    "",
                                    strProduct));
                          }

                          print("text $strProduct");
                        } else if (text.length == 0) {
                          setState(() {
                            strProduct = "";
                          });
                          if (strCity.length > 2) {
                            _dialogDriverOpen = true;
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                _dialogContext = context;
                                return Dialog(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      AVerticalSpace(25.0.scale()),
                                      new CircularProgressIndicator(
                                        color: Colors.black45,
                                      ),
                                      AVerticalSpace(12.0.scale()),
                                      new Text(
                                              "Category search for available driver",
                                              style: textStyleCustomColor(
                                                  14.0.scale(), Colors.black))
                                          .leftPadding(8.0.scale())
                                          .rightPadding(8.0.scale()),
                                      AVerticalSpace(25.0.scale()),
                                    ],
                                  ).widgetBgColor(Colors.white),
                                );
                              },
                            );
                            BlocProvider.of<HomeBloc>(context).add(
                                HomeEventDriverListApiCallLoading(
                                    widget.currentLat,
                                    widget.currentLong,
                                    strCity,
                                    ""));
                          } else {
                            BlocProvider.of<HomeBloc>(context).add(
                                HomeEventDriverListApiCallLoading(
                                    widget.currentLat,
                                    widget.currentLong,
                                    "",
                                    ""));
                          }
                        }
                      },
                      controller: _textSearchByText,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      cursorColor: KColorTextFieldCommonHint,
                      decoration: InputDecoration(
                        hintText: "Product, Brand, Type, ProductCode",
                        hintStyle: textStyleCustomColor(
                            12.0.scale().scale(), KColorTextGrey),
                        fillColor: Colors.white,
                        filled: true,
                        border: InputBorder.none,
                      ),
                    ).expand(),
                  ],
                ).widgetBgColor(Colors.white)),
            AVerticalSpace(5.0.scale()),
          ],
        )
            .topPadding(5.0.scale())
            .leftPadding(10.0.scale())
            .rightPadding(10.0.scale()));
  }
}
