class VendorLocationModel {
  String message;
  int status;
  Location location;

  VendorLocationModel({this.message, this.status, this.location});

  VendorLocationModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    location =
        json['data'] != null ? new Location.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.location != null) {
      data['data'] = this.location.toJson();
    }
    return data;
  }
}

class Location {
  List<VendorLatlng> vendorLatlng;

  Location({this.vendorLatlng});

  Location.fromJson(Map<String, dynamic> json) {
    if (json['vendor_latlng'] != null) {
      vendorLatlng = [];
      json['vendor_latlng'].forEach((v) {
        vendorLatlng.add(new VendorLatlng.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.vendorLatlng != null) {
      data['vendor_latlng'] = this.vendorLatlng.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VendorLatlng {
  String lat;
  String lng;

  VendorLatlng({this.lat, this.lng});

  VendorLatlng.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
