import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grambunny_customer/components/a_widget_extensions.dart';
import 'package:grambunny_customer/eventhistory/bloc/event_history_bloc.dart';
import 'package:grambunny_customer/utils/ui_utils.dart';

import '../../components/a_header_back_button.dart';
import '../../components/a_vertical_space.dart';
import '../../side_navigation/bloc/side_navigat_bloc.dart';
import '../../side_navigation/bloc/side_navigat_event.dart';
import '../../theme/ft_theme_colors.dart';
import '../eventhistory_navigator.dart';
import '../model/event_history_model.dart';

class EventHistoryPage extends StatefulWidget {
  const EventHistoryPage({Key? key}) : super(key: key);

  @override
  _EventHistoryPageState createState() => _EventHistoryPageState();
}

class _EventHistoryPageState extends State<EventHistoryPage> {
  List<EventHistoryListData> eventHistoryList = [];
  late ScrollController _scrollController;
  int pageCount = 1;
  bool isLoading = false;
  late final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  void showHideProgress(bool show) {
    BlocProvider.of<SideNavigatBloc>(context)
        .add(SideNavigationEventToggleLoadingAnimation(needToShow: show));
  }

  void initState() {
    showHideProgress(false);
    BlocProvider.of<EventHistoryBloc>(context)
        .add(EventHistorybtnEvent('${pageCount}'));
    _scrollController = ScrollController()..addListener(_scrollListener);
    setDarkStatusBarOverlay();
    super.initState();
    print("data=====>");
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
      BlocProvider.of<EventHistoryBloc>(context)
          .add(EventHistorybtnEvent('${pageCount}'));
    });
  }

  String getEventHistoryStatus(String str) {
    String status = "";
    if (str == "0") {
      status = "Pending";
    } else if (str == "1") {
      status = "Accept";
    } else if (str == "2") {
      status = "Cancelled";
    } else if (str == "") {
      status = "On the way";
    } else if (str == "4") {
      status = "Successful";
    }
    return status;
  }

  Future<Null> _refresh() async {
    pageCount = 1;
    BlocProvider.of<EventHistoryBloc>(context)
        .add(EventHistorybtnEvent('${pageCount}'));
    _refreshIndicatorKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refresh,
      child: BlocListener<EventHistoryBloc, EventHistoryState>(
        listenWhen: (prevState, curState) => ModalRoute.of(context)!.isCurrent,
        listener: (context, state) {
          if (state is EventDetailPageState) {
            Navigator.of(context)
                .pushNamed(EventHistoryNavigator.eventdetailPage);
          }
          if (state is EventHistoryApiLoadingCompleteState) {
            showHideProgress(false);
            setState(() {
              if (state.refresh == 1) {
                eventHistoryList.clear();
                List<EventHistoryListData> eventHistoryListnew =
                    state.eventHistoryList!;
                eventHistoryList.addAll(eventHistoryListnew);
                print("dataprint====> ${eventHistoryList[0].vendorId}");
              } else {
                List<EventHistoryListData> eventHistoryListnew =
                    state.eventHistoryList!;
                eventHistoryList.addAll(eventHistoryListnew);
              }
            });
          }
          if (state is EventHisyoryLoadingErrorState) {
            showHideProgress(false);
            BlocProvider.of<EventHistoryBloc>(context)
                .add(EventHistoryStateReset());
            showSnackBar(state.message, context);
          }
          if (state is EventHistoryToNavigateHomeResetPageState) {
            print("In blocListener");
            BlocProvider.of<EventHistoryBloc>(context)
                .add(EventHistoryEventReset());
            BlocProvider.of<SideNavigatBloc>(context)
                .add(SideNavigationEventGoToHomePageFromHistory());
          }
        },
        child: SafeArea(
            bottom: false,
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              AHeaderWidget(
                headerSigninText: "",
                headerText: "",
                btnEditOnPressed: () {},
                strBackbuttonName: 'ic_slide_menu_icon.png',
                backBtnVisibility: true,
                btnBackOnPressed: () {
                  if (_timer != null) {
                    _timer?.cancel();
                  }
                  Scaffold.of(context).openDrawer();
                },
                strBtnRightImageName: 'ic_search_logo.png',
                rightEditButtonVisibility: false,
              ),
              AVerticalSpace(10.0.scale()),
              Text(
                "Events History",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ).align(Alignment.center),
              AVerticalSpace(30.0.scale()),
              Expanded(
                child: ListView.builder(
                    controller: _scrollController,
                    itemCount: eventHistoryList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 0.5, color: Colors.grey),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 40,
                              color: Colors.black,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Event ID:",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ).leftPadding(10.0.scale()),
                                  Text("#${eventHistoryList[index].orderId}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold))
                                      .rightPadding(10.0.scale())
                                ],
                              ),
                            ),
                            AVerticalSpace(10.0.scale()),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Merchant ID:",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ).leftPadding(20.0.scale()),
                                  Text(
                                    "#${eventHistoryList[index].vendorId}",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ).rightPadding(10.0.scale()),
                                ]),
                            AVerticalSpace(10.0.scale()),
                            const Divider(
                              color: Colors.grey,
                              thickness: 1.5,
                            ),
                            AVerticalSpace(5.0.scale()),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Merchant Name :",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ).leftPadding(20.0.scale()),
                                Text(
                                  "${eventHistoryList[index].name} ${eventHistoryList[index].lastName}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ).rightPadding(10.0.scale()),
                              ],
                            ),
                            AVerticalSpace(10.0.scale()),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "User Name :",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ).leftPadding(20.0.scale()),
                                Text(
                                  "${eventHistoryList[index].username}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ).rightPadding(10.0.scale()),
                              ],
                            ),
                            AVerticalSpace(10.0.scale()),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Event Price :",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ).leftPadding(20.0.scale()),
                                Text(
                                  "\$${eventHistoryList[index].total}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ).rightPadding(10.0.scale()),
                              ],
                            ),
                            AVerticalSpace(10.0.scale()),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Placed :",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ).leftPadding(20.0.scale()),
                                Text(
                                  "${eventHistoryList[index].createdAt}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ).rightPadding(10.0.scale()),
                              ],
                            ),
                            AVerticalSpace(10.0.scale()),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Event Status :",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ).leftPadding(20.0.scale()),
                                Text(
                                  "${getEventHistoryStatus(eventHistoryList[index].status ?? "")}",
                                  style: TextStyle(
                                      color:
                                          "${getEventHistoryStatus(eventHistoryList[index].status ?? "")}" ==
                                                  "Successful"
                                              ? Colors.green
                                              : Colors.red,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ).rightPadding(10.0.scale()),
                              ],
                            ),
                            AVerticalSpace(10.0.scale()),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Delivery Address :",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ).leftPadding(20.0.scale()),
                                Text(
                                  "${eventHistoryList[index].addressd}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ).rightPadding(10.0.scale()),
                              ],
                            ),
                            AVerticalSpace(10.0.scale()),
                            const Divider(
                              color: Colors.grey,
                              thickness: 1.5,
                            ),
                            Center(
                              child: InkWell(
                                onTap: () {
                                  BlocProvider.of<EventHistoryBloc>(context)
                                      .add(EventViewDetailEventClicked(
                                          "${eventHistoryList[index].id.toString()}"));
                                },
                                child: Container(
                                  height: 40,
                                  width: 120,
                                  decoration: const BoxDecoration(
                                    color: mainColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "View Detail",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  )),
                                ),
                              ),
                            ),
                            AVerticalSpace(10.0.scale())
                          ],
                        ),
                      )
                          .leftPadding(10.0.scale())
                          .rightPadding(10.0.scale())
                          .bottomPadding(15.0.scale());
                    }),
              )
            ])).pageBgColor(kColorScreenBgColor),
      ).pageBgColor(kColorScreenBgColor),
    );
  }
}

const double _kTextBirthdateField = 128.0;
String strCity = "";
Timer? _timer;
bool isTimerOn = false;
String strProduct = "";
