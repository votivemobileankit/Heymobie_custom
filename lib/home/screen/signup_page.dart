import 'dart:io' show File, Platform;

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:grambunny_customer/generated/l10n.dart';
import 'package:grambunny_customer/home/home.dart';
import 'package:grambunny_customer/home/model/model.dart';
import 'package:grambunny_customer/side_navigation/side_navigation.dart';
import 'package:grambunny_customer/theme/theme.dart';
import 'package:grambunny_customer/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../components/components.dart';

const double _kVerticalSpaceBetweenTextField = 15.0;
const double _kCommonHintTextFieldFontSize = 14.0;
const double _kCommonPadding = 14.0;
const double _kHeightTextFieldGender = 55.0;
const double _kTextCustRegistrationFontSize = 18.0;
const double _kTextBirthdateField = 327.0;

late TextEditingController _textFiledUserName;
late TextEditingController _textFiledLastName;
late TextEditingController _textFiledPhone;
late TextEditingController _textFiledEmail;
late TextEditingController _textFiledAddress;
late TextEditingController _textFiledCity;
late TextEditingController _textFiledZipCode;
late TextEditingController _textFiledZipPassword;
String strState = "State";
late String _deviceType;
late String _osName;
late String _deviceToken;

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String _dateStr = "";
  String _dateStrServer = "";
  DateTime _date = new DateTime.now();
  TimeOfDay _time = new TimeOfDay.now();
  late List<StatesList> stateArrayList;
  late  File _userImage;
  late File _licenseImage;
  late File _mariyunaImage;
  String strPathProfile = "";
  String strPathLicenseFront = "Select license image copy front";
  String strPathLicenseBack = "Select license image copy back";
  String strPathMarijuanaId = "Select Marijuana id";
  String strServerPathMarijuana = "";

  late String type;
  String customerType = "Recreational Customer";

  // Future<Null> _selectedDate(BuildContext context) async {
  //   final DateTime picked = await showDatePicker(
  //       context: context,
  //       initialDate: _date,
  //       firstDate: new DateTime(DateTime.now().ordinalDate),
  //       lastDate: new DateTime(2022));
  //
  //   if (picked != null && picked != _date) {
  //     // print("Date selected ${_date.toString()}");
  //     if (calculateAge(_date) >= 21) {
  //       setState(() {
  //         _date = picked;
  //         _dateStr = DateFormat("MM-dd-yyyy").format(_date);
  //         _dateStrServer = DateFormat("yyyy-MM-dd").format(_date);
  //       });
  //     }
  //   }
  // }
  _selectedDate(BuildContext context) {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(1780, 1, 1),
        maxTime: DateTime.now(), onChanged: (date) {
      print('change $date in time zone ' +
          date.timeZoneOffset.inHours.toString());
    }, onConfirm: (date) {
      print('confirm $date');
      setState(() {
        var strDate = DateFormat('yyyy-MM-dd').format(date);

        DateTime _date = DateTime.parse(strDate);
        print('confirm1 $_date');
        // print("Date selected ${_date.toString()}");
        if (calculateAge(_date) >= 21) {
          print('inside $_date');
          setState(() {
            _dateStr = DateFormat("MM-dd-yyyy").format(_date);
            _dateStrServer = DateFormat("yyyy-MM-dd").format(_date);
            print('confirm2 $_dateStr');
            print('confirm3 $_dateStrServer');
          });
        }
      });
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  void showHideProgress(bool show) {
    BlocProvider.of<SideNavigatBloc>(context)
        .add(SideNavigationEventToggleLoadingAnimation(needToShow: show));
  }

  @override
  void initState() {
    HomeState rootBlocState = BlocProvider.of<HomeBloc>(context).state;
    if (rootBlocState is SignUpPageState) {
      stateArrayList = rootBlocState.stateArrayList;
    }
    // // TODO: implement initState

    _textFiledUserName = TextEditingController();
    _textFiledLastName = TextEditingController();
    _textFiledEmail = TextEditingController();
    _textFiledPhone = TextEditingController();
    _textFiledAddress = TextEditingController();
    _textFiledCity = TextEditingController();
    _textFiledZipCode = TextEditingController();
    _textFiledZipPassword = TextEditingController();

    _deviceToken = "";
    getDeviceVersion();
    super.initState();
  }

  void _showPicker(context, String type) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: [
                  ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery(type);
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera(type);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera(String type) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    setState(() {
      if (type == "UserProfile") {
        _userImage = File(pickedFile!.path);
        strPathProfile = pickedFile.path;
      } else if (type == "LicenseFront") {
        strPathLicenseFront = pickedFile!.path;
        _licenseImage = File(pickedFile.path);
      } else if (type == "MarijuanaId") {
        strPathMarijuanaId = pickedFile!.path;
        _mariyunaImage = File(pickedFile.path);
      } else {
        strPathLicenseBack = pickedFile!.path;
      }
      print(pickedFile.path);
    });
  }

  _imgFromGallery(String type) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        if (type == "UserProfile") {
          _userImage = File(pickedFile.path);
          strPathProfile = pickedFile.path;
        } else if (type == "LicenseFront") {
          strPathLicenseFront = pickedFile.path;
          _licenseImage = File(pickedFile.path);
        } else if (type == "MarijuanaId") {
          strPathMarijuanaId = pickedFile.path;
          strServerPathMarijuana = pickedFile.path;
          _mariyunaImage = File(pickedFile.path);
        } else {
          strPathLicenseBack = pickedFile.path;
        }

        print(pickedFile.path);
      });
    }
  }

  searchCustomerType(String strCustomerType) {
    setState(() {
      customerType = strCustomerType;
    });
  }

  Future<void> getDeviceVersion() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      _osName = "Android " + androidInfo.version.release;
      _deviceType = "Android";
    } else {
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      _osName = "IOS " + iosInfo.systemVersion;
      _deviceType = "IOS";
    }
    print("deviceType:" + _deviceType + "  osName:" + _osName);
  }

  @override
  Widget build(BuildContext context) {
    print("In signup");
    return WillPopScope(
        onWillPop: () {
          print("demo");

          BlocProvider.of<HomeBloc>(context).add(LoginEventBackBtnClicked());
          Navigator.of(context).pop();

          return Future<bool>.value(false);
        },
        child: BlocListener<HomeBloc, HomeState>(
          listenWhen: (prevState, curState) => ModalRoute.of(context)!.isCurrent,
          listener: (context, state) {
            if (state is LoginPageState) {
              Navigator.of(context).pop(true);
            }
            if (state is OTPpageState) {
              Navigator.of(context).pushNamed(HomeNavigator.otpPage);
            }
            if (state is SignUpLoadingCompleteState) {
              showHideProgress(false);
              BlocProvider.of<HomeBloc>(context)
                  .add(HomeEventForOTPScreen(state.email, "signup"));
              showSnackBar(state.message, context);
            }
            if (state is SignUpLoadingErrorState) {
              showHideProgress(false);
              BlocProvider.of<HomeBloc>(context)
                  .add(LoginEventLoginStateReset());
              showSnackBar(state.message, context);
            }
          },
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                AHeaderWidget(
                  btnEditOnPressed: () {

                  },
                  strBtnRightImageName: "",
                  headerSigninText: "",
                  headerText: "",
                  rightEditButtonVisibility: false,
                  strBackbuttonName: 'ic_red_btn_back.png',
                  backBtnVisibility: true,
                  btnBackOnPressed: () {
                    BlocProvider.of<HomeBloc>(context)
                        .add(HomeEventBackBtnClick());
                  },
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    AVerticalSpace(_kVerticalSpaceBetweenTextField.scale()),
                    GestureDetector(
                        onTap: () {
                          type = "UserProfile";
                          _showPicker(context, type);
                        },
                        child: CircleAvatar(
                            radius: 55,
                            backgroundColor: Color(0xffFDCF09),
                            child: _userImage != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.file(
                                      _userImage,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    width: 100,
                                    height: 100,
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.grey[800],
                                    ),
                                  ))),
                    AVerticalSpace(_kVerticalSpaceBetweenTextField.scale()),
                    Text(
                      Stringss.current.txtCustomerRegisteration,
                      style: textStyleBoldCustomColor(
                          _kTextCustRegistrationFontSize.scale(),
                          KColorAppThemeColor),
                    ).align(Alignment.center),
                    AVerticalSpace(_kVerticalSpaceBetweenTextField.scale()),
                    TextField(
                      controller: _textFiledUserName,
                      keyboardType: TextInputType.text,
                      inputFormatters: [
                        NoLeadingSpaceFormatter(),
                      ],
                      autofocus: false,
                      cursorColor: KColorTextFieldCommonHint,
                      decoration: InputDecoration(
                        hintText: Stringss.current.txtHintFirstName,
                        hintStyle: textStyleCustomColor(
                            _kCommonHintTextFieldFontSize.scale(),
                            KColorTextFieldCommonHint),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    AVerticalSpace(_kVerticalSpaceBetweenTextField.scale()),
                    TextField(
                      controller: _textFiledLastName,
                      keyboardType: TextInputType.text,
                      inputFormatters: [
                        NoLeadingSpaceFormatter(),
                      ],
                      autofocus: false,
                      cursorColor: KColorTextFieldCommonHint,
                      decoration: InputDecoration(
                        hintText: Stringss.current.txtHintLastName,
                        hintStyle: textStyleCustomColor(
                            _kCommonHintTextFieldFontSize.scale(),
                            KColorTextFieldCommonHint),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onTap: () {},
                    ),
                    AVerticalSpace(_kVerticalSpaceBetweenTextField.scale()),
                    InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          _selectedDate(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10.0.scale()),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 1.0),
                            borderRadius: BorderRadius.circular(8.0.scale()),
                            shape: BoxShape.rectangle,
                          ),
                          child: Text(
                            _dateStr == ""
                                ? Stringss.current.txtHintBirthDate
                                : _dateStr,
                            style: textStyleCustomColor(
                                _kCommonHintTextFieldFontSize.scale(),
                                KColorTextFieldCommonHint),
                            textAlign: TextAlign.center,
                          ).align(Alignment.centerLeft),
                        ).size(_kTextBirthdateField.scale(),
                            _kHeightTextFieldGender.scale())),
                    AVerticalSpace(_kVerticalSpaceBetweenTextField.scale()),
                    _EmailWidget(),
                    _PasswordWidget(),
                    _PhoneWidget(),
                    _AddressWidget(),
                    _CityWidget(),
                    _StateListWidget(stateArrayList),
                    _ZipWidget(),
                    GestureDetector(
                        onTap: () {
                          type = "LicenseFront";
                          _showPicker(context, type);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10.0.scale()),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 1.0),
                            borderRadius: BorderRadius.circular(8.0.scale()),
                            shape: BoxShape.rectangle,
                          ),
                          child: Text(
                            strPathLicenseFront,
                            style: textStyleCustomColor(
                                _kCommonHintTextFieldFontSize.scale(),
                                KColorTextFieldCommonHint),
                            textAlign: TextAlign.center,
                          ).align(Alignment.centerLeft),
                        ).size(_kTextBirthdateField.scale(),
                            _kHeightTextFieldGender.scale())),
                    AVerticalSpace(_kVerticalSpaceBetweenTextField.scale()),
                    GestureDetector(
                        onTap: () {
                          type = "LicenseBack";
                          _showPicker(context, type);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10.0.scale()),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 1.0),
                            borderRadius: BorderRadius.circular(8.0.scale()),
                            shape: BoxShape.rectangle,
                          ),
                          child: Text(
                            strPathLicenseBack,
                            style: textStyleCustomColor(
                                _kCommonHintTextFieldFontSize.scale(),
                                KColorTextFieldCommonHint),
                            textAlign: TextAlign.center,
                          ).align(Alignment.centerLeft),
                        ).size(_kTextBirthdateField.scale(),
                            _kHeightTextFieldGender.scale())),
                    AVerticalSpace(_kVerticalSpaceBetweenTextField.scale()),
                    __BuyRentWidgetState1(searchCustomerType),
                    AVerticalSpace(_kVerticalSpaceBetweenTextField.scale()),
                    GestureDetector(
                        onTap: () {
                          type = "MarijuanaId";
                          _showPicker(context, type);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10.0.scale()),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 1.0),
                            borderRadius: BorderRadius.circular(8.0.scale()),
                            shape: BoxShape.rectangle,
                          ),
                          child: Text(
                            strPathMarijuanaId,
                            style: textStyleCustomColor(
                                _kCommonHintTextFieldFontSize.scale(),
                                KColorTextFieldCommonHint),
                            textAlign: TextAlign.center,
                          ).align(Alignment.centerLeft),
                        ).size(_kTextBirthdateField.scale(),
                            _kHeightTextFieldGender.scale())),
                    AVerticalSpace(_kVerticalSpaceBetweenTextField.scale()),
                    ARoundedButton(
                      btnBorderSideColor: kColorCommonButton,btnDisabledColor: Color(0xFF5e6163),btnIconSize:15 ,
                      btnDisabledTextColor:Color(0xFFFFFFFF) ,
                      btnFontWeight: FontWeight.normal,
                      btnBgColor: kColorAppBgColor,
                      btnTextColor: Colors.white,
                      btnOnPressed: () {
                        if (_textFiledUserName.text.isEmpty) {
                          showSnackBar(
                              "Please enter your first name.", context);
                        } else if (_textFiledLastName.text.isEmpty) {
                          showSnackBar("Please enter your last name.", context);
                        } else if (_dateStr == "") {
                          showSnackBar(
                              "Please enter your Date of Birth.", context);
                        } else if (validateEmail(_textFiledEmail.text) !=
                            "Success") {
                          showSnackBar(
                              "Please enter your vailid email id.", context);
                        } else if (_textFiledZipPassword.text.isEmpty) {
                          showSnackBar(
                              "Please enter at least 8 character password must be contain lowercase, uppercase, number and spaical character.",
                              context);
                        } else if (isvalidNumber(_textFiledPhone.text) ==
                            false) {
                          showSnackBar(
                              "Please enter your vailid mobile number.",
                              context);
                        } else if (_textFiledAddress.text.isEmpty) {
                          showSnackBar("Please enter your address.", context);
                        } else if (_textFiledCity.text.isEmpty) {
                          showSnackBar("Please enter your city.", context);
                        } else if (strState == "State") {
                          showSnackBar("Please enter your state.", context);
                        } else if (_textFiledZipCode.text.isEmpty) {
                          showSnackBar("Please enter zipcode.", context);
                        } else if (strPathProfile.isEmpty) {
                          showSnackBar(
                              "Please select image for your avatar.", context);
                        } else if (strServerPathMarijuana.isEmpty) {
                          showSnackBar("Please select Marijuana Id.", context);
                        } else {
                          String Pathlicensefront = "";
                          String Pathlicenseback = "";

                          if (strPathLicenseFront ==
                              "Select license image copy front") {
                            Pathlicensefront = "";
                          } else if (strPathLicenseBack ==
                              "Select license image copy back") {
                            Pathlicenseback = "";
                          }
                          print(_dateStrServer);
                          showHideProgress(true);
                          BlocProvider.of<HomeBloc>(context).add(
                              SignUpEventSignUpBtnClick(
                                  firstName: _textFiledUserName.text,
                                  lastName: _textFiledLastName.text,
                                  email: _textFiledEmail.text,
                                  password: _textFiledZipPassword.text,
                                  mobileNO: _textFiledPhone.text,
                                  devicetype: _deviceType,
                                  devicetoken: _deviceToken,
                                  dob: _dateStrServer,
                                  address: _textFiledAddress.text,
                                  city: _textFiledCity.text,
                                  state: strState,
                                  zipcode: _textFiledZipCode.text,
                                  os_name: _osName,
                                  strUserProfilePath: strPathProfile,
                                  strFrontLicensePath: Pathlicensefront,
                                  strBackLicensePath: Pathlicenseback,
                                  strCustomerType: customerType,
                                  strMarijuanaId: strServerPathMarijuana));
                        }
                      },
                      btnText: Stringss.current.txtBtnCreateAccont,
                      btnHeight: kHeightBtnSplashNormal.scale(),
                      btnWidth: kWidthBtnNormal.scale(),
                      btnFontSize: kFontSizeBtnLarge.scale(),
                      btnElevation: 0,
                    ),
                    AVerticalSpace(_kVerticalSpaceBetweenTextField.scale()),
                  ],
                )
                    .leftPadding(_kCommonPadding.scale())
                    .rightPadding(_kCommonPadding.scale())
                    .scroll()
                    .expand()
              ],
            ).widgetBgColor(kColorScreenBgColor),
          ).pageBgColor(kColorAppBgColor),
        ));
  }
}

