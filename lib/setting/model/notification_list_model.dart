class NotificationListModel {
  String userId;
  NotificationDetail notificationDetail;
  int status;

  NotificationListModel({this.userId, this.notificationDetail, this.status});

  NotificationListModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    notificationDetail = json['notification_detail'] != null
        ? NotificationDetail.fromJson(json['notification_detail'])
        : null;
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
  int total;
  int perPage;
  int currentPage;
  int lastPage;
  List<Data> data;

  NotificationDetail(
      {this.total, this.perPage, this.currentPage, this.lastPage, this.data});

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
  String notiId;
  String notiUserid;
  String notiTitle;
  String notiDesc;
  String notiDeviceid;
  String notiRead;
  String agoTime;
  String createdAt;
  String updatedAt;
  String order_id;
  String orderid;
  String vendorId;

  Data(
      {this.notiId,
      this.notiUserid,
      this.notiTitle,
      this.notiDesc,
      this.notiDeviceid,
      this.notiRead,
      this.agoTime,
      this.createdAt,
      this.updatedAt,
      this.order_id,
      this.orderid,
      this.vendorId});

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
