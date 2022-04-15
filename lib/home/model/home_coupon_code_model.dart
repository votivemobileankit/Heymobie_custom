class CouponCodeListModel {
  String flatRate;
  String parcent;
  String message;
  int status;
  List<Couponlist> couponlist;

  CouponCodeListModel(
      {this.flatRate,
      this.parcent,
      this.message,
      this.status,
      this.couponlist});

  CouponCodeListModel.fromJson(Map<String, dynamic> json) {
    flatRate = json['flat_rate'];
    parcent = json['parcent'];
    message = json['message'];
    status = json['status'];
    if (json['couponlist'] != null) {
      couponlist = [];
      json['couponlist'].forEach((v) {
        couponlist.add(new Couponlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flat_rate'] = this.flatRate;
    data['parcent'] = this.parcent;
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.couponlist != null) {
      data['couponlist'] = this.couponlist.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Couponlist {
  String id;
  String vendorId;
  String name;
  String coupon;
  String discount;
  String amount;
  String applyMinAmount;
  String status;
  String createdAt;
  String validTill;
  String perUser;
  String usageLimit;
  String description;
  String updatedAt;

  Couponlist(
      {this.id,
      this.vendorId,
      this.name,
      this.coupon,
      this.discount,
      this.amount,
      this.applyMinAmount,
      this.status,
      this.createdAt,
      this.validTill,
      this.perUser,
      this.usageLimit,
      this.description,
      this.updatedAt});

  Couponlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    name = json['name'];
    coupon = json['coupon'];
    discount = json['discount'];
    amount = json['amount'];
    applyMinAmount = json['apply_min_amount'];
    status = json['status'];
    createdAt = json['created_at'];
    validTill = json['valid_till'];
    perUser = json['per_user'];
    usageLimit = json['usage_limit'];
    description = json['description'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['name'] = this.name;
    data['coupon'] = this.coupon;
    data['discount'] = this.discount;
    data['amount'] = this.amount;
    data['apply_min_amount'] = this.applyMinAmount;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['valid_till'] = this.validTill;
    data['per_user'] = this.perUser;
    data['usage_limit'] = this.usageLimit;
    data['description'] = this.description;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
