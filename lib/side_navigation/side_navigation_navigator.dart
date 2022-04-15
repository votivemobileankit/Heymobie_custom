import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grambunny_customer/hm_root/hm_root.dart';
import 'package:grambunny_customer/side_navigation/side_navigation.dart';

class SideNavigationNavigator extends StatefulWidget {
  static const String bottomNavigatorMainPage = '/bnMainPage';
  final UserRepository userRepository;

  SideNavigationNavigator({Key key, this.userRepository}) : super(key: key);

  @override
  _BottomNavigationNavigatorState createState() =>
      _BottomNavigationNavigatorState();
}

class _BottomNavigationNavigatorState extends State<SideNavigationNavigator> {
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

  SideNavigatBloc _sideNavigationBloc;

  _SideNavigationRouter(UserRepository userRepository) {
    this.userRepository = userRepository;

    _sideNavigationBloc = SideNavigatBloc(userRepository: this.userRepository);
  }

  Route onGenerateRoute(RouteSettings settings) {
    print(settings.name);
    switch (settings.name) {
      case SideNavigationNavigator.bottomNavigatorMainPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<SideNavigatBloc>.value(
            value: _sideNavigationBloc,
            child: SideNavigationHomeTab(userRepository: userRepository),
          ),
        );

      default:
        return null;
    }
  }

  void dispose() {
    _sideNavigationBloc.close();
  }
}
