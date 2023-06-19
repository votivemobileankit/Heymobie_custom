import 'package:flutter/material.dart';

import '../utils/utils.dart';
import 'a_widget_extensions.dart';

class ARoundedCustomButton extends StatelessWidget {
  final Color btnBgColor;
  final Color btnTextColor;
  final Color btnBorderSideColor;
  final String btnText;
  final double btnFontSize;
  final double btnHeight;
  final double btnWidth;
  final VoidCallback btnOnPressed;


  final double btnIconSize;
  final double btnElevation;
  final double btnBorderShape;
  final FontWeight btnFontWeight;
  final Color btnDisabledColor;
  final Color btnDisabledTextColor;

  const ARoundedCustomButton({

   required this.btnBgColor,
    required this.btnTextColor,
    required this.btnText,
   required this.btnFontSize,
    required this.btnHeight,
    required this.btnOnPressed,
    this.btnWidth = double.infinity,
   required this.btnBorderSideColor,

    this.btnIconSize = 24,
    this.btnElevation = 2,
    required this.btnBorderShape,
    this.btnFontWeight = FontWeight.normal,
    required this.btnDisabledColor,
    required this.btnDisabledTextColor
  }) ;

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(btnBorderShape.scale()),
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

    return ( ElevatedButton(
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
                    if (states.contains(MaterialState.disabled)) return 0;
                    return btnElevation;
                  }),
                ),
              ))
        .size(btnWidth, btnHeight);
  }
}
