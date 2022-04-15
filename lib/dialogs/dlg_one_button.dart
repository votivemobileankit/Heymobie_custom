import 'package:flutter/material.dart';

import '../components/components.dart';
import '../theme/theme.dart';
import '../utils/utils.dart';

const double _kTitleBottomMargin = 10.0;
const double _kDescBottomMargin = 20.0;
const double _kBtnWidth = 100.0;
const double _kImageIconWidth = 22.0;
const double _kImageIconHeight = 22.0;

void showAgeDialog(
    {@required BuildContext context,
    @required String titleText,
    @required descText,
    @required String btnTitleText,
    @required VoidCallback btnNoPressed}) {
  showDialog(
    context: context,
    barrierColor: Colors.black26,
    barrierDismissible: false,
    builder: (context) {
      return _getOneButtonDialog(
          context: context,
          titleText: titleText,
          descText: descText,
          btnTitleText: btnTitleText,
          btnNoPressed: btnNoPressed);
    },
  );
}

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

Dialog _getOneButtonDialog(
    {@required BuildContext context,
    @required String titleText,
    @required descText,
    @required String btnTitleText,
    @required VoidCallback btnYesPressed,
    @required VoidCallback btnNoPressed}) {
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
        Stack(
          children: [
            Image(
              image: AssetImage(
                  '${imgPathGeneral}ic_profile_bg_vaccin_history_circle.png'),
              height: _kImageIconWidth.scale(),
              width: _kImageIconHeight.scale(),
            ),
            Image(
              image:
                  AssetImage('${imgPathGeneral}ic_pushnotification_alert.png'),
              height: _kImageIconWidth.scale(),
              width: _kImageIconHeight.scale(),
            ),
          ],
        ),
        AVerticalSpace(_kTitleBottomMargin.scale()),
        Text(
          titleText,
          style: textStyleDialogTitle(),
          textAlign: TextAlign.center,
        ),
        AVerticalSpace(_kTitleBottomMargin.scale()),
        Text(
          descText,
          style: textStyleDialogDesc(),
          textAlign: TextAlign.center,
        ).horPadding(kDialogDescHorPadding.scale()),
        AVerticalSpace(_kDescBottomMargin.scale()),
        Row(
          children: [
            ARoundedButton(
              btnBgColor: kColorBtnBgQuinary,
              btnTextColor: kColorTextFieldText,
              btnFontSize: kFontSizeBtnLarge.scale(),
              btnText: "Yes, i am",
              btnOnPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
                btnNoPressed();
              },
              btnHeight: kHeightBtnNormal.scale(),
              btnWidth: _kBtnWidth.scale(),
              btnElevation: 4,
            ),
            ARoundedButton(
              btnBgColor: kColorBtnBgQuinary,
              btnTextColor: kColorTextFieldText,
              btnFontSize: kFontSizeBtnLarge.scale(),
              btnText: "No",
              btnOnPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
                btnNoPressed();
              },
              btnHeight: kHeightBtnNormal.scale(),
              btnWidth: _kBtnWidth.scale(),
              btnElevation: 4,
            )
          ],
        )
      ],
    )
        .horPadding(kDialogHorizontalPadding.scale())
        .verPadding(kDialogVerticalPadding.scale()),
  );
}
