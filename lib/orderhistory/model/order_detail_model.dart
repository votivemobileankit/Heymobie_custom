class OrderDetailResponseModel {
late  String profileUrl;
late String message;
late int status;
late  Data data;

  OrderDetailResponseModel(
      {required this.profileUrl,required this.message,required this.status,required this.data});

  OrderDetailResponseModel.fromJson(Map<String, dynamic> json) {
    profileUrl = json['profile_url'];
    message = json['message'];
    status = json['status'];
    data = (json['data'] != null ? new Data.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_url'] = this.profileUrl;
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
late  List<OrderDetail> orderDetail;
 late List<OrderItems> orderItems;
 late List<Vendor1> vendor;

  Data({required this.orderDetail,required this.orderItems,required this.vendor});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['order_detail'] != null) {
      orderDetail = [];
      json['order_detail'].forEach((v) {
        orderDetail.add(new OrderDetail.fromJson(v));
      });
    }
    if (json['order_items'] != null) {
      orderItems = [];
      json['order_items'].forEach((v) {
        orderItems.add(new OrderItems.fromJson(v));
      });
    }
    if (json['vendor'] != null) {
      vendor = [];
      json['vendor'].forEach((v) {
        vendor.add(new Vendor1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderDetail != null) {
      data['order_detail'] = this.orderDetail.map((v) => v.toJson()).toList();
    }
    if (this.orderItems != null) {
      data['order_items'] = this.orderItems.map((v) => v.toJson()).toList();
    }
    if (this.vendor != null) {
      data['vendor'] = this.vendor.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDetail {
 late String id;
 late String vendorId;
 late  String userId;
 late  String psId;
 late  String psQty;
 late  String orderId;
 late  String address;
 late String addressp;
 late  String addressd;
 late  String city;
 late  String cityp;
 late String cityd;
 late String mobileNo;
 late  String email;
 late  String instruction;
 late  String cancelReason;
 late String status;
 late String returnReason;
 late String returnReasonMerchant;
 late String deliveryFee;
 late String deliveryTime;
 late String latitude;
 late String longitude;
 late String subTotal;
 late String total;
 late String serviceTax;
 late String exciseTax;
 late String cityTax;
 late String promoAmount;
 late String couponId;
 late String verificationCode;
 late String txnId;
 late String transactionTag;
 late String authorizationNum;
 late String tagged;
 late  String receiptUrl;
 late  String payStatus;
 late String paymentMethod;
 late String firstName;
 late String lastName;
 late  String state;
 late String statep;
 late String stated;
 late String zip;
 late String zipp;
 late String zipd;
 late String createdAt;
 late String updatedAt;

  OrderDetail(
      {required this.id,
        required this.vendorId,
        required this.userId,
        required this.psId,
        required this.psQty,
        required  this.orderId,
        required  this.address,
        required this.addressp,
        required this.addressd,
        required   this.city,
        required  this.cityp,
        required this.cityd,
        required this.mobileNo,
        required this.email,
        required this.instruction,
        required this.cancelReason,
        required  this.status,
        required  this.returnReason,
        required  this.returnReasonMerchant,
        required  this.deliveryFee,
        required  this.deliveryTime,
        required  this.latitude,
        required   this.longitude,
        required  this.subTotal,
        required  this.total,
        required   this.serviceTax,
        required  this.exciseTax,
        required this.cityTax,
        required this.promoAmount,
        required  this.couponId,
        required  this.verificationCode,
        required  this.txnId,
        required  this.transactionTag,
        required  this.authorizationNum,
        required  this.tagged,
        required  this.receiptUrl,
        required  this.payStatus,
        required   this.paymentMethod,
        required  this.firstName,
        required this.lastName,
        required  this.state,
        required this.statep,
        required  this.stated,
        required  this.zip,
        required   this.zipp,
        required this.zipd,
        required  this.createdAt,
        required  this.updatedAt});

  OrderDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    userId = json['user_id'];
    psId = json['ps_id'];
    psQty = json['ps_qty'];
    orderId = json['order_id'];
    address = json['address'];
    addressp = json['addressp'];
    addressd = json['addressd'];
    city = json['city'];
    cityp = json['cityp'];
    cityd = json['cityd'];
    mobileNo = json['mobile_no'];
    email = json['email'];
    instruction = json['instruction'];
    cancelReason = json['cancel_reason'];
    status = json['status'];
    returnReason = json['return_reason'];
    returnReasonMerchant = json['return_reason_merchant'];
    deliveryFee = json['delivery_fee'];
    deliveryTime = json['delivery_time'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    subTotal = json['sub_total'];
    total = json['total'];
    serviceTax = json['service_tax'];
    exciseTax = json['excise_tax'];
    cityTax = json['city_tax'];
    promoAmount = json['promo_amount'];
    couponId = json['coupon_id'];
    verificationCode = json['verification_code'];
    txnId = json['txn_id'];
    transactionTag = json['transaction_tag'];
    authorizationNum = json['authorization_num'];
    tagged = json['tagged'];
    receiptUrl = json['receipt_url'];
    payStatus = json['pay_status'];
    paymentMethod = json['payment_method'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    state = json['state'];
    statep = json['statep'];
    stated = json['stated'];
    zip = json['zip'];
    zipp = json['zipp'];
    zipd = json['zipd'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['user_id'] = this.userId;
    data['ps_id'] = this.psId;
    data['ps_qty'] = this.psQty;
    data['order_id'] = this.orderId;
    data['address'] = this.address;
    data['addressp'] = this.addressp;
    data['addressd'] = this.addressd;
    data['city'] = this.city;
    data['cityp'] = this.cityp;
    data['cityd'] = this.cityd;
    data['mobile_no'] = this.mobileNo;
    data['email'] = this.email;
    data['instruction'] = this.instruction;
    data['cancel_reason'] = this.cancelReason;
    data['status'] = this.status;
    data['return_reason'] = this.returnReason;
    data['return_reason_merchant'] = this.returnReasonMerchant;
    data['delivery_fee'] = this.deliveryFee;
    data['delivery_time'] = this.deliveryTime;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['sub_total'] = this.subTotal;
    data['total'] = this.total;
    data['service_tax'] = this.serviceTax;
    data['excise_tax'] = this.exciseTax;
    data['city_tax'] = this.cityTax;
    data['promo_amount'] = this.promoAmount;
    data['coupon_id'] = this.couponId;
    data['verification_code'] = this.verificationCode;
    data['txn_id'] = this.txnId;
    data['transaction_tag'] = this.transactionTag;
    data['authorization_num'] = this.authorizationNum;
    data['tagged'] = this.tagged;
    data['receipt_url'] = this.receiptUrl;
    data['pay_status'] = this.payStatus;
    data['payment_method'] = this.paymentMethod;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['state'] = this.state;
    data['statep'] = this.statep;
    data['stated'] = this.stated;
    data['zip'] = this.zip;
    data['zipp'] = this.zipp;
    data['zipd'] = this.zipd;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class OrderItems {
  late int id;
  late String vendorId;
  late String adminProductId;
  late String type;
  late String categoryId;
  late  String subCategoryId;
  late  String avgRating;
  late String ratingCount;
  late String name;
  late String slug;
  late String description;
  late String price;
  late  String quantity;
  late String unit;
  late String brands;
  late String types;
  late String potencyThc;
  late String potencyCbd;
  late String image;
  late String keyword;
  late String productCode;
  late String status;
  late  String loginStatus;
  late String stock;
  late String popular;
  late String createdAt;
  late String updatedAt;
  late String psQty;
  late String categoryname;
  late String imageURL;
  late String subcategoryname;
  late List<Images> images;
  late String totalprice;

  OrderItems(
      {required this.id,
        required this.vendorId,
        required this.adminProductId,
        required this.type,
        required  this.categoryId,
        required  this.subCategoryId,
        required  this.avgRating,
        required  this.ratingCount,
        required this.name,
        required this.slug,
        required this.description,
        required  this.price,
        required this.quantity,
        required this.unit,
        required  this.brands,
        required  this.types,
        required   this.potencyThc,
        required  this.potencyCbd,
        required this.image,
        required  this.keyword,
        required this.productCode,
        required  this.status,
        required  this.loginStatus,
        required  this.stock,
        required this.popular,
        required this.createdAt,
        required  this.updatedAt,
        required  this.psQty,
        required  this.categoryname,
        required  this.imageURL,
        required this.subcategoryname,
        required this.images,
        required this.totalprice});

  OrderItems.fromJson(Map<String, dynamic> json) {
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
    psQty = json['ps_qty'];
    categoryname = json['categoryname'];
    imageURL = json['ImageURL'];
    subcategoryname = json['subcategoryname'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    totalprice = json['totalprice'];
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
    data['ps_qty'] = this.psQty;
    data['categoryname'] = this.categoryname;
    data['ImageURL'] = this.imageURL;
    data['subcategoryname'] = this.subcategoryname;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    data['totalprice'] = this.totalprice;
    return data;
  }
}

class Images {
late  String id;
late String psId;
late  String name;

late  String createdAt;
late  String updatedAt;
late  String path;

  Images(
      {required this.id,
        required  this.psId,
        required this.name,
        required this.createdAt,
        required   this.updatedAt,
        required   this.path});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    psId = json['ps_id'];
    name = json['name'];

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ps_id'] = this.psId;
    data['name'] = this.name;

    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['path'] = this.path;
    return data;
  }
}

class Vendor1 {
 late int vendorId;
 late String uniqueId;
 late String name;
 late String username;
 late String lastName;
 late String businessName;
 late String email;
 late String mailingAddress;
 late String address;
 late String avgRating;
 late String ratingCount;
 late String lat;
 late  String lng;
 late String address1;
 late String suburb;
 late String state;
 late String city;
 late String zipcode;
 late String mobNo;
 late String vendorStatus;
 late String loginStatus;
 late String vendorType;
 late String walletAmount;
 late String deviceid;
 late String devicetype;
 late  String marketArea;
 late String serviceRadius;
 late String driverLicense;
 late  String licenseExpiry;
 late  String licenseFront;
 late String licenseBack;
 late String ssn;
 late String dob;
 late String profileImg1;
 late String profileImg2;
 late String profileImg3;
 late String profileImg4;
 late String type;
 late String categoryId;
 late String subCategoryId;
 late String service;
 late String permitType;
 late String permitNumber;
 late String permitExpiry;
 late String description;
 late String otp;
 late String forgetpassRequest;
 late String forgetpassRequestStatus;
 late String planId;
 late String planPurchased;
 late String planExpiry;
 late String txnId;
 late String createdAt;
 late String updatedAt;
 late String stripeId;
 late String make;
 late String model;
 late String color;
 late  String year;
 late String licensePlate;
 late String views;
 late String salesTax;
 late String exciseTax;
 late String cityTax;
 late String commissionRate;
 late String deliveryFee;
 late String licensefrontURL;
 late String licensebackURL;
 late String profileURL;
 late String profile2URL;
 late String profile3URL;
 late String profile4URL;
 late Membership membership;
 late String fullname;
 late  String category;

  Vendor1({required
    this.vendorId,
    required this.uniqueId,
    required this.name,
    required  this.username,
    required this.lastName,
    required  this.businessName,
    required this.email,
    required  this.mailingAddress,
    required this.address,
    required  this.avgRating,
    required  this.ratingCount,
    required  this.lat,
    required  this.lng,
    required this.address1,
    required this.suburb,
    required this.state,
    required this.city,
    required  this.zipcode,
    required  this.mobNo,
    required  this.vendorStatus,
    required  this.loginStatus,
    required  this.vendorType,
    required  this.walletAmount,
    required this.deviceid,
    required  this.devicetype,
    required  this.marketArea,
    required  this.serviceRadius,
    required this.driverLicense,
    required this.licenseExpiry,
    required  this.licenseFront,
    required this.licenseBack,
    required  this.ssn,
    required  this.dob,
    required  this.profileImg1,
    required this.profileImg2,
    required this.profileImg3,
    required this.profileImg4,
    required  this.type,
    required this.categoryId,
    required this.subCategoryId,
    required this.service,
    required this.permitType,
    required  this.permitNumber,
    required this.permitExpiry,
    required this.description,
    required  this.otp,
    required  this.forgetpassRequest,
    required  this.forgetpassRequestStatus,
    required  this.planId,
    required  this.planPurchased,
    required  this.planExpiry,
    required  this.txnId,
    required this.createdAt,
    required this.updatedAt,
    required this.stripeId,
    required this.make,
    required this.model,
    required this.color,
    required this.year,
    required this.licensePlate,
    required  this.views,
    required  this.salesTax,
    required this.exciseTax,
    required this.cityTax,
    required this.commissionRate,
    required this.deliveryFee,
    required this.licensefrontURL,
    required  this.licensebackURL,
    required this.profileURL,
    required this.profile2URL,
    required this.profile3URL,
    required this.profile4URL,
    required this.membership,
    required  this.fullname,
    required this.category,
  });

  Vendor1.fromJson(Map<String, dynamic> json) {
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

  Membership({required this.remainingDays, required this.status});

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
