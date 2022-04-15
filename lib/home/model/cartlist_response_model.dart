class CartViewReponseList1 {
  String message;
  int status;
  DataCart data;

  CartViewReponseList1({this.message, this.status, this.data});

  CartViewReponseList1.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new DataCart.fromJson(json['data']) : null;
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
  String salesTax;
  String exciseTax;
  String cityTax;
  String subtotal;
  String grandtotal;
  String vendor_id;
  List<ItemsCart> items;

  DataCart(
      {this.salesTax,
      this.exciseTax,
      this.cityTax,
      this.subtotal,
      this.grandtotal,
      this.items,
      this.vendor_id});

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
  int id;
  String vendorId;
  String adminProductId;
  String type;
  String categoryId;
  String subCategoryId;
  String avgRating;
  String ratingCount;
  String name;
  String slug;
  String description;
  String price;
  String quantity;
  String unit;
  String brands;
  String types;
  String potencyThc;
  String potencyCbd;
  String image;
  String keyword;
  String productCode;
  String status;
  String loginStatus;
  String stock;
  String popular;
  String createdAt;
  String updatedAt;
  String categoryname;
  String imageURL;
  String subcategoryname;

  String totalprice;
  VendorDetailCart vendor;

  ItemsCart(
      {this.id,
      this.vendorId,
      this.adminProductId,
      this.type,
      this.categoryId,
      this.subCategoryId,
      this.avgRating,
      this.ratingCount,
      this.name,
      this.slug,
      this.description,
      this.price,
      this.quantity,
      this.unit,
      this.brands,
      this.types,
      this.potencyThc,
      this.potencyCbd,
      this.image,
      this.keyword,
      this.productCode,
      this.status,
      this.loginStatus,
      this.stock,
      this.popular,
      this.createdAt,
      this.updatedAt,
      this.categoryname,
      this.imageURL,
      this.subcategoryname,
      this.totalprice,
      this.vendor});

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
    brands = json['brands'];
    types = json['types'];
    potencyThc = json['potency_thc'];
    potencyCbd = json['potency_cbd'];
    image = json['image'];
    keyword = json['keyword'];
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
    vendor = json['Vendor'] != null
        ? new VendorDetailCart.fromJson(json['Vendor'])
        : null;
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
  int vendorId;
  String uniqueId;
  String name;
  String username;
  String lastName;
  String businessName;
  String email;
  String mailingAddress;
  String address;
  String avgRating;
  String ratingCount;
  String lat;
  String lng;
  String address1;
  String suburb;
  String state;
  String city;
  String zipcode;
  String mobNo;
  String vendorStatus;
  String loginStatus;
  String vendorType;
  String walletAmount;
  String deviceid;
  String devicetype;
  String marketArea;
  String serviceRadius;
  String driverLicense;
  String licenseExpiry;
  String licenseFront;
  String licenseBack;
  String ssn;
  String dob;
  String profileImg1;
  String profileImg2;
  String profileImg3;
  String profileImg4;
  String type;
  String categoryId;
  String subCategoryId;
  String service;
  String permitType;
  String permitNumber;
  String permitExpiry;
  String description;
  String otp;
  String forgetpassRequest;
  String forgetpassRequestStatus;
  String planId;
  String planPurchased;
  String planExpiry;
  String txnId;
  String createdAt;
  String updatedAt;
  String stripeId;
  String make;
  String model;
  String color;
  String year;
  String licensePlate;
  String views;
  String salesTax;
  String exciseTax;
  String cityTax;
  String commissionRate;
  String deliveryFee;
  String licensefrontURL;
  String licensebackURL;
  String profileURL;
  String profile2URL;
  String profile3URL;
  String profile4URL;
  Membership membership;
  String fullname;
  String category;

  VendorDetailCart({
    this.vendorId,
    this.uniqueId,
    this.name,
    this.username,
    this.lastName,
    this.businessName,
    this.email,
    this.mailingAddress,
    this.address,
    this.avgRating,
    this.ratingCount,
    this.lat,
    this.lng,
    this.address1,
    this.suburb,
    this.state,
    this.city,
    this.zipcode,
    this.mobNo,
    this.vendorStatus,
    this.loginStatus,
    this.vendorType,
    this.walletAmount,
    this.deviceid,
    this.devicetype,
    this.marketArea,
    this.serviceRadius,
    this.driverLicense,
    this.licenseExpiry,
    this.licenseFront,
    this.licenseBack,
    this.ssn,
    this.dob,
    this.profileImg1,
    this.profileImg2,
    this.profileImg3,
    this.profileImg4,
    this.type,
    this.categoryId,
    this.subCategoryId,
    this.service,
    this.permitType,
    this.permitNumber,
    this.permitExpiry,
    this.description,
    this.otp,
    this.forgetpassRequest,
    this.forgetpassRequestStatus,
    this.planId,
    this.planPurchased,
    this.planExpiry,
    this.txnId,
    this.createdAt,
    this.updatedAt,
    this.stripeId,
    this.make,
    this.model,
    this.color,
    this.year,
    this.licensePlate,
    this.views,
    this.salesTax,
    this.exciseTax,
    this.cityTax,
    this.commissionRate,
    this.deliveryFee,
    this.licensefrontURL,
    this.licensebackURL,
    this.profileURL,
    this.profile2URL,
    this.profile3URL,
    this.profile4URL,
    this.membership,
    this.fullname,
    this.category,
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
    membership = json['membership'] != null
        ? new Membership.fromJson(json['membership'])
        : null;
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
  int remainingDays;
  int status;

  Membership({this.remainingDays, this.status});

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
  String id;
  String token;
  String name;
  String lname;
  String email;
  String password;
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
  String rememberToken;
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

  UserInfo(
      {this.id,
      this.token,
      this.name,
      this.lname,
      this.email,
      this.password,
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
      this.rememberToken,
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
      this.smsNotification});

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
