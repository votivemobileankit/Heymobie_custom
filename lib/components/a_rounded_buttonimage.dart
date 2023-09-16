import 'package:flutter/material.dart';

import '../theme/theme.dart';
import '../utils/utils.dart';
import 'a_widget_extensions.dart';

class ARoundedButtonImage extends StatelessWidget {
  final Color btnBgColor;
  final Color btnTextColor;
  final Color btnBorderSideColor;
  final String btnText;
  final double btnFontSize;
  final double btnHeight;
  final double btnWidth;
  final VoidCallback btnOnPressed;
  final ImageIcon btnIconData;
  final Color btnIconColor;
  final double btnIconSize;
  final double btnElevation;
  final FontWeight btnFontWeight;
  final Color btnDisabledColor;
  final Color btnDisabledTextColor;
  final String btnIconImagePath;

  ARoundedButtonImage({
    required this.btnBgColor,
    required this.btnTextColor,
    required this.btnText,
    required this.btnFontSize,
    required this.btnHeight,
    required this.btnOnPressed,
    this.btnWidth = double.infinity,
    required this.btnBorderSideColor,
    required this.btnIconData,
    required this.btnIconImagePath,
    this.btnIconColor = Colors.black26,
    this.btnIconSize = 24,
    this.btnElevation = 2,
    this.btnFontWeight = FontWeight.normal,
    required this.btnDisabledColor,
    required this.btnDisabledTextColor,
  });

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBorderRadiusRoundedBtn.scale()),
        side: btnBorderSideColor != null
            ? BorderSide(color: btnBorderSideColor, width: 1.0)
            : BorderSide.none);

    final text = Text(
      this.btnText,
      style: TextStyle(
          fontSize: btnFontSize,
          color: btnTextColor,
          fontStyle: FontStyle.normal,
          fontWeight: btnFontWeight),
    );

    final column = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                this.btnText,
                style: TextStyle(
                  fontSize: btnFontSize,
                  fontFamily: "Inter-Regular", // 18pt in font.
                  color: Colors.white,
                  // You can ommit it if you use textColor in RaisedButton.
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Image(
                image: AssetImage(btnIconImagePath),
                // White Color. You can ommit it too if you use textColor property on RaisedButton.
                width: 20,
                height: 20, // 18 pt, same as text.
              ),
            )
          ],
        ),
      ],
    );

    return (btnIconData != null
            ? ElevatedButton(
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
                child: column,
              )
            : ElevatedButton(
                onPressed: btnOnPressed,
                child: text,
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
                    if (states.contains(MaterialState.disabled)) {}
                    return btnElevation;
                  }),
                ),
              ))
        .size(btnWidth, btnHeight);
  }
}
