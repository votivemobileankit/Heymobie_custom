class RideDetailResponseModel {
  String? profileUrl;
  String? message;
  int? status;
  Data? data;

  RideDetailResponseModel(
      {this.profileUrl, this.message, this.status, this.data});

  RideDetailResponseModel.fromJson(Map<String, dynamic> json) {
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
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  //   List<RideViewDetail>? rideDetail;
//   List<RideViewItems>? rideItems;
//   List<Vendor>? vendor;
  List<RideViewDetail>? rideDetail;
  List<RideViewItems>? rideItems;
  List<Vendor>? vendor;
  String? currentTime;

  Data({this.rideDetail, this.rideItems, this.vendor, this.currentTime});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['order_detail'] != null) {
      rideDetail = <RideViewDetail>[];
      json['order_detail'].forEach((v) {
        rideDetail!.add(new RideViewDetail.fromJson(v));
      });
    }
    if (json['order_items'] != null) {
      rideItems = <RideViewItems>[];
      json['order_items'].forEach((v) {
        rideItems!.add(new RideViewItems.fromJson(v));
      });
    }
    if (json['vendor'] != null) {
      vendor = <Vendor>[];
      json['vendor'].forEach((v) {
        vendor!.add(new Vendor.fromJson(v));
      });
    }
    currentTime = json['current_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rideDetail != null) {
      data['order_detail'] = this.rideDetail!.map((v) => v.toJson()).toList();
    }
    if (this.rideItems != null) {
      data['order_items'] = this.rideItems!.map((v) => v.toJson()).toList();
    }
    if (this.vendor != null) {
      data['vendor'] = this.vendor!.map((v) => v.toJson()).toList();
    }
    data['current_time'] = this.currentTime;
    return data;
  }
}

class RideViewDetail {
  String? id;
  String? vendorId;
  String? userId;
  String? psId;
  String? psQty;
  String? productType;
  String? orderId;
  String? ticketId;
  String? address;
  String? addressp;
  String? addressd;
  String? city;
  String? cityp;
  String? cityd;
  String? mobileNo;
  String? email;
  String? instruction;
  String? cancelReason;
  String? status;
  String? ticketQrcode;
  String? ticketuseStatus;
  String? returnReason;
  String? returnReasonMerchant;
  String? deliveryFee;
  String? deliveryTime;
  String? ticketFee;
  String? ticketServiceFee;
  String? latitude;
  String? longitude;
  String? subTotal;
  String? total;
  String? serviceTax;
  String? exciseTax;
  String? cityTax;
  String? promoAmount;
  String? couponId;
  String? verificationCode;
  String? txnId;
  String? transactionTag;
  String? authorizationNum;
  String? tagged;
  String? receiptUrl;
  String? payStatus;
  String? paymentMethod;
  String? firstName;
  String? lastName;
  String? state;
  String? statep;
  String? stated;
  String? zip;
  String? zipp;
  String? zipd;
  String? country;
  String? countryd;
  String? deviceType;
  String? deviceOsName;
  String? pickAddress;
  String? dropAddress;
  String? distance;
  String? estimatePrice;
  String? rideStartTime;
  String? rideEndTime;
  String? rideTotalTime;
  String? rideUnit;
  String? createdAt;
  String? updatedAt;

  RideViewDetail(
      {this.id,
      this.vendorId,
      this.userId,
      this.psId,
      this.psQty,
      this.productType,
      this.orderId,
      this.ticketId,
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
      this.ticketQrcode,
      this.ticketuseStatus,
      this.returnReason,
      this.returnReasonMerchant,
      this.deliveryFee,
      this.deliveryTime,
      this.ticketFee,
      this.ticketServiceFee,
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
      this.country,
      this.countryd,
      this.deviceType,
      this.deviceOsName,
      this.pickAddress,
      this.dropAddress,
      this.distance,
      this.estimatePrice,
      this.rideStartTime,
      this.rideEndTime,
      this.rideTotalTime,
      this.rideUnit,
      this.createdAt,
      this.updatedAt});

  RideViewDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    userId = json['user_id'];
    psId = json['ps_id'];
    psQty = json['ps_qty'];
    productType = json['product_type'];
    orderId = json['order_id'];
    ticketId = json['ticket_id'];
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
    ticketQrcode = json['ticket_qrcode'];
    ticketuseStatus = json['ticketuse_status'];
    returnReason = json['return_reason'];
    returnReasonMerchant = json['return_reason_merchant'];
    deliveryFee = json['delivery_fee'];
    deliveryTime = json['delivery_time'];
    ticketFee = json['ticket_fee'];
    ticketServiceFee = json['ticket_service_fee'];
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
    country = json['country'];
    countryd = json['countryd'];
    deviceType = json['device_type'];
    deviceOsName = json['device_os_name'];
    pickAddress = json['pick_address'];
    dropAddress = json['drop_address'];
    distance = json['distance'];
    estimatePrice = json['estimate_price'];
    rideStartTime = json['ride_start_time'];
    rideEndTime = json['ride_end_time'];
    rideTotalTime = json['ride_total_time'];
    rideUnit = json['ride_unit'];
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
    data['product_type'] = this.productType;
    data['order_id'] = this.orderId;
    data['ticket_id'] = this.ticketId;
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
    data['ticket_qrcode'] = this.ticketQrcode;
    data['ticketuse_status'] = this.ticketuseStatus;
    data['return_reason'] = this.returnReason;
    data['return_reason_merchant'] = this.returnReasonMerchant;
    data['delivery_fee'] = this.deliveryFee;
    data['delivery_time'] = this.deliveryTime;
    data['ticket_fee'] = this.ticketFee;
    data['ticket_service_fee'] = this.ticketServiceFee;
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
    data['country'] = this.country;
    data['countryd'] = this.countryd;
    data['device_type'] = this.deviceType;
    data['device_os_name'] = this.deviceOsName;
    data['pick_address'] = this.pickAddress;
    data['drop_address'] = this.dropAddress;
    data['distance'] = this.distance;
    data['estimate_price'] = this.estimatePrice;
    data['ride_start_time'] = this.rideStartTime;
    data['ride_end_time'] = this.rideEndTime;
    data['ride_total_time'] = this.rideTotalTime;
    data['ride_unit'] = this.rideUnit;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class RideViewItems {
  int? id;
  String? vendorId;
  String? adminProductId;
  String? vendorProductId;
  String? type;
  String? categoryId;
  String? subCategoryId;
  String? categoryAddonId;
  String? addonType;
  String? avgRating;
  String? ratingCount;
  String? name;
  String? slug;
  String? description;
  String? price;
  String? quantity;
  String? unit;
  String? rateMile;
  String? rateMinute;
  String? brands;
  String? types;
  String? potencyThc;
  String? potencyCbd;
  String? image;
  String? keyword;
  String? productCode;
  String? status;
  String? loginStatus;
  String? stock;
  String? popular;
  String? notesRemarks;
  String? venueName;
  String? venueAddress;
  String? eventDate;
  String? eventStartTime;
  String? eventEndTime;
  String? ticketInventory;
  String? seatingArea;
  String? ticketCommission;
  String? ticketFee;
  String? ticketServiceFee;
  String? createdAt;
  String? updatedAt;
  String? psQty;
  String? categoryname;
  String? imageURL;
  String? subcategoryname;
  List<Images>? images;
  String? totalprice;

  RideViewItems(
      {this.id,
      this.vendorId,
      this.adminProductId,
      this.vendorProductId,
      this.type,
      this.categoryId,
      this.subCategoryId,
      this.categoryAddonId,
      this.addonType,
      this.avgRating,
      this.ratingCount,
      this.name,
      this.slug,
      this.description,
      this.price,
      this.quantity,
      this.unit,
      this.rateMile,
      this.rateMinute,
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
      this.notesRemarks,
      this.venueName,
      this.venueAddress,
      this.eventDate,
      this.eventStartTime,
      this.eventEndTime,
      this.ticketInventory,
      this.seatingArea,
      this.ticketCommission,
      this.ticketFee,
      this.ticketServiceFee,
      this.createdAt,
      this.updatedAt,
      this.psQty,
      this.categoryname,
      this.imageURL,
      this.subcategoryname,
      this.images,
      this.totalprice});

  RideViewItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    adminProductId = json['admin_product_id'];
    vendorProductId = json['vendor_product_id'];
    type = json['type'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    categoryAddonId = json['category_addon_id'];
    addonType = json['addon_type'];
    avgRating = json['avg_rating'];
    ratingCount = json['rating_count'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    price = json['price'];
    quantity = json['quantity'];
    unit = json['unit'];
    rateMile = json['rate_mile'];
    rateMinute = json['rate_minute'];
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
    notesRemarks = json['notes_remarks'];
    venueName = json['venue_name'];
    venueAddress = json['venue_address'];
    eventDate = json['event_date'];
    eventStartTime = json['event_start_time'];
    eventEndTime = json['event_end_time'];
    ticketInventory = json['ticket_inventory'];
    seatingArea = json['seating_area'];
    ticketCommission = json['ticket_commission'];
    ticketFee = json['ticket_fee'];
    ticketServiceFee = json['ticket_service_fee'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    psQty = json['ps_qty'];
    categoryname = json['categoryname'];
    imageURL = json['ImageURL'];
    subcategoryname = json['subcategoryname'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    totalprice = json['totalprice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['admin_product_id'] = this.adminProductId;
    data['vendor_product_id'] = this.vendorProductId;
    data['type'] = this.type;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['category_addon_id'] = this.categoryAddonId;
    data['addon_type'] = this.addonType;
    data['avg_rating'] = this.avgRating;
    data['rating_count'] = this.ratingCount;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['unit'] = this.unit;
    data['rate_mile'] = this.rateMile;
    data['rate_minute'] = this.rateMinute;
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
    data['notes_remarks'] = this.notesRemarks;
    data['venue_name'] = this.venueName;
    data['venue_address'] = this.venueAddress;
    data['event_date'] = this.eventDate;
    data['event_start_time'] = this.eventStartTime;
    data['event_end_time'] = this.eventEndTime;
    data['ticket_inventory'] = this.ticketInventory;
    data['seating_area'] = this.seatingArea;
    data['ticket_commission'] = this.ticketCommission;
    data['ticket_fee'] = this.ticketFee;
    data['ticket_service_fee'] = this.ticketServiceFee;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['ps_qty'] = this.psQty;
    data['categoryname'] = this.categoryname;
    data['ImageURL'] = this.imageURL;
    data['subcategoryname'] = this.subcategoryname;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['totalprice'] = this.totalprice;
    return data;
  }
}

class Images {
  String? id;
  String? psId;
  String? name;
  String? thumb;
  String? createdAt;
  String? updatedAt;
  String? path;

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
  String? vendorId;
  String? uniqueId;
  String? name;
  String? username;
  String? lastName;
  String? businessName;
  String? email;
  String? mailingAddress;
  String? address;
  String? avgRating;
  String? ratingCount;
  String? lat;
  String? lng;
  String? address1;
  String? suburb;
  String? state;
  String? city;
  String? zipcode;
  String? mobNo;
  String? vendorStatus;
  String? loginStatus;
  String? vendorType;
  String? walletAmount;
  String? deviceid;
  String? devicetype;
  String? password;
  String? marketArea;
  String? serviceRadius;
  String? driverLicense;
  String? licenseExpiry;
  String? licenseFront;
  String? licenseBack;
  String? ssn;
  String? dob;
  String? profileImg1;
  String? profileImg2;
  String? profileImg3;
  String? profileImg4;
  String? pvideo1;
  String? pvideo2;
  String? pvideo3;
  String? type;
  String? categoryId;
  String? subCategoryId;
  String? service;
  String? permitType;
  String? permitNumber;
  String? permitExpiry;
  String? description;
  String? rememberToken;
  String? otp;
  String? forgetpassRequest;
  String? forgetpassRequestStatus;
  String? planId;
  String? planPurchased;
  String? planExpiry;
  String? txnId;
  String? createdAt;
  String? updatedAt;
  String? stripeId;
  String? make;
  String? model;
  String? color;
  String? year;
  String? licensePlate;
  String? views;
  String? salesTax;
  String? exciseTax;
  String? cityTax;
  String? commissionRate;
  String? deliveryFee;
  String? mapIcon;
  String? typeOfMerchant;
  String? cashCard;

  Vendor(
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
      this.pvideo1,
      this.pvideo2,
      this.pvideo3,
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
      this.mapIcon,
      this.typeOfMerchant,
      this.cashCard});

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
    pvideo1 = json['pvideo1'];
    pvideo2 = json['pvideo2'];
    pvideo3 = json['pvideo3'];
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
    mapIcon = json['map_icon'];
    typeOfMerchant = json['type_of_merchant'];
    cashCard = json['cash_card'];
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
    data['pvideo1'] = this.pvideo1;
    data['pvideo2'] = this.pvideo2;
    data['pvideo3'] = this.pvideo3;
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
    data['map_icon'] = this.mapIcon;
    data['type_of_merchant'] = this.typeOfMerchant;
    data['cash_card'] = this.cashCard;
    return data;
  }
}

//...............................................................................
// class RideDetailResponseModel {
//   String? profileUrl;
//   String? message;
//   int? status;
//   Data? data;
//
//   RideDetailResponseModel(
//       {this.profileUrl, this.message, this.status, this.data});
//
//   RideDetailResponseModel.fromJson(Map<String, dynamic> json) {
//     profileUrl = json['profile_url'];
//     message = json['message'];
//     status = json['status'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['profile_url'] = this.profileUrl;
//     data['message'] = this.message;
//     data['status'] = this.status;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   List<RideViewDetail>? rideDetail;
//   List<RideViewItems>? rideItems;
//   List<Vendor>? vendor;
//
//   Data({this.rideDetail, this.rideItems, this.vendor});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     if (json['order_detail'] != null) {
//       rideDetail = <RideViewDetail>[];
//       json['order_detail'].forEach((v) {
//         rideDetail!.add(new RideViewDetail.fromJson(v));
//       });
//     }
//     if (json['order_items'] != null) {
//       rideItems = <RideViewItems>[];
//       json['order_items'].forEach((v) {
//         rideItems!.add(new RideViewItems.fromJson(v));
//       });
//     }
//     if (json['vendor'] != null) {
//       vendor = <Vendor>[];
//       json['vendor'].forEach((v) {
//         vendor!.add(new Vendor.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.rideDetail != null) {
//       data['order_detail'] = this.rideDetail!.map((v) => v.toJson()).toList();
//     }
//     if (this.rideItems != null) {
//       data['order_items'] = this.rideItems!.map((v) => v.toJson()).toList();
//     }
//     if (this.vendor != null) {
//       data['vendor'] = this.vendor!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class RideViewDetail {
//   String? id;
//   String? vendorId;
//   String? userId;
//   String? psId;
//   String? psQty;
//   String? productType;
//   String? orderId;
//   String? ticketId;
//   String? address;
//   String? addressp;
//   String? addressd;
//   String? city;
//   String? cityp;
//   String? cityd;
//   String? mobileNo;
//   String? email;
//   String? instruction;
//   String? cancelReason;
//   String? status;
//   String? ticketQrcode;
//   String? ticketuseStatus;
//   String? returnReason;
//   String? returnReasonMerchant;
//   String? deliveryFee;
//   String? deliveryTime;
//   String? ticketFee;
//   String? ticketServiceFee;
//   String? latitude;
//   String? longitude;
//   String? subTotal;
//   String? total;
//   String? serviceTax;
//   String? exciseTax;
//   String? cityTax;
//   String? promoAmount;
//   String? couponId;
//   String? verificationCode;
//   String? txnId;
//   String? transactionTag;
//   String? authorizationNum;
//   String? tagged;
//   String? receiptUrl;
//   String? payStatus;
//   String? paymentMethod;
//   String? firstName;
//   String? lastName;
//   String? state;
//   String? statep;
//   String? stated;
//   String? zip;
//   String? zipp;
//   String? zipd;
//   String? country;
//   String? countryd;
//   String? deviceType;
//   String? deviceOsName;
//   String? pickAddress;
//   String? dropAddress;
//   String? distance;
//   String? estimatePrice;
//   String? rideStartTime;
//   String? rideEndTime;
//   String? rideTotalTime;
//   String? rideUnit;
//   String? createdAt;
//   String? updatedAt;
//
//   RideViewDetail(
//       {this.id,
//       this.vendorId,
//       this.userId,
//       this.psId,
//       this.psQty,
//       this.productType,
//       this.orderId,
//       this.ticketId,
//       this.address,
//       this.addressp,
//       this.addressd,
//       this.city,
//       this.cityp,
//       this.cityd,
//       this.mobileNo,
//       this.email,
//       this.instruction,
//       this.cancelReason,
//       this.status,
//       this.ticketQrcode,
//       this.ticketuseStatus,
//       this.returnReason,
//       this.returnReasonMerchant,
//       this.deliveryFee,
//       this.deliveryTime,
//       this.ticketFee,
//       this.ticketServiceFee,
//       this.latitude,
//       this.longitude,
//       this.subTotal,
//       this.total,
//       this.serviceTax,
//       this.exciseTax,
//       this.cityTax,
//       this.promoAmount,
//       this.couponId,
//       this.verificationCode,
//       this.txnId,
//       this.transactionTag,
//       this.authorizationNum,
//       this.tagged,
//       this.receiptUrl,
//       this.payStatus,
//       this.paymentMethod,
//       this.firstName,
//       this.lastName,
//       this.state,
//       this.statep,
//       this.stated,
//       this.zip,
//       this.zipp,
//       this.zipd,
//       this.country,
//       this.countryd,
//       this.deviceType,
//       this.deviceOsName,
//       this.pickAddress,
//       this.dropAddress,
//       this.distance,
//       this.estimatePrice,
//       this.rideStartTime,
//       this.rideEndTime,
//       this.rideTotalTime,
//       this.rideUnit,
//       this.createdAt,
//       this.updatedAt});
//
//   RideViewDetail.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     vendorId = json['vendor_id'];
//     userId = json['user_id'];
//     psId = json['ps_id'];
//     psQty = json['ps_qty'];
//     productType = json['product_type'];
//     orderId = json['order_id'];
//     ticketId = json['ticket_id'];
//     address = json['address'];
//     addressp = json['addressp'];
//     addressd = json['addressd'];
//     city = json['city'];
//     cityp = json['cityp'];
//     cityd = json['cityd'];
//     mobileNo = json['mobile_no'];
//     email = json['email'];
//     instruction = json['instruction'];
//     cancelReason = json['cancel_reason'];
//     status = json['status'];
//     ticketQrcode = json['ticket_qrcode'];
//     ticketuseStatus = json['ticketuse_status'];
//     returnReason = json['return_reason'];
//     returnReasonMerchant = json['return_reason_merchant'];
//     deliveryFee = json['delivery_fee'];
//     deliveryTime = json['delivery_time'];
//     ticketFee = json['ticket_fee'];
//     ticketServiceFee = json['ticket_service_fee'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     subTotal = json['sub_total'];
//     total = json['total'];
//     serviceTax = json['service_tax'];
//     exciseTax = json['excise_tax'];
//     cityTax = json['city_tax'];
//     promoAmount = json['promo_amount'];
//     couponId = json['coupon_id'];
//     verificationCode = json['verification_code'];
//     txnId = json['txn_id'];
//     transactionTag = json['transaction_tag'];
//     authorizationNum = json['authorization_num'];
//     tagged = json['tagged'];
//     receiptUrl = json['receipt_url'];
//     payStatus = json['pay_status'];
//     paymentMethod = json['payment_method'];
//     firstName = json['first_name'];
//     lastName = json['last_name'];
//     state = json['state'];
//     statep = json['statep'];
//     stated = json['stated'];
//     zip = json['zip'];
//     zipp = json['zipp'];
//     zipd = json['zipd'];
//     country = json['country'];
//     countryd = json['countryd'];
//     deviceType = json['device_type'];
//     deviceOsName = json['device_os_name'];
//     pickAddress = json['pick_address'];
//     dropAddress = json['drop_address'];
//     distance = json['distance'];
//     estimatePrice = json['estimate_price'];
//     rideStartTime = json['ride_start_time'];
//     rideEndTime = json['ride_end_time'];
//     rideTotalTime = json['ride_total_time'];
//     rideUnit = json['ride_unit'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['vendor_id'] = this.vendorId;
//     data['user_id'] = this.userId;
//     data['ps_id'] = this.psId;
//     data['ps_qty'] = this.psQty;
//     data['product_type'] = this.productType;
//     data['order_id'] = this.orderId;
//     data['ticket_id'] = this.ticketId;
//     data['address'] = this.address;
//     data['addressp'] = this.addressp;
//     data['addressd'] = this.addressd;
//     data['city'] = this.city;
//     data['cityp'] = this.cityp;
//     data['cityd'] = this.cityd;
//     data['mobile_no'] = this.mobileNo;
//     data['email'] = this.email;
//     data['instruction'] = this.instruction;
//     data['cancel_reason'] = this.cancelReason;
//     data['status'] = this.status;
//     data['ticket_qrcode'] = this.ticketQrcode;
//     data['ticketuse_status'] = this.ticketuseStatus;
//     data['return_reason'] = this.returnReason;
//     data['return_reason_merchant'] = this.returnReasonMerchant;
//     data['delivery_fee'] = this.deliveryFee;
//     data['delivery_time'] = this.deliveryTime;
//     data['ticket_fee'] = this.ticketFee;
//     data['ticket_service_fee'] = this.ticketServiceFee;
//     data['latitude'] = this.latitude;
//     data['longitude'] = this.longitude;
//     data['sub_total'] = this.subTotal;
//     data['total'] = this.total;
//     data['service_tax'] = this.serviceTax;
//     data['excise_tax'] = this.exciseTax;
//     data['city_tax'] = this.cityTax;
//     data['promo_amount'] = this.promoAmount;
//     data['coupon_id'] = this.couponId;
//     data['verification_code'] = this.verificationCode;
//     data['txn_id'] = this.txnId;
//     data['transaction_tag'] = this.transactionTag;
//     data['authorization_num'] = this.authorizationNum;
//     data['tagged'] = this.tagged;
//     data['receipt_url'] = this.receiptUrl;
//     data['pay_status'] = this.payStatus;
//     data['payment_method'] = this.paymentMethod;
//     data['first_name'] = this.firstName;
//     data['last_name'] = this.lastName;
//     data['state'] = this.state;
//     data['statep'] = this.statep;
//     data['stated'] = this.stated;
//     data['zip'] = this.zip;
//     data['zipp'] = this.zipp;
//     data['zipd'] = this.zipd;
//     data['country'] = this.country;
//     data['countryd'] = this.countryd;
//     data['device_type'] = this.deviceType;
//     data['device_os_name'] = this.deviceOsName;
//     data['pick_address'] = this.pickAddress;
//     data['drop_address'] = this.dropAddress;
//     data['distance'] = this.distance;
//     data['estimate_price'] = this.estimatePrice;
//     data['ride_start_time'] = this.rideStartTime;
//     data['ride_end_time'] = this.rideEndTime;
//     data['ride_total_time'] = this.rideTotalTime;
//     data['ride_unit'] = this.rideUnit;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
//
// class RideViewItems {
//   int? id;
//   String? vendorId;
//   String? adminProductId;
//   String? vendorProductId;
//   String? type;
//   String? categoryId;
//   String? subCategoryId;
//   String? categoryAddonId;
//   String? addonType;
//   String? avgRating;
//   String? ratingCount;
//   String? name;
//   String? slug;
//   String? description;
//   String? price;
//   String? quantity;
//   String? unit;
//   String? rateMile;
//   String? rateMinute;
//   String? brands;
//   String? types;
//   String? potencyThc;
//   String? potencyCbd;
//   String? image;
//   String? keyword;
//   String? productCode;
//   String? status;
//   String? loginStatus;
//   String? stock;
//   String? popular;
//   String? notesRemarks;
//   String? venueName;
//   String? venueAddress;
//   String? eventDate;
//   String? eventStartTime;
//   String? eventEndTime;
//   String? ticketInventory;
//   String? seatingArea;
//   String? ticketCommission;
//   String? ticketFee;
//   String? ticketServiceFee;
//   String? createdAt;
//   String? updatedAt;
//   String? psQty;
//   String? categoryname;
//   String? imageURL;
//   String? subcategoryname;
//   List<Images>? images;
//   String? totalprice;
//
//   RideViewItems(
//       {this.id,
//       this.vendorId,
//       this.adminProductId,
//       this.vendorProductId,
//       this.type,
//       this.categoryId,
//       this.subCategoryId,
//       this.categoryAddonId,
//       this.addonType,
//       this.avgRating,
//       this.ratingCount,
//       this.name,
//       this.slug,
//       this.description,
//       this.price,
//       this.quantity,
//       this.unit,
//       this.rateMile,
//       this.rateMinute,
//       this.brands,
//       this.types,
//       this.potencyThc,
//       this.potencyCbd,
//       this.image,
//       this.keyword,
//       this.productCode,
//       this.status,
//       this.loginStatus,
//       this.stock,
//       this.popular,
//       this.notesRemarks,
//       this.venueName,
//       this.venueAddress,
//       this.eventDate,
//       this.eventStartTime,
//       this.eventEndTime,
//       this.ticketInventory,
//       this.seatingArea,
//       this.ticketCommission,
//       this.ticketFee,
//       this.ticketServiceFee,
//       this.createdAt,
//       this.updatedAt,
//       this.psQty,
//       this.categoryname,
//       this.imageURL,
//       this.subcategoryname,
//       this.images,
//       this.totalprice});
//
//   RideViewItems.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     vendorId = json['vendor_id'];
//     adminProductId = json['admin_product_id'];
//     vendorProductId = json['vendor_product_id'];
//     type = json['type'];
//     categoryId = json['category_id'];
//     subCategoryId = json['sub_category_id'];
//     categoryAddonId = json['category_addon_id'];
//     addonType = json['addon_type'];
//     avgRating = json['avg_rating'];
//     ratingCount = json['rating_count'];
//     name = json['name'];
//     slug = json['slug'];
//     description = json['description'];
//     price = json['price'];
//     quantity = json['quantity'];
//     unit = json['unit'];
//     rateMile = json['rate_mile'];
//     rateMinute = json['rate_minute'];
//     brands = json['brands'];
//     types = json['types'];
//     potencyThc = json['potency_thc'];
//     potencyCbd = json['potency_cbd'];
//     image = json['image'];
//     keyword = json['keyword'];
//     productCode = json['product_code'];
//     status = json['status'];
//     loginStatus = json['login_status'];
//     stock = json['stock'];
//     popular = json['popular'];
//     notesRemarks = json['notes_remarks'];
//     venueName = json['venue_name'];
//     venueAddress = json['venue_address'];
//     eventDate = json['event_date'];
//     eventStartTime = json['event_start_time'];
//     eventEndTime = json['event_end_time'];
//     ticketInventory = json['ticket_inventory'];
//     seatingArea = json['seating_area'];
//     ticketCommission = json['ticket_commission'];
//     ticketFee = json['ticket_fee'];
//     ticketServiceFee = json['ticket_service_fee'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     psQty = json['ps_qty'];
//     categoryname = json['categoryname'];
//     imageURL = json['ImageURL'];
//     subcategoryname = json['subcategoryname'];
//     if (json['images'] != null) {
//       images = <Images>[];
//       json['images'].forEach((v) {
//         images!.add(new Images.fromJson(v));
//       });
//     }
//     totalprice = json['totalprice'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['vendor_id'] = this.vendorId;
//     data['admin_product_id'] = this.adminProductId;
//     data['vendor_product_id'] = this.vendorProductId;
//     data['type'] = this.type;
//     data['category_id'] = this.categoryId;
//     data['sub_category_id'] = this.subCategoryId;
//     data['category_addon_id'] = this.categoryAddonId;
//     data['addon_type'] = this.addonType;
//     data['avg_rating'] = this.avgRating;
//     data['rating_count'] = this.ratingCount;
//     data['name'] = this.name;
//     data['slug'] = this.slug;
//     data['description'] = this.description;
//     data['price'] = this.price;
//     data['quantity'] = this.quantity;
//     data['unit'] = this.unit;
//     data['rate_mile'] = this.rateMile;
//     data['rate_minute'] = this.rateMinute;
//     data['brands'] = this.brands;
//     data['types'] = this.types;
//     data['potency_thc'] = this.potencyThc;
//     data['potency_cbd'] = this.potencyCbd;
//     data['image'] = this.image;
//     data['keyword'] = this.keyword;
//     data['product_code'] = this.productCode;
//     data['status'] = this.status;
//     data['login_status'] = this.loginStatus;
//     data['stock'] = this.stock;
//     data['popular'] = this.popular;
//     data['notes_remarks'] = this.notesRemarks;
//     data['venue_name'] = this.venueName;
//     data['venue_address'] = this.venueAddress;
//     data['event_date'] = this.eventDate;
//     data['event_start_time'] = this.eventStartTime;
//     data['event_end_time'] = this.eventEndTime;
//     data['ticket_inventory'] = this.ticketInventory;
//     data['seating_area'] = this.seatingArea;
//     data['ticket_commission'] = this.ticketCommission;
//     data['ticket_fee'] = this.ticketFee;
//     data['ticket_service_fee'] = this.ticketServiceFee;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['ps_qty'] = this.psQty;
//     data['categoryname'] = this.categoryname;
//     data['ImageURL'] = this.imageURL;
//     data['subcategoryname'] = this.subcategoryname;
//     if (this.images != null) {
//       data['images'] = this.images!.map((v) => v.toJson()).toList();
//     }
//     data['totalprice'] = this.totalprice;
//     return data;
//   }
// }
//
// class Images {
//   String? id;
//   String? psId;
//   String? name;
//   String? thumb;
//   String? createdAt;
//   String? updatedAt;
//   String? path;
//
//   Images(
//       {this.id,
//       this.psId,
//       this.name,
//       this.thumb,
//       this.createdAt,
//       this.updatedAt,
//       this.path});
//
//   Images.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     psId = json['ps_id'];
//     name = json['name'];
//     thumb = json['thumb'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     path = json['path'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['ps_id'] = this.psId;
//     data['name'] = this.name;
//     data['thumb'] = this.thumb;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['path'] = this.path;
//     return data;
//   }
// }
//
// class Vendor {
//   String? vendorId;
//   String? uniqueId;
//   String? name;
//   String? username;
//   String? lastName;
//   String? businessName;
//   String? email;
//   String? mailingAddress;
//   String? address;
//   String? avgRating;
//   String? ratingCount;
//   String? lat;
//   String? lng;
//   String? address1;
//   String? suburb;
//   String? state;
//   String? city;
//   String? zipcode;
//   String? mobNo;
//   String? vendorStatus;
//   String? loginStatus;
//   String? vendorType;
//   String? walletAmount;
//   String? deviceid;
//   String? devicetype;
//   String? password;
//   String? marketArea;
//   String? serviceRadius;
//   String? driverLicense;
//   String? licenseExpiry;
//   String? licenseFront;
//   String? licenseBack;
//   String? ssn;
//   String? dob;
//   String? profileImg1;
//   String? profileImg2;
//   String? profileImg3;
//   String? profileImg4;
//   String? pvideo1;
//   String? pvideo2;
//   String? pvideo3;
//   String? type;
//   String? categoryId;
//   String? subCategoryId;
//   String? service;
//   String? permitType;
//   String? permitNumber;
//   String? permitExpiry;
//   String? description;
//   String? rememberToken;
//   String? otp;
//   String? forgetpassRequest;
//   String? forgetpassRequestStatus;
//   String? planId;
//   String? planPurchased;
//   String? planExpiry;
//   String? txnId;
//   String? createdAt;
//   String? updatedAt;
//   String? stripeId;
//   String? make;
//   String? model;
//   String? color;
//   String? year;
//   String? licensePlate;
//   String? views;
//   String? salesTax;
//   String? exciseTax;
//   String? cityTax;
//   String? commissionRate;
//   String? deliveryFee;
//   String? mapIcon;
//   String? typeOfMerchant;
//   String? cashCard;
//
//   Vendor(
//       {this.vendorId,
//       this.uniqueId,
//       this.name,
//       this.username,
//       this.lastName,
//       this.businessName,
//       this.email,
//       this.mailingAddress,
//       this.address,
//       this.avgRating,
//       this.ratingCount,
//       this.lat,
//       this.lng,
//       this.address1,
//       this.suburb,
//       this.state,
//       this.city,
//       this.zipcode,
//       this.mobNo,
//       this.vendorStatus,
//       this.loginStatus,
//       this.vendorType,
//       this.walletAmount,
//       this.deviceid,
//       this.devicetype,
//       this.password,
//       this.marketArea,
//       this.serviceRadius,
//       this.driverLicense,
//       this.licenseExpiry,
//       this.licenseFront,
//       this.licenseBack,
//       this.ssn,
//       this.dob,
//       this.profileImg1,
//       this.profileImg2,
//       this.profileImg3,
//       this.profileImg4,
//       this.pvideo1,
//       this.pvideo2,
//       this.pvideo3,
//       this.type,
//       this.categoryId,
//       this.subCategoryId,
//       this.service,
//       this.permitType,
//       this.permitNumber,
//       this.permitExpiry,
//       this.description,
//       this.rememberToken,
//       this.otp,
//       this.forgetpassRequest,
//       this.forgetpassRequestStatus,
//       this.planId,
//       this.planPurchased,
//       this.planExpiry,
//       this.txnId,
//       this.createdAt,
//       this.updatedAt,
//       this.stripeId,
//       this.make,
//       this.model,
//       this.color,
//       this.year,
//       this.licensePlate,
//       this.views,
//       this.salesTax,
//       this.exciseTax,
//       this.cityTax,
//       this.commissionRate,
//       this.deliveryFee,
//       this.mapIcon,
//       this.typeOfMerchant,
//       this.cashCard});
//
//   Vendor.fromJson(Map<String, dynamic> json) {
//     vendorId = json['vendor_id'];
//     uniqueId = json['unique_id'];
//     name = json['name'];
//     username = json['username'];
//     lastName = json['last_name'];
//     businessName = json['business_name'];
//     email = json['email'];
//     mailingAddress = json['mailing_address'];
//     address = json['address'];
//     avgRating = json['avg_rating'];
//     ratingCount = json['rating_count'];
//     lat = json['lat'];
//     lng = json['lng'];
//     address1 = json['address1'];
//     suburb = json['suburb'];
//     state = json['state'];
//     city = json['city'];
//     zipcode = json['zipcode'];
//     mobNo = json['mob_no'];
//     vendorStatus = json['vendor_status'];
//     loginStatus = json['login_status'];
//     vendorType = json['vendor_type'];
//     walletAmount = json['wallet_amount'];
//     deviceid = json['deviceid'];
//     devicetype = json['devicetype'];
//     password = json['password'];
//     marketArea = json['market_area'];
//     serviceRadius = json['service_radius'];
//     driverLicense = json['driver_license'];
//     licenseExpiry = json['license_expiry'];
//     licenseFront = json['license_front'];
//     licenseBack = json['license_back'];
//     ssn = json['ssn'];
//     dob = json['dob'];
//     profileImg1 = json['profile_img1'];
//     profileImg2 = json['profile_img2'];
//     profileImg3 = json['profile_img3'];
//     profileImg4 = json['profile_img4'];
//     pvideo1 = json['pvideo1'];
//     pvideo2 = json['pvideo2'];
//     pvideo3 = json['pvideo3'];
//     type = json['type'];
//     categoryId = json['category_id'];
//     subCategoryId = json['sub_category_id'];
//     service = json['service'];
//     permitType = json['permit_type'];
//     permitNumber = json['permit_number'];
//     permitExpiry = json['permit_expiry'];
//     description = json['description'];
//     rememberToken = json['remember_token'];
//     otp = json['otp'];
//     forgetpassRequest = json['forgetpass_request'];
//     forgetpassRequestStatus = json['forgetpass_request_status'];
//     planId = json['plan_id'];
//     planPurchased = json['plan_purchased'];
//     planExpiry = json['plan_expiry'];
//     txnId = json['txn_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     stripeId = json['stripe_id'];
//     make = json['make'];
//     model = json['model'];
//     color = json['color'];
//     year = json['year'];
//     licensePlate = json['license_plate'];
//     views = json['views'];
//     salesTax = json['sales_tax'];
//     exciseTax = json['excise_tax'];
//     cityTax = json['city_tax'];
//     commissionRate = json['commission_rate'];
//     deliveryFee = json['delivery_fee'];
//     mapIcon = json['map_icon'];
//     typeOfMerchant = json['type_of_merchant'];
//     cashCard = json['cash_card'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['vendor_id'] = this.vendorId;
//     data['unique_id'] = this.uniqueId;
//     data['name'] = this.name;
//     data['username'] = this.username;
//     data['last_name'] = this.lastName;
//     data['business_name'] = this.businessName;
//     data['email'] = this.email;
//     data['mailing_address'] = this.mailingAddress;
//     data['address'] = this.address;
//     data['avg_rating'] = this.avgRating;
//     data['rating_count'] = this.ratingCount;
//     data['lat'] = this.lat;
//     data['lng'] = this.lng;
//     data['address1'] = this.address1;
//     data['suburb'] = this.suburb;
//     data['state'] = this.state;
//     data['city'] = this.city;
//     data['zipcode'] = this.zipcode;
//     data['mob_no'] = this.mobNo;
//     data['vendor_status'] = this.vendorStatus;
//     data['login_status'] = this.loginStatus;
//     data['vendor_type'] = this.vendorType;
//     data['wallet_amount'] = this.walletAmount;
//     data['deviceid'] = this.deviceid;
//     data['devicetype'] = this.devicetype;
//     data['password'] = this.password;
//     data['market_area'] = this.marketArea;
//     data['service_radius'] = this.serviceRadius;
//     data['driver_license'] = this.driverLicense;
//     data['license_expiry'] = this.licenseExpiry;
//     data['license_front'] = this.licenseFront;
//     data['license_back'] = this.licenseBack;
//     data['ssn'] = this.ssn;
//     data['dob'] = this.dob;
//     data['profile_img1'] = this.profileImg1;
//     data['profile_img2'] = this.profileImg2;
//     data['profile_img3'] = this.profileImg3;
//     data['profile_img4'] = this.profileImg4;
//     data['pvideo1'] = this.pvideo1;
//     data['pvideo2'] = this.pvideo2;
//     data['pvideo3'] = this.pvideo3;
//     data['type'] = this.type;
//     data['category_id'] = this.categoryId;
//     data['sub_category_id'] = this.subCategoryId;
//     data['service'] = this.service;
//     data['permit_type'] = this.permitType;
//     data['permit_number'] = this.permitNumber;
//     data['permit_expiry'] = this.permitExpiry;
//     data['description'] = this.description;
//     data['remember_token'] = this.rememberToken;
//     data['otp'] = this.otp;
//     data['forgetpass_request'] = this.forgetpassRequest;
//     data['forgetpass_request_status'] = this.forgetpassRequestStatus;
//     data['plan_id'] = this.planId;
//     data['plan_purchased'] = this.planPurchased;
//     data['plan_expiry'] = this.planExpiry;
//     data['txn_id'] = this.txnId;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['stripe_id'] = this.stripeId;
//     data['make'] = this.make;
//     data['model'] = this.model;
//     data['color'] = this.color;
//     data['year'] = this.year;
//     data['license_plate'] = this.licensePlate;
//     data['views'] = this.views;
//     data['sales_tax'] = this.salesTax;
//     data['excise_tax'] = this.exciseTax;
//     data['city_tax'] = this.cityTax;
//     data['commission_rate'] = this.commissionRate;
//     data['delivery_fee'] = this.deliveryFee;
//     data['map_icon'] = this.mapIcon;
//     data['type_of_merchant'] = this.typeOfMerchant;
//     data['cash_card'] = this.cashCard;
//     return data;
//   }
// }
