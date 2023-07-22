import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grambunny_customer/components/a_widget_extensions.dart';
import 'package:grambunny_customer/ridehistory/model/ride_detail_model.dart';
import 'package:grambunny_customer/side_navigation/bloc/side_navigat_bloc.dart';
import 'package:grambunny_customer/utils/ui_utils.dart';

import '../../components/a_horizontal_space.dart';
import '../../components/a_vertical_space.dart';
import '../../side_navigation/bloc/side_navigat_event.dart';
import '../../theme/ft_theme_colors.dart';
import '../../utils/network_image_widget.dart';
import '../bloc/ride_history_bloc.dart';

class RideHistoryDetailsPage extends StatefulWidget {
  const RideHistoryDetailsPage({Key? key}) : super(key: key);

  @override
  _RideHistoryDetailsPageState createState() => _RideHistoryDetailsPageState();
}

class _RideHistoryDetailsPageState extends State<RideHistoryDetailsPage> {
  RideViewDetail? rideDetail;
  RideViewItems? rideItems;
  String orderId = "";
  String vendorId = "";
  String timeresponse = "";
  RideDetailResponseModel? ridedetailmodel;
  double? totalTime;

  String getRideDetailHistoryStatus(String str) {
    String status = "";
    if (str == "0") {
      status = "Pending";
    } else if (str == "1") {
      status = "Accept";
    } else if (str == "2") {
      status = "Cancelled";
    } else if (str == "3") {
      status = "Ride Start";
    } else if (str == "4") {
      status = "Ride End";
    }
    return status;
  }

  void showHideProgress(bool show) {
    BlocProvider.of<SideNavigatBloc>(context)
        .add(SideNavigationEventToggleLoadingAnimation(needToShow: show));
  }

