import 'dart:convert';
import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grambunny_customer/home/home.dart';
import 'package:grambunny_customer/home/model/cartlist_response_model.dart';
import 'package:grambunny_customer/home/model/category_list_model.dart';
import 'package:grambunny_customer/home/model/product_list_model.dart';
import 'package:grambunny_customer/home/model/statelist_reponse_model.dart';
import 'package:grambunny_customer/networking/networking.dart';
import 'package:grambunny_customer/orderhistory/model/model.dart';
import 'package:grambunny_customer/orderhistory/model/order_detail_model.dart';
import 'package:grambunny_customer/orderhistory/model/vendor_location_model.dart';
import 'package:grambunny_customer/profile/profile.dart';
import 'package:grambunny_customer/services/herbarium_cust_shared_preferences.dart';
import 'package:grambunny_customer/setting/model/model.dart';
import 'package:grambunny_customer/utils/image_cropper1.dart';
import 'package:grambunny_customer/utils/utils.dart';

NetworkApiProvider _vdApiProvider;

class UserRepository {
  String currentLanguageCode = "";
  ScreenNavigation ScreenName;
  List<RatingReviewData> ratingReviewDataArray;
  String herberiumUrlCall;
  List<CategoryListModel> categortList;
  List<DriverList> _driverList;
  List<ProductListMenu> _productList;
  FilterListModel _filterListModel;
  List<StatesList> statesList;
  String cartCount = "0";
  List<ItemsCart> _cartList;
  DataCart cartDataModel;
  List<Couponlist> couponlist;
  DataResponse checkoutCalculation;
  List<ProductListDriver> _driverProductList;
  UserDetail _userDetail;
  List<VendorLatlng> _vendorLatLong;
  List<HistoryList> _orderHistoryItem;
  List<OrderDetail> orderDetail;
  List<OrderItems> orderItems;
  List<Vendor1> vendorData;
  String orderId = "";
  String notifyOrderId = "";
  String notifyDriverId = "";
  String isNewdriver;
  UserDetailResponseModel userDetailResponseModel;
  NotificationDetail notificationDetail;
  UserInfoData userDataInfo;
  String strFirebaseToken = "";
  String strBannerImage = "";
  List<RelatedProductList> relatedProductList;
  List<AddonProductList> addonProductList;
  List<Advertisement> _advertisement;
  List<BitmapDescriptor> pinLocationIcon;
  static String strProfileMerchantUrl = "";

  UserRepository() {
    herberiumUrlCall = herBeriumBaseDevUrl;
    pinLocationIcon = [];
    _vdApiProvider = NetworkApiProvider(herberiumUrlCall);
  }

  Future<void> getToken() async {
    strFirebaseToken = await FirebaseMessaging.instance.getToken();
    print('user Repos ${strFirebaseToken}');
  }

  set profileMerchantUrl(String value) {
    strProfileMerchantUrl = value;
  }

  static String getProfileUrl() {
    return strProfileMerchantUrl;
  }

  set screenNameSet(ScreenNavigation value) {
    ScreenName = value;
  }

  Future<NetworkApiCallState<bool>> LoginToAPI(
      String email,
      String password,
      String card_id,
      String devicetype,
      String os_name,
      String devicetoken) async {
    NetworkApiCallState<bool> apiCallState;
    var response;
    String status;
    String massage;
    try {
      Map<String, dynamic> requestParams = {
            "mobileno": email,
            "password": password,
            "cart_id": sharedPrefs.getUserId,
            "devicetype": devicetype,
            "os_name": os_name,
            "devicetoken": strFirebaseToken
          },
          response = await _vdApiProvider.postWithUrl(
              herberiumUrlCall + apiLogin, requestParams);

      status = response['status'].toString();
      massage = response['message'].toString();
      print("Status=====>>>>" + status);
      if (response["status"].toString() == "1" ||
          response["status"].toString() == "2") {
        LoginModel loginModel = LoginModel.fromJson(response);
        _userDetail = loginModel.data.userDetail;
        apiCallState = NetworkApiCallState.completed(true,
            response["message"].toString(), response["status"].toString());
      } else {
        apiCallState = NetworkApiCallState.completed(true,
            response["message"].toString(), response["status"].toString());
      }
    } catch (Excep) {
      print('Exception Auth ${Excep.toString()}');
      if (Excep is CustomNetworkException) {
        apiCallState =
            NetworkApiCallState.error(Excep.message, "", Excep.errorType);
      } else {
        apiCallState = NetworkApiCallState.error(
            "Unknown Error", "", NetworkErrorType.OTHER);
      }
    }
    return apiCallState;
  }

  Future<NetworkApiCallState<bool>> getOrderDetail(
      String orderID, String vendorId) async {
    NetworkApiCallState<bool> apiCallState;
    var response;
    String status;
    String massage;
    try {
      Map<String, dynamic> requestParams = {
        "vendor_id": vendorId,
        "order_id": orderID
      };

      //_orderHistoryItem = [];
      var responseList = await _vdApiProvider.post(
          herberiumUrlCall + apiOrderDetails, requestParams);

      orderItems = [];
      orderDetail = [];
      vendorData = [];
      print("ORder=====>>>>" + responseList.toString());
      if (responseList["status"] == 1) {
        print("ORder=====>>>>" + "success");
        // Map<String, dynamic> data = responseList["data"];
        // data.forEach((key, value) {
        //   List<dynamic> orderitemsList = data["order_items"];
        //   orderitemsList.forEach((element) {
        //     Map<String, dynamic> orderListInnerMap =
        //         element as Map<String, dynamic>;
        //     print(orderListInnerMap["slug"]);
        //     Map<String, dynamic> dataVendor =
        //         orderListInnerMap["Vendor"] as Map;
        //     dataVendor.forEach((key, value) {
        //       print(key);
        //     });
        //   });
        // });

        OrderDetailResponseModel orderDetailModel =
            OrderDetailResponseModel.fromJson(responseList);
        orderDetail = orderDetailModel.data.orderDetail;
        orderItems = orderDetailModel.data.orderItems;
        vendorData = orderDetailModel.data.vendor;

        apiCallState = NetworkApiCallState.completed(
            true,
            responseList["message"].toString(),
            responseList['status'].toString());
      } else {
        apiCallState = NetworkApiCallState.completed(
            true,
            responseList["message"].toString(),
            responseList["status"].toString());
      }
    } catch (Excep) {
      print('Exception Auth ${Excep.toString()}');
      if (Excep is CustomNetworkException) {
        apiCallState =
            NetworkApiCallState.error(Excep.message, "", Excep.errorType);
      } else {
        apiCallState = NetworkApiCallState.error(
            "Unknown Error", "", NetworkErrorType.OTHER);
      }
    }
    return apiCallState;
  }

