import 'dart:io';



// String loginNumberFormatCheck(String number) {
//   String concateNumber;
//   if (number.length == 10) {
//     concateNumber = '19${number}';
//   }
//   if (Personnummer.valid(concateNumber)) {
//     concateNumber = concateNumber;
//   } else {
//     //aPrint("here");
//     if (number.length == 10) {
//       concateNumber = '20${number}';
//     }
//     aPrint(concateNumber);
//     if (Personnummer.valid(concateNumber)) {
//       concateNumber = concateNumber;
//     } else {
//       concateNumber = "";
//     }
//   }
//
//   return concateNumber;
// }

// launchMap(
//     {double endLat, double endLong}) async {
//
//   var mapOptions = [
//     'daddr=$endLat,$endLong',
//     'dir_action=navigate'
//   ].join('&');
//
//   if (Platform.isIOS) {
//     String googleMapsUrliOS = 'comgooglemaps://?$mapOptions';
//     final String appleMapsUrl =
//         "http://maps.apple.com/maps?daddr=$endLat,$endLong";
//
//     if (await canLaunch(appleMapsUrl)) {
//       print(appleMapsUrl);
//       await launch(appleMapsUrl);
//     } else
//      if (await canLaunch(googleMapsUrliOS)) {
//       print(googleMapsUrliOS);
//       await launch(googleMapsUrliOS);
//     } else {
//       throw 'Could not launch $googleMapsUrliOS';
//     }
//   } else {
//     String googleMapUrlAndroid = 'https://www.google.com/maps?$mapOptions';
//     if (await canLaunch(googleMapUrlAndroid)) {
//       print(googleMapUrlAndroid);
//       await launch(googleMapUrlAndroid);
//     } else {
//       throw 'Could not launch $googleMapUrlAndroid';
//     }
//   }
// }
