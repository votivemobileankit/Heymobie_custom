import 'dart:io';

import 'package:flutter/material.dart';

Widget getPageTransition(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  var begin = Platform.isIOS ? Offset(1.0, 0.0) : Offset(0.0, 1.0);
  var end = Offset.zero;
  var curve = Curves.ease;

  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

  return SlideTransition(
    position: animation.drive(tween),
    child: child,
  );
}
