import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grambunny_customer/aboutus/aboutus.dart';
import 'package:grambunny_customer/aboutus/aboutus_navigator.dart';
import 'package:grambunny_customer/components/components.dart';
import 'package:grambunny_customer/hm_root/hm_root.dart';
import 'package:grambunny_customer/home/home.dart';
import 'package:grambunny_customer/orderhistory/orderhistory.dart';
import 'package:grambunny_customer/privacy_policy/privacy_policy.dart';
import 'package:grambunny_customer/profile/profile.dart';
import 'package:grambunny_customer/services/services.dart';
import 'package:grambunny_customer/setting/setting.dart';
import 'package:grambunny_customer/theme/theme.dart';

import '../../utils/utils.dart';
import '../side_navigation.dart';

class SideNavigationHomeTab extends StatefulWidget {
  final UserRepository userRepository;

  SideNavigationHomeTab({this.userRepository});

  @override
  _SideNavigationHomeTabState createState() => _SideNavigationHomeTabState();
}

class _SideNavigationHomeTabState extends State<SideNavigationHomeTab> {
  SideNavigationTab _selectedTab;
  bool _showLoadingAnimation;
  ProfileBloc profileBloc;
  HomeBloc homeBloc;
  SettingBloc settingBloc;
  AboutBloc aboutusBloc;
  PrivacyPolicyBloc privacyPolicyBloc;
  OrderHistoryBloc orderHistoryBloc;
  BlocProvider<ProfileBloc> profileProvider;
  BlocProvider<HomeBloc> homeProvider;
  BlocProvider<OrderHistoryBloc> orderHistoryProvider;
  BlocProvider<SettingBloc> settingProvider;
  BlocProvider<AboutBloc> aboutUsProvider;
  BlocProvider<PrivacyPolicyBloc> privacyPolicyProvider;

  @override
  void initState() {
    super.initState();
    print("Initialize Sidenavigation");
    _selectedTab = (BlocProvider.of<SideNavigatBloc>(context).state
            as SideNavigationDefaultState)
        .selectedTab;
    _showLoadingAnimation = (BlocProvider.of<SideNavigatBloc>(context).state
            as SideNavigationDefaultState)
        .showLoadingAnimation;
    profileBloc = new ProfileBloc(userRepository: widget.userRepository);
    homeBloc = new HomeBloc(userRepository: widget.userRepository);
    settingBloc = new SettingBloc(userRepository: widget.userRepository);
    orderHistoryBloc =
        new OrderHistoryBloc(userRepository: widget.userRepository);
    aboutusBloc = new AboutBloc(userRepository: widget.userRepository);
    privacyPolicyBloc =
        new PrivacyPolicyBloc(userRepository: widget.userRepository);
    initializeProviders();
  }

  void initializeProviders() {
    print("Initialize provider");
    profileProvider =
        BlocProvider.value(value: profileBloc, child: ProfileNavigator());
    homeProvider = BlocProvider.value(
        value: homeBloc,
        child: HomeNavigator(userRepository: widget.userRepository));
    orderHistoryProvider = BlocProvider.value(
        value: orderHistoryBloc,
        child: OrderHistoryNavigator(userRepository: widget.userRepository));
    settingProvider = BlocProvider.value(
        value: settingBloc,
        child: SettingNavigator(userRepository: widget.userRepository));
    aboutUsProvider = BlocProvider.value(
        value: aboutusBloc,
        child: AboutUsNavigator(userRepository: widget.userRepository));
    privacyPolicyProvider = BlocProvider.value(
        value: privacyPolicyBloc,
        child: PrivacyPolicyNavigator(userRepository: widget.userRepository));
  }

  void onTabTapped(int index) {
    BlocProvider.of<SideNavigatBloc>(context).add(SideNavigationEventTabChanged(
        selectedTab: SideNavigationTab.values[index]));
  }

