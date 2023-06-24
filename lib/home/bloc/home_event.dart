import 'package:equatable/equatable.dart';
import 'package:grambunny_customer/home/model/cartlist_response_model.dart';
import 'package:grambunny_customer/home/model/category_list_model.dart';
import 'package:grambunny_customer/home/model/driver_list_model.dart';
import 'package:grambunny_customer/home/model/product_list_model.dart';
import 'package:grambunny_customer/home/model/statelist_reponse_model.dart';

import '../model/ps_list_model.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoginEventSignInButtonClick extends HomeEvent {}

class LoginEventSignInFromCheckOutPage extends HomeEvent {
  String strScreen;
  List<ItemsCart> productList;
  DriverList driverDetail;
  ProductListMenu productListModel;
  DataCart cartDataModel;

  LoginEventSignInFromCheckOutPage(this.strScreen, this.productList,
      this.driverDetail, this.productListModel, this.cartDataModel);

  @override
  List<Object> get props =>
      [strScreen, productList, driverDetail, productListModel, cartDataModel];
}

class LoginEventSignUpButtonClick extends HomeEvent {}

class LoginEventForgetPasswordClick extends HomeEvent {}

class LoginEventBackBtnClicked extends HomeEvent {}

class LoginEventLoginStateReset extends HomeEvent {}

class LoginEventBtnLoginClicked extends HomeEvent {
  String emailid;
  String password;
  String card_id;
  String devicetype;
  String os_name;
  String devicetoken;

  LoginEventBtnLoginClicked(this.emailid, this.password, this.card_id,
      this.devicetype, this.os_name, this.devicetoken);

  @override
  List<Object> get props =>
      [emailid, password, card_id, devicetype, os_name, devicetoken];
}

class SignUpEventSignUpBtnClick extends HomeEvent {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? mobileNO;
  String? devicetype;
  String? devicetoken;
  String? dob;
  String? address;
  String? city;
  String? state;
  String? zipcode;
  String? os_name;
  String? strUserProfilePath;
  String? strFrontLicensePath;
  String? strBackLicensePath;
  String? strCustomerType;
  String? strMarijuanaId;

  SignUpEventSignUpBtnClick(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      required this.mobileNO,
      required this.devicetype,
      required this.devicetoken,
      required this.dob,
      required this.address,
      required this.city,
      required this.state,
      required this.zipcode,
      required this.os_name,
      required this.strUserProfilePath,
      required this.strFrontLicensePath,
      required this.strBackLicensePath,
      required this.strCustomerType,
      required this.strMarijuanaId});

  @override
  List<Object> get props => [
        firstName!,
        lastName!,
        email!,
        password!,
        mobileNO!,
        devicetype!,
        devicetoken!,
        dob!,
        address!,
        city!,
        state!,
        zipcode!,
        os_name!,
        strUserProfilePath!,
        strFrontLicensePath!,
        strBackLicensePath!,
        strCustomerType!,
        strMarijuanaId!
      ];
}

class HomeEventCatgoryDetailClick extends HomeEvent {
  late DriverList driverDetail;
  late CategoryListModel categoryListModel;
  late String category_id;

  HomeEventCatgoryDetailClick(
      this.categoryListModel, this.driverDetail, this.category_id);

  @override
  List<Object> get props => [categoryListModel, driverDetail, category_id];
}

class HomeEventCartPageBtnClick extends HomeEvent {
  DriverList driverDetail;

  HomeEventCartPageBtnClick(this.driverDetail);

  @override
  List<Object> get props => [driverDetail];
}

class HomeEventCheckOutButtonClick extends HomeEvent {
  String strScreen;
  DriverList driverDetail;
  ProductListMenu productListModel;
  String vendorId;

  HomeEventCheckOutButtonClick(
      this.strScreen, this.driverDetail, this.productListModel, this.vendorId);

  @override
  List<Object> get props =>
      [strScreen, driverDetail, productListModel, vendorId];
}

