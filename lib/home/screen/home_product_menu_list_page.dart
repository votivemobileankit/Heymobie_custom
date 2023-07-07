import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grambunny_customer/components/a_widget_extensions.dart';
import 'package:grambunny_customer/components/components.dart';
import 'package:grambunny_customer/dialogs/dlg_two_button.dart';
import 'package:grambunny_customer/generated/l10n.dart';
import 'package:grambunny_customer/hm_root/hm_root.dart';
import 'package:grambunny_customer/home/components/home_menu_list_item.dart';
import 'package:grambunny_customer/home/home.dart';
import 'package:grambunny_customer/home/model/product_list_model.dart';
import 'package:grambunny_customer/services/services.dart';
import 'package:grambunny_customer/side_navigation/side_navigation.dart';
import 'package:grambunny_customer/theme/theme.dart';
import 'package:grambunny_customer/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/driver_list_model.dart';

const double _kTitleBottomMargin = 20.0;
const double _kDescBottomMargin = 20.0;
const double _kBtnWidth = 135.0;
const double _kSpaceBetweenButtons = 20;
const double _kCommonFontSize = 15.0;
const double _kCommonCartMediumFontSize = 14.0;
const double _kClosedTextFontSize = 20.0;
const double _kAddtoCartDialogRadius = 20.0;
const double _kMenuitemNameTextFontSize = 20.0;
const double _kSearchWidgetHeight = 60.0;
late String _driverId, _categoryId;
late CategoryListModel _categoryListModel;

class ProductMenuListPage extends StatefulWidget {
  @override
  _ProductMenuListPageState createState() => _ProductMenuListPageState();
}

