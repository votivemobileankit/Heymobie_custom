class DriverListModel {
  String message;
  String imgUrl;
  String productUrl;
  String banner_image;
  int status;
  Data data;

  DriverListModel(
      {this.message, this.imgUrl, this.productUrl, this.status, this.data});

  DriverListModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    imgUrl = json['img_url'];
    productUrl = json['product_url'];
    banner_image = json['banner_image'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['img_url'] = this.imgUrl;
    data['product_url'] = this.productUrl;
    data['banner_image'] = this.banner_image;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  List<DriverList> driverList;
  List<ProductListDriver> productList;
  List<Advertisement> advertisement;

  Data({this.driverList, this.productList, this.advertisement});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['driver_list'] != null) {
      driverList = [];
      json['driver_list'].forEach((v) {
        driverList.add(new DriverList.fromJson(v));
      });
    }
    if (json['product_list'] != null) {
      productList = [];
      json['product_list'].forEach((v) {
        productList.add(new ProductListDriver.fromJson(v));
      });
    }
    if (json['advertisement'] != null) {
      advertisement = [];
      json['advertisement'].forEach((v) {
        advertisement.add(new Advertisement.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.driverList != null) {
      data['driver_list'] = this.driverList.map((v) => v.toJson()).toList();
    }
    if (this.productList != null) {
      data['product_list'] = this.productList.map((v) => v.toJson()).toList();
    }
    if (this.advertisement != null) {
      data['advertisement'] =
          this.advertisement.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DriverList {
  String vendorId;
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
  String password;
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
  String rememberToken;
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
  String distance;
  String map_icon;
  String type_of_merchant;

  DriverList(
      {this.vendorId,
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
      this.password,
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
      this.rememberToken,
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
      this.distance,
      this.map_icon,
      this.type_of_merchant});

  DriverList.fromJson(Map<String, dynamic> json) {
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
    password = json['password'];
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
    rememberToken = json['remember_token'];
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
    distance = json['distance'];
    map_icon = json['map_icon'];
    type_of_merchant = json['type_of_merchant'];
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
    data['password'] = this.password;
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
    data['remember_token'] = this.rememberToken;
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
    data['distance'] = this.distance;
    data['map_icon'] = this.map_icon;
    data['type_of_merchant'] = this.type_of_merchant;
    return data;
  }
}

class ProductListDriver {
  int id;
  String vendorId;
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
  String uniqueId;
  String username;
  String lastName;
  String businessName;
  String email;
  String mailingAddress;
  String address;
  String lat;
  String lng;
  String address1;
  String suburb;
  String state;
  String city;
  String zipcode;
  String mobNo;
  String vendorStatus;
  String vendorType;
  String walletAmount;
  String deviceid;
  String devicetype;
  String password;
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
  String service;
  String permitType;
  String permitNumber;
  String permitExpiry;
  String rememberToken;
  String otp;
  String forgetpassRequest;
  String forgetpassRequestStatus;
  String planId;
  String planPurchased;
  String planExpiry;
  String txnId;
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
  String vid;
  String vendorname;
  String vendorlastname;

  String categoryname;
  String imageURL;
  String subcategoryname;
  List<Images> images;
  String totalprice;
  Vendor vendor;

  ProductListDriver(
      {this.id,
      this.vendorId,
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
      this.uniqueId,
      this.username,
      this.lastName,
      this.businessName,
      this.email,
      this.mailingAddress,
      this.address,
      this.lat,
      this.lng,
      this.address1,
      this.suburb,
      this.state,
      this.city,
      this.zipcode,
      this.mobNo,
      this.vendorStatus,
      this.vendorType,
      this.walletAmount,
      this.deviceid,
      this.devicetype,
      this.password,
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
      this.service,
      this.permitType,
      this.permitNumber,
      this.permitExpiry,
      this.rememberToken,
      this.otp,
      this.forgetpassRequest,
      this.forgetpassRequestStatus,
      this.planId,
      this.planPurchased,
      this.planExpiry,
      this.txnId,
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
      this.vid,
      this.vendorname,
      this.vendorlastname,
      this.categoryname,
      this.imageURL,
      this.subcategoryname,
      this.images,
      this.totalprice,
      this.vendor});

  ProductListDriver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
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
    uniqueId = json['unique_id'];
    username = json['username'];
    lastName = json['last_name'];
    businessName = json['business_name'];
    email = json['email'];
    mailingAddress = json['mailing_address'];
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
    address1 = json['address1'];
    suburb = json['suburb'];
    state = json['state'];
    city = json['city'];
    zipcode = json['zipcode'];
    mobNo = json['mob_no'];
    vendorStatus = json['vendor_status'];
    vendorType = json['vendor_type'];
    walletAmount = json['wallet_amount'];
    deviceid = json['deviceid'];
    devicetype = json['devicetype'];
    password = json['password'];
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
    service = json['service'];
    permitType = json['permit_type'];
    permitNumber = json['permit_number'];
    permitExpiry = json['permit_expiry'];
    rememberToken = json['remember_token'];
    otp = json['otp'];
    forgetpassRequest = json['forgetpass_request'];
    forgetpassRequestStatus = json['forgetpass_request_status'];
    planId = json['plan_id'];
    planPurchased = json['plan_purchased'];
    planExpiry = json['plan_expiry'];
    txnId = json['txn_id'];
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
    vid = json['vid'];
    vendorname = json['vendorname'];
    vendorlastname = json['vendorlastname'];
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
    vendor =
        json['Vendor'] != null ? new Vendor.fromJson(json['Vendor']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
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
    data['unique_id'] = this.uniqueId;
    data['username'] = this.username;
    data['last_name'] = this.lastName;
    data['business_name'] = this.businessName;
    data['email'] = this.email;
    data['mailing_address'] = this.mailingAddress;
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['address1'] = this.address1;
    data['suburb'] = this.suburb;
    data['state'] = this.state;
    data['city'] = this.city;
    data['zipcode'] = this.zipcode;
    data['mob_no'] = this.mobNo;
    data['vendor_status'] = this.vendorStatus;
    data['vendor_type'] = this.vendorType;
    data['wallet_amount'] = this.walletAmount;
    data['deviceid'] = this.deviceid;
    data['devicetype'] = this.devicetype;
    data['password'] = this.password;
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
    data['service'] = this.service;
    data['permit_type'] = this.permitType;
    data['permit_number'] = this.permitNumber;
    data['permit_expiry'] = this.permitExpiry;
    data['remember_token'] = this.rememberToken;
    data['otp'] = this.otp;
    data['forgetpass_request'] = this.forgetpassRequest;
    data['forgetpass_request_status'] = this.forgetpassRequestStatus;
    data['plan_id'] = this.planId;
    data['plan_purchased'] = this.planPurchased;
    data['plan_expiry'] = this.planExpiry;
    data['txn_id'] = this.txnId;
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
    data['vid'] = this.vid;
    data['vendorname'] = this.vendorname;
    data['vendorlastname'] = this.vendorlastname;
    data['categoryname'] = this.categoryname;
    data['ImageURL'] = this.imageURL;
    data['subcategoryname'] = this.subcategoryname;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    data['totalprice'] = this.totalprice;
    if (this.vendor != null) {
      data['Vendor'] = this.vendor.toJson();
    }
    return data;
  }
}

class Images {
  String id;
  String psId;
  String name;
  String thumb;
  String createdAt;
  String updatedAt;
  String path;

  Images(
      {this.id,
      this.psId,
      this.name,
      this.thumb,
      this.createdAt,
      this.updatedAt,
      this.path});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    psId = json['ps_id'];
    name = json['name'];
    thumb = json['thumb'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ps_id'] = this.psId;
    data['name'] = this.name;
    data['thumb'] = this.thumb;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['path'] = this.path;
    return data;
  }
}

class Vendor {
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

  String fullname;
  String category;

  Vendor({
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
    this.fullname,
    this.category,
  });

  Vendor.fromJson(Map<String, dynamic> json) {
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

    data['fullname'] = this.fullname;
    data['Category'] = this.category;

    return data;
  }
}

class Advertisement {
  String image;
  String url;

  Advertisement({this.image, this.url});

  Advertisement.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['url'] = this.url;
    return data;
  }
}