  Future<NetworkApiCallState<bool>> getOrderHistoryList(
      String pageNumber) async {
    NetworkApiCallState<bool> apiCallState;
    var response;
    String status;
    String massage;
    try {
      Map<String, dynamic> requestParams = {
        "user_id": sharedPrefs.getUserId,
        "current_page": pageNumber
      };
      _orderHistoryItem = [];
      var responseList = await _vdApiProvider.post(
          herberiumUrlCall + apiOrderHistory, requestParams);

      status = responseList['status'].toString();
      massage = responseList['message'].toString();
      print(
          "ORder=====>>>>" + status + "response==>>" + responseList.toString());
      if (responseList["status"] == 1) {
        OrderHistoryModel historyModel =
            OrderHistoryModel.fromJson(responseList);
        _orderHistoryItem = historyModel.items.data;
        print("ORder=====>>>>" + "success");
        status = responseList['status'].toString();
        apiCallState = NetworkApiCallState.completed(
            true,
            responseList["message"].toString(),
            responseList['status'].toString());
      } else {
        _orderHistoryItem = [];
        apiCallState = NetworkApiCallState.completed(
            true,
            responseList["message"].toString(),
            responseList["status"].toString());
      }
    } catch (Excep) {
      print('Exception Auth ${Excep.toString()}');
      if (Excep is CustomNetworkException) {
        apiCallState =
            NetworkApiCallState.error(Excep.message, "", Excep.errorType);
      } else {
        apiCallState = NetworkApiCallState.error(
            "Unknown Error", "", NetworkErrorType.OTHER);
      }
    }
    return apiCallState;
  }

  Future<NetworkApiCallState<bool>> ResetPasswordToAPI(
      String email, String password) async {
    NetworkApiCallState<bool> apiCallState;
    var response;
    String status;
    String massage;
    try {
      Map<String, dynamic> requestParams = {
            "userid": email,
            "newpassword": password
          },
          response = await _vdApiProvider.postWithUrl(
              herberiumUrlCall + apiResetPassword, requestParams);

      status = response['status'].toString();
      massage = response['message'].toString();
      print("Status=====>>>>" + status);
      if (response["status"].toString() == "1" ||
          response["status"].toString() == "2") {
        LoginModel loginModel = LoginModel.fromJson(response);
        _userDetail = loginModel.data.userDetail;
        apiCallState = NetworkApiCallState.completed(true,
            response["message"].toString(), response["status"].toString());
      } else {
        apiCallState = NetworkApiCallState.completed(true,
            response["message"].toString(), response["status"].toString());
      }
    } catch (Excep) {
      print('Exception Auth ${Excep.toString()}');
      if (Excep is CustomNetworkException) {
        apiCallState =
            NetworkApiCallState.error(Excep.message, "", Excep.errorType);
      } else {
        apiCallState = NetworkApiCallState.error(
            "Unknown Error", "", NetworkErrorType.OTHER);
      }
    }
    return apiCallState;
  }

  Future<NetworkApiCallState<bool>> ForgotPasswordToAPI(String email) async {
    NetworkApiCallState<bool> apiCallState;
    var response;
    String status;
    String massage;
    try {
      Map<String, dynamic> requestParams = {
            "emailid": email,
          },
          response = await _vdApiProvider.postWithUrl(
              herberiumUrlCall + apiForgotPassword, requestParams);

      status = response['status'].toString();
      massage = response['message'].toString();
      print("Status=====>>>>" + status);
      if (response["status"].toString() == "1") {
        apiCallState = NetworkApiCallState.completed(true,
            response["message"].toString(), response["status"].toString());
      } else {
        apiCallState = NetworkApiCallState.completed(true,
            response["message"].toString(), response["status"].toString());
      }
    } catch (Excep) {
      print('Exception Auth ${Excep.toString()}');
      if (Excep is CustomNetworkException) {
        apiCallState =
            NetworkApiCallState.error(Excep.message, "", Excep.errorType);
      } else {
        apiCallState = NetworkApiCallState.error(
            "Unknown Error", "", NetworkErrorType.OTHER);
      }
    }
    return apiCallState;
  }

  Future<NetworkApiCallState<bool>> OtpVarify(
      String email, String otp, String from) async {
    NetworkApiCallState<bool> apiCallState;
    var response;
    String status;
    String massage;
    try {
      Map<String, dynamic> requestParams = {
            "mobileno": email,
            "otp": otp,
            "from": from
          },
          response = await _vdApiProvider.postWithUrl(
              herberiumUrlCall + apiOtpVerify, requestParams);

      status = response['status'].toString();
      massage = response['message'].toString();
      print("Status=====>>>>" + status);
      if (response["status"].toString() == "1") {
        apiCallState = NetworkApiCallState.completed(true,
            response["message"].toString(), response["status"].toString());
      } else {
        apiCallState = NetworkApiCallState.completed(true,
            response["message"].toString(), response["status"].toString());
      }
    } catch (Excep) {
      print('Exception Auth ${Excep.toString()}');
      if (Excep is CustomNetworkException) {
        apiCallState =
            NetworkApiCallState.error(Excep.message, "", Excep.errorType);
      } else {
        apiCallState = NetworkApiCallState.error(
            "Unknown Error", "", NetworkErrorType.OTHER);
      }
    }
    return apiCallState;
  }

  Future<NetworkApiCallState<bool>> OtpResend(String email, String from) async {
    NetworkApiCallState<bool> apiCallState;
    var response;
    String status;
    String massage;
    try {
      Map<String, dynamic> requestParams = {"mobileno": email, "from": from},
          response = await _vdApiProvider.postWithUrl(
              herberiumUrlCall + apiOtpResend, requestParams);

      status = response['status'].toString();
      massage = response['message'].toString();
      print("Status=====>>>>" + status);
      if (response["status"].toString() == "1") {
        apiCallState = NetworkApiCallState.completed(true,
            response["message"].toString(), response["status"].toString());
      } else {
        apiCallState = NetworkApiCallState.completed(true,
            response["message"].toString(), response["status"].toString());
      }
    } catch (Excep) {
      print('Exception Auth ${Excep.toString()}');
      if (Excep is CustomNetworkException) {
        apiCallState =
            NetworkApiCallState.error(Excep.message, "", Excep.errorType);
      } else {
        apiCallState = NetworkApiCallState.error(
            "Unknown Error", "", NetworkErrorType.OTHER);
      }
    }
    return apiCallState;
  }

