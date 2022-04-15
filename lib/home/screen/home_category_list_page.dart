import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get_it/get_it.dart';
import 'package:grambunny_customer/components/components.dart';
import 'package:grambunny_customer/generated/l10n.dart';
import 'package:grambunny_customer/hm_root/user_repository.dart';
import 'package:grambunny_customer/home/bloc/bloc.dart';
import 'package:grambunny_customer/home/home.dart';
import 'package:grambunny_customer/home/model/model.dart';
import 'package:grambunny_customer/services/herbarium_cust_shared_preferences.dart';
import 'package:grambunny_customer/side_navigation/side_navigation.dart';
import 'package:grambunny_customer/theme/theme.dart';
import 'package:grambunny_customer/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

const double _kTextBirthdateField = 60.0;
const double _kCommonHintTextFieldFontSize = 18.0;
const double _kCommonTexFieldFontSize = 14.0;
const double _kCommonPadding = 15.0;
const double _kMenuImageWidthSize = 70.0;
const double _kMenuImageHeightSize = 70.0;
const double _kCommonIconHeight = 20.0;

//List<String> categoryList = [];
List<CategoryListModel> _categoryList;
DriverList _driverDetail;

class HomeCategoryMainPage extends StatefulWidget {
  @override
  _HomeCategoryMainPageState createState() => _HomeCategoryMainPageState();
}

class _HomeCategoryMainPageState extends State<HomeCategoryMainPage> {
  String _cartCountValue = "0";
  GetIt locator1;
  CallsAndMessagesService _service;

  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    HomeState homeState = BlocProvider.of<HomeBloc>(context).state;

    if (homeState is HomeCategoryListPageState) {
      _categoryList = homeState.categoryListArray;
      _driverDetail = homeState.driverDetail;
    }
    locator1 = GetIt.instance;
    setupLocator();
    _service = locator1<CallsAndMessagesService>();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    // categoryStaticList();
    super.initState();
  }

  void setupLocator() {
    locator1.reset();
    locator1.registerSingleton(CallsAndMessagesService());
  }

  Future<void> _callNumber(String phoneNumber) async {
    // String number = phoneNumber;
    // await FlutterPhoneDirectCaller.callNumber(number);
    String url = 'tel:' + phoneNumber;
    url = url.replaceAll(RegExp(r'-'), '');
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      throw 'Could not launch $url';
    }
  }

//all the reload processes

  void showHideProgress(bool show) {
    BlocProvider.of<SideNavigatBloc>(context)
        .add(SideNavigationEventToggleLoadingAnimation(needToShow: show));
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _cartCountValue = sharedPrefs.getCartCount;
    });

    // TODO: implement build
    return BlocListener<HomeBloc, HomeState>(
        listenWhen: (prevState, curState) => ModalRoute.of(context).isCurrent,
        listener: (context, state) {
          print("print in listener ");
          if (state is HomeFromCategoryCartPageState) {
            showHideProgress(false);
            Navigator.of(context).pushNamed(HomeNavigator.homeShowCartPage);
          }
          if (state is HomeCategoryProductPageState) {
            print("call state");
            showHideProgress(false);
            Navigator.of(context).pushNamed(HomeNavigator.homeMenuListPage);
          }
          if (state is HomeEventErrorHandelCategorypageState) {
            showHideProgress(false);

            showSnackBar(state.message, context);
            BlocProvider.of<HomeBloc>(context)
                .add(HomeEventCategoryPageReset(state.driverDetail));
          }
          if (state is HomeInitial) {
            print("Back=====");
            Navigator.of(context).pop(true);
          }
        },
        child: SafeArea(
          bottom: false,
          child: Scaffold(
              // floatingActionButtonLocation:
              //     FloatingActionButtonLocation.miniEndDocked,
              // floatingActionButton: Container(
              //   width: 70.0.scale(),
              //   height: 70.0.scale(),
              //   child: FloatingActionButton(
              //     backgroundColor: KColorAppThemeColor,
              //     child: Stack(
              //       children: [
              //         ImageIcon(
              //           AssetImage('${imgPathGeneral}ic_cart_white.png'),
              //           color: Color(0xFF3A5A98),
              //         ),
              //         Text(
              //           _cartCountValue,
              //           style: textStyleCustomColor(
              //               12.0.scale(), KColorCommonText),
              //         ).leftPadding(23.0.scale())
              //       ],
              //     ),
              //     onPressed: () {
              //       if (sharedPrefs.getCartCount != "0") {
              //         showHideProgress(true);
              //         BlocProvider.of<HomeBloc>(context)
              //             .add(HomeEventCategoryCartBtnClick());
              //       }
              //     },
              //   ),
              // ).bottomPadding(20.0.scale()),
              body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AHeaderWidget(
                  strBackbuttonName: 'ic_red_btn_back.png',
                  backBtnVisibility: true,
                  btnBackOnPressed: () {
                    timerOnListener = false;
                    BlocProvider.of<HomeBloc>(context)
                        .add(HomeEventBackBtnClick());
                  },
                  strBtnRightImageName: 'ic_cart_white.png',
                  rightEditButtonVisibility: true,
                  headerSigninText: _cartCountValue,
                  btnEditOnPressed: () {
                    if (sharedPrefs.getCartCount != "0") {
                      showHideProgress(true);
                      BlocProvider.of<HomeBloc>(context)
                          .add(HomeEventCategoryCartBtnClick());
                    }
                  }),
              //   _SearchWidget(),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        AVerticalSpace(15.0.scale()),
                        if (_driverDetail != null)
                          GestureDetector(
                            onTap: () {
                              print("click");
                              Scaffold.of(context).openEndDrawer();
                            },
                            child: _DriverDetail(
                                _driverDetail, _callNumber, locator1),
                          ),
                        AVerticalSpace(15.0.scale()),
                        Text(
                          Stringss.current.txtBrowseCategory,
                          style: textStyleCustomColor(
                              _kCommonHintTextFieldFontSize.scale(),
                              KColorCommonText),
                        )
                            .align(Alignment.centerLeft)
                            .leftPadding(_kCommonPadding.scale())
                            .rightPadding(_kCommonPadding.scale()),
                        AVerticalSpace(15.0.scale()),
                        if (_categoryList != null && _categoryList.length > 0)
                          _GridLayout(showHideProgress),
                        AVerticalSpace(15.0.scale()),
                      ],
                    ),
                  ).expand()
                ],
              ).expand()
            ],
          ).pageBgColor(Colors.white)),
        ).lightStatusBarText().pageBgColor(kColorAppBgColor));
  }
}

