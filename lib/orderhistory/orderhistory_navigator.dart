import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grambunny_customer/components/components.dart';
import 'package:grambunny_customer/hm_root/hm_root.dart';
import 'package:grambunny_customer/side_navigation/side_navigation.dart';

import 'orderhistory.dart';

class OrderHistoryNavigator extends StatefulWidget {
  static const String orderHistoryPage = '/orderHistoryPage';
  static const String orderHistoryDetailPage = '/orderHistoryDetailPage';
  static const String mapOrderTrackPage = '/mapOrderTrackPage';

  final UserRepository userRepository;

  OrderHistoryNavigator({
    Key key,
    @required this.userRepository,
  }) : super(key: key);

  @override
  _OrderHistoryNavigatorState createState() => _OrderHistoryNavigatorState();
}

class _OrderHistoryNavigatorState extends State<OrderHistoryNavigator> {
  _OrderHistoryRouter _router;

  @override
  void initState() {
    super.initState();
    _router = _OrderHistoryRouter(
        orderHistoryBloc: BlocProvider.of<OrderHistoryBloc>(context));
    bool showOrderHistoryDetail = (BlocProvider.of<SideNavigatBloc>(context)
            .state as SideNavigationDefaultState)
        .goToOrderDetail;

    if (showOrderHistoryDetail) {
      BlocProvider.of<SideNavigatBloc>(context)
          .add(SideNavigationEventGoToOrderDetailPageHandel());
    } else {
      _router.orderHistoryBloc.add(OrderHistoryEventReset());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
      builder: (context, state) {
        bool showOrderDetailPage = state is OrderDetailApiLoadingCompleteState;
        return Navigator(
          onGenerateInitialRoutes:
              (NavigatorState navState, String initialRouteName) {
            return <Route>[
              _router.getProfileMainPageRoute(
                const RouteSettings(
                    name: OrderHistoryNavigator.orderHistoryPage),
              ),
              if (showOrderDetailPage)
                _router.getOrderyHistoryDetailPageRoute(const RouteSettings(
                    name: OrderHistoryNavigator.orderHistoryDetailPage)),
            ];
          },
          onGenerateRoute: _router.onGenerateRoute,
        );
      },
    );
  }

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }
}

class _OrderHistoryRouter {
  final OrderHistoryBloc orderHistoryBloc;

  _OrderHistoryRouter({this.orderHistoryBloc});

  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case OrderHistoryNavigator.orderHistoryPage:
        return getProfileMainPageRoute(settings);
        break;
      case OrderHistoryNavigator.orderHistoryDetailPage:
        return getOrderyHistoryDetailPageRoute(settings);
        break;
      case OrderHistoryNavigator.mapOrderTrackPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<OrderHistoryBloc>.value(
            value: orderHistoryBloc,
            child: MapOrderTrackPage(),
          ),
        );
        break;
      default:
        return null;
    }
  }

  Route getProfileMainPageRoute(RouteSettings settings) {
    return AMaterialRoute(
        builder: (_) => BlocProvider<OrderHistoryBloc>.value(
              value: orderHistoryBloc,
              child: OrderHistoryPage(),
            ),
        settings: settings);
  }

  //
  Route getOrderyHistoryDetailPageRoute(RouteSettings settings) {
    return AMaterialRoute(
      builder: (_) => BlocProvider<OrderHistoryBloc>.value(
        value: orderHistoryBloc,
        child: OrderHistoryDetailsPage(),
      ),
      settings: settings,
    );
  }

  void dispose() {
    //   profileBloc.close();
  }
}