class _ProductMenuListPageState extends State<ProductMenuListPage>
    with TickerProviderStateMixin {
  late List<ProductListMenu> _productList;
  late List<ProductListMenu> _productListSearch;
  late DriverList _driverDetail;

  // FilterListModel _filterListModel;
  // List<Subcategories> _subcategories;
  // List<Weights> _weights;
  // List<Brands> _brands;
  // List<Types> _types;
  late TabController primaryTC;
  late GoogleMapController _cameraController;
  late bool isListView = true;
  late double currentLat, currentLong;
  late Set<Marker> _markers = {};
  late BitmapDescriptor pinLocationIcon;
  late CustomInfoWindowController _customInfoWindowController;
  String _cartCountValue = "0";
  bool innerBoxScrolled = false;
  int _activeTabIndex = 0;

  // DefaultCacheManager manager = new DefaultCacheManager();
  // manager.emptyCache();

  final List<Tab> myTabs = List.generate(
    1,
    (index) => Tab(text: 'TAB $index'),
  );

  void showHideProgress(bool show) {
    BlocProvider.of<SideNavigatBloc>(context)
        .add(SideNavigationEventToggleLoadingAnimation(needToShow: show));
  }

  TextEditingController searchTextController = TextEditingController();
  late FocusNode focusNode1;

  @override
  void initState() {
    print("=========  " + UserRepository.getProfileUrl()!);
    focusNode1 = FocusNode();
    _customInfoWindowController = CustomInfoWindowController();
    primaryTC = new TabController(length: 1, vsync: this);
    primaryTC.addListener(_setActiveTabIndex);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    HomeState homeState = BlocProvider.of<HomeBloc>(context).state;
    _productList = [];
    _productListSearch = [];
    // _subcategories = [];
    // _weights = [];
    // _brands = [];
    // _types = [];

    if (homeState is HomeCategoryProductPageState) {
      _productList = homeState.productListArray;
      _productListSearch = homeState.productListArray;
      _driverDetail = homeState.driverDetail;
      _categoryListModel = homeState.categoryListModel;
      _driverId = homeState.vendorId;

      _categoryId = homeState.category_id;
      _cartCountValue = homeState.cartCount;
      // print(_subcategories[1].subcategory);
    }

    super.initState();
  }

  void _setActiveTabIndex() {
    if (primaryTC.indexIsChanging) {
      setState(() {
        _activeTabIndex = primaryTC.index;

        // print(_activeTabIndex);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    setState(() {
      _cartCountValue = sharedPrefs.getCartCount;
    });
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    var pinnedHeaderHeight = statusBarHeight + kToolbarHeight;
    return BlocListener<HomeBloc, HomeState>(
        listenWhen: (prevState, curState) => ModalRoute.of(context)!.isCurrent,
        listener: (context, state) {
          if (state is HomeCategoryListPageState) {
            print("call state");
            // RefreshCartValue().CartCountValue
            Navigator.of(context).pop();
          }
          if (state is HomeCategoryProductPageState) {
            showHideProgress(false);
            print("call Again============");
            setState(() {
              _productList = [];
              _productListSearch = [];
              _productList = state.productListArray;
              _productListSearch = state.productListArray;
              _categoryListModel = state.categoryListModel;
              _driverDetail = state.driverDetail;
              _driverId = state.vendorId;

              _categoryId = state.category_id;
              _cartCountValue = state.cartCount;
            });
          }
          if (state is HomeCartPageState) {
            showHideProgress(false);
            Navigator.of(context).pushNamed(HomeNavigator.homeShowCartPage);
          }

          if (state is HomeEventErrorHandelProductListPage) {
            showHideProgress(false);
            showSnackBar(state.message, context);
            BlocProvider.of<HomeBloc>(context).add(
                HomeEventApplyResetProductList(
                    driverId: _driverId,
                    categoryId: _categoryId,
                    subCategoryId: _strSubcategoryId,
                    weight: state.weight,
                    type: state.type,
                    brand: state.brand,
                    potencyCbd: state.potencyCbd,
                    potencyThc: state.potencyThc,
                    popular: "",
                    driverDetail: _driverDetail));
          } else if (state is HomeEventMessageShowState) {
            showHideProgress(false);
            showSnackBar(state.message, context);
            String subCateg = "",
                strWeight = "",
                strBrand = "",
                strType = "",
                strPotencyCbd = "",
                strPotencyThc = "";
            if (_strSubcategoryId == "0" && _strSubcategoryId == "") {
              subCateg = "";
            } else {
              subCateg = _strSubcategoryId;
            }
            if (_strTypeHint == "Type") {
              strType = "";
            } else {
              strType = _strTypeHint;
            }
            if (_strWeightHint == "Weight") {
              strWeight = "";
            } else {
              strWeight = _strWeightHint;
            }
            if (_strBrandHint == "Brand") {
              strBrand = "";
            } else {
              strBrand = _strBrandHint;
            }
            if (_strPotencyCbdEnd == "") {
              strPotencyCbd = "";
            } else {
              strPotencyCbd = _strPotencyCbdEnd;
            }
            if (_strPotencyThcEnd == "") {
              strPotencyThc = "";
            } else {
              strPotencyThc = _strPotencyThcEnd;
            }
            BlocProvider.of<HomeBloc>(context).add(
                HomeEventApplyResetProductList(
                    driverId: _driverId,
                    categoryId: _categoryId,
                    subCategoryId: "",
                    weight: "",
                    type: "",
                    brand: "",
                    potencyCbd: "",
                    potencyThc: "",
                    popular: "",
                    driverDetail: _driverDetail));
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
                      HomeEventApplyResetProductList(
                          driverId: _driverId,
                          categoryId: _categoryId,
                          subCategoryId: _strSubcategoryId,
                          weight: "",
                          type: "",
                          brand: "",
                          potencyCbd: "",
                          potencyThc: "",
                          popular: "",
                          driverDetail: _driverDetail));
                },
                btn1OnPressed: () {
                  BlocProvider.of<HomeBloc>(context).add(
                      HomeEventAddToCartBtnClick(1, state.productId, _driverId,
                          0, _driverDetail, "1", ""));
                });
          }
          if (state is HomeMenuItemDetailsPageState) {
            Navigator.of(context).pushNamed(HomeNavigator.homeMenuDetailPage);
          }
        },
        child: SafeArea(
                bottom: false,
                child: Scaffold(
                  body: DefaultTabController(
                    length: 1,
                    child: NestedScrollView(
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) {
                        innerBoxScrolled = innerBoxIsScrolled;

                        return <Widget>[
                          SliverAppBar(
                            expandedHeight: 200.0.scale(),
                            floating: true,
                            pinned: true,
                            elevation: 1,
                            automaticallyImplyLeading: false,
                            leading: InkWell(
                              onTap: () {
                                print("back");
                                BlocProvider.of<HomeBloc>(context)
                                    .add(HomeEventBackBtnClick());
                              },
                              child: Image(
                                color: Colors.white,
                                image: AssetImage(
                                    '${imgPathGeneral}ic_red_btn_back.png'),
                                height: 40.0.scale(),
                              )
                                  .topPadding(6.0.scale())
                                  .leftPadding(5.0.scale()),
                            ),
                            backgroundColor: innerBoxIsScrolled == true
                                ? KColorAppThemeColor
                                : KColorAppThemeColor,
                            flexibleSpace: FlexibleSpaceBar(
                              collapseMode: CollapseMode.pin,
                              centerTitle: true,
                              background: _DriverDetailWidget(_driverDetail,
                                  showHideProgress, _cartCountValue),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  if (innerBoxIsScrolled == true)
                                    Text(
                                      _categoryListModel.category,
                                      style: textStyleCustomColor(
                                          20.0.scale(), Colors.black),
                                    )
                                        .leftPadding(
                                          60.0.scale(),
                                        )
                                        .topPadding(15.0.scale())
                                  else
                                    Text(
                                      "",
                                      style: textStyleCustomColor(
                                          20.0.scale(), Colors.black),
                                    )
                                ],
                              ),
                            ),
                          ),
                          SliverPersistentHeader(
                            delegate: _SliverAppBarDelegate(
                                TabBar(
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  indicatorColor: KColorAppThemeColor,
                                  controller: primaryTC,
                                  indicatorWeight: 6.0.scale(),
                                  labelColor: Colors.black87,
                                  unselectedLabelColor: Colors.grey,
                                  tabs: [
                                    Tab(
                                      child: Text(
                                        "Menu",
                                        style: textStyleCustomColor(
                                            13.0.scale(), Colors.black),
                                        textAlign: TextAlign.center,
                                      ).align(Alignment.center),
                                    ),
                                    // Tab(
                                    //   child: Text(
                                    //     "Details",
                                    //     style: textStyleCustomColor(
                                    //         13.0.scale(), Colors.black),
                                    //   ),
                                    // ),
                                  ],
                                ),
                                _activeTabIndex,
                                _driverDetail,
                                focusNode1,
                                searchTextController),
                            pinned: true,
                            floating: false,
                          ),
                        ];
                      },
                      body: TabBarView(
                        controller: primaryTC,
                        physics: ScrollPhysics(),
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                            },
                            child: _TabProductMenu(
                                _productList,
                                _productListSearch,
                                _driverId,
                                showHideProgress,
                                _driverDetail,
                                innerBoxScrolled),
                          ),
                          //_TabDetailScreen(_driverDetail),
                        ],
                      ),
                    ),
                  ).pageBgColor(Colors.white),
                ).pageBgColor(kColorAppBgColor))
            .pageBgColor(kColorAppBgColor));
  }
}

