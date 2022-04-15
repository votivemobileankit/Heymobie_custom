import 'package:flutter/material.dart';

import '../theme/theme.dart';
import '../utils/utils.dart';
import 'a_widget_extensions.dart';

class ARoundedButton extends StatelessWidget {
  final Color btnBgColor;
  final Color btnTextColor;
  final Color btnBorderSideColor;
  final String btnText;
  final double btnFontSize;
  final double btnHeight;
  final double btnWidth;
  final VoidCallback btnOnPressed;
  final IconData btnIconData;
  final Color btnIconColor;
  final double btnIconSize;
  final double btnElevation;
  final FontWeight btnFontWeight;
  final Color btnDisabledColor;
  final Color btnDisabledTextColor;

  const ARoundedButton({
    @required Key key,
    @required this.btnBgColor,
    @required this.btnTextColor,
    @required this.btnText,
    @required this.btnFontSize,
    @required this.btnHeight,
    @required this.btnOnPressed,
    this.btnWidth = double.infinity,
    @required this.btnBorderSideColor,
    @required this.btnIconData,
    @required this.btnIconColor,
    this.btnIconSize = 24,
    this.btnElevation = 2,
    this.btnFontWeight = FontWeight.normal,
    @required this.btnDisabledColor,
    @required this.btnDisabledTextColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBorderRadiusRoundedBtn.scale()),
        side: btnBorderSideColor != null
            ? BorderSide(color: btnBorderSideColor, width: 1.0)
            : BorderSide.none);

    final text = Text(
      this.btnText,
      style: textStyleBoldCustomColor(btnFontSize, btnTextColor),
      // style: TextStyle(
      //     fontSize: btnFontSize,
      //     color: btnTextColor,
      //     fontStyle: FontStyle.normal,
      //     fontWeight: btnFontWeight),
    );

    return (btnIconData != null
            ? ElevatedButton.icon(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  backgroundColor: MaterialStateProperty.all(btnBgColor),
                  shape: MaterialStateProperty.all(shape),
                ),
                onPressed: btnOnPressed,
                label: text,
                icon: Icon(
                  btnIconData,
                  color: btnIconColor,
                  size: btnIconSize,
                ),
              )
            : ElevatedButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled))
                      return btnDisabledColor;
                    return btnBgColor;
                  }),
                  foregroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {}
                    return btnDisabledTextColor;
                  }),
                  shape: MaterialStateProperty.all(shape),
                  elevation: MaterialStateProperty.resolveWith<double>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) return 0;
                    return btnElevation;
                  }),
                ),
                onPressed: btnOnPressed,
                child: text,
              ))
        .size(btnWidth, btnHeight);
  }
}
