import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grambunny_customer/components/a_widget_extensions.dart';
import 'package:grambunny_customer/components/components.dart';
import 'package:grambunny_customer/generated/l10n.dart';
import 'package:grambunny_customer/orderhistory/orderhistory.dart';
import 'package:grambunny_customer/theme/theme.dart';
import 'package:grambunny_customer/utils/ui_utils.dart';
import 'package:grambunny_customer/utils/utils.dart';

const double _kTextCommonFontSize = 14.0;
const double _kButtonNextWidth = 150.0;
const kHeightBtnAddToCart = 40.0;

class OrderHistoryRowItem extends StatefulWidget {
  HistoryList _historyItemModel;

  OrderHistoryRowItem(this._historyItemModel);

  @override
  State<OrderHistoryRowItem> createState() => _OrderHistoryRowItemState();
}

class _OrderHistoryRowItemState extends State<OrderHistoryRowItem> {
  String status = "0";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        height: 265.0.scale(),
        padding: EdgeInsets.only(top: 10.0.scale(), bottom: 10.0.scale()),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: KColorAppThemeColor, spreadRadius: 3),
          ],
        ),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image(
                            image: AssetImage(
                                '${imgPathGeneral}ic_calendar_icon.png'),
                            width: 25.0.scale(),
                            height: 25.0.scale(),
                          ).align(Alignment.centerLeft),
                          AHorizontalSpace(4.0.scale()),
                          Text(
                            widget._historyItemModel.createdAt!,
                            style: textStyleCustomColor(
                                _kTextCommonFontSize.scale(), KColorCommonText),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      if (widget._historyItemModel.status == "0")
                        Text(
                          "Pending",
                          style: textStyleCustomColor(
                              _kTextCommonFontSize.scale(), KColorPending),
                          textAlign: TextAlign.left,
                        )
                      else if (widget._historyItemModel.status == "1")
                        Text(
                          "Accept",
                          style: textStyleCustomColor(
                              _kTextCommonFontSize.scale(), KColorCommonText),
                          textAlign: TextAlign.left,
                        )
                      else if (widget._historyItemModel.status == "2")
                        Text(
                          "Cancelled",
                          style: textStyleCustomColor(
                              _kTextCommonFontSize.scale(),
                              KColorCancelledStatus),
                          textAlign: TextAlign.left,
                        )
                      else if (widget._historyItemModel.status == "3")
                        Text(
                          "on the way",
                          style: textStyleCustomColor(
                              _kTextCommonFontSize.scale(), KColorOnTheWay),
                          textAlign: TextAlign.left,
                        )
                      else if (widget._historyItemModel.status == "4")
                        Text(
                          "Delivered",
                          style: textStyleCustomColor(
                              _kTextCommonFontSize.scale(), KColorDelivered),
                          textAlign: TextAlign.left,
                        )
                    ],
                  ),
                  AVerticalSpace(10.0.scale()),
                  ASeparatorLine(
                    height: 1.0.scale(),
                    color: KColorAppointmentDropinHistoryListSeprator,
                  )
                ],
              ).leftPadding(5.0.scale()).rightPadding(5.0.scale()),
              Column(
                children: [
                  AVerticalSpace(10.0.scale()),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Stringss.current.txtMerchantName,
                        style: textStyleCustomColor(
                            _kTextCommonFontSize.scale(), KColorCommonText),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        widget._historyItemModel.name! +
                            " " +
                            widget._historyItemModel.lastName!,
                        style: textStyleCustomColor(
                            _kTextCommonFontSize.scale(), KColorCommonText),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ).leftPadding(5.0.scale()).rightPadding(5.0.scale()),
                  AVerticalSpace(10.0.scale()),
                  ASeparatorLine(
                    height: 1.0.scale(),
                    color: KColorAppointmentDropinHistoryListSeprator,
                  ),
                  AVerticalSpace(10.0.scale()),
                ],
              ).leftPadding(5.0.scale()).rightPadding(5.0.scale()),
              Column(
                children: [
                  AVerticalSpace(5.0.scale()),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Stringss.current.txtOrderId,
                        style: textStyleCustomColor(
                            _kTextCommonFontSize.scale(), KColorCommonText),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "#" + widget._historyItemModel.orderId!,
                        style: textStyleCustomColor(
                            _kTextCommonFontSize.scale(), KColorCommonText),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ).leftPadding(5.0.scale()).rightPadding(5.0.scale()),
                  AVerticalSpace(10.0.scale()),
                  ASeparatorLine(
                    height: 1.0.scale(),
                    color: KColorAppointmentDropinHistoryListSeprator,
                  ),
                  AVerticalSpace(10.0.scale()),
                ],
              ).leftPadding(5.0.scale()).rightPadding(5.0.scale()),
              Column(
                children: [
                  AVerticalSpace(5.0.scale()),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order Amount",
                        style: textStyleCustomColor(
                            _kTextCommonFontSize.scale(), KColorCommonText),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        '\$' + widget._historyItemModel.total!,
                        style: textStyleCustomColor(
                            _kTextCommonFontSize.scale(), KColorCommonText),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  AVerticalSpace(10.0.scale()),
                  ASeparatorLine(
                    height: 1.0.scale(),
                    color: KColorAppointmentDropinHistoryListSeprator,
                  )
                ],
              ).leftPadding(5.0.scale()).rightPadding(5.0.scale()),
              Column(
                children: [
                  AVerticalSpace(10.0.scale()),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Payment Type",
                        style: textStyleCustomColor(
                            _kTextCommonFontSize.scale(), KColorCommonText),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        widget._historyItemModel.paymentMethod!,
                        style: textStyleCustomColor(
                            _kTextCommonFontSize.scale(), KColorCommonText),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  AVerticalSpace(5.0.scale()),
                ],
              ).leftPadding(5.0.scale()).rightPadding(5.0.scale()),
              ARoundedButton(
                btnBorderSideColor: kColorCommonButton,
                btnDisabledColor: Color(0xFF5e6163),
                btnIconSize: 15,
                btnDisabledTextColor: Color(0xFFFFFFFF),
                btnFontWeight: FontWeight.normal,
                btnBgColor: KColorAppThemeColor,
                btnTextColor: Colors.white,
                btnOnPressed: () {
                  BlocProvider.of<OrderHistoryBloc>(context).add(
                      OrderHistoryEventRowItemClick(
                          widget._historyItemModel.id!,
                          widget._historyItemModel.username!,
                          widget._historyItemModel.lastName!,
                          widget._historyItemModel.vendorId!));
                },
                btnText: Stringss.current.btnViewOrder,
                btnHeight: kHeightBtnAddToCart.scale(),
                btnWidth: _kButtonNextWidth.scale(),
                btnFontSize: kFontSizeBtnLarge.scale(),
              ),
            ],
          ).width(double.infinity),
        ).leftPadding(5.0.scale()).rightPadding(5.0.scale()));
  }
}
