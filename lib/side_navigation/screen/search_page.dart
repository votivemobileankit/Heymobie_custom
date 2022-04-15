import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grambunny_customer/generated/l10n.dart';
import 'package:grambunny_customer/theme/theme.dart';
import 'package:grambunny_customer/utils/ui_utils.dart';

const double _kCommonHintTextFieldFontSize = 14.0;

class SearchPage extends StatelessWidget {
  TextEditingController _textFiledUserName;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        TextField(
            controller: _textFiledUserName,
            autofocus: false,
            obscureText: true,
            cursorColor: KColorTextFieldCommonHint,
            decoration: InputDecoration(
              hintText: Stringss.current.txtHintFirstName,
              hintStyle: textStyleCustomColor(
                  _kCommonHintTextFieldFontSize.scale(),
                  KColorTextFieldCommonHint),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
            )),
      ],
    );
  }
}