class CustomerType {
  final int id;
  final String strType;

  CustomerType(this.id, this.strType);
}

String _strCustomerType = "Recreational Customer";

class __BuyRentWidgetState1 extends StatefulWidget {
  Function searchData;

  __BuyRentWidgetState1(this.searchData);

  @override
  State<__BuyRentWidgetState1> createState() => __BuyRentWidgetState1State();
}

class __BuyRentWidgetState1State extends State<__BuyRentWidgetState1> {
  final List<CustomerType> buyRentList = <CustomerType>[
    CustomerType(1, "Recreational Customer"),
    CustomerType(2, "Medical Customer"),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Container(
          height: 50.0.scale(),
          padding: EdgeInsets.all(10.0.scale()),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: KColorTextGrey, width: 1.0),
            borderRadius: BorderRadius.circular(5.0.scale()),
            shape: BoxShape.rectangle,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<CustomerType>(
              isExpanded: true,
              items: buyRentList
                  .map<DropdownMenuItem<CustomerType>>((CustomerType item) {
                return DropdownMenuItem<CustomerType>(
                  value: item,
                  child: Text(item.strType),
                );
              }).toList(),
              onChanged: (CustomerType? value) {
                setState(() {
                  _strCustomerType = value!.strType;
                  widget.searchData(_strCustomerType);
                });
              },
              hint: Text(_strCustomerType,
                  style: _strCustomerType == "Recreational Customer"
                      ? textStyleCustomColor(
                          _kCommonHintTextFieldFontSize.scale(), KColorTextGrey)
                      : textStyleCustomColor(
                          _kCommonHintTextFieldFontSize.scale(), Colors.black)),
            ),
          ).align(Alignment.centerLeft),
        ),
      ],
    );
  }
}

