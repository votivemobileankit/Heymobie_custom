class RideHistoryModel {
  int? status;
  String? message;
  int? totalpage;
  Items? items;

  RideHistoryModel({this.status, this.message, this.totalpage, this.items});

  RideHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    totalpage = json['totalpage'];
    items = json['items'] != null ? new Items.fromJson(json['items']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['totalpage'] = this.totalpage;
    if (this.items != null) {
      data['items'] = this.items!.toJson();
    }
    return data;
  }
}

class Items {
  int? currentPage;
  List<RideHistoryListData>? rideHistoryList;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  Null? prevPageUrl;
  int? to;
  int? total;

  Items(
      {this.currentPage,
      this.rideHistoryList,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  Items.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      rideHistoryList = <RideHistoryListData>[];
      json['data'].forEach((v) {
        rideHistoryList!.add(new RideHistoryListData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.rideHistoryList != null) {
      data['data'] = this.rideHistoryList!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class RideHistoryListData {
  String? orderId;
  String? id;
  String? status;
  String? paymentMethod;
  String? payStatus;
  String? createdAt;
  String? total;
  String? pickAddress;
  String? dropAddress;
  String? vendorId;
  String? username;
  String? name;
  String? lastName;

  RideHistoryListData(
      {this.orderId,
      this.id,
      this.status,
      this.paymentMethod,
      this.payStatus,
      this.createdAt,
      this.total,
      this.pickAddress,
      this.dropAddress,
      this.vendorId,
      this.username,
      this.name,
      this.lastName});

  RideHistoryListData.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    id = json['id'];
    status = json['status'];
    paymentMethod = json['payment_method'];
    payStatus = json['pay_status'];
    createdAt = json['created_at'];
    total = json['total'];
    pickAddress = json['pick_address'];
    dropAddress = json['drop_address'];
    vendorId = json['vendor_id'];
    username = json['username'];
    name = json['name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['id'] = this.id;
    data['status'] = this.status;
    data['payment_method'] = this.paymentMethod;
    data['pay_status'] = this.payStatus;
    data['created_at'] = this.createdAt;
    data['total'] = this.total;
    data['pick_address'] = this.pickAddress;
    data['drop_address'] = this.dropAddress;
    data['vendor_id'] = this.vendorId;
    data['username'] = this.username;
    data['name'] = this.name;
    data['last_name'] = this.lastName;
    return data;
  }
}
