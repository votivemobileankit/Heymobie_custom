import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:grambunny_customer/components/components.dart';
import 'package:grambunny_customer/theme/theme.dart';

import '../utils/utils.dart';
import 'a_widget_extensions.dart';

const double _kStatPadding = 10.0;
const double _kEndPadding = 10.0;
const double _kTextFieldHorPadding = 4.0;
const double _kButtonDimension = 40.0;
const double _kTextFieldBottomPadding = 6.0;
const kBorderRadiusSearchBar = 40.0;
const double _kTextCommonFontSize = 14;
const double _kWidthHeightSearchButton = 20.0;
const double _kWidthSearchCityBox = 328.0;
const double _kHeightSearchCityBox = 44.0;

class CustomSearchBar extends StatefulWidget {
  final Color borderColor;
  final Color bgColor;
  final String hintStr;
  final Color cursorColor;
  final TextStyle textStyle;
  final TextStyle hintStyle;
  final Function() onSearch;
  final Function(String) onTextChange;
  final Function() onBack;
  final TextEditingController searchTextController;

  const CustomSearchBar({

    required this.borderColor,
    required this.bgColor,
    required this.cursorColor,
    required this.hintStr,
    required this.textStyle,
    required this.hintStyle,
    required this.onSearch,
    required this.searchTextController,
    required this.onTextChange,
    required this.onBack,
  });

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  void initState() {
    widget.searchTextController.addListener(_searchValueOnChange);

    super.initState();
  }

  _searchValueOnChange() {
    widget.onTextChange(widget.searchTextController.text);
  }

  @override
  void dispose() {
    widget.searchTextController.removeListener(_searchValueOnChange);
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
                  image: AssetImage('${imgPathGeneral}ic_search_logo.png'),
                  width: _kWidthHeightSearchButton.scale(),
                  height: _kWidthHeightSearchButton.scale(),
                )
                    .align(Alignment.center)
                    .width(_kButtonDimension.scale())
                    .setHeight(_kButtonDimension.scale()),
                AHorizontalSpace(_kTextFieldHorPadding.scale()),
                FocusScope(
                        onFocusChange: (focus) => print("focus: $focus"),
                        child: Focus(
                            child: TextField(
                          controller: widget.searchTextController,
                          maxLines: 1,
                          style: widget.textStyle ??
                              textStyleCustomColor(_kTextCommonFontSize.scale(),
                                  kColorSearchFieldText),
                          cursorColor:
                              widget.cursorColor ?? kColorSearchFieldText,
                          textAlignVertical: TextAlignVertical.top,
                          enableInteractiveSelection: false,
                          autocorrect: false,
                          enableSuggestions: false,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: widget.hintStr ?? "",
                            hintStyle: widget.hintStyle ??
                                textStyleCustomColor(
                                        _kTextCommonFontSize.scale(),
                                        kColorSearchHintText)
                                    .copyWith(fontStyle: FontStyle.italic),
                          ),
                        )))
                    .align(Alignment.center)
                    .horPadding(_kTextFieldHorPadding.scale())
                    .bottomPadding(_kTextFieldBottomPadding.scale())
                    .expand(),
                // AHorizontalSpace(_kTextFieldHorPadding.scale()),
                // AVerticalSeparatorLine(
                //   width: 1,
                //   height: _kVerticalSepratorHeight.scale(),
                //   color: kColorSearchBoxBorder,
                // ).align(Alignment.centerRight),
                // TextButton(
                //   onPressed: widget.onSearch,
                //   child: Image(
                //     image: AssetImage(
                //         '${imgPathGeneral}ic_find_a_clinic_go_button_icon.png'),
                //     width: _kWidthHeightGoButton.scale(),
                //     height: _kWidthHeightGoButton.scale(),
                //   ),
                // )
                //     .align(Alignment.center)
                //     .width(_kButtonDimension.scale())
                //     .setHeight(_kButtonDimension.scale())
                //     .bottomPadding(_kCloseButtonBottomPadding.scale())
              ],
            )
                .size(
                    _kWidthSearchCityBox.scale(), _kHeightSearchCityBox.scale())
                .leftPadding(_kStatPadding.scale())
                .rightPadding(_kEndPadding.scale()))
        .widgetBgColor(Colors.transparent);
  }
}
