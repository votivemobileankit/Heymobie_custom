import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grambunny_customer/components/components.dart';
import 'package:grambunny_customer/home/home.dart';
import 'package:grambunny_customer/home/model/product_list_model.dart';
import 'package:grambunny_customer/theme/theme.dart';
import 'package:grambunny_customer/utils/ui_utils.dart';

const double _kButtonNextWidth = 102;
const double _kHeightBtnAddToCart = 35.0;

class CouponCodeRowItemListModel extends StatelessWidget {
  Couponlist couponArrayList;
  Function showHideProgress;
  DriverList driverDetail;
  String strScreen;
  ProductListMenu productListModel;

  CouponCodeRowItemListModel(this.couponArrayList, this.showHideProgress,
      this.driverDetail, this.strScreen, this.productListModel);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        height: 60.0.scale(),
        padding: EdgeInsets.only(
          top: 10.0.scale(),
          bottom: 10.0.scale(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              couponArrayList.name,
              style: textStyleCustomColor(14.0.scale(), KColorCommonText),
            ),
            ARoundedButton(
              btnBgColor: kColorCommonButtonBackGround,
              btnTextColor: kColorCommonButton,
              btnOnPressed: () {
                Navigator.of(context).pop();
                showHideProgress(true);
                BlocProvider.of<HomeBloc>(context).add(
                    HomeEventCouponListbtnClick(
                        driverDetail.vendorId,
                        strScreen,
                        driverDetail,
                        productListModel,
                        couponArrayList.coupon));
              },
              btnText: "Apply",
              btnHeight: _kHeightBtnAddToCart.scale(),
              btnWidth: _kButtonNextWidth.scale(),
              btnFontSize: kFontSizeBtnLarge.scale(),
              btnElevation: 0,
              btnBorderSideColor: kColorCommonButton,
            ),
          ],
        ).leftPadding(15.0.scale()).rightPadding(15.0.scale()));
  }
}
