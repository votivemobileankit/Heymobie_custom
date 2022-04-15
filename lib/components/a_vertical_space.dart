import 'package:flutter/material.dart';

class AVerticalSpace extends StatelessWidget {
  final double space;

  const AVerticalSpace(this.space);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: space);
  }
}
