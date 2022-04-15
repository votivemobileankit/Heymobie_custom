import 'package:equatable/equatable.dart';

abstract class PrivacyPolicyState extends Equatable {
  const PrivacyPolicyState();
}

class PrivacyPolicyInitial extends PrivacyPolicyState {
  @override
  List<Object> get props => [];
}

class PrivacyPolicyBackToHomeState extends PrivacyPolicyState {
  @override
  List<Object> get props => [];
}