class _EmailWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        TextField(
          controller: _textFiledEmail,
          keyboardType: TextInputType.emailAddress,
          inputFormatters: [
            NoLeadingSpaceFormatter(),
          ],
          autofocus: false,
          cursorColor: KColorTextFieldCommonHint,
          decoration: InputDecoration(
            hintText: Stringss.current.txtHintEmail,
            hintStyle: textStyleCustomColor(
                _kCommonHintTextFieldFontSize.scale(),
                KColorTextFieldCommonHint),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        AVerticalSpace(_kVerticalSpaceBetweenTextField.scale()),
      ],
    );
  }
}

class _PhoneWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        TextField(
          controller: _textFiledPhone,
          keyboardType: TextInputType.phone,
          inputFormatters: [LengthLimitingTextInputFormatter(12)],
          autofocus: false,
          cursorColor: KColorTextFieldCommonHint,
          decoration: InputDecoration(
            hintText: Stringss.current.txtHintPhone,
            hintStyle: textStyleCustomColor(
                _kCommonHintTextFieldFontSize.scale(),
                KColorTextFieldCommonHint),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        AVerticalSpace(_kVerticalSpaceBetweenTextField.scale()),
      ],
    );
  }
}

class _AddressWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        TextField(
          controller: _textFiledAddress,
          keyboardType: TextInputType.text,
          inputFormatters: [
            NoLeadingSpaceFormatter(),
          ],
          autofocus: false,
          cursorColor: KColorTextFieldCommonHint,
          decoration: InputDecoration(
            hintText: Stringss.current.txtHintAddress,
            hintStyle: textStyleCustomColor(
                _kCommonHintTextFieldFontSize.scale(),
                KColorTextFieldCommonHint),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        AVerticalSpace(_kVerticalSpaceBetweenTextField.scale()),
      ],
    );
  }
}