class HomeEventSubmitOrderBtnClick extends HomeEvent {
  late String payMethod;
  late String mobile;
  late String address;
  late String city;
  late String zip;
  late String state;
  late String comment;
  late String cc_name;
  late String creditcardtype;
  late String cc_number;
  late String cc_expiration;
  late String cc_cvv;
  late String cc_expire_month;
  late String cc_expire_year;
  late String promo_amount;
  late String saletax;
  late String excisetax;
  late String citytax;
  late String vendorId;
  late String final_amount;
  late String sub_total;
  late String coupon_id;
  late String osName;
  late String deviceType;

  HomeEventSubmitOrderBtnClick(
      {required this.payMethod,
      required this.mobile,
      required this.address,
      required this.city,
      required this.state,
      required this.zip,
      required this.comment,
      required this.cc_name,
      required this.creditcardtype,
      required this.cc_number,
      required this.cc_expiration,
      required this.cc_cvv,
      required this.cc_expire_month,
      required this.cc_expire_year,
      required this.saletax,
      required this.promo_amount,
      required this.excisetax,
      required this.citytax,
      required this.vendorId,
      required this.final_amount,
      required this.sub_total,
      required this.coupon_id,
      required this.osName,
      required this.deviceType});

  @override
  List<Object> get props => [
        payMethod,
        mobile,
        address,
        city,
        state,
        zip,
        comment,
        cc_name,
        creditcardtype,
        cc_number,
        creditcardtype,
        cc_expiration,
        cc_cvv,
        cc_expire_month,
        cc_expire_year,
        saletax,
        promo_amount,
        excisetax,
        citytax,
        vendorId,
        final_amount,
        sub_total,
        coupon_id,
        osName,
        deviceType
      ];
}

class HomeEventProductDetailPageCartBtnClick extends HomeEvent {
  DriverList driverDetail;
  ProductListMenu productListModel;
  String strScreen;

  HomeEventProductDetailPageCartBtnClick(
      this.driverDetail, this.productListModel, this.strScreen);

  @override
  List<Object> get props => [driverDetail, productListModel, strScreen];
}

class HomeEventCouponListbtnClick extends HomeEvent {
  String vendorId;
  String strScreen;
  DriverList driverDetail;
  ProductListMenu productListModel;
  String couponCode;

  HomeEventCouponListbtnClick(this.vendorId, this.strScreen, this.driverDetail,
      this.productListModel, this.couponCode);

  @override
  List<Object> get props =>
      [vendorId, strScreen, driverDetail, productListModel, couponCode];
}

class HomeEventCouponListbtnApply extends HomeEvent {
  String vendorId;
  String strScreen;
  DriverList driverDetail;
  ProductListMenu productListModel;
  String couponCode;
  String couponId;
  String couponAmount;

  HomeEventCouponListbtnApply(this.vendorId, this.strScreen, this.driverDetail,
      this.productListModel, this.couponCode, this.couponAmount, this.couponId);

  @override
  List<Object> get props => [
        vendorId,
        strScreen,
        driverDetail,
        productListModel,
        couponCode,
        couponAmount,
        couponId
      ];
}

class HomeEventResetCheckOutState extends HomeEvent {
  String vendorId;
  String strScreen;
  DriverList driverDetail;
  ProductListMenu productListModel;

  HomeEventResetCheckOutState(
      this.strScreen, this.driverDetail, this.productListModel, this.vendorId);

  @override
  List<Object> get props =>
      [strScreen, driverDetail, productListModel, vendorId];
}

class HomeEventCartPageReset extends HomeEvent {
  DriverList driverDetail;
  String strScreen;
  ProductListMenu productListModel;
  DataCart cartDataModel;

  HomeEventCartPageReset(this.driverDetail, this.strScreen,
      this.productListModel, this.cartDataModel);

  @override
  List<Object> get props =>
      [driverDetail, strScreen, productListModel, cartDataModel];
}

class HomeEventAfterRefreshToCheckOutPage extends HomeEvent {
  String strScreen;
  String vendorId;
  List<StatesList> stateArrayList;
  DriverList driverDetail;
  ProductListMenu productListModel;

  HomeEventAfterRefreshToCheckOutPage(this.strScreen, this.vendorId,
      this.stateArrayList, this.driverDetail, this.productListModel);

  @override
  List<Object> get props =>
      [strScreen, vendorId, stateArrayList, driverDetail, productListModel];
}

class HomeEventCartDeleteItemClick extends HomeEvent {
  int productId;
  DriverList driverDetail;

