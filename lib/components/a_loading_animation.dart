import 'package:flutter/material.dart';

import 'a_widget_extensions.dart';

class ALoadingAnimation extends StatelessWidget {
  final bool useLighterBlackOverlay;

  const ALoadingAnimation({ this.useLighterBlackOverlay = false});
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
    )
        .align(Alignment.center)
        .size(double.infinity, double.infinity)
        .widgetBgColor(
            useLighterBlackOverlay ? Colors.black12 : Colors.black45);
  }
}
