import 'package:equatable/equatable.dart';

abstract class PrivacyPolicyEvent extends Equatable {
  const PrivacyPolicyEvent();

  @override
  List<Object> get props => [];
}

class PrivacyPolicyBackBtnClick extends PrivacyPolicyEvent {}

class PrivacyPolicyResetEventInitialState extends PrivacyPolicyEvent {}
