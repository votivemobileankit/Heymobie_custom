import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grambunny_customer/components/components.dart';
import 'package:grambunny_customer/home/home.dart';
import 'package:grambunny_customer/home/model/product_list_model.dart';
import 'package:grambunny_customer/theme/theme.dart';
import 'package:grambunny_customer/utils/utils.dart';

import '../model/driver_list_model.dart';

const double _kMenuImageWidthSize = 100.0;
const double _kMenuImageHeightSize = 110.0;
const double _kMenuitemNameTextFontSize = 14.0;
const double _kMenuitemSmallText = 12.0;
const double _kMenuTypeTextFontSize = 16.0;
const double _kVerticalSpaceSeparatorLineHeight = 10;
const double _kSeparatorLineHeight = .5;
const double _kButtonNextWidth = 102;
const kHeightBtnAddToCart = 35.0;

class MenuListRowItem extends StatelessWidget {
  ProductListMenu? productList;
  DriverList? driverDetail;
  String? strSubcategoryId;

  MenuListRowItem(this.productList, this.driverDetail);

  @override
  Widget build(BuildContext context12) {
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
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () {
                    if (int.parse(productList!.quantity!) == 0) {
                      showSnackBar("Product is out of stock!", context12);
                    } else {
                      showDialog(
                        context: context12,
                        barrierColor: Colors.black26,
                        barrierDismissible: true,
                        builder: (context) {
                          return getAddToCartWidget(
                              context1: context12,
                              productlist: productList!,
                              driverDetail: driverDetail!,
                              titleText: '',
                              btn1TitleText: '',
                              btn1OnPressed: () {},
                              btn2TitleText: '',
                              btn2OnPressed: () {});
                        },
                      );
                    }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              if (int.parse(productList!.quantity!) == 0)
                                OutlinedButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        KColorAppThemeColor),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0))),
                                  ),
                                  child: Text(
                                    "Out of stock",
                                    style: textStyleCustomColor(
                                        14.0.scale(), Colors.red),
                                    textAlign: TextAlign.center,
                                  ),
                                ).rightPadding(12.0.scale())
                            ],
                          ),
                          AVerticalSpace(3.0.scale()),
                          Text(
                            productList!.name!,
                            style: textStyleBoldCustomColor(
                                _kMenuitemNameTextFontSize.scale(),
                                KColorCommonText),
                          ),
                          AVerticalSpace(3.0.scale()),
                          Text(
                            "UPC#" + productList!.productCode!,
                            style: textStyleBoldCustomColor(
                                _kMenuitemNameTextFontSize.scale(),
                                KColorCommonText),
                          ),
                        ],
                      ).align(Alignment.centerLeft),
                      AVerticalSpace(3.0.scale()),
                      Row(
                        children: [
                          Container(
                            width: 150.0.scale(),
                            child: Row(
                              children: [
                                Text(
                                  '\$' + productList!.price!,
                                  style: textStyleBoldCustomLargeColor(
                                      _kMenuTypeTextFontSize.scale(),
                                      KColorCommonText),
                                  textAlign: TextAlign.left,
                                ).align(Alignment.centerLeft),
                                AHorizontalSpace(5.0.scale()),
                                Text(
                                  "(${productList!.unit}) ",
                                  style: textStyleBoldCustomLargeColor(
                                      _kMenuTypeTextFontSize.scale(),
                                      KColorCommonText),
                                  textAlign: TextAlign.left,
                                ).align(Alignment.centerLeft),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )).align(Alignment.centerLeft).expand(),
              InkWell(
                onTap: () {
                  if (int.parse(productList!.quantity!) == 0) {
                    showSnackBar("Product is out of stock!", context12);
                  } else {
                    showDialog(
                      context: context12,
                      barrierColor: Colors.black26,
                      barrierDismissible: true,
                      builder: (context) {
                        return getAddToCartWidget(
                            btn1OnPressed: () {},
                            btn1TitleText: "",
                            btn2OnPressed: () {},
                            btn2TitleText: "",
                            titleText: "",
                            context1: context12,
                            productlist: productList!,
                            driverDetail: driverDetail!);
                      },
                    );
                  }
                },
                child: Container(
                  width: _kMenuImageHeightSize.scale(),
                  height: _kMenuImageHeightSize.scale() - 30.0.scale(),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: CachedNetworkImage(
                          width: _kMenuImageHeightSize.scale(),
                          height: _kMenuImageHeightSize.scale() - 30.0.scale(),
                          imageUrl: productList!.imageURL!,
                          fit: BoxFit.fill,
                          errorWidget: (context, url, error) =>
                              new Icon(Icons.error),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [],
                      )
                    ],
                  ),
                ).topPadding(15.0),
              ).align(Alignment.centerRight),
            ],
          ),
          AVerticalSpace(_kVerticalSpaceSeparatorLineHeight.scale()),
        ],
      ).leftPadding(7.0.scale()).rightPadding(7.0.scale()),
    )
        .leftPadding(8.0.scale())
        .rightPadding(8.0.scale())
        .bottomPadding(12.0.scale());
  }
}

