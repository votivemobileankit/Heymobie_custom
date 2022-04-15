class StateListModel {
  String message;
  int status;
  StateData data;

  StateListModel({this.message, this.status, this.data});

  StateListModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new StateData.fromJson(json['data']) : null;
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

class StateData {
  List<StatesList> statesList;

  StateData({this.statesList});

  StateData.fromJson(Map<String, dynamic> json) {
    if (json['states_list'] != null) {
      statesList = [];
      json['states_list'].forEach((v) {
        statesList.add(new StatesList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.statesList != null) {
      data['states_list'] = this.statesList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StatesList {
  String name;
  String stateCode;

  StatesList({this.name, this.stateCode});

  StatesList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    stateCode = json['state_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['state_code'] = this.stateCode;
    return data;
  }
}