class _CityWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        TextField(
          controller: _textFiledCity,
          keyboardType: TextInputType.text,
          inputFormatters: [
            NoLeadingSpaceFormatter(),
          ],
          autofocus: false,
          cursorColor: KColorTextFieldCommonHint,
          decoration: InputDecoration(
            hintText: Stringss.current.txtHintCity,
            hintStyle: textStyleCustomColor(
                _kCommonHintTextFieldFontSize.scale(),
                KColorTextFieldCommonHint),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        AVerticalSpace(_kVerticalSpaceBetweenTextField.scale()),
      ],
    );
  }
}

// class _StateWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Column(
//       children: [
//         TextField(
//           controller: _textFiledUserName,
//           keyboardType: TextInputType.text,
//           inputFormatters: [
//             NoLeadingSpaceFormatter(),
//           ],
//           autofocus: false,
//           cursorColor: KColorTextFieldCommonHint,
//           decoration: InputDecoration(
//             hintText: Stringss.current.txtHintState,
//             hintStyle: textStyleCustomColor(
//                 _kCommonHintTextFieldFontSize.scale(),
//                 KColorTextFieldCommonHint),
//             fillColor: Colors.white,
//             filled: true,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//           ),
//         ),
//         AVerticalSpace(_kVerticalSpaceBetweenTextField.scale()),
//       ],
//     );
//   }
// }