//
// class _SearchWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Container(
//         color: KColorAppThemeColor,
//         height: _kTextBirthdateField.scale(),
//         width: double.infinity,
//         child: Row(
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             Image(
//               image: AssetImage('${imgPathGeneral}ic_search_logo.png'),
//             ).align(Alignment.center).leftPadding(5.0.scale()),
//           ],
//         )
//             .widgetBgColor(Colors.white)
//             .topPadding(10.0.scale())
//             .bottomPadding(10.0.scale())
//             .leftPadding(_kCommonPadding.scale())
//             .rightPadding(_kCommonPadding.scale()));
//   }
// }
class CallsAndMessagesService {
  void call(String number) => launch("tel:$number");

  void sendSms(String number) => launch("sms:$number");

  void sendEmail(String email) => launch("mailto:$email");
}

class _DriverDetail extends StatelessWidget {
  double initialRat = 3;
  DriverList driverDetail;
  Function callNumber;

  CallsAndMessagesService service;
  GetIt locator1;

  _DriverDetail(this.driverDetail, this.callNumber, this.locator1);

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

  // _callNumber(String mobNo) async {
  //   bool res = await FlutterPhoneDirectCaller.callNumber(mobNo);
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
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
            child: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          children: [
            Container(
              width: 50.0.scale(),
              height: 50.0.scale(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: CachedNetworkImage(
                  imageUrl:
                      UserRepository.getProfileUrl() + driverDetail.profileImg1,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
              ),
            ),
            AHorizontalSpace(10.0.scale()),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      driverDetail.name,
                      style: textStyleBoldCustomLargeColor(
                          18.0.scale(), KColorCommonText),
                    ).leftPadding(5.0.scale()),
                    AHorizontalSpace(3.0.scale()),
                    Image(
                      image: AssetImage('${imgPathGeneral}ic_bluetick.png'),
                    ),
                  ],
                ),
                AVerticalSpace(5.0.scale()),
                Row(
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
                      '$initialRat (${_driverDetail.ratingCount})',
                      style: textStyleCustomColor(
                          12.0.scale(), kColorTextFieldText),
                    )
                  ],
                ),
                AVerticalSpace(5.0.scale()),
                if (_driverDetail.marketArea != null)
                  Text(
                    _driverDetail.marketArea,
                    style: textStyleBoldCustomColor(
                        12.0.scale(), kColorTextFieldText),
                  ).leftPadding(5.0.scale()),
              ],
            ).expand()
          ],
        ).leftPadding(10.0.scale()).rightPadding(5.0.scale()),
        AVerticalSpace(10.0.scale()),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image(
                          fit: BoxFit.fill,
                          image:
                              AssetImage('${imgPathGeneral}ic_phone_icon.png'),
                          width: 15.0.scale(),
                          height: 15.0.scale(),
                        ),
                        AHorizontalSpace(5.0.scale()),
                        if (_driverDetail.mobNo != null)
                          GestureDetector(
                            child: Text(
                              _driverDetail.mobNo,
                              style: textStyleBoldCustomColor(
                                  12.0.scale(), kColorTextFieldText),
                            ),
                            onTap: () {
                              //service.call(_driverDetail.mobNo);
                              print("tap");
                              // launch("tel:${_driverDetail.mobNo}");
                              //set the number here
                              _callNumber(_driverDetail.mobNo);
                            },
                          )
                      ],
                    ),
                  ],
                ),
              ],
            ),
            AVerticalSpace(5.0.scale()),
          ],
        ).leftPadding(10.0.scale())
      ],
    ).topPadding(10.0.scale()).bottomPadding(10.0.scale()))
        .leftPadding(15.0.scale())
        .rightPadding(15.0.scale());
  }
}

