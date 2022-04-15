import 'package:flutter/material.dart';

class AHorizontalSpace extends StatelessWidget{
  final double space;

  const AHorizontalSpace( this.space) ;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: space);
  }
}