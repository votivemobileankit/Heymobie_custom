
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;







class ImageCropper2{

Future<BitmapDescriptor> byteData(String url ) async {
  var iconurl ='your url';
  var dataBytes;
  var request = await http.get(Uri.parse(url));
  var bytes = request.bodyBytes;
  dataBytes = bytes;
  BitmapDescriptor bitmap= BitmapDescriptor.fromBytes(dataBytes.buffer.asUint8List());

  return bitmap ;

}

}