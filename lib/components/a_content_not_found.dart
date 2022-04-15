import 'package:flutter/material.dart';
import 'package:grambunny_customer/theme/theme.dart';

import '../utils/utils.dart';
import 'components.dart';

const double _kVerticalSpaceAfterChildrenSavedFontSize = 10.0;
const double _kCommonSizeDataNotFoundIcon = 100.0;
const double _kTextChildrenSavedFontSize = 20.0;
const double _kTextChildrenSavedContentFontSize = 14.0;
const double _kVerticalSpaceChildrenSavedFontSize = 14.0;

class AContentNotFoundWidget extends StatelessWidget {
  final String imagePath;
  final bool Isvisible;
  final String title;
  final String message;

  const AContentNotFoundWidget(
      {Key key,
      @required this.imagePath,
      this.Isvisible = false,
      this.title = "",
      this.message = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Visibility(
        visible: Isvisible,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Stack(
                  children: [
                    Image(
                      image: AssetImage(
                          '${imgPathGeneral}assets/images/general/ic_not_found_icon.png'),
                      width: _kCommonSizeDataNotFoundIcon.scale(),
                      height: _kCommonSizeDataNotFoundIcon.scale(),
                    ).align(Alignment.center),
                    Image(
                      image: AssetImage('${imgPathGeneral}' + imagePath),
                      width: _kCommonSizeDataNotFoundIcon.scale(),
                      height: _kCommonSizeDataNotFoundIcon.scale(),
                    ).align(Alignment.center),
                  ],
                ),
                AVerticalSpace(_kVerticalSpaceChildrenSavedFontSize.scale()),
                Text(
                  title,
                  style: textStyleBoldCustomColor(
                      _kTextChildrenSavedFontSize.scale(), Colors.white),
                  textAlign: TextAlign.center,
                ).align(Alignment.center),
                AVerticalSpace(
                    _kVerticalSpaceAfterChildrenSavedFontSize.scale()),
                Text(
                  message,
                  style: textStyleCustomColor(
                      _kTextChildrenSavedContentFontSize.scale(),
                      kColorTextContentChildSaved),
                  textAlign: TextAlign.center,
                ).align(Alignment.center)
              ],
            ).bottomPadding(30.0.scale())
          ],
        ));
  }
}
