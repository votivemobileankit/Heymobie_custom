class CheckOutResponseModel {
  late String message;
  late int status;
  late DataResponse data;

  CheckOutResponseModel(
      {required this.message, required this.status, required this.data});

  CheckOutResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = (json['data'] != null
        ? new DataResponse.fromJson(json['data'])
        : null)!;
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
  late String salesTax;
  late String exciseTax;
  late String cityTax;
  late String delivery_fee;
  String? ticket_fee;
  String? ticket_service_fee;
  late String subtotal;
  late String grandtotal;
  late String couponAmount;

  DataResponse(
      {required this.salesTax,
      required this.exciseTax,
      required this.cityTax,
      required this.delivery_fee,
      required this.ticket_fee,
      required this.ticket_service_fee,
      required this.subtotal,
      required this.grandtotal,
      required this.couponAmount});

  DataResponse.fromJson(Map<String, dynamic> json) {
    salesTax = json['sales_tax'];
    exciseTax = json['excise_tax'];
    cityTax = json['city_tax'];
    delivery_fee = json['delivery_fee'];
    ticket_fee = json['ticket_fee'];
    ticket_service_fee = json['ticket_service_fee'];
    subtotal = json['subtotal'];
    grandtotal = json['grandtotal'];
    couponAmount = json['coupon_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sales_tax'] = this.salesTax;
    data['excise_tax'] = this.exciseTax;
    data['city_tax'] = this.cityTax;
    data['delivery_fee'] = this.delivery_fee;
    data['ticket_fee'] = this.ticket_fee;
    data['ticket_service_fee'] = this.ticket_service_fee;
    data['subtotal'] = this.subtotal;
    data['grandtotal'] = this.grandtotal;
    data['coupon_amount'] = this.couponAmount;
    return data;
  }
}
