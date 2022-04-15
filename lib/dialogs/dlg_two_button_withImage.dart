import 'package:flutter/material.dart';
import 'package:grambunny_customer/services/herbarium_cust_shared_preferences.dart';

import '../components/components.dart';
import '../theme/theme.dart';
import '../utils/utils.dart';

const double _kTitleBottomMargin = 20.0;
const double _kDescBottomMargin = 20.0;
const double _kBtnWidth = 89.0;
const double _kBtnSettingwidth = 200.0;
const double _kImageIconWidth = 22.0;
const double _kImageIconHeight = 22.0;
const double _kCommonTitlepadding = 40.0;
const double _kBtnBorderShape = 16.0;
const double _kMarginTop1 = 16.0;

void thankYouDialog(
    {@required BuildContext context,
    @required String titleText,
    @required descText,
    @required String btnTitleText,
    @required VoidCallback btnHome,
    @required VoidCallback btnOrderHistory}) {
  showDialog(
      context: context,
      barrierColor: Colors.black26,
      barrierDismissible: false,
      builder: (context) {
        return _getTwoButtonDialog(
            context: context,
            titleText: titleText,
            descText: descText,
            btnTitleText: btnTitleText,
            btnHome: btnHome,
            btnOrderHistory: btnOrderHistory);
      });
}

// void showServerErrorDialog(
//     {@required BuildContext context,
//     @required String errorMsg,
//     @required VoidCallback btnOnPressed}) {
//   showAgeDialog(
//       context: context,
//       titleText: Stringss.current.titleTxtAlert,
//       descText: errorMsg,
//       btnTitleText: Stringss.current.btnOk,
//       btnOnPressed: btnOnPressed);
// }
//
// void showCameraPermissionDeniedDialog({@required BuildContext context}) {
//   showOneButtonDialog(
//       context: context,
//       titleText: Strings.current.lblDeniedPermissionDlg,
//       descText: Strings.current.descDeniedCameraPermissionDlg,
//       btnTitleText: Strings.current.btnAppSettings,
//       btnOnPressed: () {
//         openAppSettings();
//       });
// }
//
// void showGalleryPermissionDeniedDialog({@required BuildContext context}) {
//   showOneButtonDialog(
//       context: context,
//       titleText: Strings.current.lblDeniedPermissionDlg,
//       descText: Strings.current.descDeniedGalleryPermissionDlg,
//       btnTitleText: Strings.current.btnAppSettings,
//       btnOnPressed: () {
//         openAppSettings();
//       });
// }
//
// void showLocationPermissionDeniedDialog({@required BuildContext context}) {
//   showOneButtonDialog(
//       context: context,
//       titleText: Strings.current.lblDeniedPermissionDlg,
//       descText: Strings.current.descDeniedLocationPermissionDlg,
//       btnTitleText: Strings.current.btnAppSettings,
//       btnOnPressed: () {
//         openAppSettings();
//       });
// }

Dialog _getTwoButtonDialog(
    {@required BuildContext context,
    @required String titleText,
    @required descText,
    @required String btnTitleText,
    @required VoidCallback btnHome,
    @required VoidCallback btnOrderHistory}) {
  return Dialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBorderRadiusDialog.scale())),
    elevation: 8,
    insetAnimationDuration: Duration(milliseconds: 30),
    insetPadding: EdgeInsets.all(kDialogInsetPadding.scale()),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AVerticalSpace(_kMarginTop1.scale()),
        Text(
          "Thank You for your order",
          style: textStyleBoldCustomColor(18.0.scale(), KColorCommonText),
          textAlign: TextAlign.center,
        )
            .leftPadding(_kCommonTitlepadding.scale())
            .rightPadding(_kCommonTitlepadding.scale()),
        AVerticalSpace(_kTitleBottomMargin.scale()),
        Text(
          sharedPrefs.getUserName,
          style: textStyleBoldCustomColor(16.0.scale(), KColorCommonText),
          textAlign: TextAlign.center,
        )
            .leftPadding(_kCommonTitlepadding.scale())
            .rightPadding(_kCommonTitlepadding.scale()),
        AVerticalSpace(10.0.scale()),
        Image(
          image: AssetImage('${imgPathGeneral}ic_succes_icon.png'),
        ).align(Alignment.center),
        AVerticalSpace(_kTitleBottomMargin.scale()),
        Text(
          "The order confirmation and email with detail of your order and a link to track its progress has been sent to your email address",
          style: textStyleCustomColor(14.0.scale(), KColorCommonText),
          textAlign: TextAlign.center,
        ).horPadding(kDialogDescHorPadding.scale()),
        AVerticalSpace(_kDescBottomMargin.scale()),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ARoundedCustomButton(
            //   btnBorderShape: _kBtnBorderShape.scale(),
            //   btnBgColor: kColorBtnBgQuinary,
            //   btnTextColor: kColorTextFieldText,
            //   btnFontSize: kFontSizeBtnLarge.scale(),
            //   btnText: "Back to Home",
            //   btnOnPressed: () {
            //     btnHome();
            //     Navigator.of(context, rootNavigator: true).pop();
            //   },
            //   btnHeight: kHeightBtnNormal.scale(),
            //   btnWidth: _kBtnSettingwidth.scale(),
            //   btnElevation: 1,
            // ),
            ARoundedCustomButton(
              btnBorderShape: _kBtnBorderShape.scale(),
              btnBgColor: kColorCommonButtonBackGround,
              btnTextColor: kColorAppBgColor,
              btnFontSize: kFontSizeBtnLarge.scale(),
              btnText: "View Order History",
              btnOnPressed: () {
                btnOrderHistory();
                Navigator.of(context, rootNavigator: true).pop();
              },
              btnHeight: kHeightBtnNormal.scale(),
              btnWidth: _kBtnSettingwidth.scale(),
              btnElevation: 1,
            ).align(Alignment.center),
          ],
        )
      ],
    )
        .horPadding(kDialogHorizontalPadding.scale())
        .verPadding(kDialogVerticalPadding.scale()),
  );
}