// class MyDynamicHeader extends SliverPersistentHeaderDelegate {
//   int index = 0;
//
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return LayoutBuilder(builder: (context, constraints) {
//       final Color color = Colors.primaries[index];
//       final double percentage =
//           (constraints.maxHeight - minExtent) / (maxExtent - minExtent);
//
//       if (++index > Colors.primaries.length - 1) index = 0;
//
//       return Container(
//         decoration: BoxDecoration(
//             boxShadow: [BoxShadow(blurRadius: 4.0, color: Colors.black45)],
//             gradient: LinearGradient(colors: [Colors.blue, color])),
//         height: constraints.maxHeight,
//         child: SafeArea(
//             child: Center(
//           child: CircularProgressIndicator(
//             value: percentage,
//             valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//           ),
//         )),
//       );
//     });
//   }
//
//   @override
//   bool shouldRebuild(SliverPersistentHeaderDelegate _) => true;
//
//   @override
//   double get maxExtent => 250.0;
//
//   @override
//   double get minExtent => 80.0;
// }

const double _kCommonIconHeight = 20.0;

class _DriverDetailWidget extends StatelessWidget {
  double initialRat = 3;
  DriverList driverDetail;
  Function showHideProgress;
  String cartCountValue;

  _DriverDetailWidget(
      this.driverDetail, this.showHideProgress, this.cartCountValue) {
    initialRat = double.parse(driverDetail.avgRating);
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
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        AHeaderWidget(
            strBackbuttonName: 'ic_red_btn_back.png',
            backBtnVisibility: false,
            btnBackOnPressed: () {
              // BlocProvider.of<HomeBloc>(context).add(HomeEventBackBtnClick());
            },
            headerSigninText: cartCountValue,
            strBtnRightImageName: 'ic_cart_white.png',
            rightEditButtonVisibility: true,
            btnEditOnPressed: () {
              if (sharedPrefs.getCartCount != "0") {
                showHideProgress(true);
                BlocProvider.of<HomeBloc>(context)
                    .add(HomeEventCartPageBtnClick(driverDetail));
              }
            }),
        AVerticalSpace(5.0.scale()),
        Row(
          children: [
            Container(
              width: 50.0.scale(),
              height: 50.0.scale(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: CachedNetworkImage(
                  imageUrl: UserRepository.getProfileUrl()! +
                      driverDetail.profileImg1,
                  fit: BoxFit.cover,
                  placeholder: (context, url) {
                    return Image(
                      image: AssetImage(
                          '${imgPathGeneral}ic_no_image_available.png'),
                    );
                  },
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
                      driverDetail.name + " " + driverDetail.lastName,
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
                      '$initialRat (${driverDetail.ratingCount})',
                      style: textStyleCustomColor(
                          12.0.scale(), kColorTextFieldText),
                    )
                  ],
                ),
                AVerticalSpace(5.0.scale()),
                Text(
                  driverDetail.marketArea,
                  style: textStyleBoldCustomColor(
                      12.0.scale(), kColorTextFieldText),
                ).leftPadding(5.0.scale()),
              ],
            ).expand()
          ],
        ).leftPadding(10.0.scale()).rightPadding(10.0.scale()),
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
                        if (driverDetail.mobNo != null)
                          GestureDetector(
                            child: Text(
                              driverDetail.mobNo,
                              style: textStyleBoldCustomColor(
                                  12.0.scale(), kColorTextFieldText),
                            ),
                            onTap: () {
                              _callNumber(driverDetail.mobNo);
                            },
                          )
                      ],
                    ),
                  ],
                ),
              ],
            ).leftPadding(14.0.scale()).rightPadding(14.0.scale()),
            AVerticalSpace(5.0.scale()),
          ],
        ).leftPadding(10.0.scale()).rightPadding(10.0.scale())
      ],
    ).widgetBgColor(Colors.white);
  }
}

