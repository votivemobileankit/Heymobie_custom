import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grambunny_customer/hm_root/hm_root.dart';
import 'package:grambunny_customer/setting/setting.dart';

import 'screen/setting_page.dart';

class SettingNavigator extends StatefulWidget {
  static const String settingPage = '/settingPage';
  static const String notificationDetailPage = '/notificationDetailPage';
  static const String notificationPage = '/notificationPage';
  final UserRepository userRepository;

  SettingNavigator({

    required this.userRepository,
  }) ;

  @override
  _SettingNavigatorState createState() => _SettingNavigatorState();
}

class _SettingNavigatorState extends State<SettingNavigator> {
  late _SettingRouter _router;

  @override
  void initState() {
    super.initState();
    _router =
        _SettingRouter(settingBloc: BlocProvider.of<SettingBloc>(context));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) {
        //print("in bloc Provider of OrderHistory");
        return Navigator(
          onGenerateInitialRoutes:
              (NavigatorState navState, String initialRouteName) {
            return <Route>[
              _router.getSettingMainPageRoute(
                RouteSettings(name: SettingNavigator.settingPage),
              ),
            ];
          },
          onGenerateRoute: _router.onGenerateRoute,
        );
      },
    );
    ;
  }
}

class _SettingRouter {
late  final SettingBloc settingBloc;

  _SettingRouter({required this.settingBloc});

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SettingNavigator.settingPage:
        return getSettingMainPageRoute(settings);
        break;
      case SettingNavigator.notificationPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<SettingBloc>.value(
            value: settingBloc,
            child: NotificationListPage(),
          ),
        );
        break;
      case SettingNavigator.notificationDetailPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<SettingBloc>.value(
            value: settingBloc,
            child: NotificationOrderDetailsPage(),
          ),
        );
        break;
      default:
        return null;
    }
  }

  Route getSettingMainPageRoute(RouteSettings settings) {
    return MaterialPageRoute(
        builder: (_) => BlocProvider<SettingBloc>.value(
              value: settingBloc,
              child: SettingPage(),
            ),
        settings: settings);
  }

  //
  // Route getProfileVaccinationHistoryDetailPageRoute(RouteSettings settings) {
  //   return AMaterialRoute(
  //     builder: (_) => BlocProvider<ProfileBloc>.value(
  //       value: profileBloc,
  //       child: ProfileVaccineHistoryDetails(),
  //     ),
  //     settings: settings,
  //   );
  // }

  void dispose() {
    //   profileBloc.close();
  }
}
