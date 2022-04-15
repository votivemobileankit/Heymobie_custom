import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:grambunny_customer/utils/utils.dart';
import 'package:http/http.dart' as http;

import 'custom_network_exceptions.dart';

class NetworkApiProvider {
  String _baseUrl;
  String accessToken;

  NetworkApiProvider(String baseUrl) {
    _baseUrl = baseUrl;
  }

  Future<dynamic> get(String url,
      [bool addToken = false, Map<String, String> additionalHeaders]) async {
    var responseJson;
    try {
      var headers = <String, String>{
        'Content-Type': 'application/json',
        'herbarium': '123456',
      };
      if (additionalHeaders != null) {
        headers.addAll(additionalHeaders);
      }
      print('url = $url');
      print('headers = $headers');
      final response = await http
          .get(
        Uri.parse(url),
        headers: headers,
      )
          .timeout(Duration(seconds: 180), onTimeout: () {
        print('Time Out');
      });
      responseJson = _response(response);
    } on SocketException {
      throw NoInternetNetworkException();
    }
    return responseJson;
  }

  Future<dynamic> getstaticContent(String url,
      [bool addToken = false, Map<String, String> additionalHeaders]) async {
    var responseJson;
    try {
      String Username = "mild";
      String Password = "mild";
      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$Username:$Password'));
      var headers = <String, String>{
        'accept': 'application/json',
        'Authorization': basicAuth,
      };
      if (additionalHeaders != null) {
        headers.addAll(additionalHeaders);
      }
      print('url = $url');
      print('headers = $headers');
      final response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(Duration(seconds: 140), onTimeout: () {
        print('Time Out');
      });
      responseJson = _response(response);
    } on SocketException {
      throw NoInternetNetworkException();
    }
    return responseJson;
  }