  Future<NetworkApiCallState<bool>> SignUpToAPI(
      {String fname,
      String lname,
      String email,
      String password,
      String mobileno,
      String devicetype,
      String devicetoken,
      String dob,
      String address,
      String city,
      String state,
      String zipcode,
      String os_name,
      String profileImage,
      String licenseImageFront,
      String licenseImageBack,
      String strCustomerType,
      String marijuanaIdCard}) async {
    NetworkApiCallState<bool> apiCallState;
    var response;
    String status;
    String massage;
    try {
      Map<String, dynamic> requestParams = {
            "fname": fname,
            "lname": lname,
            "email": email,
            "password": password,
            "mobileno": mobileno,
            "devicetype": devicetype,
            "devicetoken": devicetoken,
            "dob": dob,
            "address": address,
            "city": city,
            "state": state,
            "zipcode": zipcode,
            "os_name": os_name,
            "customer_type": strCustomerType,
          },
          // response = await _vdApiProvider.postWithUrl(
          //     herberiumUrlCall + apiSignUP, requestParams);

          response = await _vdApiProvider.postMultipartImageSignup(
              herberiumUrlCall + apiSignUP,
              profileImage,
              licenseImageFront,
              licenseImageBack,
              marijuanaIdCard,
              requestParams);

      status = response['status'].toString();
      massage = response['message'].toString();
      print("Status=====>>>>" + status);
      if (response["status"].toString() == "1") {
        LoginModel loginModel = LoginModel.fromJson(response);
        _userDetail = loginModel.data.userDetail;
        sharedPrefs.setUserProfileImage = loginModel.data.userDetail.profileURL;
        apiCallState = NetworkApiCallState.completed(true,
            response["message"].toString(), response["status"].toString());
      } else {
        apiCallState = NetworkApiCallState.completed(true,
            response["message"].toString(), response["status"].toString());
      }
    } catch (Excep) {
      print('Exception Auth ${Excep.toString()}');
      if (Excep is CustomNetworkException) {
        apiCallState =
            NetworkApiCallState.error(Excep.message, "", Excep.errorType);
      } else {
        apiCallState = NetworkApiCallState.error(
            "Unknown Error", "", NetworkErrorType.OTHER);
      }
    }
    return apiCallState;
  }

  Future<NetworkApiCallState<bool>> getCategoryApiListCall(
      String vendorId) async {
    NetworkApiCallState<bool> apiCallState;
    categortList = [];
    try {
      Map<String, dynamic> requestParams = {"vendor_id": vendorId};
      var responseList = await _vdApiProvider.post(
          herberiumUrlCall + apiCategoryList, requestParams);

      print(responseList["status"]);
      if (responseList["status"].toString() == "1") {
        Map<String, dynamic> dataDetailsMap = responseList["data"];
        List<dynamic> categoryListMap = dataDetailsMap["category_list"];
        categoryListMap.forEach((element) {
          Map<String, dynamic> categoryListDetailsMap =
              element as Map<String, dynamic>;
          print(categoryListDetailsMap["category"]);
          CategoryListModel categoryListModel = CategoryListModel(
              cat_image: categoryListDetailsMap["cat_image"],
              category: categoryListDetailsMap["category"],
              category_id: categoryListDetailsMap["category_id"],
              status: categoryListDetailsMap["status"]);
          categortList.add(categoryListModel);
        });

        apiCallState = NetworkApiCallState.completed(
            true,
            responseList["message"].toString(),
            responseList["status"].toString());
      } else {
        categortList = [];
        apiCallState = NetworkApiCallState.completed(
            true,
            responseList["message"].toString(),
            responseList["status"].toString());
      }
    } catch (Excep) {
      print('Exception  Call ${Excep.toString()}');
      if (Excep is CustomNetworkException) {
        apiCallState =
            NetworkApiCallState.error(Excep.message, "", Excep.errorType);
      } else {
        apiCallState = NetworkApiCallState.error(
            "Unknown Error", "", NetworkErrorType.OTHER);
      }
    }

    return apiCallState;
  }

  Future<NetworkApiCallState<bool>> getDriverApiListCall(double currentLat,
      double currentLong, String keyword, String searchBy) async {
    NetworkApiCallState<bool> apiCallState;
    Map<String, dynamic> latlongMap;
    if (currentLat == 0.0) {
      latlongMap = {
        "latitude": "",
        "longitude": "",
        "keyword": keyword,
        "searchby": searchBy
      };
    } else {
      latlongMap = {
        "latitude": currentLat,
        "longitude": currentLong,
        "keyword": keyword,
        "searchby": searchBy
      };
    }

    _driverProductList = [];
    _advertisement = [];
    try {
      var responseList = await _vdApiProvider.post(
          herberiumUrlCall + apiDriverList, latlongMap);

      // print("response ======= " + responseList.toString());
      // print(responseList["status"]);
      if (responseList["status"].toString() == "1") {
        profileMerchantUrl = responseList["img_url"];
        DriverListModel driverListModel =
            DriverListModel.fromJson(responseList);
        print(driverListModel.status);
        strBannerImage = driverListModel.banner_image;
        _driverList = driverListModel.data.driverList;

        _driverProductList = driverListModel.data.productList;
        _advertisement = driverListModel.data.advertisement;

        apiCallState = NetworkApiCallState.completed(
            true,
            responseList["message"].toString(),
            responseList["status"].toString());
      } else {
        _advertisement = [];
        _driverList = [];
        DriverListModel driverListModel =
            DriverListModel.fromJson(responseList);
        //  print(driverListModel.status);

        _advertisement = driverListModel.data.advertisement;

        apiCallState = NetworkApiCallState.completed(
            true,
            responseList["message"].toString(),
            responseList["status"].toString());
      }
    } catch (Excep) {
      print('Exception  Call ${Excep.toString()}');
      if (Excep is CustomNetworkException) {
        apiCallState =
            NetworkApiCallState.error(Excep.message, "", Excep.errorType);
      } else {
        apiCallState = NetworkApiCallState.error(
            "Unknown Error", "", NetworkErrorType.OTHER);
      }
    }

    return apiCallState;
  }

  Future<NetworkApiCallState<bool>> uploadImageCopyAPI(
      {String imageCopyPath, String paramName}) async {
    NetworkApiCallState<bool> apiCallState;
    Map<String, dynamic> userDetailMap = {
      "userid": sharedPrefs.getUserId,
    };
    try {
      var responseList = await _vdApiProvider.postProfileMultipartImage(
          herberiumUrlCall + apiGetUserUpdateProfileImage,
          imageCopyPath,
          paramName,
          userDetailMap);
      print(responseList.toString());
      if (responseList["status"] == 1) {
        apiCallState = NetworkApiCallState.completed(
            true,
            responseList["message"].toString(),
            responseList["status"].toString());
      } else {
        apiCallState = NetworkApiCallState.completed(
            true,
            responseList["message"].toString(),
            responseList["status"].toString());
      }
    } catch (Excep) {
      print('Exception  Call ${Excep.toString()}');
      if (Excep is CustomNetworkException) {
        apiCallState =
            NetworkApiCallState.error(Excep.message, "", Excep.errorType);
      } else {
        apiCallState = NetworkApiCallState.error(
            "Unknown Error", "", NetworkErrorType.OTHER);
      }
    }

    return apiCallState;
  }

