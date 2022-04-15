import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginEventSignUpButtonClick extends LoginEvent {}

class LoginEventForgetPasswordClick extends LoginEvent {}

class LoginAgeVerifyYesButtonClicked extends LoginEvent {}

class LoginAgeVerifNoButtonClicked extends LoginEvent {}

class LoginEventBtnLoginClicked extends LoginEvent {}

class LoginEventBackBtnClicked extends LoginEvent {}
