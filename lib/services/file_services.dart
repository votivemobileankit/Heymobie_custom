import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';

Future<File> openFile(String fileName) async {
  Directory directory;
 late File file;
  try {
    directory = await getTemporaryDirectory();
    file = File('${directory.path}/$fileName');
    debugPrint("In open file:" + file.path);
  } catch (e) {}

  return file ;
}

Future<File> deleteFile(String fileName) async {
  Directory directory;
 late File file;
  try {
    directory = await getTemporaryDirectory();
    file = File('${directory.path}/$fileName');
    file.delete();
  } catch (e) {}

  return file;
}



Future<String> getVersionNumber() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  // aPrint("Package versi " + packageInfo.version);
  // aPrint("Package buildnumber " + packageInfo.buildNumber);
  return packageInfo.version;
}
