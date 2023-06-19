class OrderHistoryModel {
late  int status;
late String message;
late  Items items;
late int totalpage;

  OrderHistoryModel({required this.status,required this.message,required this.items,required this.totalpage});

  OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    items = (json['items'] != null ? new Items.fromJson(json['items']) : null)!;
    totalpage = json['totalpage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.items != null) {
      data['items'] = this.items.toJson();
    }
    data['totalpage'] = this.totalpage;
    return data;
  }
}

class Items {
 late int currentPage;
 late List<HistoryList> data;
 late  String firstPageUrl;
 late int from;
 late int lastPage;
 late  String lastPageUrl;
 late String nextPageUrl;
 late String path;
 late int perPage;
 late  String prevPageUrl;
 late int to;
 late int total;

  Items(
      {required this.currentPage,
        required this.data,
        required this.firstPageUrl,
        required  this.from,
        required this.lastPage,
        required this.lastPageUrl,
        required this.nextPageUrl,
        required this.path,
        required  this.perPage,
        required this.prevPageUrl,
        required this.to,
        required this.total});

  Items.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new HistoryList.fromJson(v));
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
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
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

class HistoryList {
late  String orderId;
late String id;
late String status;
late String paymentMethod;
late String payStatus;
late String createdAt;
late String total;
late String vendorId;
late String username;
late String name;
late  String lastName;

  HistoryList(
      {required this.orderId,
        required this.id,
        required this.status,
        required  this.paymentMethod,
        required  this.payStatus,
        required this.createdAt,
        required  this.total,
        required  this.vendorId,
        required  this.username,
        required  this.name,
        required  this.lastName});

  HistoryList.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    id = json['id'];
    status = json['status'];
    paymentMethod = json['payment_method'];
    payStatus = json['pay_status'];
    createdAt = json['created_at'];
    total = json['total'];
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
    data['vendor_id'] = this.vendorId;
    data['username'] = this.username;
    data['name'] = this.name;
    data['last_name'] = this.lastName;
    return data;
  }
}

// class OrderHistoryModel {
//   String message;
//   int status;
//
//   // HistoryData data;
//   List<HistoryList> items;
//
//   OrderHistoryModel({this.message, this.status, this.items});
//
//   OrderHistoryModel.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     status = json['status'];
//     if (json['items'] != null) {
//       items = [];
//       json['items'].forEach((v) {
//         items.add(HistoryList.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['message'] = this.message;
//     data['status'] = this.status;
//
//     if (items != null) {
//       data['items'] = items.map((v) => v.toJson()).toList();
//     }
//
//     return data;
//   }
// }
//
// class HistoryList {
//   String orderId;
//   String id;
//   String status;
//   String paymentMethod;
//   String payStatus;
//   String createdAt;
//   String total;
//   String vendorId;
//   String username;
//   String name;
//   String lastName;
//
//   HistoryList(
//       {this.orderId,
//         this.id,
//         this.status,
//         this.paymentMethod,
//         this.payStatus,
//         this.createdAt,
//         this.total,
//         this.vendorId,
//         this.username,
//         this.lastName,
//         this.name});
//
//   HistoryList.fromJson(Map<String, dynamic> json) {
//     orderId = json['order_id'];
//     id = json['id'];
//     status = json['status'];
//     paymentMethod = json['payment_method'];
//     payStatus = json['pay_status'];
//     createdAt = json['created_at'];
//     total = json['total'];
//     vendorId = json['vendor_id'];
//     username = json['username'];
//     lastName = json['last_name'];
//     name = json['name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['order_id'] = this.orderId;
//     data['id'] = this.id;
//     data['status'] = this.status;
//     data['payment_method'] = this.paymentMethod;
//     data['pay_status'] = this.payStatus;
//     data['created_at'] = this.createdAt;
//     data['total'] = this.total;
//     data['vendor_id'] = this.vendorId;
//     data['username'] = this.username;
//     data['last_name'] = this.lastName;
//     data['name'] = this.name;
//     return data;
//   }
// }
