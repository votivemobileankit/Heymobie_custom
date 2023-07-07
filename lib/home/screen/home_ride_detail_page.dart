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
import '../../theme/ft_theme_colors.dart';
import '../../theme/ft_theme_size_const.dart';
import '../../theme/ft_theme_styles.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../home_navigator.dart';
import '../model/ps_list_model.dart';

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
  double? estimatedPrice = 0;
  bool eventSelect = false;

  List<Position> locations = <Position>[];

  @override
  void initState() {
    print("TicketPrice===>");
    // TODO: implement initState
    HomeState state = BlocProvider.of<HomeBloc>(context).state;
    if (state is HomeEventDriverRideListClickPageState) {
      eventdetaillist = state.eventdetaillist!;
      print("rateMile====>${eventdetaillist[0].rateMile}");
      print("price====>${eventdetaillist[0].price}");

      //  print('_positionStream===> $_positionStream');
    }

    super.initState();
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
      String meter = metertomile!.toStringAsFixed(2);
      print('Total Distance in miles ===> $meter');
      setState(() {
        estimatedPrice = double.parse(eventdetaillist[0].price!) +
            (double.parse(eventdetaillist[0].rateMile!) * double.parse(meter));
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
        if (state is HomeRideLocationSeatchPageState) {
          //showHideProgress(false);
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
                  rightEditButtonVisibility: true,
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
                                            BlocProvider.of<HomeBloc>(context).add(
                                                HomeEventRideSearchTextFieldClick(
                                                    "Pickup"));
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
                                                child: Text("${estimatedPrice}",
                                                    maxLines: 5,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 10,
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
                                        "Rate/Minute",
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
                                                "\$${eventdetaillist[0].rateMinute}",
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
                    btnOnPressed: () {},
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