// class RefreshCartValue extends InheritedWidget {
//   RefreshCartValue({
//     Key key,
//     @required Widget child,
//   }) : super(key: key, child: child);
//
//   String CartCountValue = "0";
//
//   static RefreshCartValue of(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<RefreshCartValue>();
//   }
//
//   void toggleColor() {
//     CartCountValue = sharedPrefs.getCartCount;
//     print("refresh set to $CartCountValue");
//   }
//
//   @override
//   bool updateShouldNotify(RefreshCartValue oldWidget) =>
//       CartCountValue != oldWidget.CartCountValue;
// }

String _strTypeHint = "Type";
String _strSubcategory = "Subcategory";
String _strWeightHint = "Weight";
String _strBrandHint = "Brand";
String _strPotencyCbdStart = "";
String _strPotencyCbdEnd = "";
String _strPotencyThcStart = "";
String _strPotencyThcEnd = "";
String _strSubcategoryId = "";

class _TabProductMenu extends StatefulWidget {
  List<ProductListMenu> productList;
  List<ProductListMenu> productListSearch;
  String driverId;

  Function showHideProgress;
  DriverList driverDetail;
  bool innerBoxIsScrolled;

  _TabProductMenu(this.productList, this.productListSearch, this.driverId,
      this.showHideProgress, this.driverDetail, this.innerBoxIsScrolled);

