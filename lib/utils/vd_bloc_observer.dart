import 'package:bloc/bloc.dart';


class VDBlocObserver extends BlocObserver {


  @override
  void onEvent(Bloc bloc, Object event) {
    // TODO: implement onEvent
    super.onEvent(bloc, event);
  }

  // @override
  // void onError(Cubit cubit, Object error, StackTrace stackTrace) {
  //   aPrint(error);
  //   super.onError(cubit, error, stackTrace);
  // }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    //aPrint(transition);
    super.onTransition(bloc, transition);
  }
}
