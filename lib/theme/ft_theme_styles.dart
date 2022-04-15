import 'package:flutter/material.dart';

import '../utils/utils.dart';
import 'ft_theme_colors.dart';
import 'ft_theme_size_const.dart';

TextStyle _dialogTitleTextStyle() {
  return TextStyle(
      fontSize: 16,
      color: Colors.black,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      fontFamily: "Quicksand",
      decoration: TextDecoration.none);
}

TextStyle _dialogDescTextStyle() {
  return TextStyle(
      fontSize: 14,
      color: KColorTextGrey,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      fontFamily: "Quicksand",
      decoration: TextDecoration.none);
}

TextStyle _dialogDescDeleteTextStyle() {
  return TextStyle(
      fontSize: 14,
      color: KColorTextGrey,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      fontFamily: "Quicksand",
      decoration: TextDecoration.none);
}

TextStyle textStyleDialogTitle() {
  return _dialogTitleTextStyle();
}

TextStyle textStyleDialogDesc() {
  return _dialogDescTextStyle();
}

TextStyle textStyleRedDialogDesc() {
  return _dialogDescDeleteTextStyle();
}

TextStyle textStyleHeadlineLogin(double fontsize) {
  return _headlineTextSplashStyle(fontsize);
}

TextStyle textStyleHeadline1Login(double fontsize) {
  return _headlineTextSplashStyle1(fontsize);
}

TextStyle textStyleBlack(double fontsize) {
  return _TextStyleBlack(fontsize);
}

TextStyle textStyleCustomColor(double fontsize, Color color) {
  return _TextStyleCustomColor(fontsize, color);
}

TextStyle textStyleBoldCustomColor(double fontsize, Color color) {
  return _TextStyleSemiBoldCustomColor(fontsize, color);
}

TextStyle textStyleBoldCustomLargeColor(double fontsize, Color color) {
  return _TextStyleBoldCustomLargeTextColor(fontsize, color);
}

TextStyle textStyleSmall() {
  return _smallTextStyle();
}

TextStyle textStyleSmallBlack() {
  return _smallTextStyleBlack();
}

TextStyle textStyleBoldBlack(double fontsize) {
  return _textStyleBoldBlack(fontsize);
}

TextStyle textBodyStyleSmallGrey(double font) {
  return _smallTextGreyStyle(font);
}

TextStyle _headlineTextSplashStyle(double fontsize) {
  return TextStyle(
      fontSize: fontsize,
      color: Colors.white,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
      fontFamily: "Quicksand",
      decoration: TextDecoration.none);
}

TextStyle _headlineTextSplashStyle1(double fontsize) {
  return TextStyle(
      fontSize: fontsize,
      color: Colors.white,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontFamily: "Quicksand",
      decoration: TextDecoration.none);
}

TextStyle _smallTextStyle() {
  return TextStyle(
      fontSize: 14,
      color: Colors.white,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontFamily: "Quicksand",
      decoration: TextDecoration.none);
}

TextStyle _smallTextStyleBlack() {
  return TextStyle(
      fontSize: 14,
      color: Colors.black,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontFamily: "Quicksand",
      decoration: TextDecoration.none);
}

TextStyle _TextStyleBlack(double fontsize) {
  return TextStyle(
      fontSize: fontsize,
      color: Colors.black,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontFamily: "Quicksand",
      decoration: TextDecoration.none);
}

TextStyle _TextStyleCustomColor(double fontsize, Color colors) {
  return TextStyle(
      fontSize: fontsize,
      color: colors,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontFamily: "Quicksand",
      decoration: TextDecoration.none);
}

TextStyle _TextStyleSemiBoldCustomColor(double fontsize, Color colors) {
  return TextStyle(
      fontSize: fontsize,
      color: colors,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
      fontFamily: "Quicksand",
      decoration: TextDecoration.none);
}

TextStyle _TextStyleBoldCustomLargeTextColor(double fontsize, Color colors) {
  return TextStyle(
      fontSize: fontsize,
      color: colors,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
      fontFamily: "Inter",
      decoration: TextDecoration.none);
}

TextStyle _textStyleBoldBlack(fontsize) {
  return TextStyle(
      fontSize: fontsize,
      color: Colors.black,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
      fontFamily: "Quicksand",
      decoration: TextDecoration.none);
}

TextStyle _smallTextGreyStyle(font) {
  return TextStyle(
      fontSize: font,
      color: KColorTextGrey,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontFamily: "Quicksand",
      decoration: TextDecoration.none);
}

TextStyle textStyleEditProfileBioTextFieldText() {
  return TextStyle(
      fontSize: kFontSizeEditProfileBioTextField.scale(),
      color: KColorTextGrey,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontFamily: "Quicksand",
      decoration: TextDecoration.none);
}

TextStyle textStyleEditProfileBioTextFieldHintText() {
  return TextStyle(
      fontSize: kFontSizeEditProfileBioTextField.scale(),
      color: KColorTextGrey,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontFamily: "Quicksand",
      decoration: TextDecoration.none);
}