  HomeEventCartDeleteItemClick(this.productId, this.driverDetail);

  @override
  List<Object> get props => [productId, driverDetail];
}

class HomeEventProductMenuSearch extends HomeEvent {
  String driverId;
  String categoryId;
  String searchText;
  CategoryListModel categoryListModel;
  DriverList driverDetail;

  HomeEventProductMenuSearch(this.driverId, this.categoryId, this.searchText,
      this.categoryListModel, this.driverDetail);

  @override
  List<Object> get props =>
      [driverId, categoryId, searchText, categoryListModel];
}

class HomeEventCategoryCartBtnClick extends HomeEvent {
  HomeEventCategoryCartBtnClick();

  @override
  List<Object> get props => [];
}

class HomeEventDriverListCartBtnClick extends HomeEvent {
  HomeEventDriverListCartBtnClick();

  @override
  List<Object> get props => [];
}

class HomeEventApplyFilter extends HomeEvent {
  late String driverId;
  late String categoryId;
  late String subCategoryId;
  late String weight;
  late String brand;
  late String type;
  late String potencyThcStart;
  late String potencyThcEnd;
  late String potencyCbdStart;
  late String potencyCbdEnd;
  late String popular;
  late DriverList driverDetail;

  HomeEventApplyFilter(
      {required this.driverId,
      required this.categoryId,
      required this.subCategoryId,
      required this.weight,
      required this.brand,
      required this.type,
      required this.potencyThcStart,
      required this.potencyThcEnd,
      required this.potencyCbdStart,
      required this.potencyCbdEnd,
      required this.popular,
      required this.driverDetail});

  @override
  List<Object> get props => [
        driverId,
        categoryId,
        subCategoryId,
        weight,
        brand,
        type,
        potencyThcStart,
        potencyThcEnd,
        potencyCbdStart,
        potencyCbdEnd,
        popular,
        driverDetail
      ];
}

class HomeEventApplyResetProductList extends HomeEvent {
  late String driverId;
  late String categoryId;
  late String subCategoryId;
  late String weight;
  late String brand;
  late String type;
  late String potencyThc;
  late String potencyCbd;
  late String popular;
  late DriverList driverDetail;

  HomeEventApplyResetProductList(
      {required this.driverId,
      required this.categoryId,
      required this.subCategoryId,
      required this.weight,
      required this.brand,
      required this.type,
      required this.potencyThc,
      required this.potencyCbd,
      required this.popular,
      required this.driverDetail});

  @override
  List<Object> get props => [
        driverId,
        categoryId,
        subCategoryId,
        weight,
        brand,
        type,
        potencyThc,
        potencyCbd,
        popular,
        driverDetail
      ];
}

class HomeEventMenuListItemClick extends HomeEvent {
  late ProductListMenu productList;
  late String driverId;
  late DriverList driverDetail;
  late String screen;

  HomeEventMenuListItemClick(
      this.productList, this.driverId, this.driverDetail, this.screen);

  @override
  List<Object> get props => [productList, driverId, driverDetail, screen];
}

class HomeEventDriverProductListClick extends HomeEvent {
  late String driverId;
  late String screen;
  late int productId;
  late ProductListDriver driverProductList;
  late Vendor driverDetail;

  HomeEventDriverProductListClick(
      this.driverProductList, this.driverDetail, this.screen, this.productId);

  @override
  List<Object> get props =>
      [driverProductList, driverDetail, screen, productId];
}

// class HomeEventDriverTicketListClick extends HomeEvent {
//   late String driverId;
//   late String screen;
//   late int productId;
//   late ProductListDriver driverProductList;
//   late Vendor driverDetail;
//
//   HomeEventDriverTicketListClick(
//       this.driverProductList, this.driverDetail, this.screen, this.productId);
//
//   @override
//   List<Object> get props =>
//       [driverProductList, driverDetail, screen, productId];
// }

class HomeEventDriverTicketListClick extends HomeEvent {
  String merchant_id;
  String ps_id;
  String type;
  ProductListDriver driverProductList;

  HomeEventDriverTicketListClick(
      this.merchant_id, this.ps_id, this.type, this.driverProductList);

  @override
  List<Object> get props => [merchant_id, ps_id, type, driverProductList];
}

