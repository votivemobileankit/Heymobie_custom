import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:grambunny_customer/aboutus/aboutus.dart';
import 'package:grambunny_customer/hm_root/hm_root.dart';

class AboutBloc extends Bloc<AboutEvent, AboutState> {
  UserRepository _userRepository;

  AboutBloc({UserRepository userRepository}) : super(AboutInitial()) {
    _userRepository = userRepository;
  }

  @override
  Stream<AboutState> mapEventToState(
    AboutEvent event,
  ) async* {
    switch (event.runtimeType) {
      case AboutEventBackBtnClick:
        yield* mapAboutEventBackBtnClick();
        break;
      case AboutResetEventInitialState:
        yield* mapAboutResetEventInitialState();
        break;
    }
  }

  Stream<AboutState> mapAboutResetEventInitialState() async* {
    print("profile back");
    yield AboutInitial();
  }

  Stream<AboutState> mapAboutEventBackBtnClick() async* {
    if (state is AboutInitial) {
      print("profile back");
      yield AboutBackToHomeState();
    }
  }
}