  @override
  __TabProductMenuState createState() => __TabProductMenuState();
}

class __TabProductMenuState extends State<_TabProductMenu> {
  // TextEditingController searchTextController = TextEditingController();
  ScrollController? controller;

  @override
  void initState() {
    controller = new ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    print(controller!.position.extentAfter);
    if (controller!.position.extentAfter < 500) {
      // setState(() {
      //   items.addAll(new List.generate(42, (index) => 'Inserted $index'));
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      height: 200.0.scale(),
      child: Column(mainAxisSize: MainAxisSize.max, children: [
        AVerticalSpace(5.0.scale()),
        if (widget.productList != null && widget.productList.length > 0)
          ListView.builder(
            shrinkWrap: false,
            physics: ClampingScrollPhysics(),
            itemCount: widget.productList.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                child: MenuListRowItem(
                    widget.productList[index], widget.driverDetail),
                onTap: () {
                  // FocusScope.of(context).unfocus();
                  // new TextEditingController().clear();
                },
              );
            },
          ).expand()
      ]),
    );
  }
}

// class _FilterWidget2 extends StatefulWidget {
//   Function showHideProgress;
//
//   _FilterWidget2(this.showHideProgress);
//
//   @override
//   __FilterWidget2State createState() => __FilterWidget2State();
// }
//
// class __FilterWidget2State extends State<_FilterWidget2> {
//   int _valueSortBy = 1;
//
//   @override
//   Widget build(BuildContext context1) {
//     // TODO: implement build
//     return Row(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10.0),
//             border: Border.all(color: KColorAppThemeColor, width: 4.0),
//             color: KColorBgTabHeaderMenuFilter,
//           ),
//           child: Row(
//             children: [
//               InkWell(
//                 child: Text("Potency",
//                         style: textStyleCustomColor(
//                             14.0.scale(), KColorCommonText))
//                     .align(Alignment.centerLeft),
//                 onTap: () {
//                   showDialog(
//                     context: context1,
//                     barrierColor: Colors.black26,
//                     barrierDismissible: false,
//                     builder: (context) {
//                       return _getPotencySeekbar(
//                           context: context,
//                           contextmain: context1,
//                           showHideProgress: widget.showHideProgress);
//                     },
//                   );
//                 },
//               ),
//               Image(
//                 image: AssetImage('${imgPathGeneral}ic_menu_dropdown_icon.png'),
//                 width: 10,
//                 height: 7,
//               )
//             ],
//           )
//               .leftPadding(5.0.scale())
//               .rightPadding(5.0.scale())
//               .topPadding(15.0.scale())
//               .bottomPadding(15.0.scale()),
//         ),
//         AHorizontalSpace(4.0.scale()),
//         Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10.0),
//             border: Border.all(color: KColorAppThemeColor, width: 4.0),
//             color: KColorBgTabHeaderMenuFilter,
//           ),
//           child: DropdownButton(
//             value: _valueSortBy,
//             items: [
//               DropdownMenuItem(
//                 child: Text("Popular"),
//                 value: 1,
//               ),
//               DropdownMenuItem(
//                 child: Text("Price:Low to High"),
//                 value: 2,
//               ),
//               DropdownMenuItem(
//                 child: Text("Price:High to Low"),
//                 value: 3,
//               ),
//               DropdownMenuItem(
//                 child: Text("Potency:High to Low"),
//                 value: 4,
//               ),
//             ],
//             onChanged: (value) {
//               setState(() {
//                 _valueSortBy = value;
//               });
//             },
//             hint: Text(
//               "SortBy",
//               style: textStyleCustomColor(14.0.scale(), KColorCommonText),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }

