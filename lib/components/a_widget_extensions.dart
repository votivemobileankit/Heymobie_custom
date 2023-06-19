import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension WidgetExtensions on Widget {
  Widget align(AlignmentGeometry alignment) {
    return Align(
      alignment: alignment,
      child: this,
    );
  }

  Widget topPadding(double topPadding) {
    return Padding(padding: EdgeInsets.only(top: topPadding), child: this);
  }

  Widget bottomPadding(double bottomPadding) {
    return Padding(
        padding: EdgeInsets.only(bottom: bottomPadding), child: this);
  }

  Widget rightPadding(double rightPadding) {
    return Padding(padding: EdgeInsets.only(right: rightPadding), child: this);
  }

  Widget leftPadding(double leftPadding) {
    return Padding(padding: EdgeInsets.only(left: leftPadding), child: this);
  }

  Widget horPadding(double horPadding) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: horPadding), child: this);
  }

  Widget verPadding(double verPadding) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: verPadding), child: this);
  }

  Widget size(double width, double height) {
    return Container(
      width: width,
      height: height,
      child: this,
    );
  }

  Widget setHeight(double height) {
    return Container(
      height: height,
      child: this,
    );
  }

  Widget width(double width) {
    return Container(
      width: width,
      child: this,
    );
  }

  Widget cornerRadius(double radius) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: this,
    );
  }

  Widget expand() {
    return Expanded(
      child: this,
    );
  }

  Widget lightStatusBarText() {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light),
      child: this,
    );
  }

  Widget darkStatusBarText() {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark),
      child: this,
    );
  }

  Widget pageBgColor(Color bgColor) {
    return Scaffold(
      backgroundColor: bgColor,
      body: this,
    );
  }

  Widget widgetBgColor([Color color = Colors.white]) {
    return Container(
      decoration: BoxDecoration(color: color),
      child: this,
    );
  }

  Widget shadow(
      {required BorderRadius borderRadius,
      required BoxShadow shadow,
      Color bgColor = Colors.transparent}) {
    return Container(
      decoration: BoxDecoration(
          //Here goes the same radius, u can put into a var or function
          borderRadius: borderRadius,
          boxShadow: shadow != null ? [shadow] : [],
          color: bgColor),
      child: this,
    );
  }

  Widget scroll(
      { bool disableBounce = true}) {
    return SingleChildScrollView(
      child: this,

      physics:
          disableBounce ? ClampingScrollPhysics() : BouncingScrollPhysics(),
    );
  }

  Widget flexible() {
    return Flexible(
      child: this,
    );
  }

  Widget applyColor(Color color) {
    return ColorFiltered(
      child: this,
      colorFilter: ColorFilter.mode(color, BlendMode.srcATop),
    );
  }

  Widget circularBorder(
      {required double radius,
      required double borderWidth,
      required Color borderColor,
      required double shadowYOffset,
      required double shadowBlurRadius,
      required Color shadowColor,
      required Color bgColor}) {
    BoxShadow shadow;
    if (shadowColor != null) {
      shadow = BoxShadow(
          color: shadowColor,
          blurRadius: shadowBlurRadius,
          offset: Offset(0, shadowYOffset),
          spreadRadius: shadowYOffset);
    }
    return Container(
        width: radius * 2,
        height: radius * 2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(width: borderWidth, color: borderColor),

            color: bgColor),
        child: this.align(Alignment.center));
  }

  Widget circularBackground({
    required double radius,
    required Color bgColor,
  }) {
    return Container(
        width: radius * 2,
        height: radius * 2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius), color: bgColor),
        child: this);
  }

  Widget circularBackgroundWithInnerShadow(
      {required double radius,
      required Color bgColor,
      required double shadowRadiusOffset,
      required Color shadowColor,
      required double blurRadius}) {
    double shadowRadius = radius - shadowRadiusOffset;
    BoxShadow shadow = BoxShadow(
        color: shadowColor,
        offset: Offset(0, -shadowRadiusOffset),
        blurRadius: blurRadius,
        spreadRadius: -shadowRadiusOffset);

    return this
        .align(Alignment.center)
        .shadow(
            borderRadius: BorderRadius.circular(shadowRadius),
            bgColor: bgColor,
            shadow: shadow)
        .size(shadowRadius * 2, shadowRadius * 2)
        .align(Alignment.center)
        .circularBackground(radius: radius, bgColor: bgColor);
  }

  Widget disableBack() {
    return new WillPopScope(
      onWillPop: () async => false,
      child: this,
    );
  }
}
