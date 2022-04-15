import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grambunny_customer/components/components.dart';
import 'package:grambunny_customer/orderhistory/orderhistory.dart';
import 'package:grambunny_customer/side_navigation/side_navigation.dart';
import 'package:grambunny_customer/theme/theme.dart';
import 'package:grambunny_customer/utils/ui_utils.dart';
import 'package:grambunny_customer/utils/utils.dart';

class OrderHistoryPage extends StatefulWidget {
  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  List<HistoryList> _historyListArray;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  ScrollController _scrollController;
  int pageCount = 1;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    _historyListArray = [];
    showHideProgress(true);

    BlocProvider.of<OrderHistoryBloc>(context)
        .add(OrderHistoryEventForOrderList('${pageCount}'));
    // WidgetsBinding.instance
    //     .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    _scrollController = ScrollController()..addListener(_scrollListener);

    super.initState();
  }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      startLoader();
    }
  }

  void startLoader() {
    setState(() {
      isLoading = !isLoading;
      showHideProgress(true);
      pageCount = pageCount + 1;
      BlocProvider.of<OrderHistoryBloc>(context)
          .add(OrderHistoryEventForOrderList('${pageCount}'));
    });
  }

  void showHideProgress(bool show) {
    BlocProvider.of<SideNavigatBloc>(context)
        .add(SideNavigationEventToggleLoadingAnimation(needToShow: show));
  }

  Future<Null> _refresh() async {
    pageCount = 1;
    BlocProvider.of<OrderHistoryBloc>(context)
        .add(OrderHistoryEventForOrderList('${pageCount}'));
    _refreshIndicatorKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    return null;
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: BlocListener<OrderHistoryBloc, OrderHistoryState>(
            listenWhen: (prevState, curState) =>
                ModalRoute.of(context).isCurrent,
            listener: (context, state) {
              if (state is OrderHistoryDetailPageState) {
                Navigator.of(context)
                    .pushNamed(OrderHistoryNavigator.orderHistoryDetailPage);
                // BlocProvider.of<SideNavigatBloc>(context)
                //     .add(SideNavigationEventGoToHomePage(true));
              }
              if (state is OrderHistoryListApiLoadingCompleteState) {
                showHideProgress(false);

                setState(() {
                  if (state.refresh == 1) {
                    _historyListArray.clear();
                    List<HistoryList> historyListArray = state.historyList;

                    _historyListArray.addAll(historyListArray);
                  } else {
                    List<HistoryList> historyListArray = state.historyList;

                    _historyListArray.addAll(historyListArray);
                  }
                });
                BlocProvider.of<OrderHistoryBloc>(context)
                    .add(OrderHistoryEventReset());
              }
              if (state is OrderHistoryListLoadingErrorState) {
                showHideProgress(false);
                BlocProvider.of<OrderHistoryBloc>(context)
                    .add(OrderHistoryEventReset());
                // BlocProvider.of<SideNavigatBloc>(context)
                //     .add(SideNavigationEventGoToHomePageFromHistory());
                // showSnackBar(state.message, context);
              }
              if (state is OrderHistoryToNavigateHomeResetPageState) {
                print("In blocListener");
                BlocProvider.of<OrderHistoryBloc>(context)
                    .add(OrderHistoryEventReset());
                BlocProvider.of<SideNavigatBloc>(context)
                    .add(SideNavigationEventGoToHomePageFromHistory());
              }
            },
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  AHeaderWidget(
                    strBackbuttonName: 'ic_red_btn_back.png',
                    backBtnVisibility: true,
                    btnBackOnPressed: () {
                      //Scaffold.of(context).openDrawer();
                      //  timerOnListener = true;
                      print("back");
                      BlocProvider.of<OrderHistoryBloc>(context)
                          .add(OrderEventBackBtnClicked());
                    },
                    strBtnRightImageName: 'ic_search_logo.png',
                    rightEditButtonVisibility: false,
                  ),
                  Column(
                    children: [
                      if (_historyListArray != null &&
                          _historyListArray.isNotEmpty)
                        _HistoryListContainer(
                                _historyListArray.toList(), _scrollController)
                            .expand()
                      else
                        _NoProductFoundWidget(),
                    ],
                  ).expand()
                ],
              ).widgetBgColor(Colors.white),
            ).pageBgColor(kColorAppBgColor)));
  }
}

class _NoProductFoundWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        AVerticalSpace(120.0.scale()),
        Image(
          color: kColorAppBgColor,
          fit: BoxFit.fill,
          width: 150.0.scale(),
          height: 150.0.scale(),
          image: AssetImage('${imgPathGeneral}ic_order_empty.png'),
        ),
        AVerticalSpace(20.0.scale()),
        Text("Order is empty!",
                style: textStyleBoldCustomColor(20.0.scale(), kColorAppBgColor))
            .leftPadding(12.0.scale())
            .align(Alignment.center)
      ],
    ).expand();
  }
}

class _HistoryListContainer extends StatelessWidget {
  List<HistoryList> _historyListArray;
  ScrollController scrollController;

  _HistoryListContainer(this._historyListArray, this.scrollController);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.vertical,
        itemCount: _historyListArray.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return InkWell(
            onTap: () {},
            child: OrderHistoryRowItem(_historyListArray[index]),
          );
        });
  }
}
