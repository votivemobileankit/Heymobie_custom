import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grambunny_customer/theme/theme.dart';

double _deviceWidth = 0.0;
double _deviceHeight = 0.0;
double _devicePixelRatio = 0.0;
double _deviceSafeAreaBottomInset = 0.0;
const double referenceWidth = 360;
const double referenceHeight = 640;
GlobalKey<NavigatorState> navigatorKey = new GlobalKey();
bool timerOnListener = true;

setDeviceMetrics(double width, double height, double pixelRatio) {
  _deviceWidth = width;
  _deviceHeight = height;
  _devicePixelRatio = pixelRatio;
  print(
      "deviceWidth = $_deviceWidth deviceHeight = $_deviceHeight devicePixelRatio = $_devicePixelRatio");
}

setDarkStatusBarOverlay() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
}

setSafeAreaBottomInset(double bottomInset) {
  if (_deviceSafeAreaBottomInset == null) {
    print('safe area bottom inset = $bottomInset');
    _deviceSafeAreaBottomInset = bottomInset;
  }
}

void showSnackBar(String text, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      text,
      style: textStyleCustomColor(14.0.scale(), Colors.white),
    ),
  ));
}

double getSafeAreaBottomInset() {
  return _deviceSafeAreaBottomInset;
}

extension UIExtension on double {
  double scale() {
    return this * _deviceWidth / referenceWidth;
  }

  double scaleRespectiveToHeight([double heightOffset = 0]) {
    return this *
        (_deviceHeight - heightOffset.scale()) /
        (referenceHeight - heightOffset);
  }

  double scaleForDimension(double currentDimension, double referenceDimension) {
    return this * currentDimension / referenceDimension;
  }

  double multiplyPixelRatio() {
    return this * effectivePixelRatio();
  }
}

extension UIStringExtension on String {
  String densitySuffix() {
    return "${this}${densityAwareImageVariant()}";
  }
}

double effectivePixelRatio() {
  double effectiveRatio = 1.0;

  if (_devicePixelRatio > 1.25 && _devicePixelRatio < 1.75) {
    effectiveRatio = 1.5;
  } else if (_devicePixelRatio < 2.5) {
    effectiveRatio = 2.0;
  } else {
    effectiveRatio = 3.0;
  }
  return effectiveRatio;
}

String densityAwareImageVariant() {
  return effectivePixelRatio() == 1.0 ? "" : "${effectivePixelRatio()}x/";
}

double densityAwareImageScale() {
  return referenceWidth / _deviceWidth * effectivePixelRatio();
}

keyBoardHideFocusChange(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

// Future<void> getLocation() async {
//   Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high);
//   //  aPrint(position.latitude);
//   //  aPrint(position.longitude);
//
//   LatLng pinPosition = LatLng(position.latitude, position.longitude);
//
//   double lat = pinPosition.latitude;
//   double lng = pinPosition.longitude;
//   sharedPrefs.keyLatitude = lat;
//   sharedPrefs.keyLongitude = lng;
// }

String removeLastCharacter(String str) {
  String result = "";
  if ((str != null) && (str.length > 0)) {
    result = str.substring(0, str.length - 3);
  }

  return result;
}
