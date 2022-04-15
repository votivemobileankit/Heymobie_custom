class FilterListModel {
  String message;
  int status;
  Data1 data;

  FilterListModel({this.message, this.status, this.data});

  FilterListModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new Data1.fromJson(json['data']) : null;
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

class Data1 {
  List<Subcategories> subcategories;
  List<Weights> weights;
  List<Brands> brands;
  List<Types> types;

  Data1({this.subcategories, this.weights, this.brands, this.types});

  Data1.fromJson(Map<String, dynamic> json) {
    if (json['subcategories'] != null) {
      subcategories = [];
      json['subcategories'].forEach((v) {
        subcategories.add(new Subcategories.fromJson(v));
      });
    }
    if (json['weights'] != null) {
      weights = [];
      json['weights'].forEach((v) {
        weights.add(new Weights.fromJson(v));
      });
    }
    if (json['brands'] != null) {
      brands = [];
      json['brands'].forEach((v) {
        brands.add(new Brands.fromJson(v));
      });
    }
    if (json['types'] != null) {
      types = [];
      json['types'].forEach((v) {
        types.add(new Types.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subcategories != null) {
      data['subcategories'] =
          this.subcategories.map((v) => v.toJson()).toList();
    }
    if (this.weights != null) {
      data['weights'] = this.weights.map((v) => v.toJson()).toList();
    }
    if (this.brands != null) {
      data['brands'] = this.brands.map((v) => v.toJson()).toList();
    }
    if (this.types != null) {
      data['types'] = this.types.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subcategories {
  String id;
  String subcategory;

  Subcategories({this.id, this.subcategory});

  Subcategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subcategory = json['subcategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subcategory'] = this.subcategory;
    return data;
  }
}

class Weights {
  String id;
  String weight;

  Weights({this.id, this.weight});

  Weights.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['weight'] = this.weight;
    return data;
  }
}

class Brands {
  String id;
  String brand;

  Brands({this.id, this.brand});

  Brands.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brand = json['brand'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brand'] = this.brand;
    return data;
  }
}

class Types {
  String id;
  String type;

  Types({this.id, this.type});

  Types.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    return data;
  }
}
