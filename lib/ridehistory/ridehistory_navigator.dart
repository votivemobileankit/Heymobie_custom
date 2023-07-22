import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grambunny_customer/ridehistory/screen/ride_history_detail_page.dart';
import 'package:grambunny_customer/ridehistory/screen/ride_history_page.dart';

import '../hm_root/user_repository.dart';
import 'bloc/ride_history_bloc.dart';

class RideHistoryNavigator extends StatefulWidget {
  static const String ridehistoryPage = '/ridehistoryPage';
  static const String rideListdetailPage = '/rideListdetailPage';
  final UserRepository? userRepository;

  const RideHistoryNavigator({this.userRepository});

  @override
  _RideHistoryNavigatorState createState() => _RideHistoryNavigatorState();
}

class _RideHistoryNavigatorState extends State<RideHistoryNavigator> {
  _RideHistoryRouter? _router;

  @override
  void initState() {
    super.initState();
    _router = _RideHistoryRouter(
        ridehistoryBloc: BlocProvider.of<RideHistoryBloc>(context));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RideHistoryBloc, RideHistoryState>(
        builder: (context, state) {
      print("in bloc Builder of Profile ");
      return Navigator(
        initialRoute: RideHistoryNavigator.ridehistoryPage,
        onGenerateRoute: _router!.onGenerateRoute,
      );
    });
  }

  @override
  void dispose() {
    _router!.dispose();
    super.dispose();
  }
}

class _RideHistoryRouter {
  final RideHistoryBloc? ridehistoryBloc;

  _RideHistoryRouter({this.ridehistoryBloc});

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RideHistoryNavigator.ridehistoryPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<RideHistoryBloc>.value(
            value: ridehistoryBloc!,
            child: RideHistoryPage(),
          ),
        );
        break;

      case RideHistoryNavigator.rideListdetailPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<RideHistoryBloc>.value(
            value: ridehistoryBloc!,
            child: RideHistoryDetailsPage(),
          ),
        );
        break;

      default:
        return null;
    }
  }

  void dispose() {
    //homeBloc.close();
  }
}
