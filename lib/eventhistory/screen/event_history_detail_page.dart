import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grambunny_customer/components/a_horizontal_space.dart';
import 'package:grambunny_customer/components/a_vertical_space.dart';
import 'package:grambunny_customer/components/a_widget_extensions.dart';
import 'package:grambunny_customer/eventhistory/model/event_detail_model.dart';
import 'package:grambunny_customer/utils/ui_utils.dart';

import '../../side_navigation/bloc/side_navigat_bloc.dart';
import '../../side_navigation/bloc/side_navigat_event.dart';
import '../../theme/ft_theme_colors.dart';
import '../../utils/network_image_widget.dart';
import '../bloc/event_history_bloc.dart';

class EventHistoryDetailsPage extends StatefulWidget {
  const EventHistoryDetailsPage({Key? key}) : super(key: key);

  @override
  _EventHistoryDetailsPageState createState() =>
      _EventHistoryDetailsPageState();
}

class _EventHistoryDetailsPageState extends State<EventHistoryDetailsPage> {
  EventViewDetail? eventDetail;
  EventViewItems? eventItems;
  List<EventMultipleDetail> eventmultipleDetail = [];

  // List<EventViewItems> eventItems = [];
  String orderId = "";

  String vendorId = "";

  void showHideProgress(bool show) {
    BlocProvider.of<SideNavigatBloc>(context)
        .add(SideNavigationEventToggleLoadingAnimation(needToShow: show));
  }

  @override
  void initState() {
    // TODO: implement initState
    EventHistoryState eventState =
        BlocProvider.of<EventHistoryBloc>(context).state;
    if (eventState is EventDetailPageState) {
      showHideProgress(false);
      BlocProvider.of<EventHistoryBloc>(context).add(
          EventListDetailEventForViewDetail(eventState.order_id, vendorId));
    }
  }

  String getEventHistoryDetailStatus(String str) {
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<EventHistoryBloc, EventHistoryState>(
        listenWhen: (prevState, curState) => ModalRoute.of(context)!.isCurrent,
        listener: (context, state) {
          if (state is EventListDetailApiLoadingCompleteState) {
            showHideProgress(false);
            setState(() {
              eventDetail = state.eventDetail?[0];
              orderId = eventDetail!.id!;
              print("id=====>${eventDetail!.id!}");
              eventItems = state.eventItems?[0];
              eventmultipleDetail = state.eventmultipleDetail!;
            });
          }
          if (state is EventListDetailLoadingErrorState) {
            showHideProgress(false);
            BlocProvider.of<EventHistoryBloc>(context)
                .add(EventDetailStateReset());
            showSnackBar(state.message, context);
          }
        },
        child: SafeArea(
          bottom: false,
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: KColorAppThemeColor,
                title: Text("Event Details"),
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
                                  "Order ID",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ).leftPadding(10.0.scale()),
                                Text("#${eventDetail?.id}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold))
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
                            "${eventDetail?.firstName} ${eventDetail?.lastName}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ).leftPadding(10.0.scale()),
                          AVerticalSpace(10.0.scale()),
                          Text(
                            "${eventDetail?.mobileNo}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ).leftPadding(10.0.scale()),
                          AVerticalSpace(10.0.scale()),
                          Text(
                            "${eventDetail?.email}",
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
                            "Delivery Address",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ).leftPadding(10.0.scale()),
                          AVerticalSpace(10.0.scale()),
                          Text(
                            "${eventDetail?.address}",
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
                                "${getEventHistoryDetailStatus(eventDetail?.status ?? "")}",
                                style: TextStyle(
                                    color:
                                        "${getEventHistoryDetailStatus(eventDetail?.status ?? "")}" ==
                                                "Successful"
                                            ? Colors.green
                                            : Colors.red,
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
                                "Sub Total",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                              Text(
                                "\$${eventDetail?.subTotal}",
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Discount",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                              Text(
                                "\$0.00",
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Ticket Fee",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                              Text(
                                "\$${eventDetail?.ticketFee}",
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total Paid Amount",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                              Text(
                                "\$${eventDetail?.total}",
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Payment Type",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                              Text(
                                "${eventDetail?.paymentMethod}",
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Payment Status",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                              Text(
                                "${eventDetail?.payStatus}",
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Sales Tax	",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                              Text(
                                "\$1.25",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                              .leftPadding(10.0.scale())
                              .rightPadding(10.0.scale()),
                          AVerticalSpace(15.0.scale()),
                        ]),
                  )
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AVerticalSpace(10.0.scale()),
                        Text(
                          "${eventItems?.name}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        AVerticalSpace(10.0.scale()),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Price:",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                              Text(
                                "\$${eventItems?.price}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ]),
                        AVerticalSpace(10.0.scale()),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Quantity:",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                              Text(
                                "${eventItems?.quantity}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ]),
                        AVerticalSpace(10.0.scale()),
                        if (eventmultipleDetail.length > 0)
                          _EventListWidget(eventmultipleDetail),
                      ],
                    ).leftPadding(10.0.scale()).rightPadding(10.0.scale()),
                  )
                      .leftPadding(10.0.scale())
                      .rightPadding(10.0.scale())
                      .bottomPadding(10.0.scale()),
                ],
              ).scroll()),
        )).pageBgColor(kColorScreenBgColor);
  }
}

class _EventListWidget extends StatelessWidget {
  List<EventMultipleDetail> eventmultipleDetail;

  _EventListWidget(this.eventmultipleDetail);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListView.builder(
              itemCount: eventmultipleDetail.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Bar Code:",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        AVerticalSpace(20.0.scale()),
                        Container(
                          height: 100,
                          width: 100,
                          color: Colors.red,
                          child: NetworkImagesWidgets(
                            url: "${eventmultipleDetail[index].ticketQrcode}",
                            fit: BoxFit.contain,
                          ),
                        )
                      ],
                    )
                        .leftPadding(10.0.scale())
                        .rightPadding(10.0.scale())
                        .topPadding(10.0.scale()),
                    AHorizontalSpace(30.0.scale()),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ticket Id",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        AVerticalSpace(10.0.scale()),
                        Text(
                          "${eventmultipleDetail[index].ticketId}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        AVerticalSpace(10.0.scale()),
                        Text(
                          "Un-used",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                        .leftPadding(10.0.scale())
                        .rightPadding(10.0.scale())
                        .topPadding(10.0.scale())
                  ],
                ).bottomPadding(10.0.scale());
              })
        ]);
  }
}
