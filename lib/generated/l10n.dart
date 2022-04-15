// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class Stringss {
  Stringss();
  
  static Stringss current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<Stringss> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      Stringss.current = Stringss();
      
      return Stringss.current;
    });
  } 

  static Stringss of(BuildContext context) {
    return Localizations.of<Stringss>(context, Stringss);
  }

  /// `User Name`
  String get txtHintUserName {
    return Intl.message(
      'User Name',
      name: 'txtHintUserName',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get txtHintPassword {
    return Intl.message(
      'Password',
      name: 'txtHintPassword',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get txtWelcome {
    return Intl.message(
      'Welcome',
      name: 'txtWelcome',
      desc: '',
      args: [],
    );
  }

  /// `back`
  String get txtBack {
    return Intl.message(
      'back',
      name: 'txtBack',
      desc: '',
      args: [],
    );
  }

  /// `Signin to continue`
  String get txtSignInContinue {
    return Intl.message(
      'Signin to continue',
      name: 'txtSignInContinue',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get txtBtnLogin {
    return Intl.message(
      'Login',
      name: 'txtBtnLogin',
      desc: '',
      args: [],
    );
  }

  /// `Having trouble accessing your account? `
  String get txtForgotPwd {
    return Intl.message(
      'Having trouble accessing your account? ',
      name: 'txtForgotPwd',
      desc: '',
      args: [],
    );
  }

  /// `Click here`
  String get txtBtnForgotPwd {
    return Intl.message(
      'Click here',
      name: 'txtBtnForgotPwd',
      desc: '',
      args: [],
    );
  }

  /// `New to Herberium? `
  String get txtBtnSignup {
    return Intl.message(
      'New to Herberium? ',
      name: 'txtBtnSignup',
      desc: '',
      args: [],
    );
  }

  /// `SignUp Now`
  String get txtBtnSignupNow {
    return Intl.message(
      'SignUp Now',
      name: 'txtBtnSignupNow',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get txtHintFirstName {
    return Intl.message(
      'First Name',
      name: 'txtHintFirstName',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get txtHintLastName {
    return Intl.message(
      'Last Name',
      name: 'txtHintLastName',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get txtHintEmail {
    return Intl.message(
      'Email',
      name: 'txtHintEmail',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get txtForgotPassword {
    return Intl.message(
      'Forgot Password',
      name: 'txtForgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Date of Birth`
  String get txtHintBirthDate {
    return Intl.message(
      'Date of Birth',
      name: 'txtHintBirthDate',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get txtHintAddress {
    return Intl.message(
      'Address',
      name: 'txtHintAddress',
      desc: '',
      args: [],
    );
  }

  /// `Mobile Number`
  String get txtHintPhone {
    return Intl.message(
      'Mobile Number',
      name: 'txtHintPhone',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get txtHintCity {
    return Intl.message(
      'City',
      name: 'txtHintCity',
      desc: '',
      args: [],
    );
  }

  /// `State`
  String get txtHintState {
    return Intl.message(
      'State',
      name: 'txtHintState',
      desc: '',
      args: [],
    );
  }

  /// `Zip Code`
  String get txtHintZipCode {
    return Intl.message(
      'Zip Code',
      name: 'txtHintZipCode',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get txtHintPassWord {
    return Intl.message(
      'Password',
      name: 'txtHintPassWord',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get txtBtnCreateAccont {
    return Intl.message(
      'Create Account',
      name: 'txtBtnCreateAccont',
      desc: '',
      args: [],
    );
  }

  /// `Customer Registeration`
  String get txtCustomerRegisteration {
    return Intl.message(
      'Customer Registeration',
      name: 'txtCustomerRegisteration',
      desc: '',
      args: [],
    );
  }

  /// `Enter your EmailId associated with your account`
  String get txtMessageForgetPwd {
    return Intl.message(
      'Enter your EmailId associated with your account',
      name: 'txtMessageForgetPwd',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get btnVerify {
    return Intl.message(
      'Verify',
      name: 'btnVerify',
      desc: '',
      args: [],
    );
  }

  /// `Retrieve Password`
  String get btnRetievePwd {
    return Intl.message(
      'Retrieve Password',
      name: 'btnRetievePwd',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Otp Code`
  String get txtEnterCode {
    return Intl.message(
      'Enter Your Otp Code',
      name: 'txtEnterCode',
      desc: '',
      args: [],
    );
  }

  /// `Enter 4 digit otp code we have sent to your mailid.`
  String get txtEnterOtpCodeHint {
    return Intl.message(
      'Enter 4 digit otp code we have sent to your mailid.',
      name: 'txtEnterOtpCodeHint',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get btnYes {
    return Intl.message(
      'Yes',
      name: 'btnYes',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get btnOk {
    return Intl.message(
      'Ok',
      name: 'btnOk',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get btnClose {
    return Intl.message(
      'Close',
      name: 'btnClose',
      desc: '',
      args: [],
    );
  }

  /// `Alert`
  String get titleTxtAlert {
    return Intl.message(
      'Alert',
      name: 'titleTxtAlert',
      desc: '',
      args: [],
    );
  }

  /// `View Profile`
  String get txtViewProfile {
    return Intl.message(
      'View Profile',
      name: 'txtViewProfile',
      desc: '',
      args: [],
    );
  }

  /// `Browse by category`
  String get txtBrowseCategory {
    return Intl.message(
      'Browse by category',
      name: 'txtBrowseCategory',
      desc: '',
      args: [],
    );
  }

  /// `Top Brands`
  String get txtTopBrands {
    return Intl.message(
      'Top Brands',
      name: 'txtTopBrands',
      desc: '',
      args: [],
    );
  }

  /// `Closed`
  String get txtClosed {
    return Intl.message(
      'Closed',
      name: 'txtClosed',
      desc: '',
      args: [],
    );
  }

  /// `Mon`
  String get txtMonday {
    return Intl.message(
      'Mon',
      name: 'txtMonday',
      desc: '',
      args: [],
    );
  }

  /// `Tue`
  String get txtTue {
    return Intl.message(
      'Tue',
      name: 'txtTue',
      desc: '',
      args: [],
    );
  }

  /// `Wed`
  String get txtWed {
    return Intl.message(
      'Wed',
      name: 'txtWed',
      desc: '',
      args: [],
    );
  }

  /// `Thur`
  String get txtThur {
    return Intl.message(
      'Thur',
      name: 'txtThur',
      desc: '',
      args: [],
    );
  }

  /// `Fri`
  String get txtFri {
    return Intl.message(
      'Fri',
      name: 'txtFri',
      desc: '',
      args: [],
    );
  }

  /// `Sat`
  String get txtSat {
    return Intl.message(
      'Sat',
      name: 'txtSat',
      desc: '',
      args: [],
    );
  }

  /// `Sun`
  String get txtSun {
    return Intl.message(
      'Sun',
      name: 'txtSun',
      desc: '',
      args: [],
    );
  }

  /// `Amenities`
  String get txtAmenities {
    return Intl.message(
      'Amenities',
      name: 'txtAmenities',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get txtAdd {
    return Intl.message(
      'Add',
      name: 'txtAdd',
      desc: '',
      args: [],
    );
  }

  /// `THC:`
  String get txtTHC {
    return Intl.message(
      'THC:',
      name: 'txtTHC',
      desc: '',
      args: [],
    );
  }

  /// `CBD:`
  String get txtCBD {
    return Intl.message(
      'CBD:',
      name: 'txtCBD',
      desc: '',
      args: [],
    );
  }

  /// `Affects`
  String get txtAffects {
    return Intl.message(
      'Affects',
      name: 'txtAffects',
      desc: '',
      args: [],
    );
  }

  /// `About the Brands`
  String get txtAboutBrands {
    return Intl.message(
      'About the Brands',
      name: 'txtAboutBrands',
      desc: '',
      args: [],
    );
  }

  /// `Login and Security`
  String get txtLoginSecurity {
    return Intl.message(
      'Login and Security',
      name: 'txtLoginSecurity',
      desc: '',
      args: [],
    );
  }

  /// `Online Ordering`
  String get txtOnlineOrder {
    return Intl.message(
      'Online Ordering',
      name: 'txtOnlineOrder',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get txtEdit {
    return Intl.message(
      'Edit',
      name: 'txtEdit',
      desc: '',
      args: [],
    );
  }

  /// `Your age is below 21`
  String get txtAgemessage {
    return Intl.message(
      'Your age is below 21',
      name: 'txtAgemessage',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get txtSubmit {
    return Intl.message(
      'Submit',
      name: 'txtSubmit',
      desc: '',
      args: [],
    );
  }

  /// `Shop`
  String get txtShop {
    return Intl.message(
      'Shop',
      name: 'txtShop',
      desc: '',
      args: [],
    );
  }

  /// `Order ID`
  String get txtOrderId {
    return Intl.message(
      'Order ID',
      name: 'txtOrderId',
      desc: '',
      args: [],
    );
  }

  /// `Merchant Name`
  String get txtMerchantName {
    return Intl.message(
      'Merchant Name',
      name: 'txtMerchantName',
      desc: '',
      args: [],
    );
  }

  /// `View Order`
  String get btnViewOrder {
    return Intl.message(
      'View Order',
      name: 'btnViewOrder',
      desc: '',
      args: [],
    );
  }

  /// `%`
  String get txtPercent {
    return Intl.message(
      '%',
      name: 'txtPercent',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<Stringss> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<Stringss> load(Locale locale) => Stringss.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}