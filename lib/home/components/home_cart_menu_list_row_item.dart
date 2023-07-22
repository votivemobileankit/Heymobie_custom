import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grambunny_customer/components/components.dart';
import 'package:grambunny_customer/home/bloc/bloc.dart';
import 'package:grambunny_customer/home/model/cartlist_response_model.dart';
import 'package:grambunny_customer/home/model/driver_list_model.dart';
import 'package:grambunny_customer/home/model/product_list_model.dart';
import 'package:grambunny_customer/theme/theme.dart';
import 'package:grambunny_customer/utils/utils.dart';

const double _kMenuImageWidthSize = 80.0;
const double _kMenuImageHeightSize = 80.0;
const double _kMenuitemNameTextFontSize = 16.0;
const double _kMenuitemSmallText = 9.0;
const double _kMenuTypeTextFontSize = 11.0;
const double _kVerticalSpaceSeparatorLineHeight = 10;
const double _kSeparatorLineHeight = .5;
const double _kButtonNextWidth = 102;
const double _kHeightBtnAddToCart = 40.0;

class HomeCartMenuListRowItem extends StatelessWidget {
  ItemsCart productList;
  DriverList driverDetail;
  Function showHideProgress;
  String strScreen;
  ProductListMenu productListModel;
  String vendor_id;
  String psType;

  HomeCartMenuListRowItem(
      this.productList,
      this.driverDetail,
      this.showHideProgress,
      this.strScreen,
      this.productListModel,
      this.vendor_id,
      this.psType);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2.0),
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3.0,
                  offset: new Offset(0.0, 3.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    AHorizontalSpace(5.0.scale()),
                    Container(
                      width: _kMenuImageHeightSize.scale(),
                      height: _kMenuImageHeightSize.scale(),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: CachedNetworkImage(
                          imageUrl: productList.imageURL,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                              new Icon(Icons.error),
                        ),
                      ),
                    ).align(Alignment.centerRight),
                    AHorizontalSpace(15.0.scale()),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AVerticalSpace(5.0.scale()),
                        Text(
                          productList.name,
                          style: textStyleBoldCustomColor(
                              _kMenuitemNameTextFontSize.scale(),
                              KColorCommonText),
                        ),
                        AVerticalSpace(5.0.scale()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$' + productList.totalprice,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textStyleBoldCustomLargeColor(
                                  _kMenuitemNameTextFontSize.scale(),
                                  KColorCommonText),
                            ).leftPadding(2.0.scale()).expand(),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                        color: KColorTextGrey, width: 1.0),
                                    color: KColorTextGrey,
                                  ),
                                  padding: EdgeInsets.all(5.0.scale()),
                                  width: 120.0.scale(),
                                  // decoration: BoxDecoration(
                                  //   borderRadius: BorderRadius.circular(10.0),
                                  //   border: Border.all(
                                  //       color: kColorCommonButton, width: 3.0),
                                  //   color: Colors.white,
                                  // ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (productList.quantity != "1") {
                                            showHideProgress(true);
                                            BlocProvider.of<HomeBloc>(context).add(
                                                HomeEventItemAddMinusToCartBtnClick(
                                                    1,
                                                    productList.id,
                                                    vendor_id,
                                                    1,
                                                    driverDetail,
                                                    strScreen,
                                                    productListModel,
                                                    "1"));
                                          }
                                        },
                                        child: Container(
                                            padding:
                                                EdgeInsets.all(3.0.scale()),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: Border.all(
                                                  color: KColorTextGrey,
                                                  width: 3.0),
                                              color: KColorTextGrey,
                                            ),
                                            child: Image(
                                              color: Colors.white,
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                  '${imgPathGeneral}ic_minus_icon.png'),
                                              width: 15.0.scale(),
                                              height: 15.0.scale(),
                                            )).align(Alignment.centerLeft),
                                      ).rightPadding(7.0.scale()),
                                      Container(
                                        child: Row(
                                          children: [
                                            AHorizontalSpace(4.0.scale()),
                                            Text(
                                              ' ${productList.quantity}',
                                              style:
                                                  textStyleBoldCustomLargeColor(
                                                      _kMenuitemNameTextFontSize
                                                          .scale(),
                                                      Colors.white),
                                            ),
                                            AHorizontalSpace(5.0.scale()),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          showHideProgress(true);
                                          BlocProvider.of<HomeBloc>(context).add(
                                              HomeEventItemAddMinusToCartBtnClick(
                                                  1,
                                                  productList.id,
                                                  vendor_id,
                                                  0,
                                                  driverDetail,
                                                  strScreen,
                                                  productListModel,
                                                  "1"));
                                        },
                                        child: Container(
                                            padding:
                                                EdgeInsets.all(3.0.scale()),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: Border.all(
                                                  color: KColorTextGrey,
                                                  width: 3.0),
                                              color: KColorTextGrey,
                                            ),
                                            child: Image(
                                              color: Colors.white,
                                              fit: BoxFit.fill,
                                              width: 15.0.scale(),
                                              height: 15.0.scale(),
                                              image: AssetImage(
                                                '${imgPathGeneral}ic_add_icon.png',
                                              ),
                                            )).align(Alignment.centerLeft),
                                      ).leftPadding(8.0.scale()),
                                    ],
                                  ),
                                ),
                                AHorizontalSpace(10.0.scale()),
                                InkWell(
                                  onTap: () {
                                    showHideProgress(true);
                                    BlocProvider.of<HomeBloc>(context).add(
                                        HomeEventCartDeleteItemClick(
                                            productList.id, driverDetail));
                                  },
                                  child: Image(
                                    fit: BoxFit.fill,
                                    width: 20.0.scale(),
                                    height: 20.0.scale(),
                                    color: kColorCommonButton,
                                    image: AssetImage(
                                        '${imgPathGeneral}ic_delete_icon.png'),
                                  ),
                                )
                              ],
                            ).rightPadding(15.0.scale())
                          ],
                        ),
                      ],
                    ).expand(),
                    AVerticalSpace(5.0.scale()),
                  ],
                ),
                AVerticalSpace(_kVerticalSpaceSeparatorLineHeight.scale()),
                // ASeparatorLine(
                //   height: _kSeparatorLineHeight.scale(),
                //   color: KColorAppointmentDropinHistoryListSeprator,
                // ),
              ],
            ))
        .topPadding(12.0.scale())
        .leftPadding(8.0.scale())
        .rightPadding(8.0.scale());
  }
}
