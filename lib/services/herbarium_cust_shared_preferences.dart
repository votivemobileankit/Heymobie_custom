import 'package:shared_preferences/shared_preferences.dart';

const String _keyisAgeAbove21 = "_keyisAgeAbove21";

const String _keyLatitude = "_keyLatitude";
const String _keyLongitude = "_keyLongitude";
const String _keyUserId = "_keyUserId";
const String _keyCartCount = "_keyCartCount";
const String _keyIsLogin = "_keyIsLogin";
const String _keyUserName = "_keyUserName";
const String _keyUserProfileImage = "_keyUserProfileImage";
const String _keyUserComment = "_keyUserComment";

final sharedPrefs = HerbariumCustSharedPreference();

class HerbariumCustSharedPreference {
  static SharedPreferences? _sharedPrefs;

  init() async {
    if (_sharedPrefs == null) {
      _sharedPrefs = await SharedPreferences.getInstance();
    }
  }

  set setCartCount(String cartCount) {
    _sharedPrefs?.setString(_keyCartCount, cartCount);
  }

  String get getCartCount => _sharedPrefs?.getString(_keyCartCount) ?? "0";

  bool get isLogin => _sharedPrefs?.getBool(_keyIsLogin) ?? false;

  set isLogin(bool IsLogin) {
    _sharedPrefs?.setBool(_keyIsLogin, IsLogin);
  }

  set setUserId(String UserId) {
    _sharedPrefs?.setString(_keyUserId, UserId);
  }

  String get getUserProfileImage =>
      _sharedPrefs?.getString(_keyUserProfileImage) ?? "";

  set setUserProfileImage(String userImage) {
    _sharedPrefs?.setString(_keyUserProfileImage, userImage);
  }

  String get getUserName => _sharedPrefs?.getString(_keyUserName) ?? "";

  set setUserName(String userName) {
    _sharedPrefs?.setString(_keyUserName, userName);
  }

  String get getUserComment => _sharedPrefs?.getString(_keyUserComment) ?? "";

  set setUserComment(String userComment) {
    _sharedPrefs?.setString(_keyUserComment, userComment);
  }

  String get getUserId => _sharedPrefs?.getString(_keyUserId) ?? "";

  // set isAgeAbove21(bool isAgeAbove21) {
  //   _sharedPrefs?.setBool(_keyisAgeAbove21, isAgeAbove21);
  // }
  //
  // bool get isAgeAbove21 => _sharedPrefs?.getBool(_keyisAgeAbove21) ?? false;

  double get keyLatitude => _sharedPrefs?.getDouble(_keyLatitude) ?? 0.0;

  double get keyLongitude => _sharedPrefs?.getDouble(_keyLongitude) ?? 0.0;

  set keyLatitude(double latitude) {
    _sharedPrefs?.setDouble(_keyLatitude, latitude);
  }

  set keyLongitude(double longitude) {
    _sharedPrefs?.setDouble(_keyLongitude, longitude);
  }

  void resetPreferences() {
    // _sharedPrefs?.remove(_keyisAgeAbove21);
    _sharedPrefs?.remove(_keyUserId);
    _sharedPrefs?.remove(_keyIsLogin);
    _sharedPrefs?.remove(_keyUserName);
    _sharedPrefs?.remove(_keyUserProfileImage);
  }
}
