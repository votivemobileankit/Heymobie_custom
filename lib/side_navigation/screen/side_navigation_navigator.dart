import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grambunny_customer/hm_root/hm_root.dart';

import '../side_navigation.dart';

class SideNavigationNavigator extends StatefulWidget {
  static const String bottomNavigatorMainPage = '/bnMainPage';
  final UserRepository userRepository;

  const SideNavigationNavigator({Key key, this.userRepository})
      : super(key: key);

  @override
  _SideNavigationNavigatorState createState() =>
      _SideNavigationNavigatorState();
}

class _SideNavigationNavigatorState extends State<SideNavigationNavigator> {
  _SideNavigationRouter _router;

  @override
  void initState() {
    super.initState();
    _router = _SideNavigationRouter(widget.userRepository);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: SideNavigationNavigator.bottomNavigatorMainPage,
      onGenerateRoute: _router.onGenerateRoute,
    );
  }

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }
}

class _SideNavigationRouter {
  UserRepository userRepository;

  SideNavigatBloc _bottomNavigationBloc;

  _SideNavigationRouter(UserRepository userRepository) {
    this.userRepository = userRepository;

    _bottomNavigationBloc =
        SideNavigatBloc(userRepository: this.userRepository);
  }

  Route onGenerateRoute(RouteSettings settings) {
    // aPrint(settings.name);
    switch (settings.name) {
      case SideNavigationNavigator.bottomNavigatorMainPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<SideNavigatBloc>.value(
            value: _bottomNavigationBloc,
            child: SideNavigationHomeTab(userRepository: userRepository),
          ),
        );

      default:
        return null;
    }
  }

  void dispose() {
    _bottomNavigationBloc.close();
  }
}