  @override
  void dispose() {
    homeBloc.close();

    profileBloc.close();
    orderHistoryBloc.close();
    settingBloc.close();
    aboutusBloc.close();
    privacyPolicyBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocListener<HmRootBloc, HmRootState>(
      listener: (context, state) {
        if (state is HmRootHomeState) {
          print("in homepage");
          if (state.isBackOrderHistory) {
            print("in homepage back to history");
            if (widget.userRepository.ScreenName ==
                ScreenNavigation.OrderHistoryDetailPageScreen) {
              orderHistoryBloc.add(OrderEventBackBtnClicked());
              BlocProvider.of<HmRootBloc>(context)
                  .add(HmRootEventBackButtonOrderHistoryReset());
            } else if (widget.userRepository.ScreenName ==
                ScreenNavigation.OrderHistoryPageScreen) {
              orderHistoryBloc.add(OrderEventBackBtnClicked());
              BlocProvider.of<HmRootBloc>(context)
                  .add(HmRootEventBackButtonOrderHistoryReset());
            }
          } else if (state.isBackProfile) {
            print("in homepage back from profile");
            if (widget.userRepository.ScreenName ==
                ScreenNavigation.ProfileMainPageScreen) {
              //  profileBloc.add(ProfileEventProfileReset());
              profileBloc.add(ProfileEventBackBtnClick());
              BlocProvider.of<HmRootBloc>(context)
                  .add(HmRootEventBackButtonHomeReset());
            }
          }
          if (state.isBackHome) {
            homeBloc.add(HomeEventBackBtnClick());
            BlocProvider.of<HmRootBloc>(context)
                .add(HmRootEventBackButtonOrderHistoryReset());
          }
          if (state.isFromSetting) {
            BlocProvider.of<SideNavigatBloc>(context)
                .add(SideNavigationEventSettingPage());

            BlocProvider.of<HmRootBloc>(context)
                .add(HmRootEventSettingScreenUnSelectFromRoot());
          }
          if (state.isPushNotificationSending) {
            String orderId = widget.userRepository.notifyOrderId;
            String driverId = widget.userRepository.notifyDriverId;
            BlocProvider.of<SideNavigatBloc>(context).add(
                SideNavigationEventGoToOrderDetailPage(
                    true, orderId, driverId));
            BlocProvider.of<HmRootBloc>(context).add(HmRootEventPushHandeled());
          }
        }
      },
      child: BlocConsumer<SideNavigatBloc, SideNavigatState>(
        listener: (context, state) {
          setState(() {
            _selectedTab = (state as SideNavigationDefaultState).selectedTab;
            _showLoadingAnimation =
                (state as SideNavigationDefaultState).showLoadingAnimation;
            if (_selectedTab == SideNavigationTab.HOME) {}
            if (state is SideNavigationDefaultState) {
              print("Incart page in Consumerdefault");
              if (state.goToCart) {
                // print("Incart page in Consumer");
                // BlocProvider.of<SideNavigatBloc>(context)
                //     .add(SideNavigationEventGoToHomePage(false));
                // homeBloc.add(HomeEventCartPageOpen());
                // BlocProvider.of<SideNavigatBloc>(context)
                //     .add(SideNavigationEventSettingPageReset());
              }
              if (state.goToOrderDetail) {
                print("========Goto Detail page");
                orderHistoryBloc.add(
                    OrderHistoryEventNavigateFromNoticationToOrderDetail(
                        state.orderId, state.driverId));
              }
            }

            if (_selectedTab == SideNavigationTab.ORDERHISTORY) {}

            // aPrint("in Home page");
          });
        },
        builder: (context, state) {
          return Stack(
            children: [
              SafeArea(
                top: true,
                bottom: true,
                child: Scaffold(
                  backgroundColor: KColorAppThemeColor,
                  drawerEnableOpenDragGesture: false,
                  drawer: Drawer(
                    child: Container(
                      color: kColorAppBgColor,
                      child: Column(
                        children: [
                          Container(
                            color: KColorAppThemeColor,
                            height: 150.0.scale(),
                            width: double.infinity,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                AVerticalSpace(10.0.scale()),
                                CircleAvatar(
                                  radius: 55.0.scale(),
                                  backgroundColor: kColorAppBgColor,
                                  child: sharedPrefs.getUserProfileImage != ""
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                sharedPrefs.getUserProfileImage,
                                            width: 100.0.scale(),
                                            height: 100.0.scale(),
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: const Image(
                                            height: 100.0,
                                            width: 100.0,
                                            fit: BoxFit.cover,
                                            color: Colors.white,
                                            image: AssetImage(
                                                '${imgPathGeneral}ic_profile_icon.png'),
                                          ),
                                        ),
                                ),
                                AVerticalSpace(5.0.scale()),
                                InkWell(
                                  onTap: () {
                                    widget.userRepository.ScreenName =
                                        ScreenNavigation.ProfileMainPageScreen;
                                    Navigator.pop(context);
                                    onTabTapped(2);
                                  },
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                          sharedPrefs.getUserName == ""
                                              ? ""
                                              : sharedPrefs.getUserName,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.0.scale(),
                                          )),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          ListView(
                            physics: ClampingScrollPhysics(),
                            children: [
                              if (sharedPrefs.isLogin == true)
                                ListTile(
                                  focusColor: KColorSelectorList,
                                  selectedTileColor: KColorSelectorList,
                                  title: Text(
                                    'My Orders',
                                    style: textStyleCustomColor(
                                        18.0.scale(), kColorAppBgColor),
                                  ).align(Alignment.centerLeft),
                                  onTap: () {
                                    widget.userRepository.ScreenName =
                                        ScreenNavigation.OrderHistoryPageScreen;
                                    Navigator.pop(context);

                                    onTabTapped(1);
                                  },
                                ),
                              AVerticalSpace(10.0.scale()),
                              if (sharedPrefs.isLogin == true)
                                ListTile(
                                  title: Text(
                                    'Notification Setting',
                                    style: textStyleCustomColor(
                                        18.0.scale(), kColorAppBgColor),
                                  ).align(Alignment.centerLeft),
                                  onTap: () {
                                    Navigator.pop(context);
                                    onTabTapped(3);
                                  },
                                ),
                              AVerticalSpace(10.0.scale()),
                              ListTile(
                                title: Text(
                                  'About us',
                                  style: textStyleCustomColor(
                                      18.0.scale(), kColorAppBgColor),
                                ).align(Alignment.centerLeft),
                                onTap: () {
                                  Navigator.pop(context);
                                  onTabTapped(4);
                                },
                              ),
                              AVerticalSpace(10.0.scale()),
                              ListTile(
                                title: Text(
                                  'Privacy Policy',
                                  style: textStyleCustomColor(
                                      18.0.scale(), kColorAppBgColor),
                                ).align(Alignment.centerLeft),
                                onTap: () {
                                  Navigator.pop(context);
                                  onTabTapped(5);
                                },
                              ),
                              AVerticalSpace(10.0.scale()),
                              ListTile(
                                title: Text(
                                  'FAQ',
                                  style: textStyleCustomColor(
                                      18.0.scale(), KColorCommonText),
                                ).align(Alignment.centerLeft),
                              ),
                              AVerticalSpace(10.0.scale()),
                              if (sharedPrefs.isLogin == true)
                                ListTile(
                                  title: Text(
                                    'Log out',
                                    style: textStyleCustomColor(
                                        18.0.scale(), KColorCommonText),
                                  ).align(Alignment.centerLeft),
                                  onTap: () {
                                    Navigator.pop(context);
                                    sharedPrefs.resetPreferences();
                                    // if (Platform.isAndroid) {
                                    //   SystemNavigator.pop();
                                    // } else {
                                    //   SystemNavigator.pop();
                                    // }
                                    BlocProvider.of<HmRootBloc>(context)
                                        .add(HmRootEventLogoutClick());
                                  },
                                ),
                            ],
                          ).pageBgColor(Colors.white).expand()
                        ],
                      ),
                    ).pageBgColor(KColorAppThemeColor),
                  ),
                  body: _getSelectedTabContentView(_selectedTab),
                ),
              ).lightStatusBarText().pageBgColor(kColorAppBgColor),
              if (_showLoadingAnimation) ALoadingAnimation()
            ],
          );
        },
      ).lightStatusBarText().pageBgColor(kColorAppBgColor),
    );
  }

  Widget _getSelectedTabContentView(SideNavigationTab selectedTab) {
    Widget tabContentView;
    switch (selectedTab) {
      case SideNavigationTab.HOME:
        print("Home");
        tabContentView = homeProvider;
        break;
      case SideNavigationTab.ORDERHISTORY:
        // TODO: Handle this case.
        tabContentView = orderHistoryProvider;
        break;
      case SideNavigationTab.PROFILE:
        print("profile");
        tabContentView = profileProvider;
        break;
      case SideNavigationTab.SETTING:
        print("profile");
        tabContentView = settingProvider;
        break;
      case SideNavigationTab.ABOUTUS:
        print("profile");
        tabContentView = aboutUsProvider;
        break;
      case SideNavigationTab.PRIVACYPOLICY:
        print("profile");
        tabContentView = privacyPolicyProvider;
        break;
    }
    return tabContentView;
  }
}
