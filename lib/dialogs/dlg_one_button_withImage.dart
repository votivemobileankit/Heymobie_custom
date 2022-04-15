import 'package:flutter/material.dart';
import 'package:grambunny_customer/generated/l10n.dart';

import '../components/components.dart';
import '../theme/theme.dart';
import '../utils/utils.dart';

const double _kTitleBottomMargin = 20.0;
const double _kDescBottomMargin = 20.0;
const double _kBtnWidth = 89.0;
const double _kImageIconWidth = 22.0;
const double _kImageIconHeight = 22.0;
const double _kCommonTitlepadding = 40.0;
const double _kBtnBorderShape = 16.0;
const double _kMarginTop1 = 16.0;
const double _kCommonHintTextFieldFontSize = 14.0;

void showSearchScreen({
  @required BuildContext context,
  @required String titleText,
  @required descText,
  @required String btnTitleText,
  @required VoidCallback btnOnPressed,
  bool useMaxInsetPadding = true,
}) {
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
          btnOnPressed: btnOnPressed,
          useMaxInsetPadding: useMaxInsetPadding,
        );
      });
}

void showNoInternetErrorDialog(
    {@required BuildContext context, @required VoidCallback btnOnPressed}) {
  showSearchScreen(
      context: context,
      titleText: Stringss.current.titleTxtAlert,
      descText: "",
      btnTitleText: Stringss.current.btnOk,
      btnOnPressed: btnOnPressed);
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
TextEditingController _textFiledUserName;

Dialog _getOneButtonDialog({
  @required BuildContext context,
  @required String titleText,
  @required descText,
  @required String btnTitleText,
  @required VoidCallback btnOnPressed,
  bool useMaxInsetPadding = true,
}) {
  return Dialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBorderRadiusDialog.scale())),
    elevation: 8,
    insetAnimationDuration: Duration(milliseconds: 30),
    insetPadding: EdgeInsets.all(useMaxInsetPadding
        ? kDialogInsetPaddingMaxWidth.scale()
        : kDialogInsetPadding.scale()),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextField(
          controller: _textFiledUserName,
          keyboardType: TextInputType.emailAddress,
          autofocus: false,
          cursorColor: KColorTextFieldCommonHint,
          decoration: InputDecoration(
            hintText: Stringss.current.txtHintUserName,
            hintStyle: textStyleCustomColor(
                _kCommonHintTextFieldFontSize.scale(),
                KColorTextFieldCommonHint),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
          ),
        )
            .leftPadding(_kCommonTitlepadding.scale())
            .rightPadding(_kCommonTitlepadding.scale()),
        AVerticalSpace(_kTitleBottomMargin.scale()),
        TextField(
          controller: _textFiledUserName,
          keyboardType: TextInputType.emailAddress,
          autofocus: false,
          cursorColor: KColorTextFieldCommonHint,
          decoration: InputDecoration(
            hintText: Stringss.current.txtHintUserName,
            hintStyle: textStyleCustomColor(
                _kCommonHintTextFieldFontSize.scale(),
                KColorTextFieldCommonHint),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
          ),
        )
            .leftPadding(_kCommonTitlepadding.scale())
            .rightPadding(_kCommonTitlepadding.scale()),
        AVerticalSpace(_kDescBottomMargin.scale()),
        TextField(
          controller: _textFiledUserName,
          keyboardType: TextInputType.emailAddress,
          autofocus: false,
          cursorColor: KColorTextFieldCommonHint,
          decoration: InputDecoration(
            hintText: Stringss.current.txtHintUserName,
            hintStyle: textStyleCustomColor(
                _kCommonHintTextFieldFontSize.scale(),
                KColorTextFieldCommonHint),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
          ),
        )
            .leftPadding(_kCommonTitlepadding.scale())
            .rightPadding(_kCommonTitlepadding.scale()),
        AVerticalSpace(_kDescBottomMargin.scale()),
        ARoundedCustomButton(
          btnBorderShape: _kBtnBorderShape.scale(),
          btnBgColor: kColorBtnBgQuinary,
          btnTextColor: kColorTextFieldText,
          btnFontSize: kFontSizeBtnLarge.scale(),
          btnText: btnTitleText,
          btnOnPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            btnOnPressed();
          },
          btnHeight: kHeightBtnNormal.scale(),
          btnWidth: _kBtnWidth.scale(),
          btnElevation: 1,
        ),
      ],
    )
        .horPadding(kDialogHorizontalPadding.scale())
        .verPadding(kDialogVerticalPadding.scale()),
  );
}
