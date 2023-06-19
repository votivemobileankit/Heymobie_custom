class NotificationListModel {
  late String userId;
 late  NotificationDetail notificationDetail;
 late int status;

  NotificationListModel({required this.userId,required this.notificationDetail,required this.status});

  NotificationListModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    notificationDetail = (json['notification_detail'] != null
        ? NotificationDetail.fromJson(json['notification_detail'])
        : null)!;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    if (this.notificationDetail != null) {
      data['notification_detail'] = this.notificationDetail.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class NotificationDetail {
 late int total;
 late int perPage;
late  int currentPage;
late  int lastPage;
 late List<Data> data;

  NotificationDetail(
      {required this.total,required this.perPage,required this.currentPage,required this.lastPage,required this.data});

  NotificationDetail.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['per_page'] = this.perPage;
    data['current_page'] = this.currentPage;
    data['last_page'] = this.lastPage;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
 late String notiId;
 late String notiUserid;
 late String notiTitle;
 late String notiDesc;
 late String notiDeviceid;
 late String notiRead;
 late  String agoTime;
 late  String createdAt;
 late String updatedAt;
 late String order_id;
 late String orderid;
 late String vendorId;

  Data(
      {required this.notiId,
        required this.notiUserid,
        required this.notiTitle,
        required  this.notiDesc,
        required  this.notiDeviceid,
        required this.notiRead,
        required this.agoTime,
        required this.createdAt,
        required this.updatedAt,
        required this.order_id,
        required   this.orderid,
        required  this.vendorId});

  Data.fromJson(Map<String, dynamic> json) {
    notiId = json['noti_id'];
    notiUserid = json['noti_userid'];
    notiTitle = json['noti_title'];
    notiDesc = json['noti_desc'];
    notiDeviceid = json['noti_deviceid'];
    notiRead = json['noti_read'];
    agoTime = json['ago_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    order_id = json['order_id'];
    orderid = json['orderid'];
    vendorId = json['vendor_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['noti_id'] = this.notiId;
    data['noti_userid'] = this.notiUserid;
    data['noti_title'] = this.notiTitle;
    data['noti_desc'] = this.notiDesc;
    data['noti_deviceid'] = this.notiDeviceid;
    data['noti_read'] = this.notiRead;
    data['ago_time'] = this.agoTime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['order_id'] = this.order_id;
    data['orderid'] = this.orderid;
    data['vendor_id'] = this.vendorId;
    return data;
  }
}