class _TabDetailScreen extends StatelessWidget {
  DriverList driverDetail;

  _TabDetailScreen(this.driverDetail);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 540.0.scale(),
      child: ListView(
        children: [
          Container(
            height: 200.0.scale(),
            child: _MapWidget(driverDetail),
          ),
          AVerticalSpace(15.0.scale()),
          Column(
            children: [
              Row(
                children: [
                  Image(
                    image: AssetImage('${imgPathGeneral}ic_phone_icon.png'),
                    fit: BoxFit.fill,
                  ),
                  AHorizontalSpace(5.0.scale()),
                  Text(
                    driverDetail.mobNo!,
                    style: textStyleCustomColor(
                        _kCommonFontSize.scale(), KColorCommonText),
                  ),
                ],
              ),
              AVerticalSpace(15.0.scale()),
              Row(
                children: [
                  Image(
                    image: AssetImage('${imgPathGeneral}ic_clock_icon.png'),
                    fit: BoxFit.fill,
                  ),
                  AHorizontalSpace(5.0.scale()),
                  Text(
                    Stringss.current.txtClosed,
                    style: textStyleCustomColor(_kCommonFontSize.scale(),
                        KColorClosedTextCategoryDetailPage),
                  ),
                ],
              ),
              AVerticalSpace(10.0.scale()),
              Row(
                children: [
                  Text(
                    Stringss.current.txtMonday,
                    style: textStyleCustomColor(
                        _kCommonFontSize.scale(), KColorCommonText),
                  ),
                  AHorizontalSpace(5.0.scale()),
                  Text(
                    "6:00 am to 10:00 pm",
                    style: textStyleCustomColor(
                        _kCommonFontSize.scale(), KColorCommonText),
                  ),
                ],
              ),
              AVerticalSpace(10.0.scale()),
              Row(
                children: [
                  Text(
                    Stringss.current.txtTue,
                    style: textStyleCustomColor(
                        _kCommonFontSize.scale(), KColorCommonText),
                  ),
                  AHorizontalSpace(5.0.scale()),
                  Text(
                    "6:00 am to 10:00 pm",
                    style: textStyleCustomColor(
                        _kCommonFontSize.scale(), KColorCommonText),
                  ),
                ],
              ),
              AVerticalSpace(10.0.scale()),
              Row(
                children: [
                  Text(
                    Stringss.current.txtWed,
                    style: textStyleCustomColor(
                        _kCommonFontSize.scale(), KColorCommonText),
                  ),
                  AHorizontalSpace(5.0.scale()),
                  Text(
                    "6:00 am to 10:00 pm",
                    style: textStyleCustomColor(
                        _kCommonFontSize.scale(), KColorCommonText),
                  ),
                ],
              ),
              AVerticalSpace(10.0.scale()),
              Row(
                children: [
                  Text(
                    Stringss.current.txtThur,
                    style: textStyleCustomColor(
                        _kCommonFontSize.scale(), KColorCommonText),
                  ),
                  AHorizontalSpace(5.0.scale()),
                  Text(
                    "6:00 am to 10:00 pm",
                    style: textStyleCustomColor(
                        _kCommonFontSize.scale(), KColorCommonText),
                  ),
                ],
              ),
              AVerticalSpace(10.0.scale()),
              Row(
                children: [
                  Text(
                    Stringss.current.txtFri,
                    style: textStyleCustomColor(
                        _kCommonFontSize.scale(), KColorCommonText),
                  ),
                  AHorizontalSpace(5.0.scale()),
                  Text(
                    "6:00 am to 10:00 pm",
                    style: textStyleCustomColor(
                        _kCommonFontSize.scale(), KColorCommonText),
                  ),
                ],
              ),
              AVerticalSpace(10.0.scale()),
              Row(
                children: [
                  Text(
                    Stringss.current.txtSat,
                    style: textStyleCustomColor(
                        _kCommonFontSize.scale(), KColorCommonText),
                  ),
                  AHorizontalSpace(5.0.scale()),
                  Text(
                    "6:00 am to 10:00 pm",
                    style: textStyleCustomColor(
                        _kCommonFontSize.scale(), KColorCommonText),
                  ),
                ],
              ),
              AVerticalSpace(10.0.scale()),
              Row(
                children: [
                  Text(
                    Stringss.current.txtSun,
                    style: textStyleCustomColor(
                        _kCommonFontSize.scale(), KColorCommonText),
                  ),
                  AHorizontalSpace(5.0.scale()),
                  Text(
                    "6:00 am to 10:00 pm",
                    style: textStyleCustomColor(
                        _kCommonFontSize.scale(), KColorCommonText),
                  ),
                ],
              ),
              AVerticalSpace(10.0.scale()),
              Row(
                children: [
                  Text(
                    Stringss.current.txtThur,
                    style: textStyleCustomColor(
                        _kCommonFontSize.scale(), KColorCommonText),
                  ),
                  AHorizontalSpace(5.0.scale()),
                  Text(
                    "6:00 am to 10:00 pm",
                    style: textStyleCustomColor(
                        _kCommonFontSize.scale(), KColorCommonText),
                  ),
                ],
              ),
              AVerticalSpace(15.0.scale()),
              Row(
                children: [
                  Image(
                    image: AssetImage('${imgPathGeneral}ic_mail_icon.png'),
                    fit: BoxFit.fill,
                  ),
                  AHorizontalSpace(5.0.scale()),
                  Text(
                    driverDetail.email,
                    style: textStyleCustomColor(
                        _kCommonFontSize.scale(), KColorCommonText),
                  ),
                ],
              ),
              AVerticalSpace(15.0.scale()),
              Column(
                children: [
                  Text(
                    Stringss.current.txtAmenities,
                    style: textStyleCustomColor(
                        _kClosedTextFontSize.scale(), KColorCommonText),
                  ).align(Alignment.centerLeft),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Age: 18+",
                    style: textStyleCustomColor(
                        _kCommonFontSize.scale(), KColorCommonText),
                  ).align(Alignment.centerLeft),
                ],
              )
            ],
          ).leftPadding(14.0.scale()).rightPadding(14.0.scale())
        ],
      ),
    );
  }
}

