import 'package:flutter/material.dart';

import '../components/components.dart';
import '../theme/theme.dart';
import '../utils/utils.dart';

const double _kTopLogoAreaHeight = 60.0;
const double _kHeaderTextFontSize = 17.0;

class AHeaderSearchWidget extends StatelessWidget {
  final bool backBtnVisibility;
  final String strBackbuttonName;
  final bool rightEditButtonVisibility;
  final String headerText;
  final String strBtnRightImageName;
  final VoidCallback btnSearchOnPressed;
  final VoidCallback btnFilterOnPressed;
  final VoidCallback btnBackOnPressed;

  const AHeaderSearchWidget({

    required this.backBtnVisibility,
    this.strBackbuttonName = 'ic_red_btn_back.png',
    required this.strBtnRightImageName,
    this.headerText = "",
    this.rightEditButtonVisibility = false,
    required this.btnSearchOnPressed,
    required this.btnFilterOnPressed,
    required this.btnBackOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kColorAppBgColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Visibility(
                  replacement: SizedBox.fromSize(
                    size: Size(40.0.scale(), 0),
                  ),
                  visible: backBtnVisibility,
                  child: TextButton(
                    onPressed: btnBackOnPressed,
                    child: Image(
                      image: AssetImage('${imgPathGeneral}$strBackbuttonName'),
                      height: 40,
                    ),
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                  )).align(Alignment.centerLeft).expand(),
              Text(
                headerText,
                style: textStyleBoldCustomColor(
                    _kHeaderTextFontSize.scale(), Colors.black),
                maxLines: null,
                textAlign: TextAlign.center,
              ).expand(),
              Visibility(
                replacement: SizedBox.fromSize(
                  size: Size(40.0.scale(), 0),
                ),
                visible: rightEditButtonVisibility,
                child: TextButton(
                    onPressed: btnSearchOnPressed,
                    child: Image(
                      image:
                          AssetImage('${imgPathGeneral}$strBtnRightImageName'),
                    )),
              ).align(Alignment.centerRight),
              TextButton(
                  onPressed: btnSearchOnPressed,
                  child: Image(
                    image: AssetImage('${imgPathGeneral}$strBtnRightImageName'),
                  ))
            ],
          ),
        ],
      )
          .align(Alignment.center)
          .size(double.maxFinite, _kTopLogoAreaHeight.scale())
          .widgetBgColor(kColorScreenBgColor),
    );
  }
}
