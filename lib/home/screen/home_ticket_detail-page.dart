import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:grambunny_customer/components/a_horizontal_space.dart';
import 'package:grambunny_customer/components/a_widget_extensions.dart';
import 'package:grambunny_customer/utils/image_paths.dart';
import 'package:grambunny_customer/utils/ui_utils.dart';

import '../../components/a_header_back_button.dart';
import '../../components/a_rounded_button.dart';
import '../../components/a_rounded_buttonimage.dart';
import '../../components/a_separator_line.dart';
import '../../components/a_vertical_space.dart';
import '../../services/herbarium_cust_shared_preferences.dart';
import '../../side_navigation/bloc/side_navigat_bloc.dart';
import '../../side_navigation/bloc/side_navigat_event.dart';
import '../../theme/ft_theme_colors.dart';
import '../../theme/ft_theme_size_const.dart';
import '../../theme/ft_theme_styles.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../model/addon_productlist_boolean.dart';
import '../model/driver_list_model.dart';
import '../model/product_list_model.dart';
import '../model/ps_list_model.dart';
import '../model/rating_review_list_model.dart';
import '../model/related_product_model.dart';

const double _kMenuItemNameFontSize = 16.0;
const double _kCommonFontSize = 15.0;
const double _kCommonSmallFontSize = 12.0;
const kHeightBtnAddToCart = 40.0;
const double _kMenuitemNameTextFontSize = 16.0;
bool timerOnListener = true;

class MenuTicketDetailPage extends StatefulWidget {
  const MenuTicketDetailPage({Key? key}) : super(key: key);

  @override
  _MenuTicketDetailPageState createState() => _MenuTicketDetailPageState();
}

class _MenuTicketDetailPageState extends State<MenuTicketDetailPage> {
  String? _cartCount;
  String? strScreen;
  DriverList? _driverDetail;
  ProductListMenu? _productListModel;
  ProductListDriver? _productListDriverModel;
  String? _driverId;
  double _price = 0;
  String? name;
  Vendor? _vendorDetails;
  List<RelatedProductList>? _relatedProductList;
  int? productID;
  int qty = 1;
  double ratingCountSend = 5;
  int pageCount = 1;
  List<EventDetailsList> eventdetaillist = [];
  String? merchant_id;
  int? ps_id;
  String? type;
  String? changedriver;
  String? delete;
  String? decrease;

  List<AddonProductList>? _addOnProductList;
  List<AddonProductListBool>? _addOnProductLocalList;
  TextEditingController _textFiledUserSpecialInstruction =
      TextEditingController();

  void showHideProgress(bool show) {
    BlocProvider.of<SideNavigatBloc>(context)
        .add(SideNavigationEventToggleLoadingAnimation(needToShow: show));
  }

  @override
  void initState() {
    print("TicketPrice===>");
    // TODO: implement initState
    HomeState state = BlocProvider.of<HomeBloc>(context).state;

    if (state is HomeEventDriverTicketListClickPageState) {
      eventdetaillist = state.eventdetaillist!;
      _driverId = eventdetaillist[0].vendorId;

      print("price====>${eventdetaillist[0].price}");
    }

    super.initState();
  }