class HomeEventProductItemDetailPageReset extends HomeEvent {
  late ProductListMenu productListModel;
  late String driverId;
  late DriverList driverDetail;

  HomeEventProductItemDetailPageReset(this.productListModel, this.driverDetail);

  @override
  List<Object> get props => [productListModel, driverDetail];
}

class HomeEventBackBtnClick extends HomeEvent {
  HomeEventBackBtnClick();

  // TODO: implement props
  @override
  List<Object> get props => [];
}

class HomeEventBackForCheckOutScreen extends HomeEvent {
  HomeEventBackForCheckOutScreen();

  // TODO: implement props
  @override
  List<Object> get props => [];
}

class HomeEventCouponApplyBtnClick extends HomeEvent {
  HomeEventCouponApplyBtnClick();

  // TODO: implement props
  @override
  List<Object> get props => [];
}

class ResetPasswordPageEvent extends HomeEvent {
  String email;

  ResetPasswordPageEvent(this.email);

  // TODO: implement props
  @override
  List<Object> get props => [email];
}

class ForgotPasswordEventVerifyBtnClick extends HomeEvent {
  String emailID;

  ForgotPasswordEventVerifyBtnClick(this.emailID);

  @override
  List<Object> get props => [emailID];
}

class ResetPasswordEventResetBtnClick extends HomeEvent {
  String email;
  String password;

