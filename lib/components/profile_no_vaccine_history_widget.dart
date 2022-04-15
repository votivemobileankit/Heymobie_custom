import 'package:flutter/cupertino.dart';
import 'package:grambunny_customer/utils/utils.dart';



class NoDataFound extends StatelessWidget {
  final String path;
  final String message;
  final double btnFontSize;
  final Color btnTextColor;
  final FontWeight btnFontWeight;
  const NoDataFound(
      this.path,
      this.message,
      this.btnFontSize,
      this.btnTextColor,
      this.btnFontWeight,
      key)
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: AssetImage('${imgPathGeneral}$path'),
        ),
        Text(
          message,
          style: TextStyle(
              fontSize: btnFontSize,
              color: btnTextColor,
              fontStyle: FontStyle.normal,
              fontWeight: btnFontWeight),
        )
      ],
    );
  }
}
