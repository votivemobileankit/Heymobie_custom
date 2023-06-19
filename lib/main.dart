import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:grambunny_customer/main_common.dart';

void main() {
  FlavorConfig(
      name: "Review",
      color: Colors.red,
      location: BannerLocation.bottomEnd,
      variables: {"herBeriumBaseLiveUrl": "herBeriumBaseDevUrl"});

  initializeCommon();

  //runApp(const MyApp());
}

