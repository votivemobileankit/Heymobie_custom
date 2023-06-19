import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grambunny_customer/hm_root/hm_root.dart';
import 'package:grambunny_customer/profile/profile.dart';

import 'bloc/bloc.dart';

class ProfileNavigator extends StatefulWidget {
  static const String profileMainPage = '/profileMainPage';
  static const String changePasswordPage = '/changePasswordPage';
  final UserRepository userRepository;

  const ProfileNavigator({required this.userRepository});

  @override
  _ProfileNavigatorState createState() => _ProfileNavigatorState();
}

class _ProfileNavigatorState extends State<ProfileNavigator> {
 late _ProfileRouter _router;

  @override
  void initState() {
    super.initState();
    print("Profilenavigator");
    // _router = _ProfileRouter(widget.userRepository);
    _router =
        _ProfileRouter(profileBloc: BlocProvider.of<ProfileBloc>(context));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        print("in bloc Provider of OrderHistory");
        return Navigator(
          //initialRoute: ProfileNavigator.profileMainPage,
          onGenerateInitialRoutes:
              (NavigatorState navState, String initialRouteName) {
            return <Route>[
              _router.getProfileMainPageRoute(
                RouteSettings(name: ProfileNavigator.profileMainPage),
              ),
            ];
          },
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

class _ProfileRouter {
  late ProfileBloc profileBloc;

  _ProfileRouter({required this.profileBloc});

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ProfileNavigator.profileMainPage:
        return getProfileMainPageRoute(settings);
        break;
      case ProfileNavigator.changePasswordPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<ProfileBloc>.value(
            value: profileBloc,
            child: ChangePasswordPage(),
          ),
        );
        break;
      default:
        return null;
    }
  }

  Route getProfileMainPageRoute(RouteSettings settings) {
    return MaterialPageRoute(
        builder: (_) => BlocProvider<ProfileBloc>.value(
              value: profileBloc,
              child: ProfileMainPage(),
            ),
        settings: settings);
  }

  void dispose() {}
}
