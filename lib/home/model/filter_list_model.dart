class FilterListModel {
 late String message;
 late int status;
  late Data1 data;

  FilterListModel({required this.message,required this.status,required this.data});

  FilterListModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = (json['data'] != null ? new Data1.fromJson(json['data']) : null)!;
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
 late List<Subcategories> subcategories;
 late List<Weights> weights;
 late List<Brands> brands;
 late List<Types> types;

  Data1({required this.subcategories,required this.weights,required this.brands,required this.types});

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
 late String id;
 late String subcategory;

  Subcategories({required this.id,required this.subcategory});

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
 late String id;
late  String weight;

  Weights({required this.id,required this.weight});

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
 late String id;
 late String brand;

  Brands({required this.id,required this.brand});

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
 late String id;
late  String type;

  Types({required this.id, required this.type});

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
