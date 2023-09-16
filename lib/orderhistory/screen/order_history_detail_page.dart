import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:grambunny_customer/components/components.dart';
import 'package:grambunny_customer/orderhistory/components/my_order_list_item.dart';
import 'package:grambunny_customer/orderhistory/orderhistory.dart';
import 'package:grambunny_customer/side_navigation/side_navigation.dart';
import 'package:grambunny_customer/theme/theme.dart';
import 'package:grambunny_customer/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

const double _kCommonIconHeight = 20.0;

class OrderHistoryDetailsPage extends StatefulWidget {
  @override
  State<OrderHistoryDetailsPage> createState() =>
      _OrderHistoryDetailsPageState();
}

class _OrderHistoryDetailsPageState extends State<OrderHistoryDetailsPage> {
  String? orderId;
  String? vendorId;
  String? vendorName;
  String? vendorLastName;
  List<OrderDetail>? orderDetailData;
  List<OrderItems>? orderDetailMenuItem;
  List<Vendor1>? vendorDetailData;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    // TODO: implement initState

    OrderHistoryState homeState =
        BlocProvider.of<OrderHistoryBloc>(context).state;

    if (homeState is OrderHistoryDetailPageState) {
      orderId = homeState.orderId;
      vendorId = homeState.vendorId;
      vendorName = homeState.vendorName;
      vendorLastName = homeState.vendorlastName;
    }
    showHideProgress(true);
    BlocProvider.of<OrderHistoryBloc>(context)
        .add(OrderHistoryEventForOrderDeatil(orderId!, vendorId!));
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState!.show());
    super.initState();
  }

  void showHideProgress(bool show) {
    BlocProvider.of<SideNavigatBloc>(context)
        .add(SideNavigationEventToggleLoadingAnimation(needToShow: show));
  }

  Future<Null> _refresh() async {
    BlocProvider.of<OrderHistoryBloc>(context)
        .add(OrderHistoryEventForOrderDeatil(orderId!, vendorId!));
    _refreshIndicatorKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    return null;
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: BlocListener<OrderHistoryBloc, OrderHistoryState>(
                listenWhen: (prevState, curState) =>
                    ModalRoute.of(context)!.isCurrent,
                listener: (context, state) {
                  if (state is OrderHistoryInitial) {
                    print("bloc call");
                    Navigator.of(context).pop(true);
                    // BlocProvider.of<SideNavigatBloc>(context)
                    //     .add(SideNavigationEventGoToHomePage(true));
                  } else if (state is OrderDetailApiLoadingCompleteState) {
                    showHideProgress(false);
                    orderDetailData = state.orderDetailData;
                    orderDetailMenuItem = state.orderDetailMenuItem;
                    vendorDetailData = state.vendorDetailData;
                  } else if (state is OrderHistoryDetailPageState) {
                    orderId = state.orderId;
                    vendorId = state.vendorId;
                    vendorName = state.vendorName;
                    vendorLastName = state.vendorlastName;
                  } else if (state is OrderMerchantRatingSubmitState) {
                    BlocProvider.of<SideNavigatBloc>(context).add(
                        SideNavigationEventToggleLoadingAnimation(
                            needToShow: false));
                    showSnackBar(state.message, context);
                    BlocProvider.of<OrderHistoryBloc>(context).add(
                        OrderHistoryEventForOrderDeatil(orderId!, vendorId!));
                  } else if (state is OrderDetailLoadingErrorState) {
                    BlocProvider.of<SideNavigatBloc>(context).add(
                        SideNavigationEventToggleLoadingAnimation(
                            needToShow: false));
                    showSnackBar(state.message, context);
                    BlocProvider.of<OrderHistoryBloc>(context).add(
                        OrderHistoryEventForOrderDeatil(orderId!, vendorId!));
                  } else if (state is MapOrderTrackPageState) {
                    Navigator.of(context)
                        .pushNamed(OrderHistoryNavigator.mapOrderTrackPage);
                  }
                },
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      AHeaderWidget(
                        btnEditOnPressed: () {},
                        strBackbuttonName: 'ic_red_btn_back.png',
                        backBtnVisibility: true,
                        btnBackOnPressed: () {
                          //Scaffold.of(context).openDrawer();
                          BlocProvider.of<OrderHistoryBloc>(context)
                              .add(OrderEventBackBtnClicked());
                        },
                        strBtnRightImageName: 'ic_search_logo.png',
                        rightEditButtonVisibility: false,
                      ),
                      SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              AVerticalSpace(12.0.scale()),
                              Text(
                                "Driver Info:",
                                style: textStyleBoldCustomLargeColor(
                                    18.0.scale(), KColorCommonText),
                              )
                                  .align(Alignment.centerLeft)
                                  .leftPadding(12.0.scale()),
                              AVerticalSpace(12.0.scale()),
                              if (vendorDetailData != null)
                                if (vendorDetailData != null)
                                  _DriverDetail(vendorDetailData![0])
                                      .leftPadding(14.0.scale())
                                      .rightPadding(14.0.scale()),
                              AVerticalSpace(12.0.scale()),
                              // Text(
                              //   "Order Status",
                              //   style: textStyleBoldCustomLargeColor(
                              //       18.0.scale(), KColorCommonText),
                              // )
                              //     .align(Alignment.centerLeft)
                              //     .leftPadding(14.0.scale()),
                              AVerticalSpace(8.0.scale()),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Order Status: ",
                                    style: textStyleBoldCustomLargeColor(
                                        18.0.scale(), KColorCommonText),
                                  ),
                                  if (orderDetailData != null)
                                    if (orderDetailData![0].status == "0")
                                      Text(
                                        "Pending",
                                        style: textStyleCustomColor(
                                            18.0.scale(), KColorPending),
                                        textAlign: TextAlign.left,
                                      )
                                    else if (orderDetailData![0].status == "1")
                                      Text(
                                        "Accept",
                                        style: textStyleCustomColor(
                                            18.0.scale(), KColorCommonText),
                                        textAlign: TextAlign.left,
                                      )
                                    else if (orderDetailData![0].status == "2")
                                      Text(
                                        "Cancelled",
                                        style: textStyleCustomColor(
                                            18.0.scale().scale(),
                                            KColorCancelledStatus),
                                        textAlign: TextAlign.left,
                                      )
                                    else if (orderDetailData![0].status == "3")
                                      Text(
                                        "on the way",
                                        style: textStyleCustomColor(
                                            18.0.scale(), KColorOnTheWay),
                                        textAlign: TextAlign.left,
                                      )
                                    else if (orderDetailData![0].status == "4")
                                      Text(
                                        "Delivered",
                                        style: textStyleCustomColor(
                                            18.0.scale(), KColorDelivered),
                                        textAlign: TextAlign.left,
                                      ),
                                  if (orderDetailData != null)
                                    if (orderDetailData![0].status != "0")
                                      OutlinedButton(
                                        onPressed: () {
                                          BlocProvider.of<OrderHistoryBloc>(
                                                  context)
                                              .add(OrderTrackEventForMapScreen(
                                                  vendorDetailData![0].lat!,
                                                  vendorDetailData![0].lng!,
                                                  orderDetailData![0].latitude!,
                                                  orderDetailData![0]
                                                      .longitude!,
                                                  vendorDetailData![0]
                                                      .vendorId
                                                      .toString()));
                                        },
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0))),
                                        ),
                                        child: Text(
                                          "Order Track",
                                          style: textStyleCustomColor(
                                              15.0.scale(),
                                              kColorMemberCountText),
                                          textAlign: TextAlign.center,
                                        ),
                                      ).rightPadding(12.0.scale()),
                                ],
                              ).leftPadding(12.0.scale()),
                              AVerticalSpace(12.0.scale()),
                              if (orderDetailData != null)
                                Container(
                                  padding:
                                      EdgeInsets.fromLTRB(4.0, 8.0, 0, 8.0),
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Sub total: \$" +
                                            orderDetailData![0].subTotal!,
                                        style: textStyleCustomColor(
                                            14.0.scale(), KColorCommonText),
                                      ).align(Alignment.centerLeft),
                                      AVerticalSpace(3.0.scale()),
                                      if (vendorDetailData != null)
                                        Text(
                                          "Sales tax: \$" +
                                              orderDetailData![0].serviceTax!,
                                          style: textStyleCustomColor(
                                              14.0.scale(), KColorCommonText),
                                        ).align(Alignment.centerLeft),
                                      AVerticalSpace(3.0.scale()),
                                      // if (vendorDetailData != null)
                                      //   Text(
                                      //     "City tax: \$" +
                                      //         orderDetailData[0].cityTax,
                                      //     style: textStyleCustomColor(
                                      //         14.0.scale(), KColorCommonText),
                                      //   ).align(Alignment.centerLeft),
                                      // AVerticalSpace(3.0.scale()),
                                      // if (vendorDetailData[0] != null)
                                      //   Text(
                                      //     "Excise tax: \$" +
                                      //         orderDetailData[0].exciseTax,
                                      //     style: textStyleCustomColor(
                                      //         14.0.scale(), KColorCommonText),
                                      //   ).align(Alignment.centerLeft),
                                      // AVerticalSpace(3.0.scale()),
                                      Text(
                                        "Coupon discount amount: \$" +
                                            orderDetailData![0].promoAmount!,
                                        style: textStyleCustomColor(
                                            14.0.scale(), KColorCommonText),
                                      ).align(Alignment.centerLeft),
                                      if (orderDetailData![0].deliveryFee !=
                                          null)
                                        AVerticalSpace(3.0.scale()),
                                      if (orderDetailData![0].deliveryFee !=
                                          null)
                                        Text(
                                          "Delivery fee: \$" +
                                              orderDetailData![0].deliveryFee!,
                                          style: textStyleCustomColor(
                                              14.0.scale(), KColorCommonText),
                                        ).align(Alignment.centerLeft),
                                      AVerticalSpace(3.0.scale()),
                                      Text(
                                        "Grand total: \$" +
                                            orderDetailData![0].total!,
                                        style: textStyleBoldCustomColor(
                                            18.0.scale(), KColorCommonText),
                                      ).align(Alignment.centerLeft),
                                    ],
                                  )
                                      .align(Alignment.centerLeft)
                                      .leftPadding(10.0.scale()),
                                ),
                              AVerticalSpace(5.0.scale()),
                              ASeparatorLine(
                                height: 1.0.scale(),
                                color:
                                    KColorAppointmentDropinHistoryListSeprator,
                              ),
                              AVerticalSpace(12.0.scale()),
                              Text(
                                "My Orders",
                                style: textStyleBoldCustomLargeColor(
                                    18.0.scale(), KColorCommonText),
                              )
                                  .align(Alignment.centerLeft)
                                  .leftPadding(14.0.scale()),
                              AVerticalSpace(8.0.scale()),
                              if (orderDetailMenuItem != null)
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: new ScrollPhysics(),
                                  itemCount: orderDetailMenuItem!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      child: MyOrderListRow(
                                          orderDetailMenuItem![index]),
                                      onTap: () {},
                                    );
                                  },
                                )
                            ],
                          )).expand()
                    ],
                  ).widgetBgColor(Colors.white),
                ).widgetBgColor(kColorAppBgColor))
            .pageBgColor(kColorAppBgColor));
  }
}

