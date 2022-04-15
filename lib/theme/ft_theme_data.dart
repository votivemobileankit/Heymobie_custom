import 'package:flutter/material.dart';

class DRThemeData {
  ThemeData get themeData {
    return ThemeData.light().copyWith(
        // primaryColor: kColorPrimary,
        // backgroundColor: kColorBg,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        dividerColor: Color(0xFFE7E7E7),
        textSelectionHandleColor: Colors.transparent);
  }
}
