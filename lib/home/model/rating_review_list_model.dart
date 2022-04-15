class ReviewListModel {
  String message;
  int status;
  DataRating data;

  ReviewListModel({this.message, this.status, this.data});

  ReviewListModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? DataRating.fromJson(json['data']) : null;
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

class DataRating {
  List<RatingReviewData> ratingReviewData;
  String totalUserRating;
  String imageurl;

  DataRating({this.ratingReviewData, this.totalUserRating, this.imageurl});

  DataRating.fromJson(Map<String, dynamic> json) {
    if (json['ratingReviewData'] != null) {
      ratingReviewData = [];
      json['ratingReviewData'].forEach((v) {
        ratingReviewData.add(new RatingReviewData.fromJson(v));
      });
    }
    totalUserRating = json['totalUserRating'];
    imageurl = json['imageurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ratingReviewData != null) {
      data['ratingReviewData'] =
          this.ratingReviewData.map((v) => v.toJson()).toList();
    }
    data['totalUserRating'] = this.totalUserRating;
    data['imageurl'] = this.imageurl;
    return data;
  }
}

class RatingReviewData {
  String profileImage;
  String name;
  String lname;
  String rating;
  String review;
  String createdAt;

  RatingReviewData(
      {this.profileImage,
      this.name,
      this.lname,
      this.rating,
      this.review,
      this.createdAt});

  RatingReviewData.fromJson(Map<String, dynamic> json) {
    profileImage = json['profile_image'];
    name = json['name'];
    lname = json['lname'];
    rating = json['rating'];
    review = json['review'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_image'] = this.profileImage;
    data['name'] = this.name;
    data['lname'] = this.lname;
    data['rating'] = this.rating;
    data['review'] = this.review;
    data['created_at'] = this.createdAt;

    return data;
  }
}