  final TextEditingController _textReview = TextEditingController();
  List<RatingReviewData>? ratingReviewList;

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
    return BlocListener<HomeBloc, HomeState>(
      listenWhen: (prevState, curState) => ModalRoute.of(context)!.isCurrent,
      listener: (context, state) {
        // if (state is HomeEventDriverTicketListClickCompleteState) {
        //   eventdetaillist = state.eventdetaillist!;
        //   print("${eventdetaillist}");
        //   print("${eventdetaillist}");
        //   print("dataPrint====>${eventdetaillist[0].vendorId}");
        // }
        if (state is HomeCategoryProductPageState) {
          Navigator.of(context).pop(true);
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
          //print("driver Id ${_driverId}");
          BlocProvider.of<HomeBloc>(context).add(HomeEventEventDetailPageReset(
              eventdetaillist, _driverId!, _driverDetail!));
        }
      },
      child: SafeArea(
          bottom: false,
          //child: SizedBox(),
          child: Scaffold(
            body: Column(mainAxisSize: MainAxisSize.max, children: [
              AHeaderWidget(
                  strBackbuttonName: 'ic_red_btn_back.png',
                  backBtnVisibility: true,
                  btnBackOnPressed: () {
                    timerOnListener = false;
                    _contextLoad = null;
                    BlocProvider.of<HomeBloc>(context)
                        .add(HomeEventBackBtnClick());
                  },
                  strBtnRightImageName: 'ic_cart_white.png',
                  rightEditButtonVisibility: true,
                  headerSigninText: _cartCount!,
                  btnEditOnPressed: () {
                    if (sharedPrefs.getCartCount != "0") {
                      _contextLoad = null;
                      showHideProgress(true);
                      print(strScreen);
                      if (strScreen == "DriverList") {
                        BlocProvider.of<HomeBloc>(context).add(
                            HomeEventProductDetailPageCartBtnClick(
                                _driverDetail!,
                                _productListModel!,
                                strScreen!));
                      } else {
                        BlocProvider.of<HomeBloc>(context).add(
                            HomeEventProductDetailPageCartBtnClick(
                                _driverDetail!,
                                _productListModel!,
                                strScreen!));
                      }
                    }
                  }),
              Column(mainAxisSize: MainAxisSize.max, children: [
                CachedNetworkImage(
                  imageUrl: 'https://picsum.photos/200?image=9',
                  width: MediaQuery.of(context).size.width,
                  height: 200.0.scale(),
                  fit: BoxFit.cover,
                  // errorWidget: (context, url, error) => new Icon(Icons.error),
                ).topPadding(2.0.scale()),
                AVerticalSpace(5.0.scale()),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: const Offset(
                            0.0,
                            0.0,
                          ),
                          blurRadius: 0.0,
                          spreadRadius: 3.0,
                        ), //BoxShadow
                        BoxShadow(
                          color: Colors.white,
                          offset: const Offset(0.0, 0.0),
                          blurRadius: 5.0,
                          spreadRadius: 0.0,
                        ), //BoxShadow
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AVerticalSpace(10.0.scale()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Ticket Price :",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ).leftPadding(10.0.scale()),
                            AHorizontalSpace(5.0.scale()),
                            Text(
                              "\$${eventdetaillist[0].price}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ).rightPadding(10.0.scale()),
                          ],
                        ),
                        AVerticalSpace(10.0.scale()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Ticket Fee : ",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ).leftPadding(10.0.scale()),
                            Text(
                              "\$${eventdetaillist[0].ticketFee}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ).rightPadding(10.0.scale()),
                          ],
                        ),
                        AVerticalSpace(10.0.scale()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Ticket Service Fee :  ",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ).leftPadding(10.0.scale()),
                            Text(
                              "\$${eventdetaillist[0].ticketServiceFee}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ).rightPadding(10.0.scale()),
                          ],
                        ),
                        AVerticalSpace(15.0.scale()),
                        Container(
                                height: 30,
                                width: 170,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius:
                                      BorderRadius.circular(15.0.scale()),
                                ),
                                child: Text(
                                  "Booking Information",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ).align(Alignment.center))
                            .leftPadding(10.0.scale()),
                        AVerticalSpace(15.0.scale()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Venue Name :",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ).leftPadding(10.0.scale()),
                            Text(
                              "${eventdetaillist[0].venueName}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ).rightPadding(10.0.scale()),
                          ],
                        ),
                        AVerticalSpace(10.0.scale()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Event Date :",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ).leftPadding(10.0.scale()),
                            Text(
                              "${eventdetaillist[0].eventDate}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ).rightPadding(10.0.scale()),
                          ],
                        ),
                        AVerticalSpace(10.0.scale()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Event Start time :",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ).leftPadding(10.0.scale()),
                            Text(
                              "${eventdetaillist[0].eventStartTime}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ).rightPadding(10.0.scale()),
                          ],
                        ),
                        AVerticalSpace(10.0.scale()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Event End Time :",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ).leftPadding(10.0.scale()),
                            Text(
                              "${eventdetaillist[0].eventEndTime}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ).rightPadding(10.0.scale()),
                          ],
                        ),
                        AVerticalSpace(10.0.scale()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Venue Address :",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ).leftPadding(10.0.scale()),
                            Text(
                              "${eventdetaillist[0].venueAddress}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ).rightPadding(10.0.scale()),
                          ],
                        ),
                        AVerticalSpace(10.0.scale()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Seating Area :",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ).leftPadding(10.0.scale()),
                            Text(
                              "${eventdetaillist[0].seatingArea}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ).rightPadding(10.0.scale()),
                          ],
                        ),
                        AVerticalSpace(10.0.scale()),
                      ],
                    )),
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
                // Row(
                //   children: [
                //     Container(
                //             height: 40,
                //             width: 150,
                //             color: Colors.grey,
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: [
                //                 Image(
                //                   color: Colors.white,
                //                   image: AssetImage(
                //                       "${imgPathGeneral}ic_cart_white.png"),
                //                   height: 20,
                //                 ),
                //                 AHorizontalSpace(5.0.scale()),
                //                 Text(
                //                   "Purchase Ticket",
                //                   overflow: TextOverflow.ellipsis,
                //                   style: TextStyle(
                //                       color: Colors.white,
                //                       fontSize: 14,
                //                       fontWeight: FontWeight.bold),
                //                 )
                //               ],
                //             ))
                //         .align(Alignment.center)
                //         .topPadding(20.0.scale())
                //         .leftPadding(10.0.scale())
                //         .rightPadding(10.0.scale()),
                //   ],
                // ),
                AVerticalSpace(15.0.scale()),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: KColorTextGrey, width: 1.0),
                        color: KColorTextGrey,
                      ),
                      padding: EdgeInsets.all(5.0.scale()),
                      width: 150.0.scale(),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              if (qty > 1) {
                                qty--;
                                print(qty);
                                setState(() {
                                  _price = double.parse(eventdetaillist[0]
                                          .quantity
                                          .toString()) *
                                      qty;
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
                                  ' ${qty}',
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
                              if (qty <
                                  int.parse(
                                      eventdetaillist[0].quantity.toString())) {
                                qty++;
                                print(qty);
                                setState(() {
                                  _price = double.parse(eventdetaillist[0]
                                          .quantity
                                          .toString()) *
                                      qty;
                                  String value = _price.toStringAsFixed(2);
                                  _price = double.parse(value);
                                });
                              } else {
                                showSnackBar(
                                    "Product available quantity is ${eventdetaillist[0].quantity}",
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
                    ARoundedButtonImage(
                      btnBgColor: kColorCommonButton,
                      btnTextColor: Colors.white,
                      btnOnPressed: () {
                        if (int.parse(eventdetaillist[0].quantity!) > 0) {
                          showHideProgress(true);

                          // BlocProvider.of<HomeBloc>(context).add(
                          //     HomeEventItemClickAddToCartBtnClick(
                          //         qty,
                          //         _productListModel!.id!,
                          //         _productListModel!.vendorId!,
                          //         0,
                          //         _driverDetail!,
                          //         "0",
                          //         _textFiledUserSpecialInstruction.text));

                          BlocProvider.of<HomeBloc>(context).add(
                              HomeEventTicketItemClickPurchaseTicketBtnClick(
                                  qty,
                                  eventdetaillist[0].id,
                                  eventdetaillist[0].vendorId!,
                                  0,
                                  "0",
                                  _textFiledUserSpecialInstruction.text));
                        } else {
                          showSnackBar("Product is out of stock!", context);
                        }
                      },
                      btnText: "Purchase Ticket",
                      btnHeight: kHeightBtnAddToCart.scale(),
                      btnWidth: 160.0.scale(),
                      btnFontSize: kFontSizeBtnLarge.scale(),
                      btnElevation: 0,
                      btnBorderSideColor: kColorCommonButton,
                      btnIconImagePath: '${imgPathGeneral}ic_cart_white.png',
                      btnIconData: ImageIcon(AssetImage('')), btnDisabledColor: kColorCommonButton,
                      btnDisabledTextColor: kColorCommonButton,
                    )
                  ],
                ),
                AVerticalSpace(10.0.scale()),
                Text(
                  "Description",
                  style: textStyleCustomColor(14.0.scale(), KColorCommonText),
                ).align(Alignment.centerLeft),
                AVerticalSpace(10.0.scale()),
                Text(
                  "Hotel",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: KColorTextGrey,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ).align(Alignment.centerLeft),
                AVerticalSpace(15.0.scale()),
                ASeparatorLine(height: 1, color: KColorAppThemeColor),
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
                        border:
                            Border.all(color: KColorAppThemeColor, width: 4.0),
                        color: KColorAppThemeColor,
                      ),
                      child: Text(
                        // "${_productListModel?.avgRating}/5",
                        "3/5",
                        style: textStyleBoldCustomColor(
                            18.0.scale(), Colors.white),
                      ),
                    )
                  ],
                ),
                AVerticalSpace(15.0.scale()),
                Text(
                  "Write Your Review",
                  style:
                      textStyleBoldCustomColor(18.0.scale(), KColorCommonText),
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
                  btnBgColor: kColorCommonButton,
                  btnTextColor: Colors.white,
                  btnText: "Submit Review",
                  btnOnPressed: () {
                    if (_textReview.text.isEmpty) {
                      showSnackBar(
                          "Please add your review for this product!", context);
                    } else {
                      showHideProgress(true);
                      BlocProvider.of<HomeBloc>(context).add(
                          HomeEventSubmitRatingBtnClick("${ratingCountSend}",
                              _textReview.text, _productListModel?.id));
                    }
                  },
                  btnHeight: 40.0.scale(),
                  btnWidth: kWidthBtnNormal.scale(),
                  btnFontSize: kFontSizeBtnLarge.scale(),
                  btnBorderSideColor: kColorCommonButton,
                  btnDisabledTextColor: kColorCommonButton,
                  btnElevation: 0,
                ),
                AVerticalSpace(15.0.scale()),
                ASeparatorLine(height: 1, color: KColorAppThemeColor),
                AVerticalSpace(15.0.scale()),
                // if (ratingReviewList != null && ratingReviewList.isNotEmpty)
                Text(
                  "Customer Rating",
                  style:
                      textStyleBoldCustomColor(18.0.scale(), KColorCommonText),
                ).align(Alignment.centerLeft),
                AVerticalSpace(15.0.scale()),
                // if (ratingReviewList != null && ratingReviewList!.isNotEmpty)
                //   // for (int i = 0; i < ratingReviewList.length; i++)
                //   UserReviewList(ratingReviewList!, callLoadMore)
                // else
                //   Text(
                //     "Customer Review Not Available!",
                //     style: textStyleBoldCustomColor(
                //         18.0.scale(), KColorCommonText),
                //   ).align(Alignment.center),
              ])
                  .leftPadding(8.0.scale())
                  .rightPadding(8.0.scale())
                  .scroll()
                  .expand()
            ]).widgetBgColor(Colors.white),
          )).pageBgColor(kColorAppBgColor),
    );
  }
}

BuildContext? _contextLoad;

class UserReviewList extends StatefulWidget {
  late List<RatingReviewData> ratingReviewList;
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
                    imageUrl: widget.ratingReviewList[i].profileImage ?? "",
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
                        widget.ratingReviewList[i].name ??
                            "" + " " + widget.ratingReviewList[i].lname!,
                        style: textStyleBoldCustomColor(
                            14.0.scale(), KColorCommonText),
                      ),
                      RatingBar.builder(
                        initialRating: double.parse(
                            widget.ratingReviewList[i].rating ?? ""),
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
                        widget.ratingReviewList[i].review ?? "",
                        style: textStyleBoldCustomColor(
                            14.0.scale(), KColorCommonText),
                        maxLines: 1,
                      ),
                      AVerticalSpace(4.0.scale()),
                      Text(
                        widget.ratingReviewList[i].createdAt ?? "",
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