class _DriverDetail extends StatelessWidget {
  double initialRat = 5;

  Vendor1 vendorDetailData;

  _DriverDetail(this.vendorDetailData) {
    initialRat = double.parse(vendorDetailData.avgRating!);
  }

  void _callNumber(String phonenumber) async {
    phonenumber = phonenumber.replaceAll("(", "");
    phonenumber = phonenumber.replaceAll(")", "");
    phonenumber = phonenumber.replaceAll("-", "");
    phonenumber = phonenumber.replaceAll(" ", "");
    print(phonenumber);
    String url = "tel://" + phonenumber;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not call $phonenumber';
    }
  }

  @override
  Widget build(BuildContext context1) {
    // TODO: implement build
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 50.0.scale(),
              height: 50.0.scale(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: CachedNetworkImage(
                  imageUrl: vendorDetailData.profileImg1!,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
              ),
            ),
            AHorizontalSpace(10.0.scale()),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  vendorDetailData.username! + " " + vendorDetailData.lastName!,
                  style: textStyleBoldCustomLargeColor(
                      18.0.scale(), KColorCommonText),
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context1,
                      barrierColor: Colors.black26,
                      barrierDismissible: true,
                      builder: (context) {
                        return _getRatingReviewToMerchant(
                            context1, vendorDetailData);
                      },
                    );
                  },
                  child: Row(
                    children: [
                      RatingBar.builder(
                        initialRating: initialRat,
                        minRating: 1,
                        itemSize: 20,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        ignoreGestures: true,
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
                        "${vendorDetailData.avgRating}(${vendorDetailData.ratingCount})",
                        style: textStyleCustomColor(
                            12.0.scale(), kColorTextFieldText),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
        AVerticalSpace(10.0.scale()),
        Column(
          children: [
            AVerticalSpace(5.0.scale()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image(
                      fit: BoxFit.fill,
                      image: AssetImage('${imgPathGeneral}ic_phone_icon.png'),
                      width: 15.0.scale(),
                      height: 15.0.scale(),
                    ),
                    AHorizontalSpace(5.0.scale()),
                    if (vendorDetailData.mobNo != null)
                      GestureDetector(
                        onTap: () {
                          _callNumber(vendorDetailData.mobNo!);
                        },
                        child: Text(
                          vendorDetailData.mobNo!,
                          style: textStyleBoldCustomColor(
                              12.0.scale(), kColorTextFieldText),
                        ),
                      )
                  ],
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}

const double _kFontSize16 = 16.0;
const double _kAddtoCartDialogRadius = 20.0;
const double _kCommonCartMediumFontSize = 14.0;
const double _kCommonFontSize = 16.0;

Dialog _getRatingReviewToMerchant(BuildContext context1, Vendor1 vendorDetail) {
  return Dialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_kAddtoCartDialogRadius.scale())),
    elevation: 8,
    insetAnimationDuration: Duration(milliseconds: 30),
    insetPadding: EdgeInsets.all(10.0.scale()),
    child: _AddRatingReview(context1, vendorDetail),
  );
}

class _AddRatingReview extends StatelessWidget {
  Vendor1? vendorDetail;
  BuildContext context1;

  _AddRatingReview(this.context1, this.vendorDetail);

  double ratingCount = 5;
  final TextEditingController _textReview = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      height: 250.0.scale(),
      child: Column(
        children: [
          AVerticalSpace(8.0.scale()),
          Text(
            "Driver Rating",
            style:
                textStyleBoldCustomLargeColor(18.0.scale(), KColorCommonText),
          ).align(Alignment.center),
          AVerticalSpace(8.0.scale()),
          RatingBar.builder(
            initialRating: 5,
            minRating: 1,
            itemSize: 40,
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
              ratingCount = rating;
            },
          ),
          AVerticalSpace(8.0.scale()),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: KColorAppThemeColor, width: 4.0),
              color: KColorAppThemeColor,
            ),
            height: 80.0.scale(),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                TextField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: _textReview,
                  expands: true,
                  maxLines: null,
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  cursorColor: KColorTextFieldCommonHint,
                  decoration: InputDecoration(
                    hintText: "Enter your review here",
                    hintStyle:
                        textStyleCustomColor(12.0.scale(), KColorTextGrey),
                    fillColor: Colors.white,
                    filled: true,
                    border: InputBorder.none,
                  ),
                ).expand(),
              ],
            ),
          ).leftPadding(15.0.scale()).rightPadding(15.0.scale()),
          AVerticalSpace(15.0.scale()),
          ARoundedButton(
            btnBorderSideColor: kColorCommonButton,
            btnDisabledColor: Color(0xFF5e6163),
            btnIconSize: 15,
            btnDisabledTextColor: Color(0xFFFFFFFF),
            btnFontWeight: FontWeight.normal,
            btnBgColor: kColorCommonButtonBackGround,
            btnTextColor: kColorAppBgColor,
            btnText: "Submit Review",
            btnOnPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
              if (_textReview.text.isEmpty) {
                showSnackBar("Please enter some review for merchant", context);
              } else {
                BlocProvider.of<SideNavigatBloc>(context1).add(
                    SideNavigationEventToggleLoadingAnimation(
                        needToShow: true));
                BlocProvider.of<OrderHistoryBloc>(context1).add(
                    OrderHistoryRatingButtonClick(_textReview.text, ratingCount,
                        vendorDetail!.vendorId!));
              }
            },
            btnHeight: 40.0.scale(),
            btnWidth: 150.0.scale(),
            btnFontSize: kFontSizeBtnLarge.scale(),
            btnElevation: 0,
          ),
        ],
      ),
    );
  }
}
