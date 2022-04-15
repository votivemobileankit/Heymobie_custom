import 'package:flutter/material.dart';

import '../components/components.dart';
import '../theme/theme.dart';
import '../utils/utils.dart';

const double _kTopLogoAreaHeight = 60.0;
const double _kHeaderTextFontSize = 17.0;

class AHeaderWidget extends StatelessWidget {
  final bool backBtnVisibility;
  final String strBackbuttonName;
  final bool rightEditButtonVisibility;
  final String headerText;
  final String headerSigninText;
  final String strBtnRightImageName;
  final VoidCallback btnEditOnPressed;
  final VoidCallback btnBackOnPressed;

  const AHeaderWidget({
    Key key,
    @required this.backBtnVisibility,
    this.strBackbuttonName = 'ic_red_btn_back.png',
    @required this.strBtnRightImageName,
    this.headerText = "",
    this.headerSigninText = "",
    this.rightEditButtonVisibility = false,
    @required this.btnEditOnPressed,
    @required this.btnBackOnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kColorAppBgColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Image(
                color: Colors.white,
                image:
                    AssetImage('${imgPathGeneral}ic_app_name_logo_white.png'),
                height: 40.0.scale(),
                width: 150.0.scale(),
              ).align(Alignment.center).topPadding(5.0.scale()),
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
                          color: Colors.white,
                          image:
                              AssetImage('${imgPathGeneral}$strBackbuttonName'),
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
                        _kHeaderTextFontSize.scale(), Colors.white),
                    maxLines: null,
                    textAlign: TextAlign.center,
                  ).expand(),
                  Visibility(
                    replacement: SizedBox.fromSize(
                      size: Size(50.0.scale(), 0),
                    ),
                    visible: rightEditButtonVisibility,
                    child: Row(
                      children: [
                        InkWell(
                            onTap: btnEditOnPressed,
                            child: Image(
                                height: 30.0.scale(),
                                width: 30.0.scale(),
                                color: Colors.white,
                                image: AssetImage(
                                  '${imgPathGeneral}$strBtnRightImageName',
                                ))),
                        AHorizontalSpace(2.0.scale()),
                        Text(
                          headerSigninText,
                          style:
                              textStyleCustomColor(12.0.scale(), Colors.white),
                        ),
                      ],
                    ).rightPadding(15.0.scale()),
                  ).align(Alignment.centerRight),
                ],
              ),
            ],
          )
        ],
      )
          .align(Alignment.center)
          .size(double.maxFinite, _kTopLogoAreaHeight.scale())
          .widgetBgColor(KColorAppThemeColor),
    );
  }
}