  Future<NetworkApiCallState<bool>> getMapImage({
    String url,
  }) async {
    // var dataBytes;
    // var request = await http.get(Uri.parse(url));
    // var bytes = await request.bodyBytes;
    // dataBytes = bytes;
    //  print("url========= " + url);
    BitmapDescriptor bitmapDescriptor =
        await ImageCropper().resizeAndCircle(url, 80);

    // ui.FrameInfo fi = await codec.getNextFrame();
    // return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer
    //     .asUint8List()

    // pinLocationIcon
    //     .add(BitmapDescriptor.fromBytes(dataBytes.buffer.asUint8List()));
    pinLocationIcon.add(bitmapDescriptor);
  }

  Future<BitmapDescriptor> _paintToCanvas(Image image, Size size) async {
    final pictureRecorder = PictureRecorder();
    final canvas = Canvas(pictureRecorder);
    final paint = Paint();
    paint.isAntiAlias = true;

    _performCircleCrop(image, size, canvas);

    final recordedPicture = pictureRecorder.endRecording();
    Image img = await recordedPicture.toImage(image.width, image.height);
    final byteData = await img.toByteData(format: ImageByteFormat.png);
    final buffer = byteData.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(buffer);
  }

  Canvas _performCircleCrop(Image image, Size size, Canvas canvas) {
    Paint paint = Paint();
    canvas.drawCircle(Offset(0, 0), 0, paint);

    double drawImageWidth = 0;
    double drawImageHeight = 0;

    Path path = Path()
      ..addOval(Rect.fromLTWH(drawImageWidth, drawImageHeight,
          image.width.toDouble(), image.height.toDouble()));

    canvas.clipPath(path);
    canvas.drawImage(image, Offset(drawImageWidth, drawImageHeight), Paint());
    return canvas;
  }

  Future<NetworkApiCallState<bool>> getProductListApiCall({
    String categoryId,
    String driverId,
    String search,
  }) async {
    NetworkApiCallState<bool> apiCallState;
    Map<String, dynamic> latlongMap = {
      "category_id": categoryId,
      "driver_id": driverId,
      "search": search,
    };
    _productList = [];
    try {
      var responseList = await _vdApiProvider.post(
          herberiumUrlCall + apiCategoryProduct, latlongMap);

      print(responseList["status"]);
      if (responseList["status"].toString() == "1") {
        ProductListModel productListModel =
            ProductListModel.fromJson(responseList);
        print(productListModel.status);
        _productList = productListModel.data.productList;

        print(_productList[0].name);
        apiCallState = NetworkApiCallState.completed(
            true,
            responseList["message"].toString(),
            responseList["status"].toString());
      } else {
        apiCallState = NetworkApiCallState.completed(
            true,
            responseList["message"].toString(),
            responseList["status"].toString());
      }
    } catch (Excep) {
      print('Exception  Call ${Excep.toString()}');
      if (Excep is CustomNetworkException) {
        apiCallState =
            NetworkApiCallState.error(Excep.message, "", Excep.errorType);
      } else {
        apiCallState = NetworkApiCallState.error(
            "Unknown Error", "", NetworkErrorType.OTHER);
      }
    }

    return apiCallState;
  }

  Future<NetworkApiCallState<bool>> getCartCountApiCall() async {
    NetworkApiCallState<bool> apiCallState;
    Map<String, dynamic> latlongMap = {
      "user_id": sharedPrefs.getUserId,
    };

    try {
      var responseList = await _vdApiProvider.post(
          herberiumUrlCall + apiCartCount, latlongMap);

      print("cart refresh " + responseList["status"].toString());
      if (responseList["status"] == 1) {
        cartCount = responseList["quantity"].toString();
        print("CartCount " + cartCount);
        sharedPrefs.setCartCount = cartCount;

        apiCallState = NetworkApiCallState.completed(
            true,
            responseList["message"].toString(),
            responseList["status"].toString());
      } else {
        sharedPrefs.setCartCount = "0";
        apiCallState = NetworkApiCallState.completed(
            true,
            responseList["message"].toString(),
            responseList["status"].toString());
      }
    } catch (Excep) {
      print('Exception  Call ${Excep.toString()}');
      if (Excep is CustomNetworkException) {
        apiCallState =
            NetworkApiCallState.error(Excep.message, "", Excep.errorType);
      } else {
        apiCallState = NetworkApiCallState.error(
            "Unknown Error", "", NetworkErrorType.OTHER);
      }
    }

    return apiCallState;
  }

  Future<NetworkApiCallState<bool>> getUserDetailApi() async {
    NetworkApiCallState<bool> apiCallState;
    Map<String, dynamic> userDetailMap = {
      "user_id": sharedPrefs.getUserId,
    };

    try {
      var responseList = await _vdApiProvider.post(
          herberiumUrlCall + apiGetUserProfile, userDetailMap);
      print(responseList.toString());
      if (responseList["status"] == 1) {
        userDetailResponseModel =
            UserDetailResponseModel.fromJson(responseList);

        apiCallState = NetworkApiCallState.completed(
            true,
            responseList["message"].toString(),
            responseList["status"].toString());
      } else {
        apiCallState = NetworkApiCallState.completed(
            true,
            responseList["message"].toString(),
            responseList["status"].toString());
      }
    } catch (Excep) {
      print('Exception  Call ${Excep.toString()}');
      if (Excep is CustomNetworkException) {
        apiCallState =
            NetworkApiCallState.error(Excep.message, "", Excep.errorType);
      } else {
        apiCallState = NetworkApiCallState.error(
            "Unknown Error", "", NetworkErrorType.OTHER);
      }
    }

    return apiCallState;
  }

  Future<NetworkApiCallState<bool>> getSettingUpdateApi(String emailStatus,
      String pushNotification, String smsNotification) async {
    NetworkApiCallState<bool> apiCallState;
    Map<String, dynamic> userDetailMap = {
      "user_id": sharedPrefs.getUserId,
      "email_notification": emailStatus,
      "notification": pushNotification,
      "sms_notification": smsNotification,
    };

    try {
      var responseList = await _vdApiProvider.post(
          herberiumUrlCall + apiSettingUpdate, userDetailMap);
      print(responseList.toString());
      if (responseList["status"] == 1) {
        apiCallState = NetworkApiCallState.completed(
            true,
            responseList["message"].toString(),
            responseList["status"].toString());
      } else {
        apiCallState = NetworkApiCallState.completed(
            true,
            responseList["message"].toString(),
            responseList["status"].toString());
      }
    } catch (Excep) {
      print('Exception  Call ${Excep.toString()}');
      if (Excep is CustomNetworkException) {
        apiCallState =
            NetworkApiCallState.error(Excep.message, "", Excep.errorType);
      } else {
        apiCallState = NetworkApiCallState.error(
            "Unknown Error", "", NetworkErrorType.OTHER);
      }
    }

    return apiCallState;
  }

