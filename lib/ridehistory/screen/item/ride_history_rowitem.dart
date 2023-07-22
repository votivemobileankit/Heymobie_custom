import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grambunny_customer/components/a_horizontal_space.dart';
import 'package:grambunny_customer/components/a_widget_extensions.dart';
import 'package:grambunny_customer/ridehistory/bloc/ride_history_bloc.dart';
import 'package:grambunny_customer/utils/ui_utils.dart';

import '../../../components/a_vertical_space.dart';
import '../../../theme/ft_theme_colors.dart';
import '../../model/ride_history_model.dart';

class RideHistoryRowItem extends StatefulWidget {
  RideHistoryListData rideHistoryList;

  RideHistoryRowItem(this.rideHistoryList);

  @override
  _RideHistoryRowItemState createState() => _RideHistoryRowItemState();
}

class _RideHistoryRowItemState extends State<RideHistoryRowItem> {
  String getRideHistoryStatus(String str) {
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

  trackOpen() async {
    if (kDebugMode) {
      print("Open");
    }
    // if (await MapLauncher.isMapAvailable(MapType.google) != null) {
    //   await MapLauncher.showMarker(
    //     mapType: MapType.google,
    //     coords: Coords(37.759392, -122.5107336),
    //     title: "",
    //     description: "description",
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Order ID:",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ).leftPadding(10.0.scale()),
                        Text("#${widget.rideHistoryList.orderId}",
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Driver ID:",
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ).leftPadding(20.0.scale()),
                        Text(
                          "#${widget.rideHistoryList.vendorId}",
                          style: TextStyle(color: Colors.black, fontSize: 16),
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
                        "Driver Name :",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ).leftPadding(20.0.scale()),
                      Text(
                        "${widget.rideHistoryList.name} ${widget.rideHistoryList.lastName}",
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
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ).leftPadding(20.0.scale()),
                      Text(
                        "${widget.rideHistoryList.username}",
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
                        "Booking Price :",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ).leftPadding(20.0.scale()),
                      Text(
                        "\$${widget.rideHistoryList.total}",
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
                        "Booking Status :",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ).leftPadding(20.0.scale()),
                      Text(
                        "${getRideHistoryStatus(widget.rideHistoryList.status ?? "")}",
                        style: TextStyle(
                            color: Colors.red,
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
                        "Pick Up Address :",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ).leftPadding(20.0.scale()),
                      Text(
                        "${widget.rideHistoryList.pickAddress}" != null
                            ? ""
                            : "${widget.rideHistoryList.pickAddress}",
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
                        "Drop Off Address :",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ).leftPadding(20.0.scale()),
                      Text(
                        "${widget.rideHistoryList.dropAddress}" != null
                            ? ""
                            : "${widget.rideHistoryList.dropAddress}",
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
                        "Booking Time :",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ).leftPadding(20.0.scale()),
                      Text(
                        "${widget.rideHistoryList.createdAt}",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: InkWell(
                          onTap: () {
                            BlocProvider.of<RideHistoryBloc>(context).add(
                                RideViewDetailEventClicked(
                                    "${widget.rideHistoryList.id.toString()}"));
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            )),
                          ),
                        ),
                      ),
                      AHorizontalSpace(15.0.scale()),
                      if (widget.rideHistoryList.status == "3")
                        InkWell(
                          onTap: () {
                            if (kDebugMode) print("save=======");
                            trackOpen();
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
                              "Track Order",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            )),
                          ),
                        ),
                    ],
                  ),
                  AVerticalSpace(10.0.scale())
                ]))
        .leftPadding(10.0.scale())
        .rightPadding(10.0.scale())
        .bottomPadding(15.0.scale());
  }
}