const double _kFontSize16 = 16.0;
const double _kAddtoCartDialogRadius = 20.0;
const double _kCommonCartMediumFontSize = 14.0;
const double _kCommonFontSize = 16.0;

Dialog getAddToCartWidget(
    {required BuildContext context1,
    required String titleText,
    required String btn1TitleText,
    required VoidCallback btn1OnPressed,
    required String btn2TitleText,
    required VoidCallback btn2OnPressed,
    required ProductListMenu productlist,
    required DriverList driverDetail}) {
  return Dialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_kAddtoCartDialogRadius.scale())),
    elevation: 8,
    insetAnimationDuration: Duration(milliseconds: 30),
    insetPadding: EdgeInsets.all(10.0.scale()),
    child: _AddToCartWidget(productlist, driverDetail, context1),
  );
}

class _AddToCartWidget extends StatefulWidget {
  ProductListMenu productlist;
  DriverList driverDetail;
  BuildContext context1;

  _AddToCartWidget(this.productlist, this.driverDetail, this.context1);

  @override
  __AddToCartWidgetState createState() => __AddToCartWidgetState();
}

class __AddToCartWidgetState extends State<_AddToCartWidget> {
  int _counter = 1;
  int decrease = 0;
  late double price;
  late BuildContext contexttext;

