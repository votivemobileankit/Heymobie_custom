import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grambunny_customer/eventhistory/bloc/event_history_bloc.dart';
import 'package:grambunny_customer/eventhistory/screen/event_history_detail_page.dart';
import 'package:grambunny_customer/eventhistory/screen/event_history_page.dart';

import '../hm_root/user_repository.dart';

class EventHistoryNavigator extends StatefulWidget {
  static const String eventhistoryPage = '/eventhistoryPage';
  static const String eventdetailPage = '/eventdetailPage';

  final UserRepository? userRepository;

  const EventHistoryNavigator({this.userRepository});

  @override
  _EventHistoryNavigatorState createState() => _EventHistoryNavigatorState();
}

class _EventHistoryNavigatorState extends State<EventHistoryNavigator> {
  _EventHistoryRouter? _router;

  @override
  void initState() {
    super.initState();
    _router = _EventHistoryRouter(
        eventhistoryBloc: BlocProvider.of<EventHistoryBloc>(context));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventHistoryBloc, EventHistoryState>(
        builder: (context, state) {
      print("in bloc Builder of Profile ");
      return Navigator(
        initialRoute: EventHistoryNavigator.eventhistoryPage,
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

class _EventHistoryRouter {
  final EventHistoryBloc? eventhistoryBloc;

  _EventHistoryRouter({this.eventhistoryBloc});

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case EventHistoryNavigator.eventhistoryPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<EventHistoryBloc>.value(
            value: eventhistoryBloc!,
            child: EventHistoryPage(),
          ),
        );
        break;

      case EventHistoryNavigator.eventdetailPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<EventHistoryBloc>.value(
            value: eventhistoryBloc!,
            child: EventHistoryDetailsPage(),
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
