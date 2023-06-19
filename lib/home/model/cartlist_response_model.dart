class CartViewReponseList1 {
 late String message;
 late int status;
 late DataCart data;

  CartViewReponseList1({required this.message,required this.status,required this.data});

  CartViewReponseList1.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = (json['data'] != null ? new DataCart.fromJson(json['data']) : null)!;
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

class DataCart {
 late String salesTax;
 late  String exciseTax;
 late String cityTax;
 late String subtotal;
 late  String grandtotal;
 late  String vendor_id;
 late  List<ItemsCart> items;

  DataCart(
      {required this.salesTax,
        required  this.exciseTax,
        required this.cityTax,
        required  this.subtotal,
        required  this.grandtotal,
        required  this.items,
        required  this.vendor_id});

  DataCart.fromJson(Map<String, dynamic> json) {
    vendor_id = json['vendor_id'];
    salesTax = json['sales_tax'];
    exciseTax = json['excise_tax'];
    cityTax = json['city_tax'];
    subtotal = json['subtotal'];
    grandtotal = json['grandtotal'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items.add(new ItemsCart.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor_id'] = this.vendor_id;
    data['sales_tax'] = this.salesTax;
    data['excise_tax'] = this.exciseTax;
    data['city_tax'] = this.cityTax;
    data['subtotal'] = this.subtotal;
    data['grandtotal'] = this.grandtotal;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class ItemsCart {
  late int id;
  late String vendorId;
  late String adminProductId;
  late String type;
  late String categoryId;
  late String subCategoryId;
  late  String avgRating;
  late String ratingCount;
  late String name;
  late String slug;
  late String description;
  late String price;
  late String quantity;
  late String unit;
  late String brands;
  late  String types;
  late  String potencyThc;
  late  String potencyCbd;
  late  String image;
  late  String keyword;
  late String productCode;
  late String status;
  late String loginStatus;
  late String stock;
  late  String popular;
  late String createdAt;
  late  String updatedAt;
  late String categoryname;
  late String imageURL;
  late String subcategoryname;

  late  String totalprice;
  late  VendorDetailCart vendor;

  ItemsCart(
      {required this.id,
        required  this.vendorId,
        required  this.adminProductId,
        required this.type,
        required this.categoryId,
        required this.subCategoryId,
        required this.avgRating,
        required this.ratingCount,
        required this.name,
        required this.slug,
        required  this.description,
        required  this.price,
        required  this.quantity,
        required   this.unit,
        required   this.brands,
        required   this.types,
        required   this.potencyThc,
        required  this.potencyCbd,
        required   this.image,
        required   this.keyword,
        required   this.productCode,
        required  this.status,
        required  this.loginStatus,
        required  this.stock,
        required    this.popular,
        required   this.createdAt,
        required  this.updatedAt,
        required  this.categoryname,
        required   this.imageURL,
        required  this.subcategoryname,
        required  this.totalprice,
        required    this.vendor});

  ItemsCart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    adminProductId = json['admin_product_id'];
    type = json['type'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    avgRating = json['avg_rating'];
    ratingCount = json['rating_count'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    price = json['price'];
    quantity = json['quantity'];
    unit = json['unit'];
    brands = json['brands']??"";
    types = json['types']??"";
    potencyThc = json['potency_thc']??"";
    potencyCbd = json['potency_cbd']??"";
    image = json['image'];
    keyword = json['keyword']??"";
    productCode = json['product_code'];
    status = json['status'];
    loginStatus = json['login_status'];
    stock = json['stock'];
    popular = json['popular'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryname = json['categoryname'];
    imageURL = json['ImageURL'];
    subcategoryname = json['subcategoryname'];

    totalprice = json['totalprice'];
    vendor = (json['Vendor'] != null
        ? new VendorDetailCart.fromJson(json['Vendor'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['admin_product_id'] = this.adminProductId;
    data['type'] = this.type;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['avg_rating'] = this.avgRating;
    data['rating_count'] = this.ratingCount;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['unit'] = this.unit;
    data['brands'] = this.brands;
    data['types'] = this.types;
    data['potency_thc'] = this.potencyThc;
    data['potency_cbd'] = this.potencyCbd;
    data['image'] = this.image;
    data['keyword'] = this.keyword;
    data['product_code'] = this.productCode;
    data['status'] = this.status;
    data['login_status'] = this.loginStatus;
    data['stock'] = this.stock;
    data['popular'] = this.popular;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['categoryname'] = this.categoryname;
    data['ImageURL'] = this.imageURL;
    data['subcategoryname'] = this.subcategoryname;

    data['totalprice'] = this.totalprice;
    if (this.vendor != null) {
      data['Vendor'] = this.vendor.toJson();
    }
    return data;
  }
}

class VendorDetailCart {
 late int vendorId;
 late  String uniqueId;
 late String name;
 late String username;
 late String lastName;
 late String businessName;
 late String email;
 late  String mailingAddress;
 late String address;
 late String avgRating;
 late String ratingCount;
 late String lat;
 late String lng;
 late String address1;
 late  String suburb;
 late String state;
 late  String city;
 late  String zipcode;
 late String mobNo;
 late String vendorStatus;
 late  String loginStatus;
 late String vendorType;
 late String walletAmount;
 late  String deviceid;
 late String devicetype;
 late  String marketArea;
 late String serviceRadius;
 late String driverLicense;
 late String licenseExpiry;
 late String licenseFront;
 late  String licenseBack;
 late  String ssn;
 late  String dob;
 late String profileImg1;
 late String profileImg2;
 late  String profileImg3;
 late String profileImg4;
 late String type;
 late String categoryId;
 late String subCategoryId;
 late String service;
 late String permitType;
 late String permitNumber;
 late String permitExpiry;
 late  String description;
 late String otp;
 late  String forgetpassRequest;
 late  String forgetpassRequestStatus;
 late  String planId;
 late String planPurchased;
 late String planExpiry;
 late String txnId;
 late String createdAt;
 late  String updatedAt;
 late  String stripeId;
 late  String make;
 late String model;
 late String color;
 late  String year;
 late  String licensePlate;
 late  String views;
 late  String salesTax;
 late  String exciseTax;
 late  String cityTax;
 late  String commissionRate;
 late  String deliveryFee;
 late String licensefrontURL;
 late String licensebackURL;
 late  String profileURL;
 late  String profile2URL;
 late  String profile3URL;
 late  String profile4URL;
 late  Membership membership;
 late  String fullname;
 late  String category;

  VendorDetailCart({
   required this.vendorId,
    required   this.uniqueId,
    required  this.name,
    required  this.username,
    required this.lastName,
    required  this.businessName,
    required  this.email,
    required  this.mailingAddress,
    required  this.address,
    required this.avgRating,
    required this.ratingCount,
    required  this.lat,
    required   this.lng,
    required this.address1,
    required  this.suburb,
    required  this.state,
    required  this.city,
    required  this.zipcode,
    required this.mobNo,
    required  this.vendorStatus,
    required  this.loginStatus,
    required this.vendorType,
    required this.walletAmount,
    required  this.deviceid,
    required  this.devicetype,
    required  this.marketArea,
    required this.serviceRadius,
    required  this.driverLicense,
    required  this.licenseExpiry,
    required   this.licenseFront,
    required  this.licenseBack,
    required this.ssn,
    required this.dob,
    required this.profileImg1,
    required this.profileImg2,
    required this.profileImg3,
    required  this.profileImg4,
    required  this.type,
    required  this.categoryId,
    required  this.subCategoryId,
    required this.service,
    required  this.permitType,
    required  this.permitNumber,
    required this.permitExpiry,
    required  this.description,
    required   this.otp,
    required  this.forgetpassRequest,
    required  this.forgetpassRequestStatus,
    required  this.planId,
    required  this.planPurchased,
    required  this.planExpiry,
    required   this.txnId,
    required  this.createdAt,
    required  this.updatedAt,
    required  this.stripeId,
    required  this.make,
    required  this.model,
    required  this.color,
    required  this.year,
    required  this.licensePlate,
    required  this.views,
    required  this.salesTax,
    required  this.exciseTax,
    required  this.cityTax,
    required this.commissionRate,
    required  this.deliveryFee,
    required  this.licensefrontURL,
    required  this.licensebackURL,
    required  this.profileURL,
    required  this.profile2URL,
    required   this.profile3URL,
    required  this.profile4URL,
    required  this.membership,
    required  this.fullname,
    required  this.category,
  });

  VendorDetailCart.fromJson(Map<String, dynamic> json) {
    vendorId = json['vendor_id'];
    uniqueId = json['unique_id'];
    name = json['name'];
    username = json['username'];
    lastName = json['last_name'];
    businessName = json['business_name'];
    email = json['email'];
    mailingAddress = json['mailing_address'];
    address = json['address'];
    avgRating = json['avg_rating'];
    ratingCount = json['rating_count'];
    lat = json['lat'];
    lng = json['lng'];
    address1 = json['address1'];
    suburb = json['suburb'];
    state = json['state'];
    city = json['city'];
    zipcode = json['zipcode'];
    mobNo = json['mob_no'];
    vendorStatus = json['vendor_status'];
    loginStatus = json['login_status'];
    vendorType = json['vendor_type'];
    walletAmount = json['wallet_amount'];
    deviceid = json['deviceid'];
    devicetype = json['devicetype'];
    marketArea = json['market_area'];
    serviceRadius = json['service_radius'];
    driverLicense = json['driver_license'];
    licenseExpiry = json['license_expiry'];
    licenseFront = json['license_front'];
    licenseBack = json['license_back'];
    ssn = json['ssn'];
    dob = json['dob'];
    profileImg1 = json['profile_img1'];
    profileImg2 = json['profile_img2'];
    profileImg3 = json['profile_img3'];
    profileImg4 = json['profile_img4'];
    type = json['type'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    service = json['service'];
    permitType = json['permit_type'];
    permitNumber = json['permit_number'];
    permitExpiry = json['permit_expiry'];
    description = json['description'];
    otp = json['otp'];
    forgetpassRequest = json['forgetpass_request'];
    forgetpassRequestStatus = json['forgetpass_request_status'];
    planId = json['plan_id'];
    planPurchased = json['plan_purchased'];
    planExpiry = json['plan_expiry'];
    txnId = json['txn_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    stripeId = json['stripe_id'];
    make = json['make'];
    model = json['model'];
    color = json['color'];
    year = json['year'];
    licensePlate = json['license_plate'];
    views = json['views'];
    salesTax = json['sales_tax'];
    exciseTax = json['excise_tax'];
    cityTax = json['city_tax'];
    commissionRate = json['commission_rate'];
    deliveryFee = json['delivery_fee'];
    licensefrontURL = json['licensefrontURL'];
    licensebackURL = json['licensebackURL'];
    profileURL = json['profileURL'];
    profile2URL = json['profile2URL'];
    profile3URL = json['profile3URL'];
    profile4URL = json['profile4URL'];
    membership = (json['membership'] != null
        ? new Membership.fromJson(json['membership'])
        : null)!;
    fullname = json['fullname'];
    category = json['Category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor_id'] = this.vendorId;
    data['unique_id'] = this.uniqueId;
    data['name'] = this.name;
    data['username'] = this.username;
    data['last_name'] = this.lastName;
    data['business_name'] = this.businessName;
    data['email'] = this.email;
    data['mailing_address'] = this.mailingAddress;
    data['address'] = this.address;
    data['avg_rating'] = this.avgRating;
    data['rating_count'] = this.ratingCount;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['address1'] = this.address1;
    data['suburb'] = this.suburb;
    data['state'] = this.state;
    data['city'] = this.city;
    data['zipcode'] = this.zipcode;
    data['mob_no'] = this.mobNo;
    data['vendor_status'] = this.vendorStatus;
    data['login_status'] = this.loginStatus;
    data['vendor_type'] = this.vendorType;
    data['wallet_amount'] = this.walletAmount;
    data['deviceid'] = this.deviceid;
    data['devicetype'] = this.devicetype;
    data['market_area'] = this.marketArea;
    data['service_radius'] = this.serviceRadius;
    data['driver_license'] = this.driverLicense;
    data['license_expiry'] = this.licenseExpiry;
    data['license_front'] = this.licenseFront;
    data['license_back'] = this.licenseBack;
    data['ssn'] = this.ssn;
    data['dob'] = this.dob;
    data['profile_img1'] = this.profileImg1;
    data['profile_img2'] = this.profileImg2;
    data['profile_img3'] = this.profileImg3;
    data['profile_img4'] = this.profileImg4;
    data['type'] = this.type;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['service'] = this.service;
    data['permit_type'] = this.permitType;
    data['permit_number'] = this.permitNumber;
    data['permit_expiry'] = this.permitExpiry;
    data['description'] = this.description;
    data['otp'] = this.otp;
    data['forgetpass_request'] = this.forgetpassRequest;
    data['forgetpass_request_status'] = this.forgetpassRequestStatus;
    data['plan_id'] = this.planId;
    data['plan_purchased'] = this.planPurchased;
    data['plan_expiry'] = this.planExpiry;
    data['txn_id'] = this.txnId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['stripe_id'] = this.stripeId;
    data['make'] = this.make;
    data['model'] = this.model;
    data['color'] = this.color;
    data['year'] = this.year;
    data['license_plate'] = this.licensePlate;
    data['views'] = this.views;
    data['sales_tax'] = this.salesTax;
    data['excise_tax'] = this.exciseTax;
    data['city_tax'] = this.cityTax;
    data['commission_rate'] = this.commissionRate;
    data['delivery_fee'] = this.deliveryFee;
    data['licensefrontURL'] = this.licensefrontURL;
    data['licensebackURL'] = this.licensebackURL;
    data['profileURL'] = this.profileURL;
    data['profile2URL'] = this.profile2URL;
    data['profile3URL'] = this.profile3URL;
    data['profile4URL'] = this.profile4URL;
    if (this.membership != null) {
      data['membership'] = this.membership.toJson();
    }
    data['fullname'] = this.fullname;
    data['Category'] = this.category;

    return data;
  }
}

class Membership {
late  int remainingDays;
 late int status;

  Membership({required this.remainingDays,required this.status});

  Membership.fromJson(Map<String, dynamic> json) {
    remainingDays = json['remainingDays'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['remainingDays'] = this.remainingDays;
    data['status'] = this.status;
    return data;
  }
}

class UserInfo {
 late String id;
 late String token;
 late String name;
 late String lname;
 late  String email;
 late String password;
 late String profileImage;
 late String licenseFront;
 late String licenseBack;
 late String oauthProvider;
 late String oauthId;
 late String userMob;
 late String userAddress;
 late String userCity;
 late String userStates;
 late String userZipcode;
 late String walletAmount;
 late  String userLat;
 late  String userLong;
 late String avgRating;
 late String ratingCount;
 late String isAdmin;
 late String rememberToken;
 late String userStatus;
 late String userPass;
 late String deviceid;
 late String devicetype;
 late String carrierId;
 late  String carrierName;
 late String carrierEmail;
 late String apiToken;
 late String userRole;
 late String userFbid;
 late String userGpid;
 late String restrictions;
 late String userOtp;
 late  String checkoutVerificaiton;
 late String logId;
 late String dob;
 late String emailVerifiedAt;
 late String createdAt;
 late String updatedAt;
 late String stripeId;
 late String cardBrand;
 late String cardLastFour;
 late  String trialEndsAt;
 late  String devicetoken;
 late  String osName;
 late  String emailNotification;
 late  String notification;
 late String smsNotification;

  UserInfo(
      {required this.id,
        required this.token,
        required this.name,
        required  this.lname,
        required  this.email,
        required  this.password,
        required   this.profileImage,
        required  this.licenseFront,
        required   this.licenseBack,
        required  this.oauthProvider,
        required  this.oauthId,
        required  this.userMob,
        required  this.userAddress,
        required  this.userCity,
        required this.userStates,
        required  this.userZipcode,
        required  this.walletAmount,
        required  this.userLat,
        required  this.userLong,
        required  this.avgRating,
        required this.ratingCount,
        required  this.isAdmin,
        required   this.rememberToken,
        required   this.userStatus,
        required  this.userPass,
        required   this.deviceid,
        required  this.devicetype,
        required   this.carrierId,
        required   this.carrierName,
        required   this.carrierEmail,
        required   this.apiToken,
        required   this.userRole,
        required   this.userFbid,
        required  this.userGpid,
        required   this.restrictions,
        required    this.userOtp,
        required  this.checkoutVerificaiton,
        required   this.logId,
        required   this.dob,
        required    this.emailVerifiedAt,
        required   this.createdAt,
        required  this.updatedAt,
        required   this.stripeId,
        required this.cardBrand,
        required  this.cardLastFour,
        required  this.trialEndsAt,
        required  this.devicetoken,
        required   this.osName,
        required   this.emailNotification,
        required   this.notification,
        required   this.smsNotification});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
    name = json['name'];
    lname = json['lname'];
    email = json['email'];
    password = json['password'];
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
    rememberToken = json['remember_token'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['token'] = this.token;
    data['name'] = this.name;
    data['lname'] = this.lname;
    data['email'] = this.email;
    data['password'] = this.password;
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
    data['remember_token'] = this.rememberToken;
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
    return data;
  }
}
