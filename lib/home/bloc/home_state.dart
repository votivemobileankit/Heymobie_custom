import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter_platform_interface/src/types/bitmap.dart';
import 'package:grambunny_customer/home/model/cartlist_response_model.dart';
import 'package:grambunny_customer/home/model/category_list_model.dart';
import 'package:grambunny_customer/home/model/checkout_calculation_reponse_model.dart';
import 'package:grambunny_customer/home/model/driver_list_model.dart';
import 'package:grambunny_customer/home/model/home_coupon_code_model.dart';
import 'package:grambunny_customer/home/model/login_model.dart';
import 'package:grambunny_customer/home/model/product_list_model.dart';
import 'package:grambunny_customer/home/model/rating_review_list_model.dart';
import 'package:grambunny_customer/home/model/related_product_model.dart';
import 'package:grambunny_customer/home/model/statelist_reponse_model.dart';

import '../model/ps_list_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class CartpageFromTicketDetailState extends HomeState {
  List<ItemsCart> cartlist;
  DataCart? cartDataModel;
  String strScreen;
  List<AddonProductList> addOnProductList;
  List<RelatedProductList> relatedProductList;
  List<EventDetailsList> eventdetaillist;
  ProductListDriver? productListDriverModel;
  ProductListMenu productListModel;
  DriverList? driverDetail;
  Vendor? vendorDetails;

  CartpageFromTicketDetailState(
      this.cartlist,
      this.cartDataModel,
      this.strScreen,
      this.addOnProductList,
      this.relatedProductList,
      this.eventdetaillist,
      this.productListDriverModel,
      this.productListModel,
      this.driverDetail,
      this.vendorDetails);

  @override
  List<Object> get props => [
        cartlist,
        cartDataModel!,
        strScreen,
        addOnProductList,
        relatedProductList,
        eventdetaillist,
        productListDriverModel!,
        productListModel,
        driverDetail!,
        vendorDetails!
      ];
}

class LoginPageState extends HomeState {
  String? strScreen;

  LoginPageState(this.strScreen);

  @override
  List<Object> get props => [strScreen!];
}

class LoginPageStateFromCheckOut extends HomeState {
  String strScreen;
  List<ItemsCart> productList;
  DriverList driverDetail;
  ProductListMenu productListModel;
  DataCart cartDataModel;

  LoginPageStateFromCheckOut(this.strScreen, this.productList,
      this.driverDetail, this.productListModel, this.cartDataModel);

  @override
  List<Object> get props =>
      [strScreen, productList, driverDetail, productListModel, cartDataModel];
}

class SignUpPageState extends HomeState {
  List<StatesList> stateArrayList;

  SignUpPageState(this.stateArrayList);

  @override
  List<Object> get props => [stateArrayList];
}

class HomeInitial extends HomeState {}

class HomeInitialReset extends HomeState {}

class ForgetPwdPageState extends HomeState {}

class OTPpageState extends HomeState {
  String email_id;
  String from;

  OTPpageState(this.email_id, this.from);

  @override
  List<Object> get props => [email_id, from];
}

class OtpApiLoadingCompleteState extends HomeState {
  String message;
  String email;
  UserDetail userArray;

  OtpApiLoadingCompleteState(this.message, this.email, this.userArray);

  @override
  List<Object> get props => [message, email, userArray];
}

class ForgotPasswordApiLoadingCompleteState extends HomeState {
  String message;
  String email;

  ForgotPasswordApiLoadingCompleteState(this.message, this.email);

  @override
  List<Object> get props => [message, email];
}

class ForgotPasswordApiLoadingErrorState extends HomeState {
  String message;

  ForgotPasswordApiLoadingErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class ResetPasswordPageState extends HomeState {
  String email;

  ResetPasswordPageState(this.email);

  @override
  List<Object> get props => [email];
}

class ResetPasswordApiLoadingCompleteState extends HomeState {
  String message;

  ResetPasswordApiLoadingCompleteState(this.message);

  @override
  List<Object> get props => [message];
}

class ResetPasswordApiLoadingErrorState extends HomeState {
  String message;
  String email;

  ResetPasswordApiLoadingErrorState(this.message, this.email);

  List<Object> get props => [message, email];
}

class OtpResendApiLoadingCompleteState extends HomeState {
  String message;

  OtpResendApiLoadingCompleteState(this.message);

  @override
  List<Object> get props => [message];
}

class OtpResendApiLoadingErrorState extends HomeState {
  String message;

  OtpResendApiLoadingErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class OtpApiLoadingErrorState extends HomeState {
  String message;

  OtpApiLoadingErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class LoginLoadingCompleteState extends HomeState {
  String message;
  UserDetail userDetail;

  LoginLoadingCompleteState(this.message, this.userDetail);

  @override
  List<Object> get props => [message, userDetail];
}

class LoginLoadingErrorState extends HomeState {
  String message;

  LoginLoadingErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class SignUpLoadingCompleteState extends HomeState {
  String message;
  String email;

  SignUpLoadingCompleteState(this.message, this.email);

  @override
  List<Object> get props => [message, email];
}

class SignUpLoadingErrorState extends HomeState {
  String message;

  SignUpLoadingErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class HomeCategoryProductPageState extends HomeState {
  String vendorId;
  CategoryListModel categoryListModel;
  List<ProductListMenu> productListArray;

  //FilterListModel filterData;
  String category_id;
  DriverList driverDetail;
  String cartCount;

  HomeCategoryProductPageState(
      this.vendorId,
      this.productListArray,
      this.categoryListModel,
      this.category_id,
      this.driverDetail,
      this.cartCount);

  @override
  List<Object> get props => [
        vendorId,
        productListArray,
        categoryListModel,
        category_id,
        driverDetail,
        cartCount
      ];
}

class HomeLoginPageState extends HomeState {}

class HomeSettingPageState extends HomeState {
  List<double> amountdata;

  HomeSettingPageState(this.amountdata);

  @override
  List<Object> get props => [amountdata];
}

class HomeCategoryListPageState extends HomeState {
  late List<CategoryListModel> categoryListArray;
  late DriverList driverDetail;
  late String updatedCartCount;

  HomeCategoryListPageState(this.categoryListArray, this.driverDetail);

  @override
  List<Object> get props => [categoryListArray, driverDetail];
}

class HomeDriverListApiCallCompleteState extends HomeState {
  List<DriverList> driverListArray;
  String updatedCartCount;
  List<ProductListDriver> driverProductListArray;
  List<Advertisement> advertisementArray;
  String bannerImage;
  List<BitmapDescriptor> pinLocationList;

  HomeDriverListApiCallCompleteState(
      this.driverListArray,
      this.updatedCartCount,
      this.driverProductListArray,
      this.advertisementArray,
      this.bannerImage,
      this.pinLocationList);

  @override
  List<Object> get props => [
        driverListArray,
        updatedCartCount,
        driverProductListArray,
        advertisementArray,
        bannerImage,
        pinLocationList
      ];
}

class HomeCategoryListLoadingProgressState extends HomeState {
  DriverList driverDetail;

  HomeCategoryListLoadingProgressState(this.driverDetail);

  @override
  List<Object> get props => [driverDetail];
}

class HomeMenuItemDetailsPageState extends HomeState {
  ProductListMenu productListModel;
  String driverId;
  DriverList driverDetail;

  HomeMenuItemDetailsPageState(
      this.productListModel, this.driverId, this.driverDetail);

  @override
  List<Object> get props => [productListModel, driverId, driverDetail];
}

class HomeCustomerRatingReviewSubmitState extends HomeState {
  String message;

  HomeCustomerRatingReviewSubmitState(this.message);

  @override
  List<Object> get props => [message];
}

class HomeFromDriverProductListDetailsPageState extends HomeState {
  ProductListDriver driverProductList;
  String screen;
  Vendor driverDetail;
  List<RatingReviewData>? ratingReviewList;
  List<RelatedProductList>? relatedProductList;
  List<AddonProductList>? addOnProductList;

  HomeFromDriverProductListDetailsPageState(
      this.driverProductList,
      this.driverDetail,
      this.screen,
      this.ratingReviewList,
      this.relatedProductList,
      this.addOnProductList);

  @override
  List<Object> get props => [
        driverProductList,
        //driverDetail,
        screen,
        ratingReviewList!,
        relatedProductList!,
        addOnProductList!
      ];
}

class HomeEventDriverTicketListClickPageState extends HomeState {
  List<EventDetailsList>? eventdetaillist;

  ProductListDriver driverProductList;
  String screen;
  List<RatingReviewData> ratingList;
  List<RelatedProductList> relatedproductList;
  List<AddonProductList> addonProductlist;
  Vendor vendor;

  HomeEventDriverTicketListClickPageState(
      this.eventdetaillist,
      this.driverProductList,
      this.screen,
      this.ratingList,
      this.relatedproductList,
      this.addonProductlist,
      this.vendor);

  List<Object> get props => [
        eventdetaillist!,
        driverProductList,
        screen,
        ratingList,
        relatedproductList,
        addonProductlist,
        vendor
      ];
}

class HomeTicketEventErrorHandelState extends HomeState {
  final String message;

  HomeTicketEventErrorHandelState(this.message);

  @override
  List<Object> get props => [message];
}

class HomeEventDriverRideListClickResetPageState extends HomeState {}

class HomeEventDriverRideListClickPageState extends HomeState {
  List<EventDetailsList>? eventdetaillist;
  ProductListDriver driverProductList;
  String screen;
  List<RatingReviewData> ratingList;
  List<RelatedProductList> relatedproductList;
  List<AddonProductList> addonProductlist;
  Vendor vendor;

  HomeEventDriverRideListClickPageState(
      this.eventdetaillist,
      this.driverProductList,
      this.screen,
      this.ratingList,
      this.relatedproductList,
      this.addonProductlist,
      this.vendor);

  List<Object> get props => [
        eventdetaillist!,
        driverProductList,
        screen,
        ratingList,
        relatedproductList,
        addonProductlist,
        vendor
      ];
}

class HomeRideCheckOutPageState extends HomeState {
  List<EventDetailsList>? eventdetaillist;
  String strScreen;
  DriverList driverDetail;
  ProductListMenu productListModel;
  List<StatesList> stateArrayList;
  String vendorId;
  String distance;

  HomeRideCheckOutPageState(
      this.eventdetaillist,
      this.strScreen,
      this.driverDetail,
      this.productListModel,
      this.stateArrayList,
      this.vendorId,
      this.distance);

  @override
  List<Object> get props => [
        eventdetaillist!,
        strScreen,
        driverDetail,
        productListModel,
        stateArrayList,
        vendorId,
        distance
      ];
}

class HomeEventRideErrorHandelState extends HomeState {
  final String message;

  HomeEventRideErrorHandelState(this.message);

  @override
  List<Object> get props => [message];
}

class HomeEventDriverTicketListClickCompleteState extends HomeState {
  List<EventDetailsList>? eventdetaillist;

  HomeEventDriverTicketListClickCompleteState(
    this.eventdetaillist,
  );

  List<Object> get props => [
        eventdetaillist!,
      ];
}

class HomeCheckOutPageState extends HomeState {
  String strScreen;
  DriverList driverDetail;
  ProductListMenu productListModel;
  List<StatesList> stateArrayList;
  String vendorId;

  HomeCheckOutPageState(this.strScreen, this.driverDetail,
      this.productListModel, this.stateArrayList, this.vendorId);

  @override
  List<Object> get props =>
      [strScreen, driverDetail, productListModel, stateArrayList, vendorId];
}

class HomeTicketCheckOutPageState extends HomeState {
  String strScreen;
  DriverList driverDetail;
  ProductListMenu productListModel;
  List<StatesList> stateArrayList;
  String vendorId;

  HomeTicketCheckOutPageState(this.strScreen, this.driverDetail,
      this.productListModel, this.stateArrayList, this.vendorId);

  @override
  List<Object> get props =>
      [strScreen, driverDetail, productListModel, stateArrayList, vendorId];
}

class HomeBeforeCheckOutPageState extends HomeState {
  String strScreen;
  DriverList driverDetail;
  ProductListMenu productListModel;
  List<StatesList> stateArrayList;
  String vendorId;

  HomeBeforeCheckOutPageState(this.strScreen, this.driverDetail,
      this.productListModel, this.stateArrayList, this.vendorId);

  @override
  List<Object> get props =>
      [strScreen, driverDetail, productListModel, stateArrayList, vendorId];
}

class HomeCheckOutCalculateState extends HomeState {
  // List<Couponlist> couponArrayList;
  DataResponse checkOutCalculation;
  List<Couponlist> couponArrayList;

  HomeCheckOutCalculateState(this.checkOutCalculation, this.couponArrayList);

  @override
  List<Object> get props => [checkOutCalculation, couponArrayList];
}

class HomeCheckOutCouponApplyState extends HomeState {
  // List<Couponlist> couponArrayList;
  DataResponse checkOutCalculation;
  List<Couponlist> couponArrayList;
  String couponAmount;
  String couponId;
  String message;

  HomeCheckOutCouponApplyState(this.checkOutCalculation, this.couponArrayList,
      this.couponAmount, this.couponId, this.message);

  @override
  List<Object> get props =>
      [checkOutCalculation, couponArrayList, couponAmount, couponId, message];
}

class HomeCheckOutOrderCompleteState extends HomeState {
  // List<Couponlist> couponArrayList;

  HomeCheckOutOrderCompleteState();

  @override
  List<Object> get props => [];
}

class HomeCheckOutOrderErrorState extends HomeState {
  // List<Couponlist> couponArrayList;
  String message;

  HomeCheckOutOrderErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class HomeTabChangeToHome extends HomeState {}

class HomeCartPageState extends HomeState {
  VendorDetailCart vendor;
  DataCart cartDataModel;
  List<ItemsCart> cartDataListArray;

  HomeCartPageState(this.cartDataListArray, this.vendor, this.cartDataModel);

  @override
  List<Object> get props => [cartDataListArray, vendor, cartDataModel];
}

class HomeCartPageResetState extends HomeState {}

class HomeFromProductDetailCartPageState extends HomeState {
  List<ItemsCart> cartDataListArray;
  DriverList driverDetail;

  ProductListMenu productListModel;
  DataCart cartDataModel;
  String strScreen;

  HomeFromProductDetailCartPageState(this.cartDataListArray, this.driverDetail,
      this.productListModel, this.cartDataModel, this.strScreen);

  @override
  List<Object> get props => [
        cartDataListArray,
        driverDetail,
        productListModel,
        cartDataModel,
        strScreen
      ];
}

class HomeFromCategoryCartPageState extends HomeState {
  List<ItemsCart> cartDataListArray;
  DriverList driverDetails;
  DataCart cartDataModel;

  HomeFromCategoryCartPageState(
      this.cartDataListArray, this.driverDetails, this.cartDataModel);

  @override
  List<Object> get props => [cartDataListArray, driverDetails, cartDataModel];
}

class HomeFromDriverListCartPageState extends HomeState {
  List<ItemsCart> cartDataListArray;
  DriverList driverDetails;
  DataCart cartDataModel;

  HomeFromDriverListCartPageState(
      this.cartDataListArray, this.driverDetails, this.cartDataModel);

  @override
  List<Object> get props => [cartDataListArray, driverDetails, cartDataModel];
}

class HomeEventErrorHandelState extends HomeState {
  final String message;

  HomeEventErrorHandelState(this.message);

  @override
  List<Object> get props => [message];
}

class HomeEventDataNotFoundState extends HomeState {
  final String message;
  List<Advertisement> advertisementArray;

  HomeEventDataNotFoundState(this.message, this.advertisementArray);

  @override
  List<Object> get props => [message, advertisementArray];
}

class HomeEventMessageShowState extends HomeState {
  final String? message;
  String? updatedCartCount;

  HomeEventMessageShowState(this.message);

  @override
  List<Object> get props => [message!];
}

class HomeEventAfterDeleteMessageShowState extends HomeState {
  String message;

  late List<ItemsCart> cartDataListArray;

  HomeEventAfterDeleteMessageShowState(this.message, this.cartDataListArray);

  @override
  List<Object> get props => [message, cartDataListArray];
}

class HomeEventAddtocartSuccessState extends HomeState {
  final String message;
  String newDriver;
  int productId;
  String specialInstruction;

  HomeEventAddtocartSuccessState(
      this.message, this.newDriver, this.productId, this.specialInstruction);

  @override
  List<Object> get props => [message, newDriver, productId, specialInstruction];
}

class HomeEventErrorHandelProductListPage extends HomeState {
  final String message;
  DriverList driverDetail;
  String brand;
  String type;
  String weight;
  String potencyCbd;
  String potencyThc;

  HomeEventErrorHandelProductListPage(this.message, this.brand, this.type,
      this.weight, this.potencyCbd, this.potencyThc, this.driverDetail);

  @override
  List<Object> get props =>
      [message, brand, type, weight, potencyCbd, potencyThc, driverDetail];
}

class HomeEventErrorHandelCategorypageState extends HomeState {
  final String message;
  DriverList driverDetail;

  HomeEventErrorHandelCategorypageState(this.message, this.driverDetail);

  @override
  List<Object> get props => [message, driverDetail];
}

class HomeRideLocationPageState extends HomeState {
  String type;

  HomeRideLocationPageState(this.type);

  List<Object> get props => [type];
}

class HomeRideLocationSearchPageState extends HomeState {
  String Valuetype;

  HomeRideLocationSearchPageState(this.Valuetype);

  List<Object> get props => [Valuetype];
}

class HomeRideLocationSeatchResetPageState extends HomeState {
  List<Object> get props => [];
}