  ResetPasswordEventResetBtnClick(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class ResetPasswordPageResetPageEvent extends HomeEvent {
  String email;

  ResetPasswordPageResetPageEvent(this.email);

  @override
  List<Object> get props => [email];
}

class HomeEventForOTPScreen extends HomeEvent {
  String emai_id;
  String from;

  HomeEventForOTPScreen(this.emai_id, this.from);

  // TODO: implement props
  @override
  List<Object> get props => [emai_id, from];
}

class OTPEventOTPVerifyButton extends HomeEvent {
  String email;
  String otp;
  String from;

  OTPEventOTPVerifyButton(this.email, this.otp, this.from);

  @override
  List<Object> get props => [email, otp, from];
}

class OTPEventOTPResendButton extends HomeEvent {
  String email;
  String from;

  OTPEventOTPResendButton(this.email, this.from);

  @override
  List<Object> get props => [email, from];
}

class HomeEventBackForProductDetailPage extends HomeEvent {
  DriverList driverDetail;
  ProductListMenu productListModel;

  HomeEventBackForProductDetailPage(this.driverDetail, this.productListModel);

  // TODO: implement props
  @override
  List<Object> get props => [driverDetail, productListModel];
}

class HomeEventBackForCategoryPage extends HomeEvent {
  DriverList driverDetail;

  HomeEventBackForCategoryPage(this.driverDetail);

  // TODO: implement props
  @override
  List<Object> get props => [driverDetail];
}

class HomeEventBackForProductListpage extends HomeEvent {
  HomeEventBackForProductListpage();

  // TODO: implement props
  @override
  List<Object> get props => [];
}

class HomeEventSettingSideNavigationClick extends HomeEvent {}

class HomeEventtabChangeToHome extends HomeEvent {}

class HomeEventCategoryList extends HomeEvent {}

class HomeEventDriverItemClick extends HomeEvent {
  DriverList driverDetail;

  HomeEventDriverItemClick(this.driverDetail);

  @override
  List<Object> get props => [driverDetail];
}

class HomeEventDriverListApiCallLoading extends HomeEvent {
  double currentLat, currentLong;

  String keyword, searchBy;

  HomeEventDriverListApiCallLoading(
      this.currentLat, this.currentLong, this.keyword, this.searchBy);

  @override
  List<Object> get props => [currentLat, currentLong, keyword, searchBy];
}

class HomeEventCategoryListLoadingComplete extends HomeEvent {
  DriverList driverDetail;

  HomeEventCategoryListLoadingComplete(this.driverDetail);

  @override
  List<Object> get props => [driverDetail];
}

class HomeEventDriverPageReset extends HomeEvent {}

class HomeEventAddToCartBtnClick extends HomeEvent {
  int quantity;
  int productId;
  String driverId;
  int decrease;
  DriverList driverDetail;
  String isNewDriver;
  String specialInstruction;

  HomeEventAddToCartBtnClick(
      this.quantity,
      this.productId,
      this.driverId,
      this.decrease,
      this.driverDetail,
      this.isNewDriver,
      this.specialInstruction);

  @override
  List<Object> get props => [
        quantity,
        productId,
        driverId,
        decrease,
        driverDetail,
        isNewDriver,
        specialInstruction
      ];
}

class HomeEventTicketItemClickPurchaseTicketBtnClick extends HomeEvent {
  int quantity;
  int productId;
  String driverId;
  int decrease;

  //DriverList driverDetail;
  String newDriver;
  String specialInstruction;

  HomeEventTicketItemClickPurchaseTicketBtnClick(
      // this.quantity,
      this.quantity,
      this.productId,
      this.driverId,
      this.decrease,
      //  this.driverDetail,
      this.newDriver,
      this.specialInstruction);

  @override
  List<Object> get props => [
        quantity,
        productId,
        driverId,
        decrease,
        //driverDetail,
        newDriver,
        specialInstruction
      ];
}

class HomeEventItemClickAddToCartBtnClick extends HomeEvent {
  int quantity;
  int productId;
  String driverId;
  int decrease;
  DriverList driverDetail;
  String newDriver;
  String specialInstruction;

  HomeEventItemClickAddToCartBtnClick(
      this.quantity,
      this.productId,
      this.driverId,
      this.decrease,
      this.driverDetail,
      this.newDriver,
      this.specialInstruction);

  @override
  List<Object> get props => [
        quantity,
        productId,
        driverId,
        decrease,
        driverDetail,
        newDriver,
        specialInstruction
      ];
}

class HomeEventSubmitRatingBtnClick extends HomeEvent {
  String ratingCount;
  String reviewText;
  int productId;

  HomeEventSubmitRatingBtnClick(
      this.ratingCount, this.reviewText, this.productId);

  @override
  List<Object> get props => [ratingCount, reviewText, productId];
}

class HomeEventLoadMoreBtnClick extends HomeEvent {
  String? pageCount;
  String? productId;
  ProductListDriver? productListDriverModel;
  String? strScreen;
  DriverList? driverDetail;
  Vendor? vendorDetails;

  HomeEventLoadMoreBtnClick(this.pageCount, this.productId,
      this.productListDriverModel, this.strScreen, this.vendorDetails);

  @override
  List<Object> get props => [
        pageCount!,
        productId!,
        productListDriverModel!,
        strScreen!,
        driverDetail!,
        vendorDetails!
      ];
}

class HomeEventItemAddMinusToCartBtnClick extends HomeEvent {
  int quantity;
  int productId;
  String driverId;
  int decrease;
  DriverList driverDetail;
  String strScreen;
  ProductListMenu productListModel;

  HomeEventItemAddMinusToCartBtnClick(
      this.quantity,
      this.productId,
      this.driverId,
      this.decrease,
      this.driverDetail,
      this.strScreen,
      this.productListModel);

  @override
  List<Object> get props => [
        quantity,
        productId,
        driverId,
        decrease,
        driverDetail,
        strScreen,
        productListModel
      ];
}

class HomeEventProductDetailPageReset extends HomeEvent {
  ProductListMenu productListModel;
  String driverId;
  DriverList driverDetail;

  HomeEventProductDetailPageReset(
      this.productListModel, this.driverId, this.driverDetail);

  @override
  List<Object> get props => [productListModel, driverId, driverDetail];
}

class HomeEventEventDetailPageReset extends HomeEvent {
  List<EventDetailsList>? eventdetaillist;

  String driverId;
  DriverList driverDetail;

  HomeEventEventDetailPageReset(
      this.eventdetaillist, this.driverId, this.driverDetail);

  @override
  List<Object> get props => [eventdetaillist!, driverId, driverDetail];
}

class HomeEventCategoryPageReset extends HomeEvent {
  DriverList driverDetail;

  HomeEventCategoryPageReset(this.driverDetail);

  @override
  List<Object> get props => [driverDetail];
}

class HomeEventViewCartButtonClick extends HomeEvent {
  HomeEventViewCartButtonClick();

  @override
  List<Object> get props => [];
}