class _ZipWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        TextField(
          controller: _textFiledZipCode,
          keyboardType: TextInputType.number,
          inputFormatters: [LengthLimitingTextInputFormatter(7)],
          autofocus: false,
          cursorColor: KColorTextFieldCommonHint,
          decoration: InputDecoration(
            hintText: Stringss.current.txtHintZipCode,
            hintStyle: textStyleCustomColor(
                _kCommonHintTextFieldFontSize.scale(),
                KColorTextFieldCommonHint),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        AVerticalSpace(_kVerticalSpaceBetweenTextField.scale()),
      ],
    );
  }
}

class _PasswordWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        TextField(
          controller: _textFiledZipPassword,
          keyboardType: TextInputType.visiblePassword,
          autofocus: false,
          inputFormatters: [
            NoLeadingSpaceFormatter(),
          ],
          obscureText: true,
          cursorColor: KColorTextFieldCommonHint,
          decoration: InputDecoration(
            hintText: Stringss.current.txtHintPassWord,
            hintStyle: textStyleCustomColor(
                _kCommonHintTextFieldFontSize.scale(),
                KColorTextFieldCommonHint),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        AVerticalSpace(_kVerticalSpaceBetweenTextField.scale()),
      ],
    );
  }
}

class StateModel {
  final int id;
  final String name;

