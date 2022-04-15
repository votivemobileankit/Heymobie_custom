import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:grambunny_customer/hm_root/hm_root.dart';
import 'package:grambunny_customer/utils/utils.dart';

import '../login.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository _userRepository;

  LoginBloc(UserRepository userRepository) : super(LoginInitial()) {
    _userRepository = userRepository;
  }

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    switch (event.runtimeType) {
      case LoginEventSignUpButtonClick:
        yield* mapLoginEventSignUpButtonClick();
        break;
      case LoginEventBackBtnClicked:
        yield* mapEventBackBtnClicked();
        break;
      case LoginEventForgetPasswordClick:
        yield* mapLoginEventForgetPasswordClick();
        break;
      case LoginEventBtnLoginClicked:
        yield* mapLoginEventBtnLoginClicked();
        break;
      case LoginAgeVerifyYesButtonClicked:
        yield* mapLoginAgeVerifyYesButtonClicked();
        break;
    }
    // TODO: implement mapEventToState
  }

  Stream<LoginState> mapLoginAgeVerifyYesButtonClicked() async* {
    _userRepository.ScreenName = ScreenNavigation.Loginpage;
    yield LoginPageState();
  }

  Stream<LoginState> mapLoginEventSignUpButtonClick() async* {
    _userRepository.ScreenName = ScreenNavigation.SignUpPage;
    yield SignUpPageState();
  }

  Stream<LoginState> mapLoginEventBtnLoginClicked() async* {
    //_userRepository.ScreenName = "SignUpPage";
    yield LoginLoadingCompleteState();
  }

  Stream<LoginState> mapLoginEventForgetPasswordClick() async* {
    _userRepository.ScreenName = ScreenNavigation.ForgetPwdPage;
    yield (ForgetPwdPageState());
  }

  Stream<LoginState> mapEventBackBtnClicked() async* {
    if (state is SignUpPageState) {
      _userRepository.ScreenName = ScreenNavigation.Loginpage;
      yield (LoginInitial());
    }
    if (state is ForgetPwdPageState) {
      _userRepository.ScreenName = ScreenNavigation.Loginpage;
      yield (LoginInitial());
    }
  }
}
