import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grambunny_customer/components/components.dart';
import 'package:grambunny_customer/generated/l10n.dart';
import 'package:grambunny_customer/orderhistory/orderhistory.dart';
import 'package:grambunny_customer/theme/theme.dart';
import 'package:grambunny_customer/utils/ui_utils.dart';


const double _kMenuImageWidthSize = 100.0;
const double _kMenuImageHeightSize = 100.0;
const double _kMenuitemNameTextFontSize = 16.0;
const double _kMenuitemSmallText = 12.0;
const double _kMenuTypeTextFontSize = 16.0;
const double _kButtonNextWidth = 102;
const kHeightBtnAddToCart = 40.0;
const double _kVerticalSpaceSeparatorLineHeight = 10;
const double _kSeparatorLineHeight = .5;

class MyOrderListRow extends StatelessWidget {
  OrderItems orderDetailMenuItem;

  MyOrderListRow(this.orderDetailMenuItem);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                AHorizontalSpace(5.0.scale()),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    width: _kMenuImageHeightSize.scale(),
                    height: _kMenuImageHeightSize.scale() - 10.0.scale(),
                    imageUrl: orderDetailMenuItem.imageURL,
                    fit: BoxFit.fill,
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                ).align(Alignment.centerRight),
                AHorizontalSpace(15.0.scale()),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      orderDetailMenuItem.name,
                      style: textStyleBoldCustomColor(
                          _kMenuitemNameTextFontSize.scale(), KColorCommonText),
                    ),
                    AVerticalSpace(3.0.scale()),
                    Text(
                      orderDetailMenuItem.types,
                      style: textStyleBoldCustomLargeColor(
                          _kMenuTypeTextFontSize.scale(),
                          KColorClosedTextCategoryDetailPage),
                    ),
                    AVerticalSpace(3.0.scale()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          Stringss.current.txtTHC +
                              "${orderDetailMenuItem.potencyThc}" +
                              Stringss.current.txtPercent,
                          style: textStyleBoldCustomLargeColor(
                              _kMenuitemSmallText.scale(), KColorTextGrey),
                          textAlign: TextAlign.left,
                        ),
                        AHorizontalSpace(5.0.scale()),
                        if (orderDetailMenuItem.potencyCbd != "0" &&
                            orderDetailMenuItem.potencyCbd != "")
                          AVerticalSeparatorLine(
                              width: 1, height: 15, color: KColorTextGrey),
                        AHorizontalSpace(5.0.scale()),
                        Text(
                          Stringss.current.txtCBD +
                              "${orderDetailMenuItem.potencyThc}" +
                              Stringss.current.txtPercent,
                          style: textStyleBoldCustomLargeColor(
                              _kMenuitemSmallText.scale(), KColorTextGrey),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ).align(Alignment.centerLeft),
                    AVerticalSpace(3.0.scale()),
                    Row(
                      children: [
                        Text(
                          "\$ ${orderDetailMenuItem.price} x ${orderDetailMenuItem.psQty}",
                          style: textStyleBoldCustomLargeColor(
                              _kMenuTypeTextFontSize.scale(), KColorCommonText),
                        ),
                      ],
                    ),
                    AVerticalSpace(3.0.scale()),
                  ],
                ).expand(),
                AVerticalSpace(5.0.scale()),
              ],
            ),
            AVerticalSpace(_kVerticalSpaceSeparatorLineHeight.scale()),
            ASeparatorLine(
              height: _kSeparatorLineHeight.scale(),
              color: KColorAppointmentDropinHistoryListSeprator,
            ),
          ],
        ));
  }
}
