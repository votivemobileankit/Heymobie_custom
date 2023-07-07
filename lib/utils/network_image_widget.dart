import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkImagesWidgets extends StatelessWidget {
  NetworkImagesWidgets({Key? key, required this.url, this.fit})
      : super(key: key);
  String url;
  BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    var urlw = Uri.parse(url);
    // var imgUrl = Uri.parse(url);
    return CachedNetworkImage(
      imageUrl: urlw.toString(),
      fit: fit ?? BoxFit.cover,
      progressIndicatorBuilder: (context, url, downloadProgress) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child:
                  CircularProgressIndicator(value: downloadProgress.progress))),
      errorWidget: (context, _, __) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          "assets/images/ic_profile_icon.png",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