  Future<NetworkApiCallState<bool>> getNotificationListApiCall(
      String pageCount) async {
    NetworkApiCallState<bool> apiCallState;
    Map<String, dynamic> userDetailMap = {
      "userid": sharedPrefs.getUserId,
      "current_page": pageCount,
    };

    try {
      var responseList = await _vdApiProvider.post(
          herberiumUrlCall + apiNotificationList, userDetailMap);
      print(responseList.toString());
      if (responseList["status"] == 1) {
        NotificationListModel listmodel =
            NotificationListModel.fromJson(responseList);
        notificationDetail = listmodel.notificationDetail;
        apiCallState = NetworkApiCallState.completed(
            true,
            responseList["message"].toString(),
            responseList["status"].toString());
      } else {
        apiCallState = NetworkApiCallState.completed(
            true,
            responseList["message"].toString(),
            responseList["status"].toString());
      }
    } catch (Excep) {
      print('Exception  Call ${Excep.toString()}');
      if (Excep is CustomNetworkException) {
        apiCallState =
            NetworkApiCallState.error(Excep.message, "", Excep.errorType);
      } else {
        apiCallState = NetworkApiCallState.error(
            "Unknown Error", "", NetworkErrorType.OTHER);
      }
    }

    return apiCallState;
  }

  Future<NetworkApiCallState<bool>> vendorLocationUpdate({
    String vendorID,
  }) async {
    NetworkApiCallState<bool> apiCallState;
    Map<String, dynamic> vendorUpdateLocationMap = {
      "vendor_id": vendorID,
    };
    _vendorLatLong = [];
    try {
      var responseList = await _vdApiProvider.post(
          herberiumUrlCall + apiVendorLocationUpdate, vendorUpdateLocationMap);
      print(responseList.toString());
      if (responseList["status"] == 1) {
        VendorLocationModel locationModel =
            VendorLocationModel.fromJson(responseList);
        _vendorLatLong = locationModel.location.vendorLatlng;
        apiCallState = NetworkApiCallState.completed(
            true,
            responseList["message"].toString(),
            responseList["status"].toString());
      } else {
        apiCallState = NetworkApiCallState.completed(
            true,
            responseList["message"].toString(),
            responseList["status"].toString());
      }
    } catch (Excep) {
      print('Exception  Call ${Excep.toString()}');
      if (Excep is CustomNetworkException) {
        apiCallState =
            NetworkApiCallState.error(Excep.message, "", Excep.errorType);
      } else {
        apiCallState = NetworkApiCallState.error(
            "Unknown Error", "", NetworkErrorType.OTHER);
      }
    }

    return apiCallState;
  }

  Future<NetworkApiCallState<bool>> changePasswordAPI({
    String old_Password,
    String new_Password,
  }) async {
    NetworkApiCallState<bool> apiCallState;
    Map<String, dynamic> userDetailMap = {
      "userid": sharedPrefs.getUserId,
      "oldpassword": old_Password,
      "newpassword": new_Password,
    };
    try {
      var responseList = await _vdApiProvider.post(
          herberiumUrlCall + apiChangePassword, userDetailMap);
      print(responseList.toString());
      if (responseList["status"] == 1) {
        apiCallState = NetworkApiCallState.completed(
            true,
            responseList["message"].toString(),
            responseList["status"].toString());
      } else {
        apiCallState = NetworkApiCallState.completed(
            true,
            responseList["message"].toString(),
            responseList["status"].toString());
      }
    } catch (Excep) {
      print('Exception  Call ${Excep.toString()}');
      if (Excep is CustomNetworkException) {
        apiCallState =
            NetworkApiCallState.error(Excep.message, "", Excep.errorType);
      } else {
        apiCallState = NetworkApiCallState.error(
            "Unknown Error", "", NetworkErrorType.OTHER);
      }
    }

    return apiCallState;
  }

  Future<NetworkApiCallState<bool>> postUpdateUserInfoApi(
      {String mobileNo,
      String firstName,
      String lastName,
      String address,
      String city,
      double lat,
      double long,
      String zipCode,
      String State,
      String userPath,
      String frontCopyPath,
      String backCopyPath}) async {
    NetworkApiCallState<bool> apiCallState;
    Map<String, dynamic> userDetailMap;
    print("file front path" + userPath);
    if (userPath.isEmpty) {
      print("Wihout Profile");
      userDetailMap = {
        "userid": sharedPrefs.getUserId,
        "user_mobile": mobileNo,
        "fname": firstName,
        "lname": lastName,
        "address": address,
        "city": city,
        "postcode": zipCode,
        "state": State,
        "user_lat": "22.7196",
        "user_long": "75.8577",
        "profile": ""
      };
    } else {
      print("With Profile");
      userDetailMap = {
        "userid": sharedPrefs.getUserId,
        "user_mobile": mobileNo,
        "fname": firstName,
        "lname": lastName,
        "address": address,
        "city": city,
        "postcode": zipCode,
        "state": State,
        "user_lat": "22.7196",
        "user_long": "75.8577"
      };
    }

    print(userDetailMap.toString());
    try {
      var responseList;
      if (userPath.isEmpty &&
          frontCopyPath == "Select license image copy front" &&
          backCopyPath == "Select license image copy back") {
        responseList = await _vdApiProvider.post(
            herberiumUrlCall + apiGetUserUpdateProfile, userDetailMap);
      } else {
        responseList = await _vdApiProvider.postMultipartImage(
            herberiumUrlCall + apiGetUserUpdateProfile,
            userPath,
            frontCopyPath,
            backCopyPath,
            userDetailMap);
      }

      print(responseList.toString());
      if (responseList["status"] == 1) {
        apiCallState = NetworkApiCallState.completed(
            true,
            responseList["message"].toString(),
            responseList["status"].toString());
      } else {
        apiCallState = NetworkApiCallState.completed(
            true,
            responseList["message"].toString(),
            responseList["status"].toString());
      }
    } catch (Excep) {
      print('Exception  Call ${Excep.toString()}');
      if (Excep is CustomNetworkException) {
        apiCallState =
            NetworkApiCallState.error(Excep.message, "", Excep.errorType);
      } else {
        apiCallState = NetworkApiCallState.error(
            "Unknown Error", "", NetworkErrorType.OTHER);
      }
    }

    return apiCallState;
  }

