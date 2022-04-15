import 'package:flutter/material.dart';

class AVerticalSeparatorLine extends StatelessWidget {
  final double width;
  final Color color;
  final double height;

  const AVerticalSeparatorLine(
      {Key key,
      @required this.width,
      @required this.height,
      @required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: color,
    );
  }
}
