import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grambunny_customer/hm_root/hm_root.dart';

import 'bloc.dart';

class PrivacyPolicyBloc extends Bloc<PrivacyPolicyEvent, PrivacyPolicyState> {
  UserRepository _userRepository;

  PrivacyPolicyBloc({UserRepository userRepository})
      : super(PrivacyPolicyInitial()) {
    _userRepository = userRepository;
  }

  @override
  Stream<PrivacyPolicyState> mapEventToState(
    PrivacyPolicyEvent event,
  ) async* {
    switch (event.runtimeType) {
      case PrivacyPolicyBackBtnClick:
        yield* mapPrivacyPolicyBackBtnClick();
        break;
      case PrivacyPolicyResetEventInitialState:
        yield* mapPrivacyPolicyResetEventInitialState();
        break;
    }
  }

  Stream<PrivacyPolicyState> mapPrivacyPolicyResetEventInitialState() async* {
    print("profile back");
    yield PrivacyPolicyInitial();
  }

  Stream<PrivacyPolicyState> mapPrivacyPolicyBackBtnClick() async* {
    if (state is PrivacyPolicyInitial) {
      print("profile back");
      yield PrivacyPolicyBackToHomeState();
    }
  }
}
