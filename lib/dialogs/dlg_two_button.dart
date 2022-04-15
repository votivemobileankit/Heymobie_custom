import 'package:flutter/material.dart';
import 'package:grambunny_customer/generated/l10n.dart';

import '../components/components.dart';
import '../theme/theme.dart';
import '../utils/utils.dart';

const double _kTitleBottomMargin = 20.0;
const double _kDescBottomMargin = 20.0;
const double _kBtnWidth = 135.0;
const double _kSpaceBetweenButtons = 20;

void showFbPhotoPermissionErrorDialog({
  @required BuildContext context,
  @required VoidCallback btn1OnPressed,
  @required VoidCallback btn2OnPressed,
}) {
  showTwoButtonDialog(
      context: context,
      titleText: Stringss.current.titleTxtAlert,
      descText: "",
      btn1TitleText: "",
      btn1OnPressed: btn1OnPressed,
      btn2TitleText: "",
      btn2OnPressed: btn2OnPressed);
}

void showTwoButtonDialog({
  @required BuildContext context,
  @required String titleText,
  @required descText,
  @required String btn1TitleText,
  @required VoidCallback btn1OnPressed,
  @required String btn2TitleText,
  @required VoidCallback btn2OnPressed,
}) {
  showDialog(
    context: context,
    barrierColor: Colors.black26,
    barrierDismissible: false,
    builder: (context) {
      return _getTwoButtonDialog(
        context: context,
        titleText: titleText,
        descText: descText,
        btn1TitleText: btn1TitleText,
        btn1OnPressed: btn1OnPressed,
        btn2TitleText: btn2TitleText,
        btn2OnPressed: btn2OnPressed,
      );
    },
  );
}

Dialog _getTwoButtonDialog(
    {@required BuildContext context,
    @required String titleText,
    @required descText,
    @required String btn1TitleText,
    @required VoidCallback btn1OnPressed,
    @required String btn2TitleText,
    @required VoidCallback btn2OnPressed}) {
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
        Column(
          children: [
            ARoundedButton(
              btnBgColor: kColorBtnBgQuinary,
              btnTextColor: kColorTextFieldText,
              btnFontSize: kFontSizeBtnLarge.scale(),
              btnText: btn1TitleText,
              btnOnPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
                btn1OnPressed();
              },
              btnHeight: kHeightBtnSmall.scale(),
              btnWidth: _kBtnWidth.scale(),
              btnElevation: 4,
            ),
            AVerticalSpace(_kSpaceBetweenButtons.scale()),
            ARoundedButton(
              btnBgColor: kColorBtnBgQuinary,
              btnTextColor: kColorTextFieldText,
              btnFontSize: kFontSizeBtnLarge.scale(),
              btnText: btn2TitleText,
              btnOnPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
                btn2OnPressed();
              },
              btnHeight: kHeightBtnSmall.scale(),
              btnWidth: _kBtnWidth.scale(),
              btnElevation: 4,
            )
          ],
        ),
      ],
    )
        .horPadding(kDialogHorizontalPadding.scale())
        .verPadding(kDialogVerticalPadding.scale()),
  );
}
