import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:grambunny_customer/components/components.dart';
import 'package:grambunny_customer/theme/theme.dart';


import '../utils/utils.dart';
import 'a_widget_extensions.dart';

const double _kWidgetHeight = 45.0;
const double _kBorderSize = 1.0;
const double _kStatPadding = 10.0;
const double _kEndPadding = 10.0;
const double _kTextFieldHorPadding = 4.0;
const double _kButtonDimension = 40.0;
const double _kTextFieldBottomPadding = 2.0;
const double _kCloseButtonBottomPadding = 2.0;
const kBorderRadiusSearchBar = 40.0;
const double _kShadowBlurRadius = 1.0;
const double _kShadowYOffset = 4.0;
const double _kTextCommonFontSize = 14;
const double _kWidthHeightGoButton = 28.0;
const double _kWidthHeightSearchButton = 20.0;
const double _kVerticalSepratorHeight = 21.0;
const double _kRightPaddingAfterGoButton = 32.0;
const double _kWidthSearchCityBox = 328.0;
const double _kHeightSearchCityBox = 54.0;

class ASearchBarWidget extends StatefulWidget {
  final Color borderColor;
  final Color bgColor;
  final String hintStr;
  final Color cursorColor;
  final TextStyle textStyle;
  final TextStyle hintStyle;
  final Function() onSearch;
  final Function(String) onTextChange;
  final Function() onBack;

  const ASearchBarWidget({
    required Key key,
    required this.borderColor,
    required this.bgColor,
    required this.cursorColor,
   required this.hintStr,
    required this.textStyle,
    required this.hintStyle,
    required this.onSearch,
    required this.onTextChange,
    required this.onBack,
  }) : super(key: key);

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<ASearchBarWidget> {
  final mTextController = new TextEditingController();

  @override
  void initState() {
    mTextController.addListener(_searchValueOnChange);

    super.initState();
  }

  _searchValueOnChange() {
    widget.onTextChange(mTextController.text);
  }

  @override
  void dispose() {
    mTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: kColorSearchBoxBorder, spreadRadius: 0.5),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Image(
                  image: AssetImage(
                      '${imgPathGeneral}ic_find_a_clinic_search_icon.png'),
                  width: _kWidthHeightSearchButton.scale(),
                  height: _kWidthHeightSearchButton.scale(),
                )
                    .align(Alignment.center)
                    .width(_kButtonDimension.scale())
                    .setHeight(_kButtonDimension.scale()),
                AHorizontalSpace(_kTextFieldHorPadding.scale()),
                TextField(
                  controller: mTextController,
                  maxLines: 1,
                  style: widget.textStyle == null
                      ? textStyleCustomColor(
                          _kTextCommonFontSize, kColorSearchFieldText)
                      : null,
                  cursorColor:
                      widget.cursorColor == null ? kColorSearchFieldText : null,
                  textAlignVertical: TextAlignVertical.top,
                  enableInteractiveSelection: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.hintStr == null ? "" : "",
                    hintStyle: textStyleCustomColor(
                        _kTextCommonFontSize, kColorSearchHintText),
                  ),
                )
                    .align(Alignment.center)
                    .horPadding(_kTextFieldHorPadding.scale())
                    .bottomPadding(_kTextFieldBottomPadding.scale())
                    .expand(),
                AHorizontalSpace(_kTextFieldHorPadding.scale()),
                // AVerticalSeparatorLine(
                //   width: 1,
                //   height: _kVerticalSepratorHeight.scale(),
                //   color: kColorSearchBoxBorder,
                // ).align(Alignment.centerRight),
              ],
            )
                .size(
                    _kWidthSearchCityBox.scale(), _kHeightSearchCityBox.scale())
                .leftPadding(_kStatPadding.scale())
                .rightPadding(_kEndPadding.scale()))
        .widgetBgColor(Colors.transparent);
  }
}