class _BannerWidget extends StatefulWidget {
  @override
  __BannerWidgetState createState() => __BannerWidgetState();
}

class __BannerWidgetState extends State<_BannerWidget> {
  final CarouselController _controller = CarouselController();

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(children: [
      CarouselSlider(
        options: CarouselOptions(
            height: 200.0,
            autoPlay: true,
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
        carouselController: _controller,
        items: [1, 2].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Image.network(
                    "https://news.artnet.com/app/news-upload/2016/04/Lemon-Kush-oakland-museum.jpg",
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes
                              : null,
                        ),
                      );
                    },
                  ));
            },
          );
        }).toList(),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [1, 2].asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => _controller.animateToPage(entry.key),
            child: Container(
              width: 7.0,
              height: 7.0,
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.white)
                      .withOpacity(_current == entry.key ? 0.9 : 0.4)),
            ),
          );
        }).toList(),
      ),
    ]);
  }
}

// class _TopBrand extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return SizedBox(
//       height: 200.0,
//       child: ListView.builder(
//         physics: ClampingScrollPhysics(),
//         shrinkWrap: true,
//         scrollDirection: Axis.horizontal,
//         itemCount: 5,
//         itemBuilder: (BuildContext context, int index) => Card(
//           child: Container(
//             width: MediaQuery.of(context).size.width * 0.6,
//             child: Center(
//                 child: Image(
//               image: AssetImage('${imgPathGeneral}ic_roll.jpeg'),
//               height: 40,
//             ).align(Alignment.center)),
//           ),
//         ),
//       ),
//     );
//   }
// }

class _GridLayout extends StatefulWidget {
  Function showHideProgress;

  _GridLayout(void Function(bool show) showHideProgress) {
    this.showHideProgress = showHideProgress;
  }

  @override
  __GridLayoutState createState() => __GridLayoutState();
}

class __GridLayoutState extends State<_GridLayout> {
  int j = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GoogleGrid(
      gap: 16,
      padding: const EdgeInsets.all(16),
      children: [
        for (int i = 0; i < _categoryList.length; i++)
          GestureDetector(
            onTap: () {
              print("demo${i}");
              widget.showHideProgress(true);
              BlocProvider.of<HomeBloc>(context).add(
                  HomeEventCatgoryDetailClick(_categoryList[i], _driverDetail,
                      _categoryList[i].category_id));
              //BlocProvider.of<SideNavigatBloc>(context).add(event)
            },
            child: Container(
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
              height: 120.0.scale(),
              width: 170.0.scale(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      width: 70.0.scale(),
                      height: 70.0.scale(),
                      imageUrl: _categoryList[i].cat_image,
                      fit: BoxFit.fill,
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error),
                    ),
                  ).align(Alignment.center),
                  Text(
                    _categoryList[i].category,
                    textAlign: TextAlign.center,
                    style: textStyleBoldCustomColor(
                        _kCommonTexFieldFontSize.scale(), KColorCommonText),
                  ),
                ],
              ).topPadding(5.0.scale()).bottomPadding(5.0.scale()),
            ),
          ),
      ],
    );
  }
}

class RandomColorModel {
  Random random = Random();

  Color getColor() {
    return Color.fromARGB(random.nextInt(200), random.nextInt(200),
        random.nextInt(200), random.nextInt(200));
  }
}
