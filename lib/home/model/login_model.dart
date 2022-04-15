class LoginModel {
  String message;
  int status;
  UserData data;

  LoginModel({this.message, this.status, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class UserData {
  UserDetail userDetail;
  List<OtpDetail> otpDetail;

  UserData({this.userDetail, this.otpDetail});

  UserData.fromJson(Map<String, dynamic> json) {
    userDetail = json['user_detail'] != null
        ? UserDetail.fromJson(json['user_detail'])
        : null;
    if (json['otp_detail'] != null) {
      otpDetail = [];
      json['otp_detail'].forEach((v) {
        otpDetail.add(new OtpDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userDetail != null) {
      data['user_detail'] = this.userDetail.toJson();
    }
    if (this.otpDetail != null) {
      data['otp_detail'] = this.otpDetail.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserDetail {
  int id;
  String token;
  String name;
  String lname;
  String email;
  String profileImage;
  String licenseFront;
  String licenseBack;
  String oauthProvider;
  String oauthId;
  String userMob;
  String userAddress;
  String userCity;
  String userStates;
  String userZipcode;
  String walletAmount;
  String userLat;
  String userLong;
  String avgRating;
  String ratingCount;
  String isAdmin;
  String userStatus;
  String userPass;
  String deviceid;
  String devicetype;
  String carrierId;
  String carrierName;
  String carrierEmail;
  String apiToken;
  String userRole;
  String userFbid;
  String userGpid;
  String restrictions;
  String userOtp;
  String checkoutVerificaiton;
  String logId;
  String dob;
  String emailVerifiedAt;
  String createdAt;
  String updatedAt;
  String stripeId;
  String cardBrand;
  String cardLastFour;
  String trialEndsAt;
  String devicetoken;
  String osName;
  String emailNotification;
  String notification;
  String smsNotification;
  String profileURL;
  String licenseFrontURL;
  String licenseBackURL;

  UserDetail(
      {this.id,
      this.token,
      this.name,
      this.lname,
      this.email,
      this.profileImage,
      this.licenseFront,
      this.licenseBack,
      this.oauthProvider,
      this.oauthId,
      this.userMob,
      this.userAddress,
      this.userCity,
      this.userStates,
      this.userZipcode,
      this.walletAmount,
      this.userLat,
      this.userLong,
      this.avgRating,
      this.ratingCount,
      this.isAdmin,
      this.userStatus,
      this.userPass,
      this.deviceid,
      this.devicetype,
      this.carrierId,
      this.carrierName,
      this.carrierEmail,
      this.apiToken,
      this.userRole,
      this.userFbid,
      this.userGpid,
      this.restrictions,
      this.userOtp,
      this.checkoutVerificaiton,
      this.logId,
      this.dob,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.stripeId,
      this.cardBrand,
      this.cardLastFour,
      this.trialEndsAt,
      this.devicetoken,
      this.osName,
      this.emailNotification,
      this.notification,
      this.smsNotification,
      this.profileURL,
      this.licenseFrontURL,
      this.licenseBackURL});

  UserDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
    name = json['name'];
    lname = json['lname'];
    email = json['email'];
    profileImage = json['profile_image'];
    licenseFront = json['license_front'];
    licenseBack = json['license_back'];
    oauthProvider = json['oauth_provider'];
    oauthId = json['oauth_id'];
    userMob = json['user_mob'];
    userAddress = json['user_address'];
    userCity = json['user_city'];
    userStates = json['user_states'];
    userZipcode = json['user_zipcode'];
    walletAmount = json['wallet_amount'];
    userLat = json['user_lat'];
    userLong = json['user_long'];
    avgRating = json['avg_rating'];
    ratingCount = json['rating_count'];
    isAdmin = json['is_admin'];
    userStatus = json['user_status'];
    userPass = json['user_pass'];
    deviceid = json['deviceid'];
    devicetype = json['devicetype'];
    carrierId = json['carrier_id'];
    carrierName = json['carrier_name'];
    carrierEmail = json['carrier_email'];
    apiToken = json['api_token'];
    userRole = json['user_role'];
    userFbid = json['user_fbid'];
    userGpid = json['user_gpid'];
    restrictions = json['restrictions'];
    userOtp = json['user_otp'];
    checkoutVerificaiton = json['checkout_verificaiton'];
    logId = json['log_id'];
    dob = json['dob'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    stripeId = json['stripe_id'];
    cardBrand = json['card_brand'];
    cardLastFour = json['card_last_four'];
    trialEndsAt = json['trial_ends_at'];
    devicetoken = json['devicetoken'];
    osName = json['os_name'];
    emailNotification = json['email_notification'];
    notification = json['notification'];
    smsNotification = json['sms_notification'];
    profileURL = json['ProfileURL'];
    licenseFrontURL = json['LicenseFrontURL'];
    licenseBackURL = json['LicenseBackURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['token'] = this.token;
    data['name'] = this.name;
    data['lname'] = this.lname;
    data['email'] = this.email;
    data['profile_image'] = this.profileImage;
    data['license_front'] = this.licenseFront;
    data['license_back'] = this.licenseBack;
    data['oauth_provider'] = this.oauthProvider;
    data['oauth_id'] = this.oauthId;
    data['user_mob'] = this.userMob;
    data['user_address'] = this.userAddress;
    data['user_city'] = this.userCity;
    data['user_states'] = this.userStates;
    data['user_zipcode'] = this.userZipcode;
    data['wallet_amount'] = this.walletAmount;
    data['user_lat'] = this.userLat;
    data['user_long'] = this.userLong;
    data['avg_rating'] = this.avgRating;
    data['rating_count'] = this.ratingCount;
    data['is_admin'] = this.isAdmin;
    data['user_status'] = this.userStatus;
    data['user_pass'] = this.userPass;
    data['deviceid'] = this.deviceid;
    data['devicetype'] = this.devicetype;
    data['carrier_id'] = this.carrierId;
    data['carrier_name'] = this.carrierName;
    data['carrier_email'] = this.carrierEmail;
    data['api_token'] = this.apiToken;
    data['user_role'] = this.userRole;
    data['user_fbid'] = this.userFbid;
    data['user_gpid'] = this.userGpid;
    data['restrictions'] = this.restrictions;
    data['user_otp'] = this.userOtp;
    data['checkout_verificaiton'] = this.checkoutVerificaiton;
    data['log_id'] = this.logId;
    data['dob'] = this.dob;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['stripe_id'] = this.stripeId;
    data['card_brand'] = this.cardBrand;
    data['card_last_four'] = this.cardLastFour;
    data['trial_ends_at'] = this.trialEndsAt;
    data['devicetoken'] = this.devicetoken;
    data['os_name'] = this.osName;
    data['email_notification'] = this.emailNotification;
    data['notification'] = this.notification;
    data['sms_notification'] = this.smsNotification;
    data['ProfileURL'] = this.profileURL;
    data['LicenseFrontURL'] = this.licenseFrontURL;
    data['LicenseBackURL'] = this.licenseBackURL;
    return data;
  }
}

class OtpDetail {
  String otpId;
  String userId;
  String guestId;
  String otpFor;
  String userMob;
  String userEmail;
  String otpNumber;
  String createdAt;
  String updatedAt;

  OtpDetail(
      {this.otpId,
      this.userId,
      this.guestId,
      this.otpFor,
      this.userMob,
      this.userEmail,
      this.otpNumber,
      this.createdAt,
      this.updatedAt});

  OtpDetail.fromJson(Map<String, dynamic> json) {
    otpId = json['otp_id'];
    userId = json['user_id'];
    guestId = json['guest_id'];
    otpFor = json['otp_for'];
    userMob = json['user_mob'];
    userEmail = json['user_email'];
    otpNumber = json['otp_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otp_id'] = this.otpId;
    data['user_id'] = this.userId;
    data['guest_id'] = this.guestId;
    data['otp_for'] = this.otpFor;
    data['user_mob'] = this.userMob;
    data['user_email'] = this.userEmail;
    data['otp_number'] = this.otpNumber;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
