class UserInfoData {
late  String id;
late String token;
late String name;
late  String lname;
late String email;
late String profileImage;
late String userMob;
late String userAddress;
late String userCity;
late  String userStates;
late String userZipcode;
late String userLat;
late String userLong;
late String avgRating;
late String ratingCount;
late  String userStatus;
late String devicetype;
late String devicetoken;
late String dob;

  UserInfoData(
      {required this.id,
        required this.token,
        required this.name,
        required  this.lname,
        required this.email,
        required  this.profileImage,
        required  this.userMob,
        required this.userAddress,
        required this.userCity,
        required this.userStates,
        required this.userZipcode,
        required this.userLat,
        required this.userLong,
        required this.avgRating,
        required  this.ratingCount,
        required this.userStatus,
        required this.devicetype,
        required this.devicetoken,
        required this.dob});
}
