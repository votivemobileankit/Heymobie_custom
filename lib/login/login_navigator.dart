import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grambunny_customer/hm_root/hm_root.dart';
import 'package:grambunny_customer/login/login.dart';
import 'package:grambunny_customer/utils/utils.dart';

import 'bloc/bloc.dart';

class LoginNavigator extends StatefulWidget {
  static const String loginMainPage = '/loginMainPage';
  static const String ageAskPage = '/ageAskPage';
  static const String signUpPage = '/signUpPage';
  static const String forgotPwdPage = '/forgotPwdPage';
  static const String otpPage = '/otpPage';
  final UserRepository userRepository;

  const LoginNavigator({ required this.userRepository});

  @override
  _LoginNavigatorState createState() => _LoginNavigatorState();
}

class _LoginNavigatorState extends State<LoginNavigator> {
  _LoginRouter? _router;

  @override
  void initState() {
    super.initState();
    _router = _LoginRouter(widget.userRepository);
    // _router = _LoginRouter(_loginBloc: BlocProvider.of<LoginBloc>(context));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          print("in Login ${widget.userRepository.ScreenName}");
          if (widget.userRepository.ScreenName == ScreenNavigation.SignUpPage) {
            _router!._loginBloc.add(LoginEventBackBtnClicked());
            return Future<bool>.value(false);
          } else if (widget.userRepository.ScreenName ==
              ScreenNavigation.ForgetPwdPage) {
            _router!._loginBloc.add(LoginEventBackBtnClicked());

            return Future<bool>.value(false);
          } else {
             return Future<bool>.value(true);
          }
        },
        child: Navigator(
          initialRoute: LoginNavigator.ageAskPage,
          onGenerateRoute: _router!.onGenerateRoute,
        ));
  }

  @override
  void dispose() {
    _router!.dispose();
    super.dispose();
  }
}

class _LoginRouter {
 late LoginBloc _loginBloc;

  _LoginRouter(UserRepository userRepository) {
    _loginBloc = LoginBloc(userRepository);
  }

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginNavigator.ageAskPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<LoginBloc>.value(
            value: _loginBloc,
            child: AgeAskToUserPage(),
          ),
        );
        break;
      // case LoginNavigator.loginMainPage:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider<LoginBloc>.value(
      //       value: _loginBloc,
      //       child: LoginPage(),
      //     ),
      //   );
      //   break;
      // case LoginNavigator.signUpPage:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider<LoginBloc>.value(
      //       value: _loginBloc,
      //       child: SignupPage(),
      //     ),
      //   );
      //   break;
      // case LoginNavigator.forgotPwdPage:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider<LoginBloc>.value(
      //       value: _loginBloc,
      //       child: ForgetPasswordPage(),
      //     ),
      //   );
      //   break;

      default:
        return null;
    }
  }

  void dispose() {
    _loginBloc.close();
  }
}