  Future<NetworkApiCallState<bool>> getCartDeleteSingleItemApiCall(
      int productId, String driverId) async {
    NetworkApiCallState<bool> apiCallState;
    Map<String, dynamic> addToCartMap = {
      "user_id": sharedPrefs.getUserId,
      "product_id": productId,
      "vendor_id": driverId,
      "qty": "",
      "delete": "1",
      "decrease": "0",
    };

    try {
      var responseList = await _vdApiProvider.post(
          herberiumUrlCall + apiAddToCart, addToCartMap);

      print(responseList["status"]);
      if (responseList["status"].toString() == "1") {
        apiCallState = NetworkApiCallState.completed(
            true, responseList["message"], responseList["status"].toString());
      } else {
        apiCallState = NetworkApiCallState.completed(
            true, responseList["message"], responseList["status"].toString());
      }
    } catch (Excep) {
      print('Exception  Call ${Excep.toString()}');
      if (Excep is CustomNetworkException) {
        apiCallState = NetworkApiCallState.error(
          Excep.message,
          "",
          Excep.errorType,
        );
      } else {
        apiCallState = NetworkApiCallState.error(
            "Unknown Error", "", NetworkErrorType.OTHER);
      }
    }

    return apiCallState;
  }

  Future<NetworkApiCallState<bool>> getViewCartListApiCall() async {
    NetworkApiCallState<bool> apiCallState;
    Map<String, dynamic> latlongMap = {"user_id": sharedPrefs.getUserId};

    try {
      String userid;
      if (sharedPrefs.getUserId == "") {
        userid = "0";
      } else {
        userid = sharedPrefs.getUserId;
      }

      // var responseList =
      //     await _vdApiProvider.post(herberiumUrlCall + apiCartList, latlongMap);
      var responseList = await _vdApiProvider.get(
          herberiumUrlCall + apiCartList + "/${userid}", false);
      _cartList = [];
      cartDataModel = DataCart();
      print("status" + responseList["status"].toString());
      if (responseList["status"] == 1) {
        CartViewReponseList1 cartViewReponseList =
            CartViewReponseList1.fromJson(responseList);
        cartDataModel = cartViewReponseList.data;
        _cartList = cartViewReponseList.data.items;
        apiCallState = NetworkApiCallState.completed(
            true,
            responseList["message"].toString(),
            responseList["status"].toString());
      } else {
        _cartList = [];
        apiCallState = NetworkApiCallState.completed(
            true,
            responseList["message"].toString(),
            responseList["status"].toString());
      }
    } catch (Excep) {
      print('Exception  Call ${Excep.toString()}');
      if (Excep is CustomNetworkException) {
        apiCallState =
            NetworkApiCallState.error(Excep.message, "", Excep.errorType);
      } else {
        apiCallState = NetworkApiCallState.error(
            "Unknown Error", "", NetworkErrorType.OTHER);
      }
    }

    return apiCallState;
  }

  Future<NetworkApiCallState<bool>> getViewCouponCodeApiCall(
      String driverId) async {
    NetworkApiCallState<bool> apiCallState;
    Map<String, dynamic> latlongMap = {"vendor_id": "2"};

    try {
      var responseList = await _vdApiProvider.get(herberiumUrlCall +
          apiCouponCodeList +
          "/${driverId}" +
          "/${sharedPrefs.getUserId}");

      print(responseList["status"]);
      if (responseList["status"].toString() == "1") {
        CouponCodeListModel couponModel =
            CouponCodeListModel.fromJson(responseList);
        couponlist = couponModel.couponlist;
        apiCallState = NetworkApiCallState.completed(
            true,
            responseList["message"].toString(),
            responseList["status"].toString());
      } else {
        couponlist = [];
        apiCallState = NetworkApiCallState.completed(
            true,
            responseList["message"].toString(),
            responseList["status"].toString());
      }
    } catch (Excep) {
      print('Exception  Call ${Excep.toString()}');
      if (Excep is CustomNetworkException) {
        apiCallState =
            NetworkApiCallState.error(Excep.message, "", Excep.errorType);
      } else {
        apiCallState = NetworkApiCallState.error(
            "Unknown Error", "", NetworkErrorType.OTHER);
      }
    }

    return apiCallState;
  }

  Future<NetworkApiCallState<bool>> getCheckOutCalculationApi(
      String driverId, String couponCode) async {
    NetworkApiCallState<bool> apiCallState;
    Map<String, dynamic> latlongMap = {
      "user_id": sharedPrefs.getUserId,
      "coupon_code": couponCode,
      "vendor_id": driverId
    };

    try {
      var responseList = await _vdApiProvider.post(
          herberiumUrlCall + apiDiscountCalculation, latlongMap);

      print(responseList["status"]);
      print(responseList.toString());
      if (responseList["status"].toString() == "1") {
        CheckOutResponseModel reponse =
            CheckOutResponseModel.fromJson(responseList);
        checkoutCalculation = reponse.data;
        apiCallState = NetworkApiCallState.completed(
            true,
            responseList["message"].toString(),
            responseList["status"].toString());
      } else {
        apiCallState = NetworkApiCallState.completed(
            true,
            responseList["message"].toString(),
            responseList["status"].toString());
      }
    } catch (Excep) {
      print('Exception  Call ${Excep.toString()}');
      if (Excep is CustomNetworkException) {
        apiCallState =
            NetworkApiCallState.error(Excep.message, "", Excep.errorType);
      } else {
        apiCallState = NetworkApiCallState.error(
            "Unknown Error", "", NetworkErrorType.OTHER);
      }
    }

    return apiCallState;
  }

  Future<NetworkApiCallState<bool>> getFilterListApi(
      String categoryId, String driverId) async {
    NetworkApiCallState<bool> apiCallState;
    Map<String, dynamic> latlongMap = {
      "category_id": categoryId,
      "driver_id": driverId
    };

    try {
      var responseList = await _vdApiProvider.post(
          herberiumUrlCall + apiFilterProduct, latlongMap);
      List<Subcategories> subcatList = [];
      print(responseList["status"]);
      if (responseList["status"].toString() == "1") {
        _filterListModel = FilterListModel.fromJson(responseList);

        apiCallState = NetworkApiCallState.completed(
            true,
            responseList["message"].toString(),
            responseList["status"].toString());
      } else {
        apiCallState = NetworkApiCallState.completed(
            true,
            responseList["message"].toString(),
            responseList["status"].toString());
      }
    } catch (Excep) {
      print('Exception  Call ${Excep.toString()}');
      if (Excep is CustomNetworkException) {
        apiCallState =
            NetworkApiCallState.error(Excep.message, "", Excep.errorType);
      } else {
        apiCallState = NetworkApiCallState.error(
            "Unknown Error", "", NetworkErrorType.OTHER);
      }
    }

    return apiCallState;
  }

