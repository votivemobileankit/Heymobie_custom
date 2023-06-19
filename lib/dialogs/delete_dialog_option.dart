import 'package:flutter/material.dart';
import 'package:grambunny_customer/components/components.dart';
import 'package:grambunny_customer/generated/l10n.dart';
import 'package:grambunny_customer/theme/theme.dart';
import 'package:grambunny_customer/utils/ui_utils.dart';
import 'package:grambunny_customer/utils/utils.dart';

const double _kTitleBottomMargin = 20.0;
const double _kDescBottomMargin = 20.0;
const double _kBtnWidth = 89.0;
const double _kImageIconWidth = 30.0;
const double _kImageIconHeight = 30.0;
const double _kCommonTitlepadding = 40.0;
const double _kBtnBorderShape = 8.0;
const double _kMarginTop1 = 16.0;

void showDeleteDialog({
  required BuildContext context,
 required VoidCallback btnyesPressed,
  required VoidCallback btnClosePressed,
  required String titleTxt,
  required String descripTxt,
}) {
  showDialog(
      context: context,
      barrierColor: Colors.black26,
      barrierDismissible: false,
      builder: (context) {
        return _getDailogAbort(
            context: context,
            titleText: titleTxt,
            descText: descripTxt,
            btn1TitleText: Stringss.current.btnYes,
            btn2TitleText: Stringss.current.btnClose,
            btnYesPressed: btnyesPressed,
            btnClosePressed: btnClosePressed);
      });
}

Dialog _getDailogAbort({
  required BuildContext context,
  required String titleText,
  required String descText,
  required String btn2TitleText,
  required String btn1TitleText,
  required VoidCallback btnYesPressed,
  required VoidCallback btnClosePressed,
}) {
  return Dialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBorderRadiusDialog.scale())),
    elevation: 8.0.scale(),
    insetPadding: EdgeInsets.fromLTRB(
        kDialogInsetPadding.scale(), 0, kDialogInsetPadding.scale(), 0),
    insetAnimationDuration: Duration(milliseconds: 30),
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
        AVerticalSpace(_kMarginTop1.scale()),
        Text(
          titleText,
          style: textStyleDialogTitle(),
          textAlign: TextAlign.center,
        )
            .leftPadding(_kCommonTitlepadding.scale())
            .rightPadding(_kCommonTitlepadding.scale()),
        AVerticalSpace(_kTitleBottomMargin.scale()),
        Text(
          descText,
          style: textStyleDialogDesc(),
          textAlign: TextAlign.center,
        ).horPadding(kDialogDescHorPadding.scale()),
        AVerticalSpace(_kDescBottomMargin.scale()),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ARoundedCustomButton(

              btnBorderSideColor: kColorCommonButton,btnDisabledColor: Color(0xFF5e6163),btnIconSize:15 ,
              btnDisabledTextColor:Color(0xFFFFFFFF) ,
              btnFontWeight: FontWeight.normal,

              btnBorderShape: _kBtnBorderShape.scale(),
              btnBgColor: kColorBtnBgQuinary,
              btnTextColor: kColorTextFieldText,
              btnFontSize: kFontSizeBtnLarge.scale(),
              btnText: btn2TitleText,
              btnOnPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
                //btnClosePressed();
              },
              btnHeight: kHeightBtnNormal.scale(),
              btnWidth: _kBtnWidth.scale(),
              btnElevation: 0,
            ),
            ARoundedCustomButton(

              btnBorderSideColor: kColorCommonButton,btnDisabledColor: Color(0xFF5e6163),btnIconSize:15 ,
              btnDisabledTextColor:Color(0xFFFFFFFF) ,
              btnFontWeight: FontWeight.normal,
              btnBorderShape: _kBtnBorderShape.scale(),
              btnBgColor: kColorBtnBgQuinary,
              btnTextColor: Colors.white,
              btnFontSize: kFontSizeBtnLarge.scale(),
              btnText: btn1TitleText,
              btnOnPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
                btnYesPressed();
              },
              btnHeight: kHeightBtnNormal.scale(),
              btnWidth: _kBtnWidth.scale(),
              btnElevation: 1,
            ),
          ],
        )
      ],
    )
        .horPadding(kDialogHorizontalPadding.scale())
        .verPadding(kDialogVerticalPadding.scale()),
  );
}
