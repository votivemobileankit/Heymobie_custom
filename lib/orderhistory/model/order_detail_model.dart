class OrderDetailResponseModel {
  String profileUrl;
  String message;
  int status;
  Data data;

  OrderDetailResponseModel(
      {this.profileUrl, this.message, this.status, this.data});

  OrderDetailResponseModel.fromJson(Map<String, dynamic> json) {
    profileUrl = json['profile_url'];
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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
  List<OrderDetail> orderDetail;
  List<OrderItems> orderItems;
  List<Vendor1> vendor;

  Data({this.orderDetail, this.orderItems, this.vendor});

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
  String id;
  String vendorId;
  String userId;
  String psId;
  String psQty;
  String orderId;
  String address;
  String addressp;
  String addressd;
  String city;
  String cityp;
  String cityd;
  String mobileNo;
  String email;
  String instruction;
  String cancelReason;
  String status;
  String returnReason;
  String returnReasonMerchant;
  String deliveryFee;
  String deliveryTime;
  String latitude;
  String longitude;
  String subTotal;
  String total;
  String serviceTax;
  String exciseTax;
  String cityTax;
  String promoAmount;
  String couponId;
  String verificationCode;
  String txnId;
  String transactionTag;
  String authorizationNum;
  String tagged;
  String receiptUrl;
  String payStatus;
  String paymentMethod;
  String firstName;
  String lastName;
  String state;
  String statep;
  String stated;
  String zip;
  String zipp;
  String zipd;
  String createdAt;
  String updatedAt;

  OrderDetail(
      {this.id,
      this.vendorId,
      this.userId,
      this.psId,
      this.psQty,
      this.orderId,
      this.address,
      this.addressp,
      this.addressd,
      this.city,
      this.cityp,
      this.cityd,
      this.mobileNo,
      this.email,
      this.instruction,
      this.cancelReason,
      this.status,
      this.returnReason,
      this.returnReasonMerchant,
      this.deliveryFee,
      this.deliveryTime,
      this.latitude,
      this.longitude,
      this.subTotal,
      this.total,
      this.serviceTax,
      this.exciseTax,
      this.cityTax,
      this.promoAmount,
      this.couponId,
      this.verificationCode,
      this.txnId,
      this.transactionTag,
      this.authorizationNum,
      this.tagged,
      this.receiptUrl,
      this.payStatus,
      this.paymentMethod,
      this.firstName,
      this.lastName,
      this.state,
      this.statep,
      this.stated,
      this.zip,
      this.zipp,
      this.zipd,
      this.createdAt,
      this.updatedAt});

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
  String psQty;
  String categoryname;
  String imageURL;
  String subcategoryname;
  List<Images> images;
  String totalprice;

  OrderItems(
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
      this.psQty,
      this.categoryname,
      this.imageURL,
      this.subcategoryname,
      this.images,
      this.totalprice});

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
  String id;
  String psId;
  String name;

  String createdAt;
  String updatedAt;
  String path;

  Images(
      {this.id,
      this.psId,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.path});

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

  Vendor1({
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