  Future<NetworkApiCallState<bool>> postAddToCartApi(
      int quantity,
      int productId,
      String driverId,
      int decrease,
      String Changedriver,
      String specialInstruction) async {
    NetworkApiCallState<bool> apiCallState;
    Map<String, dynamic> addToCartMap = {
      "user_id": sharedPrefs.getUserId,
      "product_id": productId,
      "vendor_id": driverId,
      "qty": quantity,
      "delete": "",
      "decrease": decrease,
      "changedriver": Changedriver,
      "sinstruction": specialInstruction
    };

    try {
      var responseList = await _vdApiProvider.post(
          herberiumUrlCall + apiAddToCart, addToCartMap);

      print(responseList.toString());
      if (responseList["status"].toString() == "1") {
        sharedPrefs.setUserId = responseList["user_id"];
        isNewdriver = responseList["newdriver"].toString();
        apiCallState = NetworkApiCallState.completed(
            true, responseList["message"], responseList["status"].toString());
      } else {
        isNewdriver = "";
        apiCallState = NetworkApiCallState.completed(
            true, responseList["message"], responseList["status"].toString());
      }
    } catch (Excep) {
      print('Exception  Call ${Excep.toString()}');
      if (Excep is CustomNetworkException) {
        apiCallState = NetworkApiCallState.error(
          Excep.message,
          "",
          Excep.errorType,
        );
      } else {
        apiCallState = NetworkApiCallState.error(
            "Unknown Error", "", NetworkErrorType.OTHER);
      }
    }

    return apiCallState;
  }

  Future<NetworkApiCallState<bool>> postProductRatingReviewApi(
      String productId, String ratingCount, String reviewText) async {
    NetworkApiCallState<bool> apiCallState;
    Map<String, dynamic> addToCartMap = {
      "user_id": sharedPrefs.getUserId,
      "rating": ratingCount,
      "comment": reviewText,
      "product_id": productId,
    };

    try {
      var responseList = await _vdApiProvider.post(
          herberiumUrlCall + apiAddProductRating, addToCartMap);

      print(responseList["status"]);
      if (responseList["status"].toString() == "1") {
        apiCallState = NetworkApiCallState.completed(
            true, responseList["message"], responseList["status"].toString());
      } else {
        apiCallState = NetworkApiCallState.completed(
            true, responseList["message"], responseList["status"].toString());
      }
    } catch (Excep) {
      print('Exception  Call ${Excep.toString()}');
      if (Excep is CustomNetworkException) {
        apiCallState = NetworkApiCallState.error(
          Excep.message,
          "",
          Excep.errorType,
        );
      } else {
        apiCallState = NetworkApiCallState.error(
            "Unknown Error", "", NetworkErrorType.OTHER);
      }
    }

    return apiCallState;
  }

  Future<NetworkApiCallState<bool>> postMerchantRatingReviewApi(
      String driverId, String ratingCount, String reviewText) async {
    NetworkApiCallState<bool> apiCallState;
    Map<String, dynamic> addToCartMap = {
      "user_id": sharedPrefs.getUserId,
      "rating": ratingCount,
      "comment": reviewText,
      "merchant_id": driverId
    };

    try {
      var responseList = await _vdApiProvider.post(
          herberiumUrlCall + apiMerchantRating, addToCartMap);

      print(responseList["status"]);
      if (responseList["status"].toString() == "1") {
        apiCallState = NetworkApiCallState.completed(
            true, responseList["message"], responseList["status"].toString());
      } else {
        apiCallState = NetworkApiCallState.completed(
            true, responseList["message"], responseList["status"].toString());
      }
    } catch (Excep) {
      print('Exception  Call ${Excep.toString()}');
      if (Excep is CustomNetworkException) {
        apiCallState = NetworkApiCallState.error(
          Excep.message,
          "",
          Excep.errorType,
        );
      } else {
        apiCallState = NetworkApiCallState.error(
            "Unknown Error", "", NetworkErrorType.OTHER);
      }
    }

    return apiCallState;
  }

  Future<NetworkApiCallState<bool>> postReviewUserList(
      String productId, String pageCount) async {
    NetworkApiCallState<bool> apiCallState;
    Map<String, dynamic> addToCartMap = {
      "product_id": productId,
      "current_page": pageCount,
    };

    try {
      var responseList = await _vdApiProvider.post(
          herberiumUrlCall + apiRatingList, addToCartMap);

      print(responseList["status"]);
      if (responseList["status"].toString() == "1") {
        ReviewListModel ratingReviewModel =
            ReviewListModel.fromJson(responseList);
        ratingReviewDataArray = ratingReviewModel.data.ratingReviewData;
        apiCallState = NetworkApiCallState.completed(
            true, responseList["message"], responseList["status"].toString());
      } else {
        ratingReviewDataArray = [];
        apiCallState = NetworkApiCallState.completed(
            true, responseList["message"], responseList["status"].toString());
      }
    } catch (Excep) {
      print('Exception  Call ${Excep.toString()}');
      if (Excep is CustomNetworkException) {
        apiCallState = NetworkApiCallState.error(
          Excep.message,
          "",
          Excep.errorType,
        );
      } else {
        apiCallState = NetworkApiCallState.error(
            "Unknown Error", "", NetworkErrorType.OTHER);
      }
    }

    return apiCallState;
  }

  Future<NetworkApiCallState<bool>> postRelatedProductApi(
      String productId, String driverId, String categoryId) async {
    NetworkApiCallState<bool> apiCallState;
    Map<String, dynamic> addToCartMap = {
      "product_id": productId,
      "vendor_id": driverId,
      "category_id": categoryId,
    };

    try {
      var responseList = await _vdApiProvider.post(
          herberiumUrlCall + apiRelatedProduct, addToCartMap);

      print(responseList["status"]);
      if (responseList["status"].toString() == "1") {
        RelatedProductModel relatedProductModel =
            RelatedProductModel.fromJson(responseList);
        relatedProductList = relatedProductModel.data.relatedProductList;
        addonProductList = relatedProductModel.data.addonProductList;
        apiCallState = NetworkApiCallState.completed(
            true, responseList["message"], responseList["status"].toString());
      } else {
        relatedProductList = [];
        addonProductList = [];
        apiCallState = NetworkApiCallState.completed(
            true, responseList["message"], responseList["status"].toString());
      }
    } catch (Excep) {
      print('Exception  Call ${Excep.toString()}');
      if (Excep is CustomNetworkException) {
        apiCallState = NetworkApiCallState.error(
          Excep.message,
          "",
          Excep.errorType,
        );
      } else {
        apiCallState = NetworkApiCallState.error(
            "Unknown Error", "", NetworkErrorType.OTHER);
      }
    }

    return apiCallState;
  }