  StateModel(this.id, this.name);
}

class _StateListWidget extends StatefulWidget {
  List<StatesList> stateArrayList;

  _StateListWidget(this.stateArrayList);

  @override
  __StateListWidgetState createState() => __StateListWidgetState();
}

class __StateListWidgetState extends State<_StateListWidget> {
  final List<StateModel> stateList = <StateModel>[
    StateModel(1, "Alaska"),
    StateModel(2, "Alabama"),
    StateModel(3, "Arkansas"),
    StateModel(4, "Arizona"),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
              left: 10.0.scale(),
              right: 10.0.scale(),
              top: 5.0.scale(),
              bottom: 5.0.scale()),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 1.0),
            borderRadius: BorderRadius.circular(8.0.scale()),
            shape: BoxShape.rectangle,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<StatesList>(
              isExpanded: true,
              items: widget.stateArrayList
                  .map<DropdownMenuItem<StatesList>>((StatesList item) {
                return DropdownMenuItem<StatesList>(
                  value: item,
                  child: Text(item.name),
                );
              }).toList(),
              onChanged: (StatesList? value) {
                setState(() {
                  print(value!.name);
                  strState = value.name;
                });
              },
              hint: Text(strState,
                  style: textStyleCustomColor(14.0.scale(), Colors.black)),
            ),
          ).align(Alignment.centerLeft),
        ),
        AVerticalSpace(_kVerticalSpaceBetweenTextField.scale()),
      ],
    );
  }
}
