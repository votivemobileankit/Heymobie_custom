import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginPageState extends LoginState {}

class SignUpPageState extends LoginState {}

class LoginLoadingCompleteState extends LoginState {}

class ForgetPwdPageState extends LoginState {}
