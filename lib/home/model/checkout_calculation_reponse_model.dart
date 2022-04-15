class CheckOutResponseModel {
  String message;
  int status;
  DataResponse data;

  CheckOutResponseModel({this.message, this.status, this.data});

  CheckOutResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data =
        json['data'] != null ? new DataResponse.fromJson(json['data']) : null;
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

class DataResponse {
  String salesTax;
  String exciseTax;
  String cityTax;
  String deliveryFee;
  String subtotal;
  String grandtotal;
  String couponAmount;

  DataResponse(
      {this.salesTax,
      this.exciseTax,
      this.cityTax,
      this.deliveryFee,
      this.subtotal,
      this.grandtotal,
      this.couponAmount});

  DataResponse.fromJson(Map<String, dynamic> json) {
    salesTax = json['sales_tax'];
    exciseTax = json['excise_tax'];
    cityTax = json['city_tax'];
    deliveryFee = json['delivery_fee'];
    subtotal = json['subtotal'];
    grandtotal = json['grandtotal'];
    couponAmount = json['coupon_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sales_tax'] = this.salesTax;
    data['excise_tax'] = this.exciseTax;
    data['city_tax'] = this.cityTax;
    data['delivery_fee'] = this.deliveryFee;
    data['subtotal'] = this.subtotal;
    data['grandtotal'] = this.grandtotal;
    data['coupon_amount'] = this.couponAmount;
    return data;
  }
}
