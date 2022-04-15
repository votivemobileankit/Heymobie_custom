import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:grambunny_customer/hm_root/hm_root.dart';
import 'package:grambunny_customer/home/bloc/bloc.dart';
import 'package:grambunny_customer/home/home.dart';
import 'package:grambunny_customer/networking/networking.dart';
import 'package:grambunny_customer/services/services.dart';
import 'package:grambunny_customer/utils/utils.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  UserRepository _userRepository;

  HomeBloc({UserRepository userRepository}) : super(HomeInitial()) {
    _userRepository = userRepository;
  }

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    switch (event.runtimeType) {
      case HomeEventCatgoryDetailClick:
        yield* mapHomeEventCatgoryDetailClick(event);
        break;
      case HomeEventProductMenuSearch:
        yield* mapHomeEventProductMenuSearch(event);
        break;
      case LoginEventSignInButtonClick:
        yield* mapLoginEventSignINClick();
        break;
      case LoginEventSignInFromCheckOutPage:
        yield* mapLoginEventSignInFromCheckOutPage(event);
        break;
      case LoginEventSignUpButtonClick:
        yield* mapLoginEventSignUpButtonClick();
        break;
      case LoginEventForgetPasswordClick:
        yield* mapLoginEventForgetPasswordClick();
        break;
      case HomeEventForOTPScreen:
        yield* mapHomeEventForOTPScreen(event);
        break;
      case OTPEventOTPVerifyButton:
        yield* mapOTPEventOTPVerifyButton(event);
        break;
      case OTPEventOTPResendButton:
        yield* mapOTPEventOTPResendButton(event);
        break;
      case HomeEventBackBtnClick:
        yield* mapHomeEventBackBtnClick();
        break;
      // case HomeEventBackForCheckOutScreen:
      //   yield* mapHomeEventBackForCheckOutScreen();
      //   break;
      case ForgotPasswordEventVerifyBtnClick:
        yield* mapForgotPasswordEventVerifyBtnClick(event);
        break;
      case ResetPasswordPageEvent:
        yield* mapResetPasswordPageEvent(event);
        break;
      case ResetPasswordEventResetBtnClick:
        yield* mapResetPasswordEventResetBtnClick(event);
        break;
      case ResetPasswordPageResetPageEvent:
        yield* mapResetPasswordPageResetEvent(event);
        break;
      case HomeEventMenuListItemClick:
        yield* mapHomeEventMenuListItemClick(event);
        break;
      case HomeEventSettingSideNavigationClick:
        yield* mapHomeEventSettingSideNavigationClick();
        break;
      case HomeEventtabChangeToHome:
        yield* mapHomeEventtabChangeToHome();
        break;
      case HomeEventDriverItemClick:
        yield* mapHomeEventDriverItemClick(event);
        break;
      case HomeEventCategoryListLoadingComplete:
        yield* mapHomeEventCategoryListLoadingComplete(event);
        break;
      case HomeEventDriverListApiCallLoading:
        yield* mapHomeEventDriverListApiCallLoading(event);
        break;
      case HomeEventDriverPageReset:
        yield* mapHomeEventDriverPageReset();
        break;
      case HomeEventCategoryPageReset:
        yield* mapHomeEventCategoryPageReset(event);
        break;

      case HomeEventApplyFilter:
        yield* mapHomeEventApplyFilter(event);
        break;

      case HomeEventApplyResetProductList:
        yield* mapHomeAfterErrorResetProductList(event);
        break;
      case HomeEventCartPageBtnClick:
        yield* mapHomeEventCartPageBtnClick(event);
        break;
      case HomeEventCategoryCartBtnClick:
        yield* mapHomeEventCategoryCartBtnClick(event);
        break;
      case HomeEventDriverListCartBtnClick:
        yield* mapHomeEventDriverListCartBtnClick(event);
        break;
      case HomeEventAddToCartBtnClick:
        yield* mapHomeEventAddToCartBtnClick(event);
        break;
      case HomeEventItemClickAddToCartBtnClick:
        yield* mapHomeEventItemClickAddToCartBtnClick(event);
        break;
      case HomeEventItemAddMinusToCartBtnClick:
        yield* mapHomeEventItemAddMinusToCartBtnClick(event);
        break;
      case HomeEventCartDeleteItemClick:
        yield* mapHomeEventCartDeleteItemClick(event);
        break;
      case HomeEventCartPageReset:
        yield* mapHomeEventCartPageReset(event);
        break;
      case HomeEventProductDetailPageReset:
        yield* mapHomeEventProductDetailPageReset(event);
        break;
      case HomeEventProductDetailPageCartBtnClick:
        yield* mapHomeEventProductDetailPageCartBtnClick(event);
        break;
      case HomeEventBackForProductDetailPage:
        yield* mapHomeEventBackForProductDetailPage(event);
        break;
      case HomeEventBackForCategoryPage:
        yield* mapHomeEventBackForCategoryPage(event);
        break;
      case LoginEventBtnLoginClicked:
        yield* mapLoginEventBtnLoginClicked(event);
        break;
      case HomeEventBackForProductListpage:
        yield* mapHomeEventBackForProductListpage();
        break;
      case HomeEventProductItemDetailPageReset:
        yield* mapHomeEventProductItemDetailPageReset(event);
        break;
      case HomeEventCheckOutButtonClick:
        yield* mapHomeEventCheckOutButtonClick(event);
        break;
      case HomeEventAfterRefreshToCheckOutPage:
        yield* mapHomeEventAfterRefreshToCheckOutPage(event);
        break;
      case HomeEventCouponListbtnClick:
        yield* mapHomeEventCouponListbtnClick(event);
        break;
      case HomeEventCouponListbtnApply:
        yield* mapHomeEventCouponListbtnApply(event);
        break;
      case HomeEventResetCheckOutState:
        yield* mapHomeEventResetCheckOutState(event);
        break;
      case HomeEventDriverProductListClick:
        yield* mapHomeEventDriverProductListClick(event);
        break;
      case LoginEventLoginStateReset:
        yield* mapLoginEventLoginStateReset();
        break;
      case SignUpEventSignUpBtnClick:
        yield* mapSignUpEventSignUpBtnClick(event);
        break;
      case HomeEventSubmitOrderBtnClick:
        yield* mapHomeEventSubmitOrderBtnClick(event);
        break;
      case HomeEventSubmitRatingBtnClick:
        yield* mapHomeEventSubmitRatingBtnClick(event);
        break;
      case HomeEventLoadMoreBtnClick:
        yield* mapHomeEventLoadMoreBtnClick(event);
        break;
    }
  }

  Stream<HomeState> mapHomeEventLoadMoreBtnClick(
      HomeEventLoadMoreBtnClick event) async* {
    NetworkApiCallState<bool> apiCallState = await _userRepository
        .postReviewUserList('${event.productId}', event.pageCount);

    driverProductList = event.productListDriverModel;
    _userRepository.ScreenName = ScreenNavigation.HomeMenuItemDetailScreen;
    if (apiCallState.statusValue == "1") {
      yield HomeFromDriverProductListDetailsPageState(
          event.productListDriverModel,
          event.vendorDetails,
          event.strScreen,
          _userRepository.getRatingReviewList(),
          _userRepository.getRelatedProductList(),
          _userRepository.getAddOnProductList());
    } else {
      yield HomeEventErrorHandelState(apiCallState.message);
    }
  }

  Stream<HomeState> mapHomeEventSubmitOrderBtnClick(
      HomeEventSubmitOrderBtnClick event) async* {
    print("Zip in block " + event.zip);
    NetworkApiCallState<bool> apiCallState =
        await _userRepository.postSubmitPaymentApiCall(
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
      _userRepository.ScreenName = ScreenNavigation.CheckOutPageScreen;
      if (apiCallState.statusValue == "1") {
        sharedPrefs.setCartCount = "0";
        yield HomeCheckOutOrderCompleteState();
      } else {
        HomeCheckOutOrderErrorState(apiCallState.message);
      }
    } else {
      HomeCheckOutOrderErrorState(apiCallState.message);
    }
  }

  Stream<HomeState> mapHomeEventCouponListbtnApply(
      HomeEventCouponListbtnApply event) async* {
    NetworkApiCallState<bool> apiCallState = await _userRepository
        .getCheckOutCalculationApi(event.vendorId, event.couponCode);

    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      _userRepository.ScreenName = ScreenNavigation.CheckOutPageScreen;
      NetworkApiCallState<bool> apiCallState1 =
          await _userRepository.getViewCouponCodeApiCall(event.vendorId);
      if (apiCallState.statusValue == "1") {
        yield HomeCheckOutCouponApplyState(
            _userRepository.getCheckOutCalculation(),
            _userRepository.getCouponArrayList(),
            _userRepository.getCheckOutCalculation().couponAmount,
            event.couponId,
            apiCallState.message);
      } else {
        yield HomeCheckOutOrderErrorState(apiCallState.message);
      }
    } else {
      yield HomeCheckOutOrderErrorState(apiCallState.message);
    }
  }

  Stream<HomeState> mapHomeEventSubmitRatingBtnClick(
      HomeEventSubmitRatingBtnClick event) async* {
    NetworkApiCallState<bool> apiCallState =
        await _userRepository.postProductRatingReviewApi(
            "${event.productId}", event.ratingCount, event.reviewText);

    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        yield HomeCustomerRatingReviewSubmitState(apiCallState.message);
      } else {
        yield HomeEventErrorHandelState(apiCallState.message);
      }
    } else {
      yield HomeEventErrorHandelState(apiCallState.message);
    }
  }

  Stream<HomeState> mapHomeEventCouponListbtnClick(
      HomeEventCouponListbtnClick event) async* {
    NetworkApiCallState<bool> apiCallState = await _userRepository
        .getCheckOutCalculationApi(event.vendorId, event.couponCode);

    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      _userRepository.ScreenName = ScreenNavigation.CheckOutPageScreen;
      NetworkApiCallState<bool> apiCallState1 =
          await _userRepository.getViewCouponCodeApiCall(event.vendorId);
      if (apiCallState.statusValue == "1") {
        yield HomeCheckOutCalculateState(
            _userRepository.getCheckOutCalculation(),
            _userRepository.getCouponArrayList());
      } else {
        yield HomeCheckOutOrderErrorState(apiCallState.message);
      }
    } else {
      yield HomeCheckOutOrderErrorState(apiCallState.message);
    }
  }

  Stream<HomeState> mapHomeEventResetCheckOutState(
      HomeEventResetCheckOutState event) async* {
    print("In Reset Checkout");
    // yield HomeInitialReset();
    yield HomeCheckOutPageState(
        event.strScreen,
        event.driverDetail,
        event.productListModel,
        _userRepository.getStateArrayList(),
        event.vendorId);
  }

  // Stream<HomeState> mapHomeEventBackForCheckOutScreen() async* {
  //   print("In Reset Checkout");
  //   // yield HomeInitialReset();
  //   yield HomeCheckOutPageState(
  //       event.strScreen, event.driverDetail, event.productListModel);
  // }

  Stream<HomeState> mapHomeEventAfterRefreshToCheckOutPage(
      HomeEventAfterRefreshToCheckOutPage event) async* {
    print("In bloc setting");
    NetworkApiCallState<bool> apiCallState =
        await _userRepository.getStateListApi();
    NetworkApiCallState<bool> apiCallState1 =
        await _userRepository.getViewCartListApiCall();
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        print("login success" + apiCallState.message);

        yield HomeCheckOutPageState(
            event.strScreen,
            event.driverDetail,
            event.productListModel,
            _userRepository.getStateArrayList(),
            event.vendorId);
      } else {
        yield HomeCheckOutPageState(
            event.strScreen,
            event.driverDetail,
            event.productListModel,
            _userRepository.getStateArrayList(),
            event.vendorId);
      }
    } else {
      yield SignUpLoadingErrorState("Server Error");
    }
  }

  Stream<HomeState> mapHomeEventCheckOutButtonClick(
      HomeEventCheckOutButtonClick event) async* {
    print("In bloc setting");
    NetworkApiCallState<bool> apiCallState =
        await _userRepository.getStateListApi();
    NetworkApiCallState<bool> apiCallState1 =
        await _userRepository.getViewCartListApiCall();
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        print("login success" + apiCallState.message);
        yield HomeBeforeCheckOutPageState(
            event.strScreen,
            event.driverDetail,
            event.productListModel,
            _userRepository.getStateArrayList(),
            event.vendorId);
        // yield HomeCheckOutPageState(
        //     event.strScreen,
        //     event.driverDetail,
        //     event.productListModel,
        //     _userRepository.getStateArrayList(),
        //     event.vendorId);
      } else {
        yield HomeBeforeCheckOutPageState(
            event.strScreen,
            event.driverDetail,
            event.productListModel,
            _userRepository.getStateArrayList(),
            event.vendorId);
      }
    } else {
      yield SignUpLoadingErrorState("Server Error");
    }
  }

  Stream<HomeState> mapSignUpEventSignUpBtnClick(
      SignUpEventSignUpBtnClick event) async* {
    _userRepository.ScreenName = ScreenNavigation.SignUpPage;
    NetworkApiCallState<bool> apiCallState = await _userRepository.SignUpToAPI(
        fname: event.firstName,
        lname: event.lastName,
        email: event.email,
        password: event.password,
        mobileno: event.mobileNO,
        devicetype: event.devicetype,
        devicetoken: event.devicetoken,
        dob: event.dob,
        address: event.address,
        city: event.city,
        state: event.state,
        zipcode: event.zipcode,
        os_name: event.os_name,
        licenseImageBack: event.strBackLicensePath,
        licenseImageFront: event.strFrontLicensePath,
        profileImage: event.strUserProfilePath,
        strCustomerType: event.strCustomerType,
        marijuanaIdCard: event.strMarijuanaId);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        print("login success" + apiCallState.message);
        print("login success" + apiCallState.message);
        yield SignUpLoadingCompleteState(apiCallState.message, event.email);
      } else {
        print(apiCallState.message);
        yield SignUpLoadingErrorState(apiCallState.message);
      }
    } else {
      yield SignUpLoadingErrorState("Server Error");
    }
  }

  Stream<HomeState> mapResetPasswordPageResetEvent(
      ResetPasswordPageResetPageEvent event) async* {
    print("emailllllll===>>>" + event.email);
    UserDetail userArray = _userRepository.getUserDetail();

    yield OtpApiLoadingCompleteState("", event.email, userArray);
  }

  Stream<HomeState> mapResetPasswordPageEvent(
      ResetPasswordPageEvent event) async* {
    print("emailllllll===>>>" + event.email);
    yield ResetPasswordPageState(event.email);
  }

  Stream<HomeState> mapResetPasswordEventResetBtnClick(
      ResetPasswordEventResetBtnClick event) async* {
    print("emailllllll===>>>" + event.email);

    NetworkApiCallState<bool> apiCallState =
        await _userRepository.ResetPasswordToAPI(event.email, event.password);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      _userRepository.ScreenName = ScreenNavigation.ResetPwdPage;
      if (apiCallState.statusValue == "1") {
        yield ResetPasswordApiLoadingCompleteState(apiCallState.message);
      } else {
        yield ResetPasswordApiLoadingErrorState(
            apiCallState.message, event.email);
      }
    } else {
      yield ResetPasswordApiLoadingErrorState("Server Error", event.email);
    }
  }

  Stream<HomeState> mapForgotPasswordEventVerifyBtnClick(
      ForgotPasswordEventVerifyBtnClick event) async* {
    print("emailllllll===>>>" + event.emailID);

    NetworkApiCallState<bool> apiCallState =
        await _userRepository.ForgotPasswordToAPI(event.emailID);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      print("Forgot Password Success");
      _userRepository.ScreenName = ScreenNavigation.ForgetPwdPage;
      if (apiCallState.statusValue == "1") {
        yield ForgotPasswordApiLoadingCompleteState(
            apiCallState.message, event.emailID);
      } else {
        yield ForgotPasswordApiLoadingErrorState(apiCallState.message);
      }
    } else {
      yield ForgotPasswordApiLoadingErrorState("Server Error");
    }
  }

  Stream<HomeState> mapLoginEventLoginStateReset() async* {
    if (state is LoginLoadingErrorState) {
      yield LoginPageState("driverlist");
    }
    if (state is SignUpLoadingErrorState) {
      yield SignUpPageState(_userRepository.getStateArrayList());
    }
  }

  Stream<HomeState> mapLoginEventSignUpButtonClick() async* {
    _userRepository.ScreenName = ScreenNavigation.SignUpPage;
    NetworkApiCallState<bool> apiCallState =
        await _userRepository.getStateListApi();
    print("massege ===>>>" + apiCallState.message);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        yield SignUpPageState(_userRepository.getStateArrayList());
      } else {}
    } else {}
  }

  Stream<HomeState> mapHomeEventForOTPScreen(
      HomeEventForOTPScreen event) async* {
    _userRepository.ScreenName = ScreenNavigation.OTPpage;
    yield OTPpageState(event.emai_id, event.from);
  }

  Stream<HomeState> mapOTPEventOTPVerifyButton(
      OTPEventOTPVerifyButton event) async* {
    _userRepository.ScreenName = ScreenNavigation.OTPpage;
    NetworkApiCallState<bool> apiCallState =
        await _userRepository.OtpVarify(event.email, event.otp, event.from);
    print("massege ===>>>" + apiCallState.message);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        UserDetail userArray = _userRepository.getUserDetail();
        yield OtpApiLoadingCompleteState(
            apiCallState.message, event.email, userArray);
      } else {
        yield OtpApiLoadingErrorState(apiCallState.message);
      }
    } else {
      yield OtpApiLoadingErrorState("Server Error");
    }
  }

  Stream<HomeState> mapOTPEventOTPResendButton(
      OTPEventOTPResendButton event) async* {
    _userRepository.ScreenName = ScreenNavigation.OTPpage;
    NetworkApiCallState<bool> apiCallState =
        await _userRepository.OtpResend(event.email, event.from);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        yield OtpResendApiLoadingCompleteState(apiCallState.message);
      } else {
        yield OtpResendApiLoadingErrorState(apiCallState.message);
      }
    } else {
      yield OtpResendApiLoadingErrorState("Server Error");
    }
  }

  Stream<HomeState> mapLoginEventSignInFromCheckOutPage(
      LoginEventSignInFromCheckOutPage event) async* {
    _userRepository.ScreenName = ScreenNavigation.Loginpage;
    yield (LoginPageStateFromCheckOut(event.strScreen, event.productList,
        event.driverDetail, event.productListModel, event.cartDataModel));
  }

  Stream<HomeState> mapLoginEventSignINClick() async* {
    _userRepository.ScreenName = ScreenNavigation.Loginpage;
    yield (LoginPageState("DriverList"));
  }

  Stream<HomeState> mapLoginEventBtnLoginClicked(
      LoginEventBtnLoginClicked event) async* {
    //_userRepository.ScreenName = "SignUpPage";
    _userRepository.ScreenName = ScreenNavigation.Loginpage;
    NetworkApiCallState<bool> apiCallState = await _userRepository.LoginToAPI(
        event.emailid,
        event.password,
        event.card_id,
        event.devicetype,
        event.os_name,
        "");
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        UserDetail userArray = _userRepository.getUserDetail();

        sharedPrefs.setUserId = "${userArray.id}";
        sharedPrefs.isLogin = true;
        sharedPrefs.setUserName = userArray.name;
        sharedPrefs.setUserProfileImage = userArray.profileURL;
        print("login success" + apiCallState.message);
        yield LoginLoadingCompleteState(
            apiCallState.message, _userRepository.getUserDetail());
      } else if (apiCallState.statusValue == "2") {
        yield LoginLoadingCompleteState(
            apiCallState.message, _userRepository.getUserDetail());
      } else {
        print(apiCallState.message);
        yield LoginLoadingErrorState(apiCallState.message);
      }
    } else {
      yield LoginLoadingErrorState("Server Error");
    }
  }

  Stream<HomeState> mapLoginEventForgetPasswordClick() async* {
    _userRepository.ScreenName = ScreenNavigation.ForgetPwdPage;
    yield (ForgetPwdPageState());
  }

  Stream<HomeState> mapHomeEventProductDetailPageReset(
      HomeEventProductDetailPageReset event) async* {
    print("In bloc setting");

    NetworkApiCallState<bool> apiCallState =
        await _userRepository.getCartCountApiCall();
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      _userRepository.ScreenName = ScreenNavigation.HomeMenuItemDetailScreen;
      yield HomeMenuItemDetailsPageState(
          event.productListModel, event.driverId, event.driverDetail);
    } else {
      _userRepository.ScreenName = ScreenNavigation.HomeMenuItemDetailScreen;
      yield HomeMenuItemDetailsPageState(
          event.productListModel, event.driverId, event.driverDetail);
    }
  }

  Stream<HomeState> mapHomeEventCartDeleteItemClick(
      HomeEventCartDeleteItemClick event) async* {
    print("In bloc setting ${event.productId}${event.driverDetail.vendorId}");
    _userRepository.ScreenName = ScreenNavigation.HomeMyCartScreen;
    NetworkApiCallState<bool> apiCallState =
        await _userRepository.getCartDeleteSingleItemApiCall(
            event.productId, event.driverDetail.vendorId);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        NetworkApiCallState<bool> apiCallState1 =
            await _userRepository.getCartCountApiCall();
        NetworkApiCallState<bool> apiCallState =
            await _userRepository.getViewCartListApiCall();
        if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
          if (apiCallState.statusValue == "1") {
            _userRepository.ScreenName = ScreenNavigation.HomeMyCartScreen;

            yield HomeCartPageState(
                _userRepository.getCartDataListArray(),
                _userRepository.getCartDataListArray()[0].vendor,
                _userRepository.getCartDataModel());
          } else if (_userRepository.getCartDataListArray().isEmpty) {
            sharedPrefs.setCartCount = "0";
            yield HomeEventAfterDeleteMessageShowState(
              apiCallState.message,
              _userRepository.getCartDataListArray(),
            );
          } else {
            yield HomeEventMessageShowState(apiCallState.message);
          }
        } else if (apiCallState.status == NetworkRequestStatus.ERROR) {
          if (apiCallState.message == "Unknown Error") {
            yield HomeEventMessageShowState("Something went wrong");
          } else {
            yield HomeEventMessageShowState("Something went wrong");
          }
        }
      }
    } else {}
    //  yield HomeFromDriverListCartPageState(event.productId);
  }

  Stream<HomeState> mapHomeEventProductDetailPageCartBtnClick(
      HomeEventProductDetailPageCartBtnClick event) async* {
    _userRepository.ScreenName = ScreenNavigation.HomeMyCartScreen;
    NetworkApiCallState<bool> apiCallState =
        await _userRepository.getViewCartListApiCall();
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      NetworkApiCallState<bool> apiCallState1 =
          await _userRepository.getCartCountApiCall();
      if (apiCallState.statusValue == "1") {
        yield HomeFromProductDetailCartPageState(
            _userRepository.getCartDataListArray(),
            event.driverDetail,
            event.productListModel,
            _userRepository.getCartDataModel(),
            event.strScreen);
      } else {
        yield HomeEventErrorHandelState(apiCallState.message);
        if (apiCallState.message == "Cart empty") {
          sharedPrefs.setCartCount = "0";
        }
      }
    } else if (apiCallState.status == NetworkRequestStatus.ERROR) {
      if (apiCallState.message == "Unknown Error") {
        yield HomeEventErrorHandelState("Something went wrong");
      } else {
        yield HomeEventErrorHandelState("Something went wrong");
      }
    }
  }

  Stream<HomeState> mapHomeEventCartBeforeCheckout(
      HomeEventCartPageReset event) async* {
    _userRepository.ScreenName = ScreenNavigation.HomeMyCartScreen;

    if (event.strScreen == "ProductDetail") {
      yield HomeFromProductDetailCartPageState(
          _userRepository.getCartDataListArray(),
          event.driverDetail,
          event.productListModel,
          _userRepository.getCartDataModel(),
          event.strScreen);
    } else if (event.strScreen == "CategoryPage") {
      yield HomeFromCategoryCartPageState(
          _userRepository.getCartDataListArray(),
          event.driverDetail,
          _userRepository.getCartDataModel());
    } else if (event.strScreen == "DriverList") {
      yield HomeFromCategoryCartPageState(
          _userRepository.getCartDataListArray(),
          event.driverDetail,
          _userRepository.getCartDataModel());
    } else if (event.strScreen == "HomeCartpage") {
      if (_userRepository.getCartDataListArray().isEmpty) {
        yield HomeCartPageState(_userRepository.getCartDataListArray(), null,
            _userRepository.getCartDataModel());
      } else {
        yield HomeCartPageState(
            _userRepository.getCartDataListArray(),
            _userRepository.getCartDataListArray()[0].vendor,
            _userRepository.getCartDataModel());
      }
    }
  }

  Stream<HomeState> mapHomeEventCartPageReset(
      HomeEventCartPageReset event) async* {
    _userRepository.ScreenName = ScreenNavigation.HomeMyCartScreen;

    if (event.strScreen == "ProductDetail") {
      yield HomeFromProductDetailCartPageState(
          _userRepository.getCartDataListArray(),
          event.driverDetail,
          event.productListModel,
          _userRepository.getCartDataModel(),
          event.strScreen);
    } else if (event.strScreen == "CategoryPage") {
      yield HomeFromCategoryCartPageState(
          _userRepository.getCartDataListArray(),
          event.driverDetail,
          _userRepository.getCartDataModel());
    } else if (event.strScreen == "DriverList") {
      yield HomeFromCategoryCartPageState(
          _userRepository.getCartDataListArray(),
          event.driverDetail,
          _userRepository.getCartDataModel());
    } else if (event.strScreen == "HomeCartpage") {
      if (_userRepository.getCartDataListArray().isEmpty) {
        yield HomeCartPageState(_userRepository.getCartDataListArray(), null,
            _userRepository.getCartDataModel());
      } else {
        yield HomeCartPageState(
            _userRepository.getCartDataListArray(),
            _userRepository.getCartDataListArray()[0].vendor,
            _userRepository.getCartDataModel());
      }
    }
  }

  Stream<HomeState> mapHomeEventBackForProductListpage() async* {
    _userRepository.ScreenName = ScreenNavigation.HomeProductListScreen;
    yield HomeInitialReset();
    yield HomeCategoryProductPageState(
        vendorId,
        _userRepository.getProductListArray(),
        categoryList,
        categoryId,
        driverDetails,
        _userRepository.getUpdatedCartCount());
  }

  Stream<HomeState> mapHomeEventBackForCategoryPage(
      HomeEventBackForCategoryPage event) async* {
    yield HomeInitialReset();
    yield HomeCategoryListPageState(
        _userRepository.getCategoryListArray(), event.driverDetail);
  }

  Stream<HomeState> mapHomeEventProductItemDetailPageReset(
      HomeEventProductItemDetailPageReset event) async* {
    yield HomeMenuItemDetailsPageState(event.productListModel,
        event.driverDetail.vendorId, event.driverDetail);
  }

  Stream<HomeState> mapHomeEventBackForProductDetailPage(
      HomeEventBackForProductDetailPage event) async* {
    print("Here=====");
    yield HomeInitialReset();
    yield HomeMenuItemDetailsPageState(event.productListModel,
        event.driverDetail.vendorId, event.driverDetail);
  }

  Stream<HomeState> mapHomeEventDriverListCartBtnClick(
      HomeEventDriverListCartBtnClick event) async* {
    print("In bloc setting");

    NetworkApiCallState<bool> apiCallState =
        await _userRepository.getViewCartListApiCall();
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        _userRepository.ScreenName = ScreenNavigation.HomeMyCartScreen;
        yield HomeFromDriverListCartPageState(
            _userRepository.getCartDataListArray(),
            _userRepository.getDriverDetails(),
            _userRepository.getCartDataModel());
      }
    } else {}
  }

  Stream<HomeState> mapHomeEventCategoryCartBtnClick(
      HomeEventCategoryCartBtnClick event) async* {
    print("In bloc setting");

    NetworkApiCallState<bool> apiCallState =
        await _userRepository.getViewCartListApiCall();
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        _userRepository.ScreenName = ScreenNavigation.HomeMyCartScreen;
        yield HomeFromCategoryCartPageState(
            _userRepository.getCartDataListArray(),
            _userRepository.getDriverDetails(),
            _userRepository.getCartDataModel());
      }
    } else {}
  }

  Stream<HomeState> mapHomeEventCartPageBtnClick(
      HomeEventCartPageBtnClick event) async* {
    print("In bloc setting");
    _userRepository.ScreenName = ScreenNavigation.HomeMyCartScreen;
    NetworkApiCallState<bool> apiCallState =
        await _userRepository.getViewCartListApiCall();
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        for (int i = 0;
            i < _userRepository.getCartDataListArray().length;
            i++) {
          if (_userRepository.getCartDataListArray()[i].vendor != null) {
            yield HomeCartPageState(
                _userRepository.getCartDataListArray(),
                _userRepository.getCartDataListArray()[i].vendor,
                _userRepository.getCartDataModel());
            break;
          }
        }
      } else {
        yield HomeEventErrorHandelProductListPage(
            "data not found", "", " ", "", "", "", event.driverDetail);
      }
    } else {
      yield HomeEventErrorHandelProductListPage(
          "data not found", "", " ", "", "", "", event.driverDetail);
    }
  }

  Stream<HomeState> mapHomeAfterErrorResetProductList(
      HomeEventApplyResetProductList event) async* {
    print("In bloc setting");

    NetworkApiCallState<bool> apiCallState =
        await _userRepository.getProductListApiCall(
            categoryId: event.categoryId, driverId: event.driverId, search: "");
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        print("Product list call====");

        print("Filter list call====");
        yield HomeCategoryProductPageState(
            event.driverDetail.vendorId,
            _userRepository.getProductListArray(),
            categoryList,
            event.categoryId,
            event.driverDetail,
            sharedPrefs.getCartCount);
      } else {
        yield HomeEventErrorHandelCategorypageState(
            "data not found", event.driverDetail);
      }
    } else {
      yield HomeEventErrorHandelCategorypageState(
          "data not found", event.driverDetail);
    }
  }

  Stream<HomeState> mapHomeEventApplyFilter(HomeEventApplyFilter event) async* {
    print("In bloc setting");
  }

  Stream<HomeState> mapHomeEventDriverItemClick(
      HomeEventDriverItemClick event) async* {
    print("In bloc setting");
    _userRepository.saveDriverDetail = event.driverDetail;
    yield HomeCategoryListLoadingProgressState(event.driverDetail);
  }

  Stream<HomeState> mapHomeEventDriverListApiCallLoading(
      HomeEventDriverListApiCallLoading event) async* {
    // yield HomeInitial();
    // yield HomeMenuItemDetailsPageState();

    NetworkApiCallState<bool> apiCallState =
        await _userRepository.getDriverApiListCall(
            event.currentLat, event.currentLong, event.keyword, event.searchBy);

    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      print("call api driver list 1 =======");
      if (apiCallState.statusValue == "1") {
        print("call api driver list 2 =======");

        for (int i = 0; i < _userRepository.getDriverListArray().length; i++) {
          try {
            NetworkApiCallState<bool> apiCallState1 =
                await _userRepository.getMapImage(
                    url: _userRepository.getDriverListArray()[i].map_icon);
          } catch (e) {
            print(e.toString());
          }
        }

        yield HomeDriverListApiCallCompleteState(
            _userRepository.getDriverListArray(),
            sharedPrefs.getCartCount,
            _userRepository.getDriverProductListArray(),
            _userRepository.getAdvertisementArray(),
            _userRepository.getBannerImage(),
            _userRepository.getPinLocationList());
      } else {
        yield HomeEventDataNotFoundState(
            "data not found", _userRepository.getAdvertisementArray());
      }
    } else if (apiCallState.status == NetworkRequestStatus.ERROR) {
      if (apiCallState.message == "Unknown Error") {
        yield HomeEventErrorHandelState("Something went wrong");
      } else {
        yield HomeEventErrorHandelState("Something went wrong");
      }
    }
  }

  Stream<HomeState> mapHomeEventAddToCartBtnClick(
      HomeEventAddToCartBtnClick event) async* {
    print("In bloc setting");
    // yield HomeInitial();
    // yield HomeMenuItemDetailsPageState();

    NetworkApiCallState<bool> apiCallState =
        await _userRepository.postAddToCartApi(
            event.quantity,
            event.productId,
            event.driverId,
            event.decrease,
            event.isNewDriver,
            event.specialInstruction);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        NetworkApiCallState<bool> apiCallState1 =
            await _userRepository.getCartCountApiCall();

        if (_userRepository.isNewdriver == "1") {
          yield HomeEventAddtocartSuccessState(
              apiCallState.message,
              _userRepository.isNewdriver,
              event.productId,
              event.specialInstruction);
        } else {
          yield HomeEventMessageShowState(apiCallState.message);
        }
      } else {
        yield HomeEventMessageShowState(apiCallState.message);
      }
    } else if (apiCallState.status == NetworkRequestStatus.ERROR) {
      if (apiCallState.message == "Unknown Error") {
        yield HomeEventMessageShowState("Something went wrong");
      } else {
        yield HomeEventMessageShowState("Something went wrong");
      }
    }
  }

  Stream<HomeState> mapHomeEventItemAddMinusToCartBtnClick(
      HomeEventItemAddMinusToCartBtnClick event) async* {
    print("In bloc setting");
    // yield HomeInitial();
    // yield HomeMenuItemDetailsPageState();
    print("driverId" + event.driverId);
    NetworkApiCallState<bool> apiCallState =
        await _userRepository.postAddToCartApi(event.quantity, event.productId,
            event.driverId, event.decrease, "0", "");
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        NetworkApiCallState<bool> apiCallState1 =
            await _userRepository.getCartCountApiCall();
        NetworkApiCallState<bool> apiCallState2 =
            await _userRepository.getViewCartListApiCall();

        if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
          if (apiCallState.statusValue == "1") {
            if (event.strScreen == "ProductDetail") {
              yield HomeFromProductDetailCartPageState(
                  _userRepository.getCartDataListArray(),
                  event.driverDetail,
                  event.productListModel,
                  _userRepository.getCartDataModel(),
                  event.strScreen);
            } else if (event.strScreen == "CategoryPage") {
              yield HomeFromCategoryCartPageState(
                  _userRepository.getCartDataListArray(),
                  event.driverDetail,
                  _userRepository.getCartDataModel());
            } else if (event.strScreen == "DriverList") {
              yield HomeFromCategoryCartPageState(
                  _userRepository.getCartDataListArray(),
                  event.driverDetail,
                  _userRepository.getCartDataModel());
            } else if (event.strScreen == "HomeCartpage") {
              yield HomeCartPageState(
                  _userRepository.getCartDataListArray(),
                  _userRepository.getCartDataListArray()[0].vendor,
                  _userRepository.getCartDataModel());
            }
          } else {
            yield HomeEventMessageShowState(apiCallState.message);
          }
        } else {
          yield HomeEventMessageShowState(apiCallState.message);
        }
      } else {
        yield HomeEventMessageShowState(apiCallState.message);
      }
    } else if (apiCallState.status == NetworkRequestStatus.ERROR) {
      if (apiCallState.message == "Unknown Error") {
        yield HomeEventMessageShowState("Something went wrong");
      } else {
        yield HomeEventMessageShowState("Something went wrong");
      }
    }
  }

  Stream<HomeState> mapHomeEventItemClickAddToCartBtnClick(
      HomeEventItemClickAddToCartBtnClick event) async* {
    print("In bloc setting");
    // yield HomeInitial();
    // yield HomeMenuItemDetailsPageState();
    NetworkApiCallState<bool> apiCallState =
        await _userRepository.postAddToCartApi(
            event.quantity,
            event.productId,
            event.driverId,
            event.decrease,
            event.newDriver,
            event.specialInstruction);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        NetworkApiCallState<bool> apiCallState1 =
            await _userRepository.getCartCountApiCall();
        if (_userRepository.isNewdriver == "1") {
          yield HomeEventAddtocartSuccessState(
              apiCallState.message,
              _userRepository.isNewdriver,
              event.productId,
              event.specialInstruction);
        } else {
          yield HomeEventMessageShowState(apiCallState.message);
        }
      } else {
        yield HomeEventMessageShowState(apiCallState.message);
      }
    } else if (apiCallState.status == NetworkRequestStatus.ERROR) {
      if (apiCallState.message == "Unknown Error") {
        yield HomeEventMessageShowState("Something went wrong");
      } else {
        yield HomeEventMessageShowState("Something went wrong");
      }
    }
  }

  DriverList driverDetail;

  Stream<HomeState> mapHomeEventCategoryListLoadingComplete(
      HomeEventCategoryListLoadingComplete event) async* {
    print("In bloc setting");

    driverDetail = event.driverDetail;
    NetworkApiCallState<bool> apiCallState = await _userRepository
        .getCategoryApiListCall(event.driverDetail.vendorId);

    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      NetworkApiCallState<bool> apiCallState1 =
          await _userRepository.getCartCountApiCall();
      if (apiCallState.statusValue == "1") {
        _userRepository.ScreenName = ScreenNavigation.HomeCategoryListScreen;
        yield HomeCategoryListPageState(
            _userRepository.getCategoryListArray(), event.driverDetail);
      } else {
        yield HomeEventErrorHandelState(
            "Driver is logout please look another driver in your area !");
      }
    } else if (apiCallState.status == NetworkRequestStatus.ERROR) {
      if (apiCallState.message == "Unknown Error") {
        yield HomeEventErrorHandelState("Something went wrong");
      } else {
        yield HomeEventErrorHandelState("Something went wrong");
      }
    }
  }

  Stream<HomeState> mapHomeEventSettingSideNavigationClick() async* {
    print("In bloc setting");

    // yield HomeSettingPageState(amountdata);
  }

  Stream<HomeState> mapHomeEventDriverPageReset() async* {
    print("In bloc setting");

    yield HomeInitial();
  }

  Stream<HomeState> mapHomeEventCategoryPageReset(
      HomeEventCategoryPageReset event) async* {
    print("In bloc setting");

    yield HomeCategoryListPageState(
        _userRepository.getCategoryListArray(), event.driverDetail);
  }

  Stream<HomeState> mapHomeEventtabChangeToHome() async* {
    print("In bloc");
    // yield HomeInitial();

    yield HomeInitial();
  }

  ProductListDriver driverProductList;

  Stream<HomeState> mapHomeEventDriverProductListClick(
      HomeEventDriverProductListClick event) async* {
    // print("In bloc " + event.name);
    // _userRepository.ScreenName = "CategoryDetailPage";

    NetworkApiCallState<bool> apiCallState =
        await _userRepository.postReviewUserList('${event.productId}', "1");
    NetworkApiCallState<bool> apiCallState1 =
        await _userRepository.postRelatedProductApi(
            '${event.productId}',
            event.driverProductList.vendorId,
            event.driverProductList.categoryId);
    driverProductList = event.driverProductList;
    _userRepository.ScreenName = ScreenNavigation.HomeMenuItemDetailScreen;

    yield HomeFromDriverProductListDetailsPageState(
        event.driverProductList,
        event.driverDetail,
        event.screen,
        _userRepository.getRatingReviewList(),
        _userRepository.getRelatedProductList(),
        _userRepository.getAddOnProductList());
  }

  Stream<HomeState> mapHomeEventMenuListItemClick(
      HomeEventMenuListItemClick event) async* {
    print("In bloc");
    // _userRepository.ScreenName = "CategoryDetailPage";
    _userRepository.ScreenName = ScreenNavigation.HomeMenuItemDetailScreen;
    yield HomeMenuItemDetailsPageState(
        event.productList, event.driverId, event.driverDetail);
  }

  CategoryListModel categoryList;
  String vendorId;
  String categoryId;
  DriverList driverDetails;

  Stream<HomeState> mapHomeEventCatgoryDetailClick(
      HomeEventCatgoryDetailClick event) async* {
    print("In bloc");
    categoryList = event.categoryListModel;
    vendorId = event.driverDetail.vendorId;
    driverDetails = event.driverDetail;
    categoryId = event.categoryListModel.category_id;

    NetworkApiCallState<bool> apiCallState =
        await _userRepository.getProductListApiCall(
            categoryId: event.categoryListModel.category_id,
            driverId: event.driverDetail.vendorId,
            search: "");

    // if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
    //   if (apiCallState.statusValue == "1") {
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        NetworkApiCallState<bool> apiCallState1 =
            await _userRepository.getCartCountApiCall();
        yield HomeCategoryProductPageState(
            event.driverDetail.vendorId,
            _userRepository.getProductListArray(),
            categoryList,
            event.categoryListModel.category_id,
            event.driverDetail,
            sharedPrefs.getCartCount);
      } else {
        NetworkApiCallState<bool> apiCallState1 =
            await _userRepository.getCartCountApiCall();
        yield HomeEventErrorHandelCategorypageState(
            "data not found", event.driverDetail);
      }
    } else if (apiCallState.status == NetworkRequestStatus.ERROR) {
      if (apiCallState.message == "Unknown Error") {
        yield HomeEventErrorHandelCategorypageState(
            "Something went wrong", event.driverDetail);
      } else {
        yield HomeEventErrorHandelCategorypageState(
            "Something went wrong", event.driverDetail);
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

  Stream<HomeState> mapHomeEventProductMenuSearch(
      HomeEventProductMenuSearch event) async* {
    print("In bloc");
    categoryList = event.categoryListModel;
    vendorId = event.driverDetail.vendorId;
    driverDetails = event.driverDetail;
    categoryId = event.categoryListModel.category_id;
    // _userRepository.ScreenName = "CategoryDetailPage";
    NetworkApiCallState<bool> apiCallState =
        await _userRepository.getProductListApiCall(
            categoryId: event.categoryListModel.category_id,
            driverId: event.driverDetail.vendorId,
            search: event.searchText);

    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
          if (apiCallState.statusValue == "1") {
            yield HomeCategoryProductPageState(
                event.driverDetail.vendorId,
                _userRepository.getProductListArray(),
                categoryList,
                event.categoryListModel.category_id,
                event.driverDetail,
                sharedPrefs.getCartCount);
          } else {
            yield HomeEventErrorHandelCategorypageState(
                "data not found", event.driverDetail);
          }
        } else if (apiCallState.status == NetworkRequestStatus.ERROR) {
          if (apiCallState.message == "Unknown Error") {
            yield HomeEventErrorHandelCategorypageState(
                "Something went wrong", event.driverDetail);
          } else {
            yield HomeEventErrorHandelCategorypageState(
                "Something went wrong", event.driverDetail);
          }
        }
      } else {
        yield HomeEventErrorHandelCategorypageState(
            "data not found", event.driverDetail);
      }
    } else if (apiCallState.status == NetworkRequestStatus.ERROR) {
      if (apiCallState.message == "Unknown Error") {
        yield HomeEventErrorHandelCategorypageState(
            "Something went wrong", event.driverDetail);
      } else {
        yield HomeEventErrorHandelCategorypageState(
            "Something went wrong", event.driverDetail);
      }
    }
  }

  Stream<HomeState> mapHomeEventBackBtnClick() async* {
    // _userRepository.ScreenName = "CategoryDetailPage";
    // print(state.toString());
    if (state is SignUpPageState) {
      _userRepository.ScreenName = ScreenNavigation.Loginpage;
      yield (LoginPageState(""));
    } else if (state is ForgetPwdPageState) {
      _userRepository.ScreenName = ScreenNavigation.Loginpage;
      yield (LoginPageState(""));
    } else if (state is LoginPageState) {
      _userRepository.ScreenName = ScreenNavigation.HomeMainPageScreen;
      yield (HomeInitial());
    } else if (state is LoginLoadingCompleteState) {
      _userRepository.ScreenName = ScreenNavigation.HomeMainPageScreen;
      yield (HomeInitial());
    } else if (state is OtpApiLoadingCompleteState) {
      _userRepository.ScreenName = ScreenNavigation.OTPpage;
      yield (HomeInitial());
    } else if (state is HomeCategoryProductPageState) {
      yield HomeCategoryListPageState(
          _userRepository.getCategoryListArray(), driverDetail);
    } else if (state is HomeMenuItemDetailsPageState) {
      _userRepository.ScreenName = ScreenNavigation.HomeProductListScreen;
      yield HomeCategoryProductPageState(
          vendorId,
          _userRepository.getProductListArray(),
          categoryList,
          categoryId,
          driverDetails,
          _userRepository.getUpdatedCartCount());
    } else if (state is HomeCategoryListPageState) {
      _userRepository.ScreenName = ScreenNavigation.HomeMainPageScreen;
      yield HomeInitial();
    } else if (state is HomeCartPageState) {
      print("cart screen ${CartScreenNavigate}");
      _userRepository.ScreenName = ScreenNavigation.HomeProductListScreen;

      yield HomeCategoryProductPageState(
          vendorId,
          _userRepository.getProductListArray(),
          categoryList,
          categoryId,
          driverDetails,
          _userRepository.getUpdatedCartCount());
    } else if (state is HomeFromCategoryCartPageState) {
      _userRepository.ScreenName = ScreenNavigation.HomeProductListScreen;
      yield HomeCategoryListPageState(
          _userRepository.getCategoryListArray(), driverDetail);
    } else if (state is HomeFromDriverProductListDetailsPageState) {
      _userRepository.ScreenName = ScreenNavigation.HomeMainPageScreen;
      yield HomeInitial();
    } else if (state is HomeFromProductDetailCartPageState) {
      _userRepository.ScreenName = ScreenNavigation.HomeMainPageScreen;
      //  print(driverDetail.vendorId);
      yield HomeFromDriverProductListDetailsPageState(
          driverProductList,
          _userRepository.getDriverProductListArray()[0].vendor,
          "DriverList",
          _userRepository.getRatingReviewList(),
          _userRepository.getRelatedProductList(),
          _userRepository.getAddOnProductList());
    } else if (state is HomeCheckOutPageState) {
      yield HomeCartPageState(
          _userRepository.getCartDataListArray(),
          _userRepository.getCartDataListArray()[0].vendor,
          _userRepository.getCartDataModel());
    } else if (state is HomeFromDriverListCartPageState) {
      _userRepository.ScreenName = ScreenNavigation.HomeMainPageScreen;
      yield HomeInitial();
    }
  }
}