  @override
  void initState() {
    // TODO: implement initState
    price = double.parse(widget.productlist.price!);
    contexttext = widget.context1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 320.0.scale(),
      child: Column(children: [
        AVerticalSpace(5.0.scale()),
        Card(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: CachedNetworkImage(
              imageUrl: widget.productlist.imageURL!,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              errorWidget: (context, url, error) => new Icon(Icons.error),
            ),
          ).topPadding(2.0.scale()).setHeight(150.0.scale()),
        ),
        Column(
          children: [
            AVerticalSpace(5.0.scale()),
            Text(
              widget.productlist.name!,
              style: textStyleBoldCustomLargeColor(
                  _kMenuitemNameTextFontSize.scale(), KColorCommonText),
            ).align(Alignment.centerLeft),
            AVerticalSpace(5.0.scale()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$ ${price}',
                  style: textStyleBoldCustomLargeColor(
                      _kMenuitemNameTextFontSize.scale(), KColorCommonText),
                ),
                Text(
                  widget.productlist.unit! + ", ",
                  style: textStyleBoldCustomLargeColor(
                      _kMenuitemNameTextFontSize.scale(), KColorCommonText),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: KColorTextGrey, width: 1.0),
                    color: KColorTextGrey,
                  ),
                  padding: EdgeInsets.all(5.0.scale()),
                  width: 130.0.scale(),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          if (_counter > 1) {
                            _counter--;
                            print(_counter);
                            setState(() {
                              price = double.parse(widget.productlist.price!) *
                                  _counter;
                              String value = price.toStringAsFixed(2);
                              price = double.parse(value);
                            });
                          }
                        },
                        child: Container(
                            padding: EdgeInsets.all(3.0.scale()),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border:
                                  Border.all(color: KColorTextGrey, width: 3.0),
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
                            // AVerticalSeparatorLine(
                            //     width: 1,
                            //     height: 20.0.scale(),
                            //     color: kColorCommonButton),

                            Text(
                              ' ${_counter}',
                              style: textStyleBoldCustomLargeColor(
                                  _kMenuitemNameTextFontSize.scale(),
                                  Colors.white),
                            ),
                            AHorizontalSpace(5.0.scale()),
                            // AVerticalSeparatorLine(
                            //     width: 1,
                            //     height: 20,
                            //     color: kColorCommonButton),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (_counter <
                              int.parse(widget.productlist.quantity!)) {
                            _counter++;
                            print(_counter);
                            setState(() {
                              price = double.parse(widget.productlist.price!) *
                                  _counter;
                              String value = price.toStringAsFixed(2);
                              price = double.parse(value);
                            });
                          } else {
                            showSnackBar(
                                "Product available quantity is ${widget.productlist == null ? widget.productlist.quantity : widget.productlist.quantity}",
                                context);
                          }
                        },
                        child: Container(
                            padding: EdgeInsets.fromLTRB(
                                9.0.scale(), 0, 9.0.scale(), 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border:
                                  Border.all(color: KColorTextGrey, width: 3.0),
                              color: KColorTextGrey,
                            ),
                            child: Image(
                              color: Colors.white,
                              fit: BoxFit.fill,
                              width: 15.0.scale(),
                              height: 15.0.scale(),
                              image: AssetImage(
                                  '${imgPathGeneral}ic_add_icon.png'),
                            )).align(Alignment.centerLeft),
                      ).leftPadding(8.0.scale()),
                    ],
                  ),
                )
              ],
            ),
            AVerticalSpace(20.0.scale()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ARoundedButton(
                  btnBgColor: kColorCommonButton,
                  btnTextColor: Colors.white,
                  btnOnPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    BlocProvider.of<HomeBloc>(contexttext).add(
                        HomeEventAddToCartBtnClick(
                            _counter,
                            widget.productlist.id!,
                            widget.driverDetail.vendorId,
                            0,
                            widget.driverDetail,
                            "0",
                            ""));
                  },
                  btnText: "Add to Cart",
                  btnHeight: kHeightBtnAddToCart.scale(),
                  btnWidth: 110.0.scale(),
                  btnFontSize: kFontSizeBtnLarge.scale(),
                  btnElevation: 0,
                  btnBorderSideColor: kColorCommonButton,
                  btnDisabledColor: Color(0xFF5e6163),
                  btnIconSize: 15,
                  btnDisabledTextColor: Color(0xFFFFFFFF),
                  btnFontWeight: FontWeight.normal,
                ).align(Alignment.center),
                AVerticalSeparatorLine(
                    width: 1, height: 20, color: Colors.white),
                ARoundedButton(
                  btnBgColor: kColorCommonButton,
                  btnTextColor: Colors.white,
                  btnOnPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  btnText: "Cancel",
                  btnHeight: kHeightBtnAddToCart.scale(),
                  btnWidth: 110.0.scale(),
                  btnFontSize: kFontSizeBtnLarge.scale(),
                  btnElevation: 0,
                  btnBorderSideColor: kColorCommonButton,
                  btnDisabledColor: Color(0xFF5e6163),
                  btnIconSize: 15,
                  btnDisabledTextColor: Color(0xFFFFFFFF),
                  btnFontWeight: FontWeight.normal,
                ).align(Alignment.center),
              ],
            )
          ],
        ).leftPadding(14.0.scale()).rightPadding(14.0.scale())
      ]),
    );
  }
}
