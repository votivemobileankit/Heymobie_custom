import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grambunny_customer/hm_root/hm_root.dart';
import 'package:grambunny_customer/side_navigation/side_navigation.dart';

import 'home.dart';

class HomeNavigator extends StatefulWidget {
  static const String homeDriverMainPage = '/homeDriverMainPage';
  static const String homeMenuListPage = '/homeMenuListPage';
  static const String homeCategoryListPage = '/homeCategoryListPage';
  static const String homeMenuDetailPage = '/homeMenuDetailPage';
  static const String homeSettingPage = '/homeSettingPage';
  static const String homeShowCartPage = '/homeShowCartPage';
  static const String loginPage = '/loginPage';
  static const String signUpPage = '/signUpPage';
  static const String forgotPage = '/forgotPage';
  static const String otpPage = '/otpPage';
  static const String resetPasswordPage = '/resetPasswordPage';
  static const String homeCheckoutPage = '/homeCheckoutPage';

  final UserRepository userRepository;

  const HomeNavigator({Key key, this.userRepository}) : super(key: key);

  @override
  _HomeNavigatorState createState() => _HomeNavigatorState();
}

class _HomeNavigatorState extends State<HomeNavigator> {
  _HomeRouter _router;

  @override
  void initState() {
    super.initState();
    print("HomeNavigator Init");
    _router = _HomeRouter(homeBloc: BlocProvider.of<HomeBloc>(context));

    bool showCartpage = (BlocProvider.of<SideNavigatBloc>(context).state
            as SideNavigationDefaultState)
        .goToCart;
    if (showCartpage) {
      print("page Reset false ");
      BlocProvider.of<SideNavigatBloc>(context)
          .add(SideNavigationEventSettingPageReset());
    } else {
      print("page Home default ");
      _router.homeBloc.add(HomeEventtabChangeToHome());
    }
    // BlocProvider.of<HomeBloc>(context)
    //     .add(HomeEventSettingSideNavigationClick());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        bool showCartPage = state is HomeCartPageState;

        print("In navigator Builder " + showCartPage.toString());
        return Navigator(
          onGenerateInitialRoutes:
              (NavigatorState navState, String initialRouteName) {
            return <Route>[
              _router.getDriverListPageRoute(
                RouteSettings(name: HomeNavigator.homeDriverMainPage),
              ),
              // if (showCartPage)
              //   _router.getHomeCartPageRoute(
              //     RouteSettings(name: HomeNavigator.homeShowCartPage),
              //   ),
            ];
          },
          // initialRoute: HomeNavigator.homeMainPage,
          onGenerateRoute: _router.onGenerateRoute,
        );
      },
    );
  }

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }
}

class _HomeRouter {
  final HomeBloc homeBloc;

  _HomeRouter({this.homeBloc});

  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeNavigator.homeDriverMainPage:
        return getDriverListPageRoute(settings);
        break;
      case HomeNavigator.homeShowCartPage:
        return getHomeCartPageRoute(settings);
        break;

      case HomeNavigator.homeMenuListPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<HomeBloc>.value(
            value: homeBloc,
            child: ProductMenuListPage(),
          ),
        );
        break;
      case HomeNavigator.homeMenuDetailPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<HomeBloc>.value(
            value: homeBloc,
            child: MenuProductDetailPage(),
          ),
        );
        break;

      case HomeNavigator.loginPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<HomeBloc>.value(
            value: homeBloc,
            child: LoginPage(),
          ),
        );
        break;
      case HomeNavigator.signUpPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<HomeBloc>.value(
            value: homeBloc,
            child: SignupPage(),
          ),
        );
        break;
      case HomeNavigator.forgotPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<HomeBloc>.value(
            value: homeBloc,
            child: ForgetPasswordPage(),
          ),
        );
        break;
      case HomeNavigator.otpPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<HomeBloc>.value(
            value: homeBloc,
            child: OtpPage(),
          ),
        );
        break;
      case HomeNavigator.resetPasswordPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<HomeBloc>.value(
            value: homeBloc,
            child: ResetPasswordPage(),
          ),
        );
        break;
      case HomeNavigator.homeCategoryListPage:
        return getCategoryListPageRoute(settings);
        break;

      case HomeNavigator.homeCheckoutPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<HomeBloc>.value(
            value: homeBloc,
            child: HomeCheckOutPage(),
          ),
        );
        break;
      default:
        return null;
    }
  }

  Route getCategoryListPageRoute(RouteSettings settings) {
    return MaterialPageRoute(
        builder: (_) => BlocProvider<HomeBloc>.value(
              value: homeBloc,
              child: HomeCategoryMainPage(),
            ),
        settings: settings);
  }

  Route getDriverListPageRoute(RouteSettings settings) {
    return MaterialPageRoute(
        builder: (_) => BlocProvider<HomeBloc>.value(
              value: homeBloc,
              child: HomeDriverListPage(),
            ),
        settings: settings);
  }

  Route getHomeCartPageRoute(RouteSettings settings) {
    return MaterialPageRoute(
        builder: (_) => BlocProvider<HomeBloc>.value(
              value: homeBloc,
              child: HomeMenuCartPage(),
            ),
        settings: settings);
  }

  Route getHomeSettingPageRoute(RouteSettings settings) {
    return MaterialPageRoute(
        builder: (_) => BlocProvider<HomeBloc>.value(
              value: homeBloc,
              child: HomeMenuCartPage(),
            ),
        settings: settings);
  }

  void dispose() {}
}
