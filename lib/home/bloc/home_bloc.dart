import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:grambunny_customer/hm_root/hm_root.dart';
import 'package:grambunny_customer/home/bloc/bloc.dart';
import 'package:grambunny_customer/home/home.dart';
import 'package:grambunny_customer/networking/networking.dart';
import 'package:grambunny_customer/services/services.dart';
import 'package:grambunny_customer/utils/utils.dart';

import '../model/driver_list_model.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  UserRepository? _userRepository;

  HomeBloc({required UserRepository userRepository}) : super(HomeInitial()) {
    _userRepository = userRepository;

    on<HomeEventCatgoryDetailClick>(mapHomeEventCatgoryDetailClick);
    on<HomeEventProductMenuSearch>(mapHomeEventProductMenuSearch);
    on<LoginEventSignInButtonClick>(mapLoginEventSignINClick);
    on<LoginEventSignInFromCheckOutPage>(mapLoginEventSignInFromCheckOutPage);
    on<LoginEventForgetPasswordClick>(mapLoginEventForgetPasswordClick);
    on<HomeEventForOTPScreen>(mapHomeEventForOTPScreen);
    on<OTPEventOTPVerifyButton>(mapOTPEventOTPVerifyButton);
    on<OTPEventOTPResendButton>(mapOTPEventOTPResendButton);
    on<HomeEventBackBtnClick>(mapHomeEventBackBtnClick);
    on<ForgotPasswordEventVerifyBtnClick>(mapForgotPasswordEventVerifyBtnClick);
    on<ResetPasswordPageEvent>(mapResetPasswordPageEvent);
    on<ResetPasswordEventResetBtnClick>(mapResetPasswordEventResetBtnClick);
    on<ResetPasswordPageResetPageEvent>(mapResetPasswordPageResetEvent);
    on<HomeEventMenuListItemClick>(mapHomeEventMenuListItemClick);
    on<HomeEventtabChangeToHome>(mapHomeEventtabChangeToHome);
    on<HomeEventDriverItemClick>(mapHomeEventDriverItemClick);
    on<HomeEventCategoryListLoadingComplete>(
        mapHomeEventCategoryListLoadingComplete);
    on<HomeEventDriverListApiCallLoading>(mapHomeEventDriverListApiCallLoading);
    on<HomeEventDriverPageReset>(mapHomeEventDriverPageReset);
    on<HomeEventCategoryPageReset>(mapHomeEventCategoryPageReset);
    on<HomeEventApplyFilter>(mapHomeEventApplyFilter);
    on<HomeEventApplyResetProductList>(mapHomeAfterErrorResetProductList);
    on<HomeEventCartPageBtnClick>(mapHomeEventCartPageBtnClick);
    on<HomeEventDriverListCartBtnClick>(mapHomeEventDriverListCartBtnClick);
    on<HomeEventAddToCartBtnClick>(mapHomeEventAddToCartBtnClick);

    on<HomeEventTicketItemClickPurchaseTicketBtnClick>(
        mapHomeEventTicketItemClickPurchaseTicketBtnClick);

    on<HomeEventItemClickAddToCartBtnClick>(
        mapHomeEventItemClickAddToCartBtnClick);
    on<HomeEventItemAddMinusToCartBtnClick>(
        mapHomeEventItemAddMinusToCartBtnClick);
    on<HomeEventCartDeleteItemClick>(mapHomeEventCartDeleteItemClick);
    // on<HomeEventCartPageReset>(mapHomeEventCartPageReset);
    on<HomeEventProductDetailPageReset>(mapHomeEventProductDetailPageReset);
    on<HomeEventProductDetailPageCartBtnClick>(
        mapHomeEventProductDetailPageCartBtnClick);
    on<HomeEventBackForProductDetailPage>(mapHomeEventBackForProductDetailPage);
    on<HomeEventBackForCategoryPage>(mapHomeEventBackForCategoryPage);
    on<LoginEventBtnLoginClicked>(mapLoginEventBtnLoginClicked);
    on<HomeEventBackForProductListpage>(mapHomeEventBackForProductListpage);
    on<HomeEventProductItemDetailPageReset>(
        mapHomeEventProductItemDetailPageReset);
    on<HomeEventCheckOutButtonClick>(mapHomeEventCheckOutButtonClick);
    on<HomeEventAfterRefreshToCheckOutPage>(
        mapHomeEventAfterRefreshToCheckOutPage);
    on<HomeEventCouponListbtnClick>(mapHomeEventCouponListbtnClick);
    on<HomeEventCouponListbtnApply>(mapHomeEventCouponListbtnApply);
    on<HomeEventResetCheckOutState>(mapHomeEventResetCheckOutState);
    on<HomeEventDriverProductListClick>(mapHomeEventDriverProductListClick);

    on<HomeEventDriverTicketListClick>(mapHomeEventDriverTicketListClick);
    on<HomeEventDriverRideListClick>(mapHomeEventDriverRideListClick);

    on<LoginEventLoginStateReset>(mapLoginEventLoginStateReset);

    on<LoginEventSignUpButtonClick>(mapLoginEventSignUpButtonClick);

    on<SignUpEventSignUpBtnClick>(mapSignUpEventSignUpBtnClick);
    on<HomeEventSubmitOrderBtnClick>(mapHomeEventSubmitOrderBtnClick);
    on<HomeEventSubmitRatingBtnClick>(mapHomeEventSubmitRatingBtnClick);
    on<HomeEventLoadMoreBtnClick>(mapHomeEventLoadMoreBtnClick);
    on<HomeEventCartPageReset>(mapHomeEventCartBeforeCheckout);
    on<HomeEventCategoryCartBtnClick>(mapHomeEventCategoryCartBtnClick);

    on<HomeEventRideSearchTextFieldClick>(mapHomeEventRideSearchTextFieldClick);

    on<HomeEventRideBackBtnClicked>(mapHomeEventRideBackBtnClicked);
  }

  mapHomeEventLoadMoreBtnClick(
      HomeEventLoadMoreBtnClick event, Emitter<HomeState> emitter) async {
    NetworkApiCallState<bool> apiCallState = await _userRepository!
        .postReviewUserList('${event.productId}', event.pageCount!);

    driverProductList = event.productListDriverModel!;
    _userRepository!.ScreenName = ScreenNavigation.HomeMenuItemDetailScreen;
    if (apiCallState.statusValue == "1") {
      emitter(HomeFromDriverProductListDetailsPageState(
          event.productListDriverModel!,
          event.vendorDetails!,
          event.strScreen!,
          _userRepository!.getRatingReviewList()!,
          _userRepository!.getRelatedProductList()!,
          _userRepository!.getAddOnProductList()!));
    } else {
      emitter(HomeEventErrorHandelState(apiCallState.message!));
    }
  }

  mapHomeEventSubmitOrderBtnClick(
      HomeEventSubmitOrderBtnClick event, Emitter<HomeState> emitter) async {
    print("Zip in block " + event.zip);
    NetworkApiCallState<bool> apiCallState = await _userRepository!
        .postSubmitPaymentApiCall(
            vendorId: event.vendorId,
            payMethod: event.payMethod,
            address: event.address,
            city: event.city,
            state: event.state,
            zip: event.zip,
            mobile: event.mobile,
            saletax: event.saletax,
            excisetax: event.excisetax,
            citytax: event.citytax,
            final_amount: event.final_amount,
            subTotal: event.sub_total,
            promo_amount: event.promo_amount,
            coupon_id: event.coupon_id,
            cc_name: event.cc_name,
            cc_number: event.cc_number,
            cc_expire_year: event.cc_expire_year,
            cc_expire_month: event.cc_expire_month,
            cc_expiration: event.cc_expiration,
            cc_cvv: event.cc_cvv,
            creditcardtype: event.creditcardtype,
            comment: event.comment,
            device_os_name: event.osName,
            device_type: event.deviceType);

    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      _userRepository!.ScreenName = ScreenNavigation.CheckOutPageScreen;
      if (apiCallState.statusValue == "1") {
        sharedPrefs.setCartCount = "0";
        emitter(HomeCheckOutOrderCompleteState());
      } else {
        emitter(HomeCheckOutOrderErrorState(apiCallState.message!));
      }
    } else {
      emitter(HomeCheckOutOrderErrorState(apiCallState.message!));
    }
  }

  mapHomeEventCouponListbtnApply(
      HomeEventCouponListbtnApply event, Emitter<HomeState> emitter) async {
    NetworkApiCallState<bool> apiCallState = await _userRepository!
        .getCheckOutCalculationApi(event.vendorId, event.couponCode);

    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      _userRepository!.ScreenName = ScreenNavigation.CheckOutPageScreen;
      NetworkApiCallState<bool> apiCallState1 =
          await _userRepository!.getViewCouponCodeApiCall(event.vendorId);
      if (apiCallState.statusValue == "1") {
        emitter(HomeCheckOutCouponApplyState(
            _userRepository!.getCheckOutCalculation()!,
            _userRepository!.getCouponArrayList()!,
            _userRepository!.getCheckOutCalculation()!.couponAmount,
            event.couponId,
            apiCallState.message!));
      } else {
        emitter(HomeCheckOutOrderErrorState(apiCallState.message!));
      }
    } else {
      emitter(HomeCheckOutOrderErrorState(apiCallState.message!));
    }
  }

  mapHomeEventSubmitRatingBtnClick(
      HomeEventSubmitRatingBtnClick event, Emitter<HomeState> emitter) async {
    NetworkApiCallState<bool> apiCallState = await _userRepository!
        .postProductRatingReviewApi(
            "${event.productId}", event.ratingCount, event.reviewText);

    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        print("complete State====>");
        emitter(HomeCustomerRatingReviewSubmitState(apiCallState.message!));
      } else {
        emitter(HomeEventErrorHandelState(apiCallState.message!));
      }
    } else {
      emitter(HomeEventErrorHandelState(apiCallState.message!));
    }
  }

  mapHomeEventCouponListbtnClick(
      HomeEventCouponListbtnClick event, Emitter<HomeState> emitter) async {
    NetworkApiCallState<bool> apiCallState = await _userRepository!
        .getCheckOutCalculationApi(event.vendorId, event.couponCode);

    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      _userRepository!.ScreenName = ScreenNavigation.CheckOutPageScreen;
      NetworkApiCallState<bool> apiCallState1 =
          await _userRepository!.getViewCouponCodeApiCall(event.vendorId);
      if (apiCallState.statusValue == "1") {
        emitter(HomeCheckOutCalculateState(
            _userRepository!.getCheckOutCalculation()!,
            _userRepository!.getCouponArrayList()!));
      } else {
        emitter(HomeCheckOutOrderErrorState(apiCallState.message!));
      }
    } else {
      emitter(HomeCheckOutOrderErrorState(apiCallState.message!));
    }
  }

  mapHomeEventResetCheckOutState(
      HomeEventResetCheckOutState event, Emitter<HomeState> emitter) async {
    print("In Reset Checkout");
    // yield HomeInitialReset();
    emitter(HomeCheckOutPageState(
        event.strScreen,
        event.driverDetail,
        event.productListModel,
        _userRepository!.getStateArrayList()!,
        event.vendorId));
  }

  // Stream<HomeState> mapHomeEventBackForCheckOutScreen() async* {
  //   print("In Reset Checkout");
  //   // yield HomeInitialReset();
  //   yield HomeCheckOutPageState(
  //       event.strScreen, event.driverDetail, event.productListModel);
  // }

  mapHomeEventAfterRefreshToCheckOutPage(
      HomeEventAfterRefreshToCheckOutPage event,
      Emitter<HomeState> emitter) async {
    print("In bloc setting");
    NetworkApiCallState<bool> apiCallState =
        await _userRepository!.getStateListApi();
    NetworkApiCallState<bool> apiCallState1 =
        await _userRepository!.getViewCartListApiCall();
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        print("login success" + apiCallState.message!);

        emitter(HomeCheckOutPageState(
            event.strScreen,
            event.driverDetail,
            event.productListModel,
            _userRepository!.getStateArrayList()!,
            event.vendorId));
      } else {
        emitter(HomeCheckOutPageState(
            event.strScreen,
            event.driverDetail,
            event.productListModel,
            _userRepository!.getStateArrayList()!,
            event.vendorId));
      }
    } else {
      emitter(SignUpLoadingErrorState("Server Error"));
    }
  }

  mapHomeEventCheckOutButtonClick(
      HomeEventCheckOutButtonClick event, Emitter<HomeState> emitter) async {
    print("In bloc setting");
    NetworkApiCallState<bool> apiCallState =
        await _userRepository!.getStateListApi();
    NetworkApiCallState<bool> apiCallState1 =
        await _userRepository!.getViewCartListApiCall();
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        print("login success" + apiCallState.message!);
        emitter(HomeBeforeCheckOutPageState(
            event.strScreen,
            event.driverDetail,
            event.productListModel,
            _userRepository!.getStateArrayList()!,
            event.vendorId));
        // yield HomeCheckOutPageState(
        //     event.strScreen,
        //     event.driverDetail,
        //     event.productListModel,
        //     _userRepository.getStateArrayList(),
        //     event.vendorId);
      } else {
        emitter(HomeBeforeCheckOutPageState(
            event.strScreen,
            event.driverDetail,
            event.productListModel,
            _userRepository!.getStateArrayList()!,
            event.vendorId));
      }
    } else {
      emitter(SignUpLoadingErrorState("Server Error"));
    }
  }

  mapSignUpEventSignUpBtnClick(
      SignUpEventSignUpBtnClick event, Emitter<HomeState> emitter) async {
    _userRepository!.ScreenName = ScreenNavigation.SignUpPage;
    NetworkApiCallState<bool> apiCallState = await _userRepository!.SignUpToAPI(
        fname: event.firstName!,
        lname: event.lastName!,
        email: event.email!,
        password: event.password!,
        mobileno: event.mobileNO!,
        devicetype: event.devicetype!,
        devicetoken: event.devicetoken!,
        dob: event.dob!,
        address: event.address!,
        city: event.city!,
        state: event.state!,
        zipcode: event.zipcode!,
        os_name: event.os_name!,
        licenseImageBack: event.strBackLicensePath!,
        licenseImageFront: event.strFrontLicensePath!,
        profileImage: event.strUserProfilePath!,
        strCustomerType: event.strCustomerType!,
        marijuanaIdCard: event.strMarijuanaId!);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        print("login success" + apiCallState.message!);
        print("login success" + apiCallState.message!);
        emitter(
            SignUpLoadingCompleteState(apiCallState.message!, event.email!));
      } else {
        print(apiCallState.message);
        emitter(SignUpLoadingErrorState(apiCallState.message!));
      }
    } else {
      emitter(SignUpLoadingErrorState("Server Error"));
    }
  }

  mapResetPasswordPageResetEvent(
      ResetPasswordPageResetPageEvent event, Emitter<HomeState> emitter) async {
    print("emailllllll===>>>" + event.email);
    UserDetail userArray = _userRepository!.getUserDetail()!;

    emitter(OtpApiLoadingCompleteState("", event.email, userArray));
  }

  mapResetPasswordPageEvent(
      ResetPasswordPageEvent event, Emitter<HomeState> emitter) async {
    print("emailllllll===>>>" + event.email);
    emitter(ResetPasswordPageState(event.email));
  }

  mapResetPasswordEventResetBtnClick(
      ResetPasswordEventResetBtnClick event, Emitter<HomeState> emitter) async {
    print("emailllllll===>>>" + event.email);

    NetworkApiCallState<bool> apiCallState =
        await _userRepository!.ResetPasswordToAPI(event.email, event.password);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      _userRepository!.ScreenName = ScreenNavigation.ResetPwdPage;
      if (apiCallState.statusValue == "1") {
        emitter(ResetPasswordApiLoadingCompleteState(apiCallState.message!));
      } else {
        emitter(ResetPasswordApiLoadingErrorState(
            apiCallState.message!, event.email));
      }
    } else {
      emitter(ResetPasswordApiLoadingErrorState("Server Error", event.email));
    }
  }

  mapForgotPasswordEventVerifyBtnClick(ForgotPasswordEventVerifyBtnClick event,
      Emitter<HomeState> emitter) async {
    print("emailllllll===>>>" + event.emailID);

    NetworkApiCallState<bool> apiCallState =
        await _userRepository!.ForgotPasswordToAPI(event.emailID);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      print("Forgot Password Success");
      _userRepository!.ScreenName = ScreenNavigation.ForgetPwdPage;
      if (apiCallState.statusValue == "1") {
        emitter(ForgotPasswordApiLoadingCompleteState(
            apiCallState.message!, event.emailID));
      } else {
        emitter(ForgotPasswordApiLoadingErrorState(apiCallState.message!));
      }
    } else {
      emitter(ForgotPasswordApiLoadingErrorState("Server Error"));
    }
  }

  mapLoginEventLoginStateReset(
      LoginEventLoginStateReset event, Emitter<HomeState> emitter) async {
    if (state is LoginLoadingErrorState) {
      emitter(LoginPageState("driverlist"));
    }
    if (state is SignUpLoadingErrorState) {
      emitter(SignUpPageState(_userRepository!.getStateArrayList()!));
    }
  }

  mapLoginEventSignUpButtonClick(
      LoginEventSignUpButtonClick event, Emitter<HomeState> emitter) async {
    _userRepository!.ScreenName = ScreenNavigation.SignUpPage;
    NetworkApiCallState<bool> apiCallState =
        await _userRepository!.getStateListApi();
    print("massege ===>>>" + apiCallState.message!);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        emitter(SignUpPageState(_userRepository!.getStateArrayList()!));
      } else {}
    } else {}
  }

  mapHomeEventForOTPScreen(
      HomeEventForOTPScreen event, Emitter<HomeState> emitter) async {
    _userRepository!.ScreenName = ScreenNavigation.OTPpage;
    emitter(OTPpageState(event.emai_id, event.from));
  }

  mapOTPEventOTPVerifyButton(
      OTPEventOTPVerifyButton event, Emitter<HomeState> emitter) async {
    _userRepository!.ScreenName = ScreenNavigation.OTPpage;
    NetworkApiCallState<bool> apiCallState =
        await _userRepository!.OtpVarify(event.email, event.otp, event.from);
    print("massege ===>>>" + apiCallState.message!);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        UserDetail userArray = _userRepository!.getUserDetail()!;
        emitter(OtpApiLoadingCompleteState(
            apiCallState.message!, event.email, userArray));
      } else {
        emitter(OtpApiLoadingErrorState(apiCallState.message!));
      }
    } else {
      emitter(OtpApiLoadingErrorState("Server Error"));
    }
  }

  mapOTPEventOTPResendButton(
      OTPEventOTPResendButton event, Emitter<HomeState> emitter) async {
    _userRepository!.ScreenName = ScreenNavigation.OTPpage;
    NetworkApiCallState<bool> apiCallState =
        await _userRepository!.OtpResend(event.email, event.from);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        emitter(OtpResendApiLoadingCompleteState(apiCallState.message!));
      } else {
        emitter(OtpResendApiLoadingErrorState(apiCallState.message!));
      }
    } else {
      emitter(OtpResendApiLoadingErrorState("Server Error"));
    }
  }

  mapLoginEventSignInFromCheckOutPage(LoginEventSignInFromCheckOutPage event,
      Emitter<HomeState> emitter) async {
    _userRepository!.ScreenName = ScreenNavigation.Loginpage;
    emitter(LoginPageStateFromCheckOut(event.strScreen, event.productList,
        event.driverDetail, event.productListModel, event.cartDataModel));
  }

  mapLoginEventSignINClick(
      LoginEventSignInButtonClick event, Emitter<HomeState> emitter) async {
    _userRepository!.ScreenName = ScreenNavigation.Loginpage;
    emitter(LoginPageState("DriverList"));
  }

  mapLoginEventBtnLoginClicked(
      LoginEventBtnLoginClicked event, Emitter<HomeState> emitter) async {
    //_userRepository.ScreenName = "SignUpPage";
    _userRepository!.ScreenName = ScreenNavigation.Loginpage;
    NetworkApiCallState<bool> apiCallState = await _userRepository!.LoginToAPI(
        event.emailid,
        event.password,
        event.card_id,
        event.devicetype,
        event.os_name,
        "");
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        UserDetail userArray = _userRepository!.getUserDetail()!;

        sharedPrefs.setUserId = "${userArray.id}";
        sharedPrefs.isLogin = true;
        sharedPrefs.setUserName = userArray.name!;
        sharedPrefs.setUserProfileImage = userArray.profileURL!;
        print("login success" + apiCallState.message!);
        emitter(LoginLoadingCompleteState(
            apiCallState.message!, _userRepository!.getUserDetail()!));
      } else if (apiCallState.statusValue == "2") {
        emitter(LoginLoadingCompleteState(
            apiCallState.message!, _userRepository!.getUserDetail()!));
      } else {
        print(apiCallState.message);
        emitter(LoginLoadingErrorState(apiCallState.message!));
      }
    } else {
      emitter(LoginLoadingErrorState("Server Error"));
    }
  }

  mapLoginEventForgetPasswordClick(
      LoginEventForgetPasswordClick event, Emitter<HomeState> emitter) async {
    _userRepository!.ScreenName = ScreenNavigation.ForgetPwdPage;
    emitter(ForgetPwdPageState());
  }

  mapHomeEventProductDetailPageReset(
      HomeEventProductDetailPageReset event, Emitter<HomeState> emitter) async {
    print("In bloc setting");

    NetworkApiCallState<bool> apiCallState =
        await _userRepository!.getCartCountApiCall();
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      _userRepository!.ScreenName = ScreenNavigation.HomeMenuItemDetailScreen;
      emitter(HomeMenuItemDetailsPageState(
          event.productListModel, event.driverId, event.driverDetail));
    } else {
      _userRepository!.ScreenName = ScreenNavigation.HomeMenuItemDetailScreen;
      emitter(HomeMenuItemDetailsPageState(
          event.productListModel, event.driverId, event.driverDetail));
    }
  }

  mapHomeEventCartDeleteItemClick(
      HomeEventCartDeleteItemClick event, Emitter<HomeState> emitter) async {
    print("In bloc setting ${event.productId}${event.driverDetail.vendorId}");
    _userRepository!.ScreenName = ScreenNavigation.HomeMyCartScreen;
    NetworkApiCallState<bool> apiCallState = await _userRepository!
        .getCartDeleteSingleItemApiCall(
            event.productId, event.driverDetail!.vendorId!);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        NetworkApiCallState<bool> apiCallState1 =
            await _userRepository!.getCartCountApiCall();
        NetworkApiCallState<bool> apiCallState =
            await _userRepository!.getViewCartListApiCall();
        if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
          if (apiCallState.statusValue == "1") {
            _userRepository!.ScreenName = ScreenNavigation.HomeMyCartScreen;

            emitter(HomeCartPageState(
                _userRepository!.getCartDataListArray()!,
                _userRepository!.getCartDataListArray()![0].vendor,
                _userRepository!.getCartDataModel()!));
          } else if (_userRepository!.getCartDataListArray()!.isEmpty) {
            sharedPrefs.setCartCount = "0";
            emitter(HomeEventAfterDeleteMessageShowState(
              apiCallState.message!,
              _userRepository!.getCartDataListArray()!,
            ));
          } else {
            emitter(HomeEventMessageShowState(apiCallState.message!));
          }
        } else if (apiCallState.status == NetworkRequestStatus.ERROR) {
          if (apiCallState.message == "Unknown Error") {
            emitter(HomeEventMessageShowState("Something went wrong"));
          } else {
            emitter(HomeEventMessageShowState("Something went wrong"));
          }
        }
      }
    } else {}
    //  yield HomeFromDriverListCartPageState(event.productId);
  }

  mapHomeEventProductDetailPageCartBtnClick(
      HomeEventProductDetailPageCartBtnClick event,
      Emitter<HomeState> emitter) async {
    _userRepository!.ScreenName = ScreenNavigation.HomeMyCartScreen;
    NetworkApiCallState<bool> apiCallState =
        await _userRepository!.getViewCartListApiCall();
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      NetworkApiCallState<bool> apiCallState1 =
          await _userRepository!.getCartCountApiCall();
      if (apiCallState.statusValue == "1") {
        emitter(HomeFromProductDetailCartPageState(
            _userRepository!.getCartDataListArray()!,
            event.driverDetail,
            event.productListModel,
            _userRepository!.getCartDataModel()!,
            event.strScreen));
      } else {
        emitter(HomeEventErrorHandelState(apiCallState.message!));
        if (apiCallState.message == "Cart empty") {
          sharedPrefs.setCartCount = "0";
        }
      }
    } else if (apiCallState.status == NetworkRequestStatus.ERROR) {
      if (apiCallState.message == "Unknown Error") {
        emitter(HomeEventErrorHandelState("Something went wrong"));
      } else {
        emitter(HomeEventErrorHandelState("Something went wrong"));
      }
    }
  }

  mapHomeEventCartBeforeCheckout(
      HomeEventCartPageReset event, Emitter<HomeState> emitter) async {
    _userRepository!.ScreenName = ScreenNavigation.HomeMyCartScreen;

    if (event.strScreen == "ProductDetail") {
      emitter(HomeFromProductDetailCartPageState(
          _userRepository!.getCartDataListArray()!,
          event.driverDetail,
          event.productListModel,
          _userRepository!.getCartDataModel()!,
          event.strScreen));
    } else if (event.strScreen == "CategoryPage") {
      emitter(HomeFromCategoryCartPageState(
          _userRepository!.getCartDataListArray()!,
          event.driverDetail,
          _userRepository!.getCartDataModel()!));
    } else if (event.strScreen == "DriverList") {
      emitter(HomeFromCategoryCartPageState(
          _userRepository!.getCartDataListArray()!,
          event.driverDetail,
          _userRepository!.getCartDataModel()!));
    } else if (event.strScreen == "HomeCartpage") {
      if (_userRepository!.getCartDataListArray()!.isEmpty) {
        emitter(HomeCartPageState(
            _userRepository!.getCartDataListArray()!,
            new VendorDetailCart(
                vendorId: 0,
                lng: "0",
                lat: "0",
                businessName: ","
                    "",
                cityTax: "",
                color: "",
                commissionRate: "",
                deliveryFee: "",
                dob: "",
                exciseTax: "",
                ratingCount: "",
                salesTax: ""
                    "",
                vendorType: "",
                driverLicense: "",
                forgetpassRequest: "",
                forgetpassRequestStatus: "",
                licenseBack: "",
                licenseExpiry: "",
                licenseFront: "",
                licensePlate: "",
                mailingAddress: "",
                make: "",
                model: "",
                otp: "",
                permitExpiry: "",
                permitNumber: "",
                permitType: "",
                planExpiry: "",
                planId: "",
                planPurchased: "",
                profileImg2: "",
                profileImg3: "",
                profileImg4: "",
                service: "",
                serviceRadius: "",
                ssn: "",
                stripeId: "",
                suburb: "",
                txnId: "",
                views: "",
                walletAmount: "",
                year: "",
                devicetype: "",
                createdAt: "",
                updatedAt: ""
                    "",
                loginStatus: "",
                uniqueId: "",
                zipcode: "",
                vendorStatus: "",
                type: "",
                subCategoryId: "",
                state: "",
                mobNo: "",
                marketArea: "",
                email: "",
                deviceid: "",
                description: "",
                city: "",
                categoryId: "",
                avgRating: "",
                address: "",
                address1: "",
                category: "",
                fullname: "",
                lastName: "",
                licensebackURL: "",
                licensefrontURL: "",
                name: "",
                profile2URL: "",
                profile4URL: "",
                profileImg1: "",
                profileURL: "",
                username: "",
                profile3URL: "",
                membership: new Membership(remainingDays: 0, status: 0)),
            _userRepository!.getCartDataModel()!));
      } else {
        emitter(HomeCartPageState(
            _userRepository!.getCartDataListArray()!,
            _userRepository!.getCartDataListArray()![0].vendor,
            _userRepository!.getCartDataModel()!));
      }
    }
  }

  // mapHomeEventCartPageReset(
  //     HomeEventCartPageReset event, Emitter<HomeState> emitter) async {
  //   _userRepository!.ScreenName = ScreenNavigation.HomeMyCartScreen;
  //
  //   if (event.strScreen == "ProductDetail") {
  //     emitter(HomeFromProductDetailCartPageState(
  //         _userRepository!.getCartDataListArray()!,
  //         event.driverDetail,
  //         event.productListModel,
  //         _userRepository!.getCartDataModel()!,
  //         event.strScreen));
  //   } else if (event.strScreen == "CategoryPage") {
  //     emitter(HomeFromCategoryCartPageState(
  //         _userRepository!.getCartDataListArray()!,
  //         event.driverDetail,
  //         _userRepository!.getCartDataModel()!));
  //   } else if (event.strScreen == "DriverList") {
  //     emitter(HomeFromCategoryCartPageState(
  //         _userRepository!.getCartDataListArray()!,
  //         event.driverDetail,
  //         _userRepository!.getCartDataModel()!));
  //   } else if (event.strScreen == "HomeCartpage") {
  //     if (_userRepository!.getCartDataListArray()!.isEmpty) {
  //       emitter(HomeCartPageState(_userRepository!.getCartDataListArray()!,
  //           null!, _userRepository!.getCartDataModel()!));
  //     } else {
  //       emitter(HomeCartPageState(
  //           _userRepository!.getCartDataListArray()!,
  //           _userRepository!.getCartDataListArray()![0].vendor,
  //           _userRepository!.getCartDataModel()!));
  //     }
  //   }
  // }

  mapHomeEventBackForProductListpage(
      HomeEventBackForProductListpage event, Emitter<HomeState> emitter) async {
    _userRepository!.ScreenName = ScreenNavigation.HomeProductListScreen;
    emitter(HomeInitialReset());
    emitter(HomeCategoryProductPageState(
        vendorId,
        _userRepository!.getProductListArray()!,
        categoryList,
        categoryId,
        driverDetails,
        _userRepository!.getUpdatedCartCount()!));
  }

  mapHomeEventBackForCategoryPage(
      HomeEventBackForCategoryPage event, Emitter<HomeState> emitter) async {
    emitter(HomeInitialReset());
    emitter(HomeCategoryListPageState(
        _userRepository!.getCategoryListArray()!, event.driverDetail));
  }

  mapHomeEventProductItemDetailPageReset(
      HomeEventProductItemDetailPageReset event,
      Emitter<HomeState> emitter) async {
    emitter(HomeMenuItemDetailsPageState(event.productListModel,
        event.driverDetail.vendorId!, event.driverDetail));
  }

  mapHomeEventBackForProductDetailPage(HomeEventBackForProductDetailPage event,
      Emitter<HomeState> emitter) async {
    print("Here=====");
    emitter(HomeInitialReset());
    emitter(HomeMenuItemDetailsPageState(event.productListModel,
        event.driverDetail.vendorId, event.driverDetail));
  }

  mapHomeEventDriverListCartBtnClick(
      HomeEventDriverListCartBtnClick event, Emitter<HomeState> emitter) async {
    print("In bloc setting");

    NetworkApiCallState<bool> apiCallState =
        await _userRepository!.getViewCartListApiCall();
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        _userRepository!.ScreenName = ScreenNavigation.HomeMyCartScreen;
        emitter(HomeFromDriverListCartPageState(
            _userRepository!.getCartDataListArray()!,
            _userRepository!.getDriverDetails()!,
            _userRepository!.getCartDataModel()!));
      }
    } else {}
  }

  mapHomeEventCategoryCartBtnClick(
      HomeEventCategoryCartBtnClick event, Emitter<HomeState> emitter) async {
    print("In bloc setting");

    NetworkApiCallState<bool> apiCallState =
        await _userRepository!.getViewCartListApiCall();
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        _userRepository!.ScreenName = ScreenNavigation.HomeMyCartScreen;
        emitter(HomeFromCategoryCartPageState(
            _userRepository!.getCartDataListArray()!,
            _userRepository!.getDriverDetails()!,
            _userRepository!.getCartDataModel()!));
      }
    } else {}
  }

  mapHomeEventCartPageBtnClick(
      HomeEventCartPageBtnClick event, Emitter<HomeState> emitter) async {
    print("In bloc setting");
    _userRepository!.ScreenName = ScreenNavigation.HomeMyCartScreen;
    NetworkApiCallState<bool> apiCallState =
        await _userRepository!.getViewCartListApiCall();
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        for (int i = 0;
            i < _userRepository!.getCartDataListArray()!.length;
            i++) {
          if (_userRepository!.getCartDataListArray()![i].vendor != null) {
            emitter(HomeCartPageState(
                _userRepository!.getCartDataListArray()!,
                _userRepository!.getCartDataListArray()![i].vendor,
                _userRepository!.getCartDataModel()!));
            break;
          }
        }
      } else {
        emitter(HomeEventErrorHandelProductListPage(
            "data not found", "", " ", "", "", "", event.driverDetail));
      }
    } else {
      emitter(HomeEventErrorHandelProductListPage(
          "data not found", "", " ", "", "", "", event.driverDetail));
    }
  }

  mapHomeAfterErrorResetProductList(
      HomeEventApplyResetProductList event, Emitter<HomeState> emitter) async {
    print("In bloc setting");

    NetworkApiCallState<bool> apiCallState = await _userRepository!
        .getProductListApiCall(
            categoryId: event.categoryId, driverId: event.driverId, search: "");
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        print("Product list call====");

        print("Filter list call====");
        emitter(HomeCategoryProductPageState(
            event.driverDetail.vendorId!,
            _userRepository!.getProductListArray()!,
            categoryList,
            event.categoryId,
            event.driverDetail,
            sharedPrefs.getCartCount));
      } else {
        emitter(HomeEventErrorHandelCategorypageState(
            "data not found", event.driverDetail));
      }
    } else {
      emitter(HomeEventErrorHandelCategorypageState(
          "data not found", event.driverDetail));
    }
  }

  mapHomeEventApplyFilter(
      HomeEventApplyFilter event, Emitter<HomeState> emitter) async {
    print("In bloc setting");
  }

  mapHomeEventDriverItemClick(
      HomeEventDriverItemClick event, Emitter<HomeState> emitter) async {
    print("In bloc setting");
    _userRepository!.saveDriverDetail = event.driverDetail;
    emitter(HomeCategoryListLoadingProgressState(event.driverDetail));
  }

  mapHomeEventDriverListApiCallLoading(HomeEventDriverListApiCallLoading event,
      Emitter<HomeState> emitter) async {
    // yield HomeInitial();
    // yield HomeMenuItemDetailsPageState();

    NetworkApiCallState<bool> apiCallState = await _userRepository!
        .getDriverApiListCall(
            event.currentLat, event.currentLong, event.keyword, event.searchBy);

    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      print("call api driver list 1 =======");
      if (apiCallState.statusValue == "1") {
        print("call api driver list 2 =======");

        for (int i = 0;
            i < _userRepository!.getDriverListArray()!.length;
            i++) {
          try {
            NetworkApiCallState<bool>? apiCallState1 = await _userRepository!
                .getMapImage(
                    url: _userRepository!.getDriverListArray()![i].map_icon!);
          } catch (e) {
            print(e.toString());
          }
        }

        emitter(HomeDriverListApiCallCompleteState(
            _userRepository!.getDriverListArray()!,
            sharedPrefs.getCartCount,
            _userRepository!.getDriverProductListArray()!,
            _userRepository!.getAdvertisementArray()!,
            _userRepository!.getBannerImage()!,
            _userRepository!.getPinLocationList()!));
      } else {
        emitter(HomeEventDataNotFoundState(
            "data not found", _userRepository!.getAdvertisementArray()!));
      }
    } else if (apiCallState.status == NetworkRequestStatus.ERROR) {
      if (apiCallState.message == "Unknown Error") {
        emitter(HomeEventErrorHandelState("Something went wrong"));
      } else {
        emitter(HomeEventErrorHandelState("Something went wrong"));
      }
    }
  }

  mapHomeEventAddToCartBtnClick(
      HomeEventAddToCartBtnClick event, Emitter<HomeState> emitter) async {
    print("In bloc setting");
    // yield HomeInitial();
    // yield HomeMenuItemDetailsPageState();

    NetworkApiCallState<bool> apiCallState = await _userRepository!
        .postAddToCartApi(event.quantity, event.productId, event.driverId,
            event.decrease, event.isNewDriver, event.specialInstruction);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        NetworkApiCallState<bool> apiCallState1 =
            await _userRepository!.getCartCountApiCall();

        if (_userRepository!.isNewdriver == "1") {
          emitter(HomeEventAddtocartSuccessState(
              apiCallState.message!,
              _userRepository!.isNewdriver,
              event.productId,
              event.specialInstruction));
        } else {
          emitter(HomeEventMessageShowState(apiCallState.message!));
        }
      } else {
        emitter(HomeEventMessageShowState(apiCallState.message!));
      }
    } else if (apiCallState.status == NetworkRequestStatus.ERROR) {
      if (apiCallState.message == "Unknown Error") {
        emitter(HomeEventMessageShowState("Something went wrong"));
      } else {
        emitter(HomeEventMessageShowState("Something went wrong"));
      }
    }
  }

  mapHomeEventItemAddMinusToCartBtnClick(
      HomeEventItemAddMinusToCartBtnClick event,
      Emitter<HomeState> emitter) async {
    print("In bloc setting");
    // yield HomeInitial();
    // yield HomeMenuItemDetailsPageState();
    print("driverId" + event.driverId);
    NetworkApiCallState<bool> apiCallState = await _userRepository!
        .postAddToCartApi(event.quantity, event.productId, event.driverId,
            event.decrease, "0", "");
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        NetworkApiCallState<bool> apiCallState1 =
            await _userRepository!.getCartCountApiCall();
        NetworkApiCallState<bool> apiCallState2 =
            await _userRepository!.getViewCartListApiCall();

        if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
          if (apiCallState.statusValue == "1") {
            if (event.strScreen == "ProductDetail") {
              emitter(HomeFromProductDetailCartPageState(
                  _userRepository!.getCartDataListArray()!,
                  event.driverDetail,
                  event.productListModel,
                  _userRepository!.getCartDataModel()!,
                  event.strScreen));
            } else if (event.strScreen == "CategoryPage") {
              emitter(HomeFromCategoryCartPageState(
                  _userRepository!.getCartDataListArray()!,
                  event.driverDetail,
                  _userRepository!.getCartDataModel()!));
            } else if (event.strScreen == "DriverList") {
              emitter(HomeFromCategoryCartPageState(
                  _userRepository!.getCartDataListArray()!,
                  event.driverDetail,
                  _userRepository!.getCartDataModel()!));
            } else if (event.strScreen == "HomeCartpage") {
              emitter(HomeCartPageState(
                  _userRepository!.getCartDataListArray()!,
                  _userRepository!.getCartDataListArray()![0].vendor,
                  _userRepository!.getCartDataModel()!));
            }
          } else {
            emitter(HomeEventMessageShowState(apiCallState.message!));
          }
        } else {
          emitter(HomeEventMessageShowState(apiCallState.message!));
        }
      } else {
        emitter(HomeEventMessageShowState(apiCallState.message!));
      }
    } else if (apiCallState.status == NetworkRequestStatus.ERROR) {
      if (apiCallState.message == "Unknown Error") {
        emitter(HomeEventMessageShowState("Something went wrong"));
      } else {
        emitter(HomeEventMessageShowState("Something went wrong"));
      }
    }
  }

  mapHomeEventTicketItemClickPurchaseTicketBtnClick(
      HomeEventTicketItemClickPurchaseTicketBtnClick event,
      Emitter<HomeState> emitter) async {
    print("In bloc setting");
    // yield HomeInitial();
    // yield HomeMenuItemDetailsPageState();
    NetworkApiCallState<bool> apiCallState = await _userRepository!
        .getPurchaseTicketApi(event.quantity, event.productId, event.driverId,
            event.decrease, event.newDriver, event.specialInstruction);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        print("list==>");
        NetworkApiCallState<bool> apiCallState1 =
            await _userRepository!.getCartCountApiCall();
        if (_userRepository!.isNewdriver == "1") {
          print("complete state==>");
          emit(HomeEventAddtocartSuccessState(
              apiCallState.message!,
              _userRepository!.isNewdriver,
              event.productId,
              event.specialInstruction));
        } else {
          emit(HomeEventMessageShowState(apiCallState.message!));
        }
      } else {
        emit(HomeEventMessageShowState(apiCallState.message!));
      }
    } else if (apiCallState.status == NetworkRequestStatus.ERROR) {
      if (apiCallState.message == "Unknown Error") {
        emit(HomeEventMessageShowState("Something went wrong"));
      } else {
        emit(HomeEventMessageShowState("Something went wrong"));
      }
    }
  }

  mapHomeEventItemClickAddToCartBtnClick(
      HomeEventItemClickAddToCartBtnClick event,
      Emitter<HomeState> emitter) async {
    print("In bloc setting");
    // yield HomeInitial();
    // yield HomeMenuItemDetailsPageState();
    NetworkApiCallState<bool> apiCallState = await _userRepository!
        .postAddToCartApi(event.quantity, event.productId, event.driverId,
            event.decrease, event.newDriver, event.specialInstruction);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        NetworkApiCallState<bool> apiCallState1 =
            await _userRepository!.getCartCountApiCall();
        if (_userRepository!.isNewdriver == "1") {
          emitter(HomeEventAddtocartSuccessState(
              apiCallState.message!,
              _userRepository!.isNewdriver,
              event.productId,
              event.specialInstruction));
        } else {
          emitter(HomeEventMessageShowState(apiCallState.message!));
        }
      } else {
        emitter(HomeEventMessageShowState(apiCallState.message!));
      }
    } else if (apiCallState.status == NetworkRequestStatus.ERROR) {
      if (apiCallState.message == "Unknown Error") {
        emitter(HomeEventMessageShowState("Something went wrong"));
      } else {
        emitter(HomeEventMessageShowState("Something went wrong"));
      }
    }
  }

  DriverList? driverDetail;

  mapHomeEventCategoryListLoadingComplete(
      HomeEventCategoryListLoadingComplete event,
      Emitter<HomeState> emitter) async {
    print("In bloc setting");

    driverDetail = event.driverDetail;
    NetworkApiCallState<bool> apiCallState = await _userRepository!
        .getCategoryApiListCall(event.driverDetail.vendorId!);

    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      NetworkApiCallState<bool> apiCallState1 =
          await _userRepository!.getCartCountApiCall();
      if (apiCallState.statusValue == "1") {
        _userRepository!.ScreenName = ScreenNavigation.HomeCategoryListScreen;
        emitter(HomeCategoryListPageState(
            _userRepository!.getCategoryListArray()!, event.driverDetail));
      } else {
        emitter(HomeEventErrorHandelState(
            "Driver is logout please look another driver in your area !"));
      }
    } else if (apiCallState.status == NetworkRequestStatus.ERROR) {
      if (apiCallState.message == "Unknown Error") {
        emitter(HomeEventErrorHandelState("Something went wrong"));
      } else {
        emitter(HomeEventErrorHandelState("Something went wrong"));
      }
    }
  }

  Stream<HomeState> mapHomeEventSettingSideNavigationClick() async* {
    print("In bloc setting");

    // yield HomeSettingPageState(amountdata);
  }

  mapHomeEventDriverPageReset(
      HomeEventDriverPageReset event, Emitter<HomeState> emitter) async {
    print("In bloc setting");

    emitter(HomeInitial());
  }

  mapHomeEventCategoryPageReset(
      HomeEventCategoryPageReset event, Emitter<HomeState> emitter) async {
    print("In bloc setting");

    emitter(HomeCategoryListPageState(
        _userRepository!.getCategoryListArray()!, event.driverDetail));
  }

  mapHomeEventtabChangeToHome(
      HomeEventtabChangeToHome event, Emitter<HomeState> emitter) async {
    print("In bloc");
    // yield HomeInitial();

    emitter(HomeInitial());
  }

  ProductListDriver? driverProductList;

  mapHomeEventDriverProductListClick(
      HomeEventDriverProductListClick event, Emitter<HomeState> emitter) async {
    print("In bloc " + event.toString());
    // _userRepository.ScreenName = "CategoryDetailPage";

    NetworkApiCallState<bool> apiCallState =
        await _userRepository!.postReviewUserList('${event.productId}', "1");
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      _userRepository!.ScreenName = ScreenNavigation.HomeMenuItemDetailScreen;

      NetworkApiCallState<bool> apiCallState1 = await _userRepository!
          .postRelatedProductApi(
              '${event.productId}',
              event.driverProductList.vendorId,
              event.driverProductList.categoryId);

      driverProductList = event.driverProductList;

      emitter(HomeFromDriverProductListDetailsPageState(
          event.driverProductList,
          event.driverDetail,
          event.screen,
          _userRepository!.getRatingReviewList()!,
          _userRepository!.getRelatedProductList()!,
          _userRepository!.getAddOnProductList()!));
    } else {
      emitter(HomeEventErrorHandelState(apiCallState.message!));
    }
  }

  ////////..............................
  mapHomeEventDriverTicketListClick(
      HomeEventDriverTicketListClick event, Emitter<HomeState> emitter) async {
    NetworkApiCallState<bool> apiCallState = await _userRepository!
        .getTicketListApi(event.merchant_id, event.ps_id, event.type);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      print("Complete state===>");
      print("${_userRepository?.getTicketList()?.length}");
      emit(HomeEventDriverTicketListClickPageState(
        _userRepository?.getTicketList()!,
      ));
    } else {
      print("EventTicketListstate===>");
      emit(HomeTicketEventErrorHandelState(apiCallState.message!));
    }
  }

  mapHomeEventDriverRideListClick(
      HomeEventDriverRideListClick event, Emitter<HomeState> emitter) async {
    NetworkApiCallState<bool> apiCallState = await _userRepository!
        .getRideListApi(event.merchant_id, event.ps_id, event.type);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      print("Complete state===>");
      print("${_userRepository?.getRideList()?.length}");
      emit(HomeEventDriverRideListClickPageState(
        _userRepository?.getRideList()!,
      ));
    } else {
      print("EventRideListstate===>");
      emit(HomeEventRideErrorHandelState(apiCallState.message!));
    }
    //emitter(HomeEventDriverRideListClickPageState(_userRepository?.getRideList()!));
  }

  mapHomeEventMenuListItemClick(
      HomeEventMenuListItemClick event, Emitter<HomeState> emitter) async {
    print("In bloc");
    // _userRepository.ScreenName = "CategoryDetailPage";
    _userRepository!.ScreenName = ScreenNavigation.HomeMenuItemDetailScreen;
    emitter(HomeMenuItemDetailsPageState(
        event.productList, event.driverId, event.driverDetail));
  }

  late CategoryListModel categoryList;
  late String vendorId;
  late String categoryId;
  late DriverList driverDetails;

  mapHomeEventCatgoryDetailClick(
      HomeEventCatgoryDetailClick event, Emitter<HomeState> emitter) async* {
    print("In bloc");
    categoryList = event.categoryListModel;
    vendorId = event.driverDetail.vendorId!;
    driverDetails = event.driverDetail;
    categoryId = event.categoryListModel.category_id;

    NetworkApiCallState<bool> apiCallState = await _userRepository!
        .getProductListApiCall(
            categoryId: event.categoryListModel.category_id,
            driverId: event.driverDetail.vendorId!,
            search: "");

    // if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
    //   if (apiCallState.statusValue == "1") {
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        NetworkApiCallState<bool> apiCallState1 =
            await _userRepository!.getCartCountApiCall();
        emitter(HomeCategoryProductPageState(
            event.driverDetail.vendorId!,
            _userRepository!.getProductListArray()!,
            categoryList,
            event.categoryListModel.category_id,
            event.driverDetail,
            sharedPrefs.getCartCount));
      } else {
        NetworkApiCallState<bool> apiCallState1 =
            await _userRepository!.getCartCountApiCall();
        emitter(HomeEventErrorHandelCategorypageState(
            "data not found", event.driverDetail));
      }
    } else if (apiCallState.status == NetworkRequestStatus.ERROR) {
      if (apiCallState.message == "Unknown Error") {
        emitter(HomeEventErrorHandelCategorypageState(
            "Something went wrong", event.driverDetail));
      } else {
        emitter(HomeEventErrorHandelCategorypageState(
            "Something went wrong", event.driverDetail));
      }
    }
    //}
    // else {
    //   yield HomeEventErrorHandelCategorypageState(
    //       "data not found", event.driverDetail);
    // }
    // } else if (apiCallState.status == NetworkRequestStatus.ERROR) {
    //   if (apiCallState.message == "Unknown Error") {
    //     yield HomeEventErrorHandelCategorypageState(
    //         "Something went wrong", event.driverDetail);
    //   } else {
    //     yield HomeEventErrorHandelCategorypageState(
    //         "Something went wrong", event.driverDetail);
    //   }
    // }
  }

  mapHomeEventProductMenuSearch(
      HomeEventProductMenuSearch event, Emitter<HomeState> emitter) async {
    print("In bloc");
    categoryList = event.categoryListModel;
    vendorId = event.driverDetail.vendorId!;
    driverDetails = event.driverDetail;
    categoryId = event.categoryListModel.category_id;
    // _userRepository.ScreenName = "CategoryDetailPage";
    NetworkApiCallState<bool> apiCallState = await _userRepository!
        .getProductListApiCall(
            categoryId: event.categoryListModel.category_id,
            driverId: event.driverDetail.vendorId!,
            search: event.searchText);

    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
          if (apiCallState.statusValue == "1") {
            emitter(HomeCategoryProductPageState(
                event.driverDetail.vendorId!,
                _userRepository!.getProductListArray()!,
                categoryList,
                event.categoryListModel.category_id,
                event.driverDetail,
                sharedPrefs.getCartCount));
          } else {
            emitter(HomeEventErrorHandelCategorypageState(
                "data not found", event.driverDetail));
          }
        } else if (apiCallState.status == NetworkRequestStatus.ERROR) {
          if (apiCallState.message == "Unknown Error") {
            emitter(HomeEventErrorHandelCategorypageState(
                "Something went wrong", event.driverDetail));
          } else {
            emitter(HomeEventErrorHandelCategorypageState(
                "Something went wrong", event.driverDetail));
          }
        }
      } else {
        emitter(HomeEventErrorHandelCategorypageState(
            "data not found", event.driverDetail));
      }
    } else if (apiCallState.status == NetworkRequestStatus.ERROR) {
      if (apiCallState.message == "Unknown Error") {
        emitter(HomeEventErrorHandelCategorypageState(
            "Something went wrong", event.driverDetail));
      } else {
        emitter(HomeEventErrorHandelCategorypageState(
            "Something went wrong", event.driverDetail));
      }
    }
  }

  mapHomeEventBackBtnClick(
      HomeEventBackBtnClick event, Emitter<HomeState> emitter) async* {
    // _userRepository.ScreenName = "CategoryDetailPage";
    // print(state.toString());
    if (state is SignUpPageState) {
      _userRepository!.ScreenName = ScreenNavigation.Loginpage;
      emit((LoginPageState("")));
    } else if (state is ForgetPwdPageState) {
      _userRepository!.ScreenName = ScreenNavigation.Loginpage;
      emitter(LoginPageState(""));
    } else if (state is LoginPageState) {
      _userRepository!.ScreenName = ScreenNavigation.HomeMainPageScreen;
      emitter(HomeInitial());
    } else if (state is LoginLoadingCompleteState) {
      _userRepository!.ScreenName = ScreenNavigation.HomeMainPageScreen;
      emitter(HomeInitial());
    } else if (state is OtpApiLoadingCompleteState) {
      _userRepository!.ScreenName = ScreenNavigation.OTPpage;
      emitter(HomeInitial());
    } else if (state is HomeCategoryProductPageState) {
      emitter(HomeCategoryListPageState(
          _userRepository!.getCategoryListArray()!, driverDetail!));
    } else if (state is HomeMenuItemDetailsPageState) {
      _userRepository!.ScreenName = ScreenNavigation.HomeProductListScreen;
      emitter(HomeCategoryProductPageState(
          vendorId,
          _userRepository!.getProductListArray()!,
          categoryList,
          categoryId,
          driverDetails,
          _userRepository!.getUpdatedCartCount()!));
    } else if (state is HomeCategoryListPageState) {
      _userRepository!.ScreenName = ScreenNavigation.HomeMainPageScreen;
      emitter(HomeInitial());
    } else if (state is HomeCartPageState) {
      print("cart screen ${CartScreenNavigate}");
      _userRepository!.ScreenName = ScreenNavigation.HomeProductListScreen;

      emitter(HomeCategoryProductPageState(
          vendorId,
          _userRepository!.getProductListArray()!,
          categoryList,
          categoryId,
          driverDetails,
          _userRepository!.getUpdatedCartCount()!));
    } else if (state is HomeFromCategoryCartPageState) {
      _userRepository!.ScreenName = ScreenNavigation.HomeProductListScreen;
      emitter(HomeCategoryListPageState(
          _userRepository!.getCategoryListArray()!, driverDetail!));
    } else if (state is HomeFromDriverProductListDetailsPageState) {
      _userRepository!.ScreenName = ScreenNavigation.HomeMainPageScreen;
      emitter(HomeInitial());
    } else if (state is HomeFromProductDetailCartPageState) {
      _userRepository!.ScreenName = ScreenNavigation.HomeMainPageScreen;
      //  print(driverDetail.vendorId);
      emitter(HomeFromDriverProductListDetailsPageState(
          driverProductList!,
          _userRepository!.getDriverProductListArray()![0].vendor!,
          "DriverList",
          _userRepository!.getRatingReviewList()!,
          _userRepository!.getRelatedProductList()!,
          _userRepository!.getAddOnProductList()!));
    } else if (state is HomeCheckOutPageState) {
      emitter(HomeCartPageState(
          _userRepository!.getCartDataListArray()!,
          _userRepository!.getCartDataListArray()![0].vendor,
          _userRepository!.getCartDataModel()!));
    } else if (state is HomeFromDriverListCartPageState) {
      _userRepository!.ScreenName = ScreenNavigation.HomeMainPageScreen;
      emitter(HomeInitial());
    }
  }

  mapHomeEventRideSearchTextFieldClick(HomeEventRideSearchTextFieldClick event,
      Emitter<HomeState> emitter) async {
    emitter(HomeRideLocationSeatchResetPageState());
    emitter(HomeRideLocationSeatchPageState(event.type));
  }

  mapHomeEventRideBackBtnClicked(
      HomeEventRideBackBtnClicked event, Emitter<HomeState> emitter) async {
    emitter(
        HomeEventDriverRideListClickPageState(_userRepository?.getRideList()!));
    print("State===>${state}");
  }
}
