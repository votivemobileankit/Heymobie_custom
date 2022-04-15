import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grambunny_customer/aboutus/aboutus.dart';
import 'package:grambunny_customer/hm_root/hm_root.dart';

class AboutUsNavigator extends StatefulWidget {
  static const String aboutUsPage = '/aboutUsPage';
  final UserRepository userRepository;

  AboutUsNavigator({
    Key key,
    @required this.userRepository,
  }) : super(key: key);

  @override
  State<AboutUsNavigator> createState() => _AboutUsNavigatorState();
}

class _AboutUsNavigatorState extends State<AboutUsNavigator> {
  _AboutUsRouter _router;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _router = _AboutUsRouter(aboutBloc: BlocProvider.of<AboutBloc>(context));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<AboutBloc, AboutState>(
      builder: (context, state) {
        //print("in bloc Provider of OrderHistory");
        return Navigator(
          onGenerateInitialRoutes:
              (NavigatorState navState, String initialRouteName) {
            return <Route>[
              _router.getSettingMainPageRoute(
                RouteSettings(name: AboutUsNavigator.aboutUsPage),
              ),
            ];
          },
          onGenerateRoute: _router.onGenerateRoute,
        );
      },
    );
  }
}

class _AboutUsRouter {
  final AboutBloc aboutBloc;

  _AboutUsRouter({this.aboutBloc});

  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AboutUsNavigator.aboutUsPage:
        return getSettingMainPageRoute(settings);
        break;
      default:
        return null;
    }
  }

  Route getSettingMainPageRoute(RouteSettings settings) {
    return MaterialPageRoute(
        builder: (_) => BlocProvider<AboutBloc>.value(
              value: aboutBloc,
              child: AboutUsPage(),
            ),
        settings: settings);
  }

  void dispose() {}
}