  @override
  void initState() {
    // TODO: implement initState
    RideHistoryState rideState =
        BlocProvider.of<RideHistoryBloc>(context).state;
    if (rideState is RideListDatailPageState) {
      showHideProgress(false);
      BlocProvider.of<RideHistoryBloc>(context)
          .add(RideListDetailEventForViewDetail(rideState.order_id, vendorId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RideHistoryBloc, RideHistoryState>(
        listenWhen: (prevState, curState) => ModalRoute.of(context)!.isCurrent,
        listener: (context, state) {
          if (state is RideListDetailApiLoadingCompleteState) {
            showHideProgress(false);
            setState(() {
              rideDetail = state.rideDetail?[0];
              orderId = rideDetail!.orderId!;
              print("id=====>${rideDetail!.orderId}");
              rideItems = state.rideItems?[0];
              timeresponse = state.ridedetailmodel!.data!.currentTime!;
              print("timeresponse===>${timeresponse}");
            });
          }
          if (state is RideListDetailLoadingErrorState) {
            showHideProgress(false);
            BlocProvider.of<RideHistoryBloc>(context)
                .add(RideDetailStateReset());
            showSnackBar(state.message, context);
          }
        },
        child: SafeArea(
            bottom: false,
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: KColorAppThemeColor,
                  title: Text("Ride Details"),
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new_sharp, // add custom icons also
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                body: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    AVerticalSpace(15.0.scale()),
                    Container(
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: const Offset(
                                    0.0,
                                    0.0,
                                  ),
                                  blurRadius: 1.0,
                                  spreadRadius: 0.0,
                                ), //BoxShadow
                                BoxShadow(
                                  color: Colors.white,
                                  offset: const Offset(0.0, 0.0),
                                  blurRadius: 1.0,
                                  spreadRadius: 0.0,
                                ), //BoxShadow
                              ],
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 40,
                                    color: Colors.black,
                                    child: Row(
                                      children: [
                                        Text(
                                          "Order ID :",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ).leftPadding(10.0.scale()),
                                        Text("${rideDetail?.id}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold))
                                            .rightPadding(10.0.scale())
                                      ],
                                    ),
                                  ),
                                  AVerticalSpace(10.0.scale()),
                                  Text(
                                    "Order By",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ).leftPadding(10.0.scale()),
                                  AVerticalSpace(10.0.scale()),
                                  Text(
                                    "${rideDetail?.firstName} ${rideDetail?.lastName}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ).leftPadding(10.0.scale()),
                                  AVerticalSpace(10.0.scale()),
                                  Text(
                                    "${rideDetail?.mobileNo}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ).leftPadding(10.0.scale()),
                                  AVerticalSpace(10.0.scale()),
                                  Text(
                                    "${rideDetail?.email}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ).leftPadding(10.0.scale()),
                                  AVerticalSpace(5.0.scale()),
                                  const Divider(
                                    color: Colors.grey,
                                    thickness: 0.5,
                                  ),
                                  AVerticalSpace(7.0.scale()),
                                  Text(
                                    "Pick Up Address",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ).leftPadding(10.0.scale()),
                                  const Divider(
                                    color: Colors.grey,
                                    thickness: 0.5,
                                  ),
                                  AVerticalSpace(7.0.scale()),
                                  Text(
                                    "Drop Off Address",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ).leftPadding(10.0.scale()),
                                  const Divider(
                                    color: Colors.grey,
                                    thickness: 0.5,
                                  ),
                                  AVerticalSpace(7.0.scale()),
                                  Row(
                                    children: [
                                      Text(
                                        "Order Status:",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ).leftPadding(10.0.scale()),
                                      AHorizontalSpace(7.0.scale()),
                                      Text(
                                        "${getRideDetailHistoryStatus(rideDetail?.status ?? "")}",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      AVerticalSpace(10.0.scale()),
                                    ],
                                  ),
                                  AVerticalSpace(10.0.scale()),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Sub Total",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                      Text(
                                        "${rideDetail?.subTotal}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                      .leftPadding(10.0.scale())
                                      .rightPadding(10.0.scale()),
                                  AVerticalSpace(10.0.scale()),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Discount",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                      Text(
                                        "",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                      .leftPadding(10.0.scale())
                                      .rightPadding(10.0.scale()),
                                  AVerticalSpace(10.0.scale()),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Sales Tax	",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                      Text(
                                        "",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                      .leftPadding(10.0.scale())
                                      .rightPadding(10.0.scale()),
                                  AVerticalSpace(10.0.scale()),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Total Paid Amount",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                      Text(
                                        "${rideDetail?.total}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                      .leftPadding(10.0.scale())
                                      .rightPadding(10.0.scale()),
                                  AVerticalSpace(10.0.scale()),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Payment Type",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                      Text(
                                        "${rideDetail?.paymentMethod}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                      .leftPadding(10.0.scale())
                                      .rightPadding(10.0.scale()),
                                  AVerticalSpace(10.0.scale()),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "TransactionID",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                      Text(
                                        "",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                      .leftPadding(10.0.scale())
                                      .rightPadding(10.0.scale()),
                                  AVerticalSpace(10.0.scale()),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Payment Status",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                      Text(
                                        "${rideDetail?.payStatus}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                      .leftPadding(10.0.scale())
                                      .rightPadding(10.0.scale()),
                                  AVerticalSpace(10.0.scale()),
                                  AVerticalSpace(15.0.scale()),
                                ]))
                        .leftPadding(10.0.scale())
                        .rightPadding(10.0.scale())
                        .bottomPadding(10.0.scale()),
                    Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: const Offset(
                              0.0,
                              0.0,
                            ),
                            blurRadius: 1.0,
                            spreadRadius: 0.0,
                          ), //BoxShadow
                          BoxShadow(
                            color: Colors.white,
                            offset: const Offset(0.0, 0.0),
                            blurRadius: 1.0,
                            spreadRadius: 0.0,
                          ), //BoxShadow
                        ],
                      ),
                      child: Row(children: [
                        Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Container(
                                height: 130,
                                width: 120,
                                // color: Colors.red,
                                child: NetworkImagesWidgets(
                                  url: "${rideItems?.imageURL}",
                                  fit: BoxFit.contain,
                                ),
                              )
                            ])
                            .leftPadding(10.0.scale())
                            .rightPadding(10.0.scale())
                            .topPadding(10.0.scale()),
                        AHorizontalSpace(30.0.scale()),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Rideshare",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            AVerticalSpace(10.0.scale()),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Ride Time:",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                                AHorizontalSpace(10.0.scale()),
                                // Text(
                                //   "${timeresponse}",
                                //   style: TextStyle(
                                //       color: Colors.black,
                                //       fontSize: 14,
                                //       fontWeight: FontWeight.bold),
                                // )
                                //  if (timeresponse.isNotEmpty)
                                //_TimerCountWidget(timeresponse),
                              ],
                            ),
                            AVerticalSpace(10.0.scale()),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Base Fee",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                                AHorizontalSpace(15.0.scale()),
                                Text(
                                  "\$${rideItems?.price}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            AVerticalSpace(10.0.scale()),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Rate/Mile",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                                AHorizontalSpace(15.0.scale()),
                                Text(
                                  "\$${rideItems?.rateMile}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            AVerticalSpace(10.0.scale()),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Rate/Minute",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                                AHorizontalSpace(15.0.scale()),
                                Text(
                                  "\$${rideItems?.rateMinute}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            AVerticalSpace(10.0.scale()),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Distance",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                                AHorizontalSpace(15.0.scale()),
                                Text(
                                  "${rideDetail?.distance}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            AVerticalSpace(10.0.scale()),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Subtotal",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                                AHorizontalSpace(15.0.scale()),
                                Text(
                                  "\$${rideDetail?.subTotal}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            AVerticalSpace(10.0.scale()),
                          ],
                        )
                            .leftPadding(10.0.scale())
                            .rightPadding(10.0.scale())
                            .topPadding(10.0.scale()),
                      ]).bottomPadding(10.0.scale()),
                    )
                        .leftPadding(10.0.scale())
                        .rightPadding(10.0.scale())
                        .bottomPadding(10.0.scale()),
                  ],
                ).scroll())));
  }
}

class _CountdownTimerDemoState extends StatefulWidget {
  @override
  __CountdownTimerDemoStateState createState() =>
      __CountdownTimerDemoStateState();
}

class __CountdownTimerDemoStateState extends State<_CountdownTimerDemoState> {
  Timer? countdownTimer;
  Duration myDuration = Duration(days: 5);

  @override
  void initState() {
    super.initState();
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  void resetTimer() {
    stopTimer();
    setState(() => myDuration = Duration(days: 5));
  }

  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final days = strDigits(myDuration.inDays);
    // Step 7
    final hours = strDigits(myDuration.inHours.remainder(24));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            // Step 8
            Text(
              '$hours:$minutes:$seconds',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 50),
            ),
            SizedBox(height: 20),
            // Step 9
            ElevatedButton(
              onPressed: startTimer,
              child: Text(
                'Start',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            // Step 10
            ElevatedButton(
              onPressed: () {
                if (countdownTimer == null || countdownTimer!.isActive) {
                  stopTimer();
                }
              },
              child: Text(
                'Stop',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            // Step 11
            ElevatedButton(
                onPressed: () {
                  resetTimer();
                },
                child: Text(
                  'Reset',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