class _MapWidget extends StatefulWidget {
  DriverList driverDetail;

  _MapWidget(this.driverDetail);

  @override
  __MapWidgetState createState() => __MapWidgetState();
}

class __MapWidgetState extends State<_MapWidget> {
  // Function markerCenterPointCall;
  late BitmapDescriptor pinLocationIcon;
  Set<Marker> markers = {};

  late GoogleMapController cameraController;

  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.974514956322324, -117.77841125765117),
    zoom: 15,
  );

  Future<void> _markerPositionWidget() async {
    if (pinLocationIcon == null) {
      await setCustomMapPin();
    }
    setState(() {
      if (widget.driverDetail.lat != 0) {
        markers.add(Marker(
            markerId: MarkerId("1"),
            onTap: () {},
            position: LatLng(double.parse(widget.driverDetail.lat),
                double.parse(widget.driverDetail.lng)),
            icon: pinLocationIcon));
      }
    });
  }

  Future<void> setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: effectivePixelRatio()),
        '${imgPathGeneral}ic_marker_driver.png');
    print("created pin icon");
  }

  CameraPosition markerCenterPoint(double lat, double lon) {
    setState(() {
      pinPosition = LatLng(lat, lon);
      _kGooglePlex = CameraPosition(
          target: pinPosition!,
          zoom: /*_selectedButton == FindBookingLink.CLINICS ? 13.0 :*/ 15);
      CameraUpdate update = CameraUpdate.newCameraPosition(_kGooglePlex);

      cameraController.animateCamera(update);
    });
    return _kGooglePlex;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GoogleMap(
      onTap: (position) {},
      onCameraMove: (position) {},
      zoomControlsEnabled: false,
      zoomGesturesEnabled: true,
      scrollGesturesEnabled: true,
      myLocationButtonEnabled: false,
      myLocationEnabled: pinPosition != null,
      compassEnabled: false,
      markers: markers,
      mapType: MapType.normal,
      initialCameraPosition: _kGooglePlex,
      onMapCreated: (GoogleMapController controller) {
        //  _controller.complete(controller);

        cameraController = controller;
        // markerCenterPointCall(
        //     driverInfoList[0].driverLat, driverInfoList[0].driverLong);
        markerCenterPoint(double.parse(widget.driverDetail.lat),
            double.parse(widget.driverDetail.lng));
        _markerPositionWidget();
      },
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  late List<Subcategories> subcategories;
  late List<Weights> weights;
  late List<Brands> brands;
  late List<Types> types;
  late Function showHideProgress;
  late DriverList driverDetail;

  late int activeTabIndex;
  late bool returnValue = false;
  late FocusNode focusNode1;
  late TextEditingController searchTextController;

  _SliverAppBarDelegate(this._tabBar, this.activeTabIndex, this.driverDetail,
      this.focusNode1, this.searchTextController);

  final TabBar _tabBar;

  // final TabBar _tabBar1;

  @override
  double get maxExtent => 120.0;

  @override
  double get minExtent => 120.0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _tabBar,
          if (activeTabIndex == 0)
            Container(
                    color: Colors.white,
                    height: _kSearchWidgetHeight.scale(),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image:
                              AssetImage('${imgPathGeneral}ic_search_logo.png'),
                        ).align(Alignment.center).leftPadding(5.0.scale()),
                        TextField(
                          onChanged: (text) {
                            activeTabIndex = 0;
                            if (text.length > 2) {
                              BlocProvider.of<HomeBloc>(context).add(
                                  HomeEventProductMenuSearch(
                                      _driverId,
                                      _categoryId,
                                      text,
                                      _categoryListModel,
                                      driverDetail));
                              print("text $text");
                            } else if (text.length == 0) {
                              BlocProvider.of<HomeBloc>(context).add(
                                  HomeEventProductMenuSearch(
                                      _driverId,
                                      _categoryId,
                                      "",
                                      _categoryListModel,
                                      driverDetail));
                            }
                          },
                          controller: searchTextController,
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          cursorColor: KColorTextFieldCommonHint,
                          decoration: InputDecoration(
                            hintText: "Search",
                            hintStyle: textStyleCustomColor(
                                12.0.scale().scale(), KColorTextGrey),
                            fillColor: Colors.white,
                            filled: true,
                            border: InputBorder.none,
                          ),
                        ).expand(),
                      ],
                    ).leftPadding(3.0.scale()).rightPadding(3.0.scale()))
                .expand(),
          AVerticalSpace(10.0.scale())
          // _FilterWidget(subcategories, weights, brands, types, showHideProgress,
          //     driverDetail),
        ],
      ),
    ); //Whatever you want to use here ();
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    // if (oldDelegate.activeTabIndex == 0) {
    //   activeTabIndex = 1;
    // } else if (oldDelegate.activeTabIndex == 1) {
    //   activeTabIndex = 0;
    // } else {
    //   activeTabIndex = 1;
    // }
    return false;
  }
}
