import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grambunny_customer/hm_root/hm_root.dart';

import 'bloc.dart';

class PrivacyPolicyBloc extends Bloc<PrivacyPolicyEvent, PrivacyPolicyState> {
  UserRepository? _userRepository;

  PrivacyPolicyBloc({required UserRepository userRepository})
      : super(PrivacyPolicyInitial()) {
    _userRepository = userRepository;

    on<PrivacyPolicyBackBtnClick>(mapPrivacyPolicyBackBtnClick);
    on<PrivacyPolicyResetEventInitialState>(mapPrivacyPolicyResetEventInitialState);


  }



  mapPrivacyPolicyResetEventInitialState(PrivacyPolicyResetEventInitialState event,Emitter<PrivacyPolicyState> emitter) async {
    print("profile back");
    emitter( PrivacyPolicyInitial());
  }

  Stream<PrivacyPolicyState> mapPrivacyPolicyBackBtnClick(PrivacyPolicyBackBtnClick event,Emitter<PrivacyPolicyState> emitter) async* {
    if (state is PrivacyPolicyInitial) {
      print("profile back");
      emitter( PrivacyPolicyBackToHomeState());
    }
  }
}