  Future<dynamic> delete(String url,
      [bool addToken = false, Map<String, String> additionalHeaders]) async {
    var responseJson;
    try {
      var headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'accept': 'application/json',
        if (addToken && accessToken != null)
          'Authorization': 'Bearer $accessToken'
      };
      if (additionalHeaders != null) {
        headers.addAll(additionalHeaders);
      }
      print('url = $url');
      print('headers = $headers');
      final response = await http
          .delete(Uri.parse(_baseUrl + url), headers: headers)
          .timeout(Duration(seconds: 90), onTimeout: () {
        print('Time Out');
      });
      responseJson = _response(response);
    } on SocketException {
      throw NoInternetNetworkException();
    }
    return responseJson;
  }

  Future<dynamic> post(String url, Map<String, dynamic> jsonMap,
      [bool addToken = false, Map<String, String> additionalHeaders]) async {
    var responseJson;
    try {
      var headers = <String, String>{
        'Content-Type': 'application/json',
        'herbarium': '123456'
      };
      if (additionalHeaders != null) {
        headers.addAll(additionalHeaders);
      }
      print('url = $url');
      // print('headers = $headers');
      // print('jsonMap = $jsonMap');
      print('urlfull = ${url}');
      String jsonStr = jsonEncode(jsonMap);
      print('jsonMap = $jsonStr');
      final response = await http
          .post(Uri.parse(url), headers: headers, body: jsonEncode(jsonMap))
          .timeout(const Duration(seconds: 60), onTimeout: () {
        print('Time Out');
      });

      responseJson = _response(response);
    } on SocketException {
      throw NoInternetNetworkException();
    }
    return responseJson;
  }

  Future<dynamic> postProfileMultipartImage(String url, String fileUserPath,
      String paramName, Map<String, dynamic> jsonMap,
      [bool addToken = false, Map<String, String> additionalHeaders]) async {
    var responseJson;
    try {
      print(url);
      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.headers['Content-Type'] = 'application/json';
      request.headers['herbarium'] = '123456';

      if (additionalHeaders != null) {
        request.headers.addAll(additionalHeaders);
      }

      request.fields['userid'] = jsonMap["userid"];

      print("User License Copy" + fileUserPath);

      print(request.headers.toString());
      print("request......" + request.fields.toString());

      request.files
          .add(await http.MultipartFile.fromPath(paramName, fileUserPath));

      final streamedResponse = await request.send();

      final response = await http.Response.fromStream(streamedResponse)
          .timeout(Duration(seconds: 120), onTimeout: () {
        print('Time Out');
      });
      print(response.body);
      responseJson = await _response(response);
    } on SocketException {
      throw NoInternetNetworkException();
    }
    return responseJson;
  }

  Future<dynamic> postWithUrl(String url, Map<String, dynamic> jsonMap,
      [bool addToken = false, Map<String, String> additionalHeaders]) async {
    var responseJson;
    try {
      var headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'accept': 'application/json',
        'herbarium': '123456',
        if (addToken && accessToken != null)
          'Authorization': 'Bearer $accessToken'
      };
      if (additionalHeaders != null) {
        headers.addAll(additionalHeaders);
      }
      print('url = $url');
      print('headers = $headers');
      //print('jsonMap = $jsonMap');
      String jsonStr = jsonEncode(jsonMap);
      print('jsonMap = $jsonStr');
      final response = await http
          .post(Uri.parse(url), headers: headers, body: jsonEncode(jsonMap))
          .timeout(Duration(seconds: 120), onTimeout: () {
        print('Time Out');
      });
      responseJson = _response(response);
    } on SocketException {
      throw NoInternetNetworkException();
    }
    return responseJson;
  }

  Future<dynamic> patch(String url, Map<String, dynamic> jsonMap,
      [bool addToken = false, Map<String, String> additionalHeaders]) async {
    var responseJson;
    try {
      var headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'accept': 'application/json',
        if (addToken && accessToken != null)
          'Authorization': 'Bearer $accessToken'
      };
      if (additionalHeaders != null) {
        headers.addAll(additionalHeaders);
      }
      print('url = $url');
      print('headers = $headers');
      print('jsonMap = $jsonMap');
      final response = await http
          .patch(Uri.parse(url), headers: headers, body: jsonEncode(jsonMap))
          .timeout(Duration(seconds: 120), onTimeout: () {
        print('Time Out');
      });
      responseJson = _response(response);
    } on SocketException {
      throw NoInternetNetworkException();
    }
    return responseJson;
  }

  Future<dynamic> postMultipartImage(
      String url,
      String fileUserPath,
      String fileFrontLicense,
      String fileBackLicense,
      Map<String, dynamic> jsonMap,
      [bool addToken = false,
      Map<String, String> additionalHeaders]) async {
    var responseJson;
    try {
      print(url);
      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.headers['Content-Type'] = 'application/json';
      request.headers['herbarium'] = '123456';

      if (additionalHeaders != null) {
        request.headers.addAll(additionalHeaders);
      }

      request.fields['userid'] = jsonMap["userid"];
      request.fields['user_mobile'] = jsonMap["user_mobile"];
      request.fields['fname'] = jsonMap["fname"];
      request.fields['lname'] = jsonMap["lname"];
      request.fields['address'] = jsonMap["address"];
      request.fields['user_lat'] = jsonMap["user_lat"];
      request.fields['user_long'] = jsonMap["user_long"];
      request.fields['city'] = jsonMap["city"];
      request.fields['postcode'] = jsonMap["postcode"];
      request.fields['state'] = jsonMap["state"];
      print("User License Copy" + fileUserPath);
      print("Front License Copy" + fileFrontLicense);
      print("Back License Copy" + fileBackLicense);
      print(request.headers.toString());
      print("request......" + request.fields.toString());
      if (fileFrontLicense == "Select license image copy front" &&
          fileBackLicense != "Select license image copy back" &&
          fileUserPath.isEmpty) {
        print("First===");

        request.files.add(
            await http.MultipartFile.fromPath('license_back', fileBackLicense));
      } else if (fileBackLicense == "Select license image copy back" &&
          fileFrontLicense != "Select license image copy front" &&
          fileUserPath.isEmpty) {
        print("Second===");

        request.files.add(await http.MultipartFile.fromPath(
            'license_front', fileFrontLicense));
      } else if (fileFrontLicense == "Select license image copy front" &&
          fileBackLicense != "Select license image copy back") {
        print("Third===");
        request.files
            .add(await http.MultipartFile.fromPath('profile', fileUserPath));
        request.files.add(
            await http.MultipartFile.fromPath('license_back', fileBackLicense));
      } else if (fileBackLicense == "Select license image copy back" &&
          fileFrontLicense != "Select license image copy front") {
        print("Fourth===");
        request.files
            .add(await http.MultipartFile.fromPath('profile', fileUserPath));
        request.files.add(await http.MultipartFile.fromPath(
            'license_front', fileFrontLicense));
      } else if (fileUserPath.isNotEmpty &&
          fileBackLicense == "Select license image copy back" &&
          fileFrontLicense == "Select license image copy front") {
        print("Five===");
        request.files
            .add(await http.MultipartFile.fromPath('profile', fileUserPath));
      } else {
        print("Six===");
        request.files
            .add(await http.MultipartFile.fromPath('profile', fileUserPath));
        request.files.add(await http.MultipartFile.fromPath(
            'license_front', fileFrontLicense));
        request.files.add(
            await http.MultipartFile.fromPath('license_back', fileBackLicense));
      }

      print("fname" + jsonMap["fname"]);

      final streamedResponse = await request.send();

      final response = await http.Response.fromStream(streamedResponse)
          .timeout(Duration(seconds: 120), onTimeout: () {
        print('Time Out');
      });
      print(response.body);
      responseJson = await _response(response);
    } on SocketException {
      throw NoInternetNetworkException();
    }
    return responseJson;
  }

  Future<dynamic> postMultipartImageSignup(
      String url,
      String fileUserPath,
      String fileFrontLicense,
      String fileBackLicense,
      String fileMarijuanaId,
      Map<String, dynamic> jsonMap,
      [bool addToken = false,
      Map<String, String> additionalHeaders]) async {
    var responseJson;
    try {
      print(url);
      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.headers['Content-Type'] = 'application/json';
      request.headers['herbarium'] = '123456';

      if (additionalHeaders != null) {
        request.headers.addAll(additionalHeaders);
      }

      request.fields['fname'] = jsonMap["fname"];
      request.fields['lname'] = jsonMap["lname"];
      request.fields['email'] = jsonMap["email"];
      request.fields['password'] = jsonMap["password"];
      request.fields['mobileno'] = jsonMap["mobileno"];
      request.fields['devicetype'] = jsonMap["devicetype"];
      request.fields['devicetoken'] = jsonMap["devicetoken"];
      request.fields['dob'] = jsonMap["dob"];
      request.fields['address'] = jsonMap["address"];
      request.fields['city'] = jsonMap["city"];
      request.fields['state'] = jsonMap["state"];
      request.fields['zipcode'] = jsonMap["zipcode"];
      request.fields['os_name'] = jsonMap["os_name"];
      request.fields['customer_type'] = jsonMap["customer_type"];
      print("User License Copy" + fileUserPath);
      print("Front License Copy" + fileFrontLicense);
      print("Back License Copy" + fileBackLicense);
      print(request.headers.toString());
      print("request......" + request.fields.toString());
      if (fileFrontLicense == "" &&
          fileBackLicense.isNotEmpty &&
          fileUserPath.isEmpty &&
          fileMarijuanaId.isEmpty) {
        print("First===");

        request.files.add(
            await http.MultipartFile.fromPath('license_back', fileBackLicense));
      } else if (fileBackLicense == "" &&
          fileFrontLicense.isNotEmpty &&
          fileUserPath.isEmpty &&
          fileMarijuanaId.isEmpty) {
        print("Second===");

        request.files.add(await http.MultipartFile.fromPath(
            'license_front', fileFrontLicense));
      } else if (fileFrontLicense == "" &&
          fileBackLicense.isNotEmpty &&
          fileUserPath.isNotEmpty &&
          fileMarijuanaId.isEmpty) {
        print("Third===");
        request.files
            .add(await http.MultipartFile.fromPath('profile', fileUserPath));
        request.files.add(
            await http.MultipartFile.fromPath('license_back', fileBackLicense));
      } else if (fileBackLicense == "" &&
          fileFrontLicense.isNotEmpty &&
          fileUserPath.isNotEmpty &&
          fileMarijuanaId.isEmpty) {
        print("Fourth===");
        request.files
            .add(await http.MultipartFile.fromPath('profile', fileUserPath));
        request.files.add(await http.MultipartFile.fromPath(
            'license_front', fileFrontLicense));
      } else if (fileUserPath.isNotEmpty &&
          fileBackLicense == "" &&
          fileFrontLicense == "" &&
          fileMarijuanaId.isEmpty) {
        print("Five===");
        request.files
            .add(await http.MultipartFile.fromPath('profile', fileUserPath));
      } else if (fileUserPath.isNotEmpty &&
          fileBackLicense == "" &&
          fileFrontLicense == "" &&
          fileMarijuanaId.isNotEmpty) {
        print("Six===");
        request.files
            .add(await http.MultipartFile.fromPath('profile', fileUserPath));
        request.files.add(await http.MultipartFile.fromPath(
            'marijuana_card', fileMarijuanaId));
      } else if (fileUserPath.isNotEmpty &&
          fileBackLicense == "" &&
          fileFrontLicense.isNotEmpty &&
          fileMarijuanaId.isNotEmpty) {
        print("Seven===");
        request.files
            .add(await http.MultipartFile.fromPath('profile', fileUserPath));
        request.files.add(await http.MultipartFile.fromPath(
            'marijuana_card', fileMarijuanaId));
        request.files.add(await http.MultipartFile.fromPath(
            'license_front', fileFrontLicense));
      } else if (fileUserPath.isNotEmpty &&
          fileBackLicense.isNotEmpty &&
          fileFrontLicense == "" &&
          fileMarijuanaId.isNotEmpty) {
        print("Eight===");
        request.files
            .add(await http.MultipartFile.fromPath('profile', fileUserPath));
        request.files.add(await http.MultipartFile.fromPath(
            'marijuana_card', fileMarijuanaId));
        request.files.add(
            await http.MultipartFile.fromPath('license_back', fileBackLicense));
      } else {
        print("Nine===");
        request.files
            .add(await http.MultipartFile.fromPath('profile', fileUserPath));
        request.files.add(await http.MultipartFile.fromPath(
            'license_front', fileFrontLicense));
        request.files.add(
            await http.MultipartFile.fromPath('license_back', fileBackLicense));
        request.files.add(await http.MultipartFile.fromPath(
            'marijuana_card', fileMarijuanaId));
      }

      print("fname" + jsonMap["fname"]);

      final streamedResponse = await request.send();

      final response = await http.Response.fromStream(streamedResponse)
          .timeout(Duration(seconds: 120), onTimeout: () {
        print('Time Out');
      });
      print(response.body);
      responseJson = await _response(response);
    } on SocketException {
      throw NoInternetNetworkException();
    }
    return responseJson;
  }

  dynamic _response(http.BaseResponse response) async {
    String responsePhrase = response is http.Response
        ? response.body
        : response is http.StreamedResponse
            ? await response.stream.bytesToString()
            : null;
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(responsePhrase);
        // print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestNetworkException(
            responsePhrase, NetworkErrorType.BAD_REQUEST);
      case 401:

      case 403:
        throw UnauthorisedNetworkException(
            responsePhrase, NetworkErrorType.UNAUTHORIZED);
      case 500:
      case 204:
        var responseJson = "";
        if (responsePhrase == "") {
          responseJson = "[]";
        } else {
          responseJson = json.decode(responsePhrase);
        }
        // print(responseJson);
        return responseJson;
      case 201:
        var responseJson = json.decode(responsePhrase);
        //  print(responseJson);
        return responseJson;
      case 409:
        var responseJson = json.decode(responsePhrase);
        //  print(responseJson);
        return responseJson;

      default:
        throw FetchDataNetworkException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}',
            NetworkErrorType.OTHER);
    }
  }
}
