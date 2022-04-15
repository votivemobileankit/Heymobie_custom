import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grambunny_customer/components/components.dart';
import 'package:grambunny_customer/hm_root/hm_root.dart';
import 'package:grambunny_customer/privacy_policy/privacy_policy.dart';


class PrivacyPolicyNavigator extends StatefulWidget {
  static const String privacyPolicyPage = '/privacyPolicyPage';
  final UserRepository userRepository;

  PrivacyPolicyNavigator({
    Key key,
    @required this.userRepository,
  }) : super(key: key);

  @override
  State<PrivacyPolicyNavigator> createState() => _PrivacyPolicyNavigatorState();
}

class _PrivacyPolicyNavigatorState extends State<PrivacyPolicyNavigator> {
  _PrivacyPolicyRouter _router;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _router = _PrivacyPolicyRouter(
        privacyBloc: BlocProvider.of<PrivacyPolicyBloc>(context));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<PrivacyPolicyBloc, PrivacyPolicyState>(
        builder: (context, state) {
      return Navigator(
        onGenerateInitialRoutes:
            (NavigatorState navState, String initialRouteName) {
          return <Route>[
            _router.getSettingMainPageRoute(
              RouteSettings(name: PrivacyPolicyNavigator.privacyPolicyPage),
            ),
          ];
        },
        onGenerateRoute: _router.onGenerateRoute,
      );
    });
  }
}

class _PrivacyPolicyRouter {
  final PrivacyPolicyBloc privacyBloc;

  _PrivacyPolicyRouter({this.privacyBloc});

  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PrivacyPolicyNavigator.privacyPolicyPage:
        return getSettingMainPageRoute(settings);
        break;
      default:
        return null;
    }
  }

  Route getSettingMainPageRoute(RouteSettings settings) {
    return AMaterialRoute(
        builder: (_) => BlocProvider<PrivacyPolicyBloc>.value(
              value: privacyBloc,
              child: PrivacyPolicyPage(),
            ),
        settings: settings);
  }

  void dispose() {}
}