  Future<NetworkApiCallState<bool>> getStateListApi() async {
    NetworkApiCallState<bool> apiCallState;
    statesList = [];
    try {
      var responseList =
          await _vdApiProvider.get(herberiumUrlCall + apiStateList);

      print(responseList["status"]);
      if (responseList["status"].toString() == "1") {
        StateListModel stateListModel = StateListModel.fromJson(responseList);
        statesList = stateListModel.data.statesList;

        apiCallState = NetworkApiCallState.completed(
            true, responseList["message"], responseList["status"].toString());
      } else {
        apiCallState = NetworkApiCallState.completed(
            true, responseList["message"], responseList["status"].toString());
      }
    } catch (Excep) {
      print('Exception  Call ${Excep.toString()}');
      if (Excep is CustomNetworkException) {
        apiCallState = NetworkApiCallState.error(
          Excep.message,
          "",
          Excep.errorType,
        );
      } else {
        apiCallState = NetworkApiCallState.error(
            "Unknown Error", "", NetworkErrorType.OTHER);
      }
    }

    return apiCallState;
  }

  Future<NetworkApiCallState<bool>> postSubmitPaymentApiCall(
      {String payMethod,
      String mobile,
      String address,
      String city,
      String state,
      String zip,
      String comment,
      String cc_name,
      String creditcardtype,
      String cc_number,
      String cc_expiration,
      String cc_cvv,
      String cc_expire_month,
      String cc_expire_year,
      String promo_amount,
      String saletax,
      String excisetax,
      String citytax,
      String vendorId,
      String final_amount,
      String subTotal,
      String coupon_id,
      String device_type,
      String device_os_name}) async {
    NetworkApiCallState<bool> apiCallState;

    Map<String, dynamic> paymentParam = {
      "pmethodc": payMethod,
      "user_mob": mobile,
      "address": address,
      "city": city,
      "state": state,
      "zip": zip,
      "comment": comment,
      "cc_name": cc_name,
      "creditcardtype": creditcardtype,
      "cc_number": cc_number,
      "cc_expiration": cc_expiration,
      "cc_cvv": cc_cvv,
      "cc_expire_month": cc_expire_month,
      "cc_expire_year": cc_expire_year,
      "promo_amount": promo_amount,
      "saletax": saletax,
      "excisetax": excisetax,
      "citytax": citytax,
      "vendor_id": vendorId,
      "user_id": sharedPrefs.getUserId,
      "final_amount": final_amount,
      "coupon_id": coupon_id,
      "sub_total": subTotal,
      "device_type": device_type,
      "device_os_name": device_os_name
    };

    String jsonStr = jsonEncode(paymentParam);
    print('jsonMap = $jsonStr');
    try {
      var responseList = await _vdApiProvider.post(
          herberiumUrlCall + apiSubmitOrder, paymentParam);

      //  print(responseList["status"]);
      if (responseList["status"].toString() == "1") {
        orderId = responseList["order_id"].toString();
        apiCallState = NetworkApiCallState.completed(
            true, responseList["message"], responseList["status"].toString());
      } else {
        apiCallState = NetworkApiCallState.completed(
            true, responseList["message"], responseList["status"].toString());
      }
    } catch (Excep) {
      print('Exception  Call ${Excep.toString()}');
      if (Excep is CustomNetworkException) {
        apiCallState = NetworkApiCallState.error(
          Excep.message,
          "",
          Excep.errorType,
        );
      } else {
        apiCallState = NetworkApiCallState.error(
            "Unknown Error", "", NetworkErrorType.OTHER);
      }
    }

    return apiCallState;
  }

  String getOrderId() {
    return orderId == "" ? "" : orderId;
  }

  DriverList driverDetail;

  set saveDriverDetail(DriverList driverDetail) {
    this.driverDetail = driverDetail;
  }

  List<BitmapDescriptor> getPinLocationList() {
    return pinLocationIcon == "" ? null : pinLocationIcon;
  }

  String getBannerImage() {
    return strBannerImage == "" ? null : strBannerImage;
  }

  UserDetailResponseModel getUserDetailInfo() {
    return userDetailResponseModel == "" ? null : userDetailResponseModel;
  }

  DataResponse getCheckOutCalculation() {
    return checkoutCalculation == "" ? null : checkoutCalculation;
  }

  List<RelatedProductList> getRelatedProductList() {
    return relatedProductList == "" ? null : relatedProductList;
  }

  List<AddonProductList> getAddOnProductList() {
    return addonProductList == "" ? null : addonProductList;
  }

  List<StatesList> getStateArrayList() {
    return statesList == "" ? null : statesList;
  }

  List<RatingReviewData> getRatingReviewList() {
    return ratingReviewDataArray == "" ? null : ratingReviewDataArray;
  }

  List<OrderDetail> getOrderDetailData() {
    return orderDetail == "" ? null : orderDetail;
  }

  List<Vendor1> getVendorDetailData() {
    return vendorData == "" ? null : vendorData;
  }

  List<OrderItems> getOrderDetailMenuItem() {
    return orderItems == "" ? null : orderItems;
  }

  List<Couponlist> getCouponArrayList() {
    return couponlist == "" ? 0 : couponlist;
  }

  UserDetail getUserDetail() {
    return _userDetail == null ? null : _userDetail;
  }

  List<VendorLatlng> getVendorLatLong() {
    return _vendorLatLong == null ? null : _vendorLatLong;
  }

  NotificationDetail getNotificationDataList() {
    return notificationDetail == "" ? null : notificationDetail;
  }

  DriverList getDriverDetails() {
    return driverDetail == "" ? null : driverDetail;
  }

  String getUpdatedCartCount() {
    return cartCount == "" ? 0 : cartCount;
  }

  List<ItemsCart> getCartDataListArray() {
    return _cartList == null ? null : _cartList;
  }

  List<HistoryList> getOrderHistory() {
    return _orderHistoryItem == null ? null : _orderHistoryItem;
  }

  DataCart getCartDataModel() {
    return cartDataModel == null ? null : cartDataModel;
  }

  List<CategoryListModel> getCategoryListArray() {
    return categortList == null ? null : categortList;
  }

  List<DriverList> getDriverListArray() {
    return _driverList == null ? null : _driverList;
  }

  List<Advertisement> getAdvertisementArray() {
    return _advertisement == null ? [] : _advertisement;
  }

  List<ProductListDriver> getDriverProductListArray() {
    return _driverProductList == null ? null : _driverProductList;
  }

  List<ProductListMenu> getProductListArray() {
    return _productList == null ? null : _productList;
  }

  FilterListModel getFilterData() {
    return _filterListModel == null ? null : _filterListModel;
  }
}
