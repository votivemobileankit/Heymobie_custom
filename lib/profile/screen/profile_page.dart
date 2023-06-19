import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grambunny_customer/components/components.dart';
import 'package:grambunny_customer/generated/l10n.dart';
import 'package:grambunny_customer/home/model/model.dart';
import 'package:grambunny_customer/profile/profile.dart';
import 'package:grambunny_customer/side_navigation/side_navigation.dart';
import 'package:grambunny_customer/theme/theme.dart';
import 'package:grambunny_customer/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

const double _kLoginSecurityTextFieldFontSize = 20.0;
const double _kCommonHintTextFieldFontSize = 16.0;
const double _kCommonTextFieldFontSize = 14.0;
const double _kCommonSpaceBetweenTextField = 10.0;

class ProfileMainPage extends StatefulWidget {
  @override
  _ProfileMainPageState createState() => _ProfileMainPageState();
}

class _ProfileMainPageState extends State<ProfileMainPage> {
late  UserDetailResponseModel userDetailInfo1;
  double average_rating = 1;
  double rating_count = 1;
  TextEditingController _textFiledCity = TextEditingController();
  TextEditingController _textFiledState = TextEditingController();
  TextEditingController _textFiledZipCode = TextEditingController();
  TextEditingController _textFiledUserName = TextEditingController();
  TextEditingController _textFiledlastName = TextEditingController();
  TextEditingController _textFiledMobileNumber = TextEditingController();
  TextEditingController _textFiledAddress = TextEditingController();
late List<StatesList> _stateArrayList;
  String strState = "";
  double _currentLat = 0.0;
  double _currentLong = 0.0;
late  File _userImage;
late File _licenseImageBack;
late File _licenseImageFront;
late  File _mariyunaImage;
  String strServerProfiImage = "";
  String strServerLicenseFront = "";
  String strServerLicenseBack = "";
  String strPathProfile = "";
  String strPathLicenseFront = "Select license image copy front";
  String strPathLicenseBack = "Select license image copy back";
  String strPathMarijuanaId = "Select Marijuana id";
  String _strServerPathMarijuana = "";
late String type;
  String _customerType = "Recreational Customer";

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: 500), () {
        getLocation();
      });
    });
    showHideProgress(true);
    BlocProvider.of<ProfileBloc>(context).add(ProfileEventGetUserData());
    super.initState();
  }

  searchCustomerType(String strCustomerType) {
    setState(() {
      _customerType = strCustomerType;
    });
  }

  Future<void> getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    switch (permission) {
      case LocationPermission.whileInUse:
      case LocationPermission.always:
        await updateLocation();
        break;
      case LocationPermission.denied:
        await handleDeniedLocationPermission();
        break;
      case LocationPermission.deniedForever:
        await handleDeniedForeverLocationPermission();
        break;
      case LocationPermission.unableToDetermine:
        // TODO: Handle this case.
        break;
    }
  }

  Future<void> handleDeniedLocationPermission() async {
    LocationPermission permissionAfterRequest =
        await Geolocator.requestPermission();
    switch (permissionAfterRequest) {
      case LocationPermission.whileInUse:
      case LocationPermission.always:
        await updateLocation();
        break;
      case LocationPermission.denied:
        if (Platform.isIOS) {
          await handleDeniedForeverLocationPermission();
        }
        break;
      case LocationPermission.deniedForever:
        await handleDeniedForeverLocationPermission();
        break;
    }
  }

  Future<void> handleDeniedForeverLocationPermission() async {
    // showLocationSettingDialog(
    //     context: context,
    //     btnClosePressed: () {},
    //     onDeviceSettings: () {
    //       Geolocator.openAppSettings();
    //     });
  }

  Future<void> updateLocation() async {
    bool locationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (locationServiceEnabled) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _currentLat = position.latitude;
      _currentLong = position.longitude;
    } else {}
  }

  void showHideProgress(bool show) {
    BlocProvider.of<SideNavigatBloc>(context)
        .add(SideNavigationEventToggleLoadingAnimation(needToShow: show));
  }

  // ValueNotifier<DateTime> _date = ValueNotifier<DateTime>(DateTime.now());

  DateTime _date = DateTime.now();
  TimeOfDay _time = new TimeOfDay.now();
  String strDateofBirth = "";
  String _dateStrServer = "";
  String _dateStr = "";

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
        _licenseImageFront = File(pickedFile.path);
      } else {
        _licenseImageBack = File(pickedFile!.path);
        strPathLicenseBack = pickedFile.path;
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
          _licenseImageFront = File(pickedFile.path);
          showHideProgress(true);
          BlocProvider.of<ProfileBloc>(context).add(
              ProfileImageUploadEventBtnClick(
                  "license_front", strPathLicenseFront));
        } else if (type == "MarijuanaId") {
          print("Marijuana type ========");
          strPathMarijuanaId = pickedFile.path;

          _strServerPathMarijuana = pickedFile.path;
          _mariyunaImage = File(pickedFile.path);
          showHideProgress(true);
          BlocProvider.of<ProfileBloc>(context).add(
              ProfileImageUploadEventBtnClick(
                  "marijuana_card", strPathMarijuanaId));
        } else {
          _licenseImageBack = File(pickedFile.path);
          strPathLicenseBack = pickedFile.path;
          showHideProgress(true);
          BlocProvider.of<ProfileBloc>(context).add(
              ProfileImageUploadEventBtnClick(
                  "license_back", strPathLicenseBack));
        }

        print(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocListener<ProfileBloc, ProfileState>(
      listenWhen: (prevState, curState) => ModalRoute.of(context)!.isCurrent,
      listener: (context, state) {
        if (state is ProfileToHomeNavigateState) {
          print("bloc call");
          BlocProvider.of<ProfileBloc>(context).add(ProfileEventProfileReset());
          BlocProvider.of<SideNavigatBloc>(context)
              .add(SideNavigationEventGoToHomePageFromHistory());
        } else if (state is ProfileGetUserDataState) {
          print("in sucees");
          showHideProgress(false);
          setState(() {
            //avrage_rating= userDetailInfo1.data.userInfo.avgRating;
            userDetailInfo1 = state.userDetailInfo;
            rating_count =
                double.parse(userDetailInfo1.data.userInfo.ratingCount);
            average_rating =
                double.parse(userDetailInfo1.data.userInfo.avgRating);
            _textFiledCity.text = userDetailInfo1.data.userInfo.userCity;
            strState = userDetailInfo1.data.userInfo.userStates;
            _textFiledZipCode.text = userDetailInfo1.data.userInfo.userZipcode;
            _textFiledUserName.text = userDetailInfo1.data.userInfo.name;
            _textFiledlastName.text = userDetailInfo1.data.userInfo.lname;
            strDateofBirth = userDetailInfo1.data.userInfo.dob;
            _textFiledMobileNumber.text = userDetailInfo1.data.userInfo.userMob;
            _textFiledAddress.text = userDetailInfo1.data.userInfo.userAddress;
            strServerProfiImage = userDetailInfo1.data.userInfo.profileURL;
            strServerLicenseFront =
                userDetailInfo1.data.userInfo.licenseFrontURL;
            strServerLicenseBack = userDetailInfo1.data.userInfo.licenseBackURL;
            _strServerPathMarijuana =
                userDetailInfo1.data.userInfo.marijuanaCardURL;

            _customerType = userDetailInfo1.data.userInfo.customerType;
            print("" + _customerType);
            _stateArrayList = state.stateArrayList;
          });
          BlocProvider.of<ProfileBloc>(context).add(ProfileEventProfileReset());
        } else if (state is ProfileUpdateUserDataState) {
          print("in sucees");
          showHideProgress(false);
          setState(() {
            userDetailInfo1 = state.userDetailInfo;
            rating_count =
                double.parse(userDetailInfo1.data.userInfo.ratingCount);
            average_rating =
                double.parse(userDetailInfo1.data.userInfo.avgRating);
            _textFiledCity.text = userDetailInfo1.data.userInfo.userCity;
            strState = userDetailInfo1.data.userInfo.userStates;
            _textFiledZipCode.text = userDetailInfo1.data.userInfo.userZipcode;
            _textFiledUserName.text = userDetailInfo1.data.userInfo.name;
            _textFiledlastName.text = userDetailInfo1.data.userInfo.lname;
            strDateofBirth = userDetailInfo1.data.userInfo.dob;
            _textFiledMobileNumber.text = userDetailInfo1.data.userInfo.userMob;
            _textFiledAddress.text = userDetailInfo1.data.userInfo.userAddress;
            strServerProfiImage = userDetailInfo1.data.userInfo.profileURL;
            strServerLicenseFront =
                userDetailInfo1.data.userInfo.licenseFrontURL;
            strServerLicenseBack = userDetailInfo1.data.userInfo.licenseBackURL;
            _strServerPathMarijuana =
                userDetailInfo1.data.userInfo.marijuanaCardURL;
            _customerType = userDetailInfo1.data.userInfo.customerType;
            _stateArrayList = state.stateArrayList;
          });
          showSnackBar("Profile update successfully! ", context);
          BlocProvider.of<ProfileBloc>(context).add(ProfileEventProfileReset());
          BlocProvider.of<SideNavigatBloc>(context)
              .add(SideNavigationEventGoToHomePageFromHistory());
        } else if (state is ProfileErrorState) {
          print("in Error =====");

          showHideProgress(false);
          showSnackBar(state.msg, context);
          BlocProvider.of<ProfileBloc>(context).add(ProfileEventProfileReset());
        } else if (state is ProfileUploadCompleteState) {
          showHideProgress(false);

          BlocProvider.of<ProfileBloc>(context).add(ProfileEventProfileReset());
        } else if (state is ChangePasswordState) {
          Navigator.of(context).pushNamed(ProfileNavigator.changePasswordPage);
        }
      },
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            AHeaderWidget(
              headerText: "",
              headerSigninText: "",
              btnEditOnPressed: () {

              },
              strBackbuttonName: 'ic_red_btn_back.png',
              backBtnVisibility: true,
              btnBackOnPressed: () {
                //Scaffold.of(context).openDrawer();
                BlocProvider.of<ProfileBloc>(context)
                    .add(ProfileEventBackBtnClick());
              },
              strBtnRightImageName: 'ic_search_logo.png',
              rightEditButtonVisibility: false,
            ),
            Column(
              children: [
                AVerticalSpace(15.0.scale()),
                Text(
                  "Customer Detail:",
                  style: textStyleBoldCustomColor(
                      _kLoginSecurityTextFieldFontSize.scale(),
                      KColorCommonText),
                )
                    .align(Alignment.centerLeft)
                    .leftPadding(14.0.scale())
                    .rightPadding(14.0.scale()),
                AVerticalSpace(_kCommonSpaceBetweenTextField.scale()),
                GestureDetector(
                  onTap: () {
                    type = "UserProfile";
                    _showPicker(context, type);
                  },
                  child: CircleAvatar(
                      radius: 55,
                      backgroundColor: Color(0xffFDCF09),
                      child: Container(
                          width: 100,
                          height: 100,
                          child: Column(
                            children: [
                              if (strServerProfiImage == "")
                                _userImage != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.file(
                                          _userImage,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image(
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                '${imgPathGeneral}ic_select_gallery.png')))
                              else
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(
                                    strServerProfiImage,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                )
                            ],
                          ))),
                ),
                AVerticalSpace(5.0.scale()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RatingBar.builder(
                      initialRating: average_rating,
                      minRating: 1,
                      itemSize: 20,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      ignoreGestures: true,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    Text(
                      '${average_rating} (${rating_count})',
                      style: textStyleCustomColor(
                          12.0.scale(), kColorTextFieldText),
                    )
                  ],
                ),
                AVerticalSpace(_kCommonSpaceBetweenTextField.scale()),
                if (userDetailInfo1 != null)
                  _EmailWidget(userDetailInfo1.data.userInfo.email)
                      .leftPadding(14.0.scale())
                      .rightPadding(14.0.scale()),
                AVerticalSpace(_kCommonSpaceBetweenTextField.scale()),
                if (userDetailInfo1 != null)
                  Column(
                    children: [
                      Text(
                        "First name",
                        style: textStyleCustomColor(
                            _kCommonHintTextFieldFontSize, KColorCommonText),
                      ).align(Alignment.centerLeft),
                      AVerticalSpace(5.0),
                      TextField(
                        controller: _textFiledUserName,
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        cursorColor: KColorTextFieldCommonHint,
                        decoration: InputDecoration(
                          hintText: "",
                          hintStyle: textStyleCustomColor(
                              _kCommonTextFieldFontSize.scale(),
                              KColorTextGrey),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      AVerticalSpace(5.0),
                      ASeparatorLine(
                          height: .50.scale(),
                          color: KColorSeperatorLineCommomn),
                    ],
                  ).leftPadding(14.0.scale()).rightPadding(14.0.scale()),
                AVerticalSpace(_kCommonSpaceBetweenTextField.scale()),
                if (userDetailInfo1 != null)
                  Column(
                    children: [
                      Text(
                        "Last name",
                        style: textStyleCustomColor(
                            _kCommonHintTextFieldFontSize, KColorCommonText),
                      ).align(Alignment.centerLeft),
                      AVerticalSpace(5.0.scale()),
                      TextField(
                        controller: _textFiledlastName,
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        cursorColor: KColorTextFieldCommonHint,
                        decoration: InputDecoration(
                          hintText: "",
                          hintStyle: textStyleCustomColor(
                              _kCommonTextFieldFontSize.scale(),
                              KColorTextGrey),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      AVerticalSpace(5.0),
                      ASeparatorLine(
                          height: .50.scale(),
                          color: KColorSeperatorLineCommomn),
                    ],
                  ).leftPadding(14.0.scale()).rightPadding(14.0.scale()),
                AVerticalSpace(_kCommonSpaceBetweenTextField.scale()),
                _PasswordWidget()
                    .leftPadding(14.0.scale())
                    .rightPadding(14.0.scale()),
                AVerticalSpace(_kCommonSpaceBetweenTextField.scale()),
                ASeparatorLine(
                    height: 1.0.scale(), color: KColorSeperatorLineCommomn),
                AVerticalSpace(_kCommonSpaceBetweenTextField.scale()),
                AVerticalSpace(15.0.scale()),
                if (userDetailInfo1 != null)
                  Column(
                    children: [
                      Text(
                        Stringss.current.txtHintBirthDate,
                        style: textStyleCustomColor(
                            _kCommonHintTextFieldFontSize, KColorCommonText),
                      ).align(Alignment.centerLeft),
                      AVerticalSpace(5.0),
                      InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          _selectedDate(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10.0.scale()),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8.0.scale()),
                            shape: BoxShape.rectangle,
                          ),
                          child: Text(
                            strDateofBirth,
                            style: textStyleCustomColor(
                                _kFontSizeEditFieldHint.scale(),
                                KColorTextGrey),
                            textAlign: TextAlign.center,
                          ).align(Alignment.centerLeft),
                        ).size(_kTextBirthdateField.scale(),
                            _kHeightTextFieldState.scale()),
                      ),
                      AVerticalSpace(5.0),
                      ASeparatorLine(
                          height: 1.0.scale(),
                          color: KColorSeperatorLineCommomn),
                    ],
                  ).leftPadding(14.0.scale()).rightPadding(14.0.scale()),
                AVerticalSpace(_kCommonSpaceBetweenTextField.scale()),
                if (userDetailInfo1 != null)
                  Column(
                    children: [
                      Text(
                        Stringss.current.txtHintPhone,
                        style: textStyleCustomColor(
                            _kCommonHintTextFieldFontSize, KColorCommonText),
                      ).align(Alignment.centerLeft),
                      AVerticalSpace(5.0),
                      TextField(
                        controller: _textFiledMobileNumber,
                        autofocus: false,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [LengthLimitingTextInputFormatter(12)],
                        cursorColor: KColorTextFieldCommonHint,
                        style: textStyleCustomColor(
                            _kCommonTextFieldFontSize.scale(), KColorTextGrey),
                        decoration: InputDecoration(
                          hintText: "",
                          hintStyle: textStyleCustomColor(
                              _kFontSizeEditFieldHint.scale(), KColorTextGrey),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      AVerticalSpace(5.0),
                      ASeparatorLine(
                          height: .50.scale(),
                          color: KColorSeperatorLineCommomn),
                    ],
                  ).leftPadding(14.0.scale()).rightPadding(14.0.scale()),
                AVerticalSpace(_kCommonSpaceBetweenTextField.scale()),
                if (userDetailInfo1 != null)
                  Column(
                    children: [
                      Text(
                        Stringss.current.txtHintAddress,
                        style: textStyleCustomColor(
                            _kCommonHintTextFieldFontSize, KColorCommonText),
                      ).align(Alignment.centerLeft),
                      AVerticalSpace(5.0),
                      TextField(
                        controller: _textFiledAddress,
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        cursorColor: KColorTextFieldCommonHint,
                        style: textStyleCustomColor(
                            _kCommonTextFieldFontSize.scale(), KColorTextGrey),
                        decoration: InputDecoration(
                          hintText: "",
                          hintStyle: textStyleCustomColor(
                              _kFontSizeEditFieldHint.scale(), KColorTextGrey),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      AVerticalSpace(5.0),
                      ASeparatorLine(
                          height: .50.scale(),
                          color: KColorSeperatorLineCommomn),
                    ],
                  ).leftPadding(14.0.scale()).rightPadding(14.0.scale()),
                AVerticalSpace(_kCommonSpaceBetweenTextField.scale()),
                if (userDetailInfo1 != null)
                  Column(
                    children: [
                      Text(
                        "City",
                        style: textStyleCustomColor(
                            _kCommonHintTextFieldFontSize, KColorCommonText),
                      ).align(Alignment.centerLeft),
                      AVerticalSpace(5.0),
                      TextField(
                        controller: _textFiledCity,
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        cursorColor: KColorTextFieldCommonHint,
                        style: textStyleCustomColor(
                            _kCommonTextFieldFontSize.scale(), KColorTextGrey),
                        decoration: InputDecoration(
                          hintText: "",
                          hintStyle: textStyleCustomColor(
                              _kFontSizeEditFieldHint.scale(), KColorTextGrey),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      AVerticalSpace(5.0),
                      ASeparatorLine(
                          height: .50.scale(),
                          color: KColorSeperatorLineCommomn),
                    ],
                  ).leftPadding(14.0.scale()).rightPadding(14.0.scale()),
                AVerticalSpace(_kCommonSpaceBetweenTextField.scale()),
                if (userDetailInfo1 != null)
                  Column(
                    children: [
                      Text(
                        "State",
                        style: textStyleCustomColor(
                            _kCommonHintTextFieldFontSize, KColorCommonText),
                      ).align(Alignment.centerLeft),
                      AVerticalSpace(5.0),
                      if (_stateArrayList != null)
                        InkWell(
                            splashColor: Colors.transparent,
                            onTap: () {
                              if (_stateArrayList.length > 0) {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext bc) {
                                      return GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              ListView.builder(
                                                physics:
                                                    ClampingScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount:
                                                    _stateArrayList.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          strState =
                                                              _stateArrayList[
                                                                      index]
                                                                  .name;
                                                        });

                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Column(
                                                        children: [
                                                          AVerticalSpace(
                                                              15.0.scale()),
                                                          Text(
                                                              _stateArrayList[
                                                                      index]
                                                                  .name,
                                                              style: textStyleCustomColor(
                                                                  14.0.scale(),
                                                                  KColorCommonText)),
                                                          AVerticalSpace(
                                                              15.0.scale()),
                                                          ASeparatorLine(
                                                              height:
                                                                  .5.scale(),
                                                              color:
                                                                  KColorCommonText)
                                                        ],
                                                      ).align(
                                                          Alignment.center));
                                                },
                                              ).expand()
                                            ],
                                          ));
                                    });
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(10.0.scale()),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black),
                                borderRadius:
                                    BorderRadius.circular(8.0.scale()),
                                shape: BoxShape.rectangle,
                              ),
                              child: Text(
                                strState,
                                style: textStyleCustomColor(
                                    _kFontSizeEditFieldHint.scale(),
                                    KColorTextGrey),
                                textAlign: TextAlign.center,
                              ).align(Alignment.centerLeft),
                            ).size(_kTextBirthdateField.scale(),
                                _kHeightTextFieldState.scale())),
                      AVerticalSpace(5.0),
                      ASeparatorLine(
                          height: .50.scale(),
                          color: KColorSeperatorLineCommomn),
                    ],
                  ).leftPadding(14.0.scale()).rightPadding(14.0.scale()),
                AVerticalSpace(_kCommonSpaceBetweenTextField.scale()),
                if (userDetailInfo1 != null)
                  Column(
                    children: [
                      Text(
                        "Zip Code",
                        style: textStyleCustomColor(
                            _kCommonHintTextFieldFontSize, KColorCommonText),
                      ).align(Alignment.centerLeft),
                      AVerticalSpace(5.0),
                      TextField(
                        controller: _textFiledZipCode,
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        cursorColor: KColorTextFieldCommonHint,
                        style: textStyleCustomColor(
                            _kCommonTextFieldFontSize.scale(), KColorTextGrey),
                        decoration: InputDecoration(
                          hintText: "",
                          hintStyle: textStyleCustomColor(
                              _kFontSizeEditFieldHint.scale(), KColorTextGrey),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      AVerticalSpace(5.0),
                      ASeparatorLine(
                          height: .50.scale(),
                          color: KColorSeperatorLineCommomn),
                    ],
                  ).leftPadding(18.0.scale()).rightPadding(18.0.scale()),
                AVerticalSpace(5.0.scale()),
                Text(
                  "Customer Type",
                  style: textStyleCustomColor(
                      _kCommonHintTextFieldFontSize, KColorCommonText),
                )
                    .align(Alignment.centerLeft)
                    .leftPadding(18.0.scale())
                    .rightPadding(18.0.scale()),
                AVerticalSpace(5.0.scale()),
                __BuyRentWidgetState1(searchCustomerType)
                    .leftPadding(18.0.scale())
                    .rightPadding(18.0.scale()),
                AVerticalSpace(5.0),
                GestureDetector(
                  onTap: () {
                    type = "LicenseFront";
                    _showPicker(context, type);
                  },
                  child: Container(
                      height: 120.0.scale(),
                      child: Row(children: [
                        if (_licenseImageFront != null)
                          Image.file(
                            _licenseImageFront,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          )
                        else if (strServerLicenseFront == "")
                          Image(
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  '${imgPathGeneral}ic_select_gallery.png'))
                        else
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: CachedNetworkImage(
                              width: 100.0.scale(),
                              height: 100.0.scale(),
                              imageUrl: strServerLicenseFront,
                              fit: BoxFit.fill,
                              errorWidget: (context, url, error) =>
                                  new Icon(Icons.error),
                            ),
                          ),
                        AHorizontalSpace(8.0.scale()),
                        Column(
                          children: [
                            AVerticalSpace(10.0.scale()),
                            Text(
                              "Update licence Front copy:",
                              maxLines: 2,
                              style: textStyleCustomColor(
                                  _kFontSizeEditFieldHint.scale(),
                                  KColorTextGrey),
                              textAlign: TextAlign.center,
                            ),
                            AVerticalSpace(5.0.scale()),
                            ARoundedButton(
                              btnBorderSideColor: kColorCommonButton,btnDisabledColor: Color(0xFF5e6163),btnIconSize:15 ,
                              btnDisabledTextColor:Color(0xFFFFFFFF) ,
                              btnFontWeight: FontWeight.normal,
                              btnBgColor: kColorCommonButton,
                              btnTextColor: Colors.white,
                              btnOnPressed: () {
                                type = "LicenseFront";
                                _showPicker(context, type);
                              },
                              btnText: "Update",
                              btnHeight: kHeightBtnSplashNormal.scale(),
                              btnWidth: 100.0.scale(),
                              btnFontSize: kFontSizeBtnLarge.scale(),
                              btnElevation: 0,
                            )
                          ],
                        )
                      ])),
                ).leftPadding(18.0.scale()).rightPadding(18.0.scale()),
                GestureDetector(
                  onTap: () {
                    type = "Licenseback";
                    _showPicker(context, type);
                  },
                  child: Container(
                      height: 120.0.scale(),
                      child: Row(children: [
                        if (_licenseImageBack != null)
                          Image.file(
                            _licenseImageBack,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          )
                        else if (strServerLicenseBack == "")
                          Image(
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  '${imgPathGeneral}ic_select_gallery.png'))
                        else
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: CachedNetworkImage(
                              width: 100.0.scale(),
                              height: 100.0.scale(),
                              imageUrl: strServerLicenseBack,
                              fit: BoxFit.fill,
                              errorWidget: (context, url, error) =>
                                  new Icon(Icons.error),
                            ),
                          ),
                        AHorizontalSpace(8.0.scale()),
                        Column(
                          children: [
                            AVerticalSpace(10.0.scale()),
                            Text(
                              "Update licence back copy:",
                              maxLines: 2,
                              style: textStyleCustomColor(
                                  _kFontSizeEditFieldHint.scale(),
                                  KColorTextGrey),
                              textAlign: TextAlign.center,
                            ),
                            AVerticalSpace(5.0.scale()),
                            ARoundedButton(
                              btnBorderSideColor: kColorCommonButton,btnDisabledColor: Color(0xFF5e6163),btnIconSize:15 ,
                              btnDisabledTextColor:Color(0xFFFFFFFF) ,
                              btnFontWeight: FontWeight.normal,
                              btnBgColor: kColorCommonButton,
                              btnTextColor: Colors.white,
                              btnOnPressed: () {
                                type = "Licenseback";
                                _showPicker(context, type);
                              },
                              btnText: "Update",
                              btnHeight: kHeightBtnSplashNormal.scale(),
                              btnWidth: 100.0.scale(),
                              btnFontSize: kFontSizeBtnLarge.scale(),
                              btnElevation: 0,
                            )
                          ],
                        )
                      ])),
                ).leftPadding(18.0.scale()).rightPadding(18.0.scale()),
                GestureDetector(
                  onTap: () {
                    type = "MarijuanaId";
                    _showPicker(context, type);
                  },
                  child: Container(
                      height: 120.0.scale(),
                      child: Row(children: [
                        if (_mariyunaImage != null)
                          Image.file(
                            _mariyunaImage,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          )
                        else if (_strServerPathMarijuana == "")
                          Image(
                              image: AssetImage(
                                  '${imgPathGeneral}ic_select_gallery.png'))
                        else
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: CachedNetworkImage(
                              width: 100.0.scale(),
                              height: 100.0.scale(),
                              imageUrl: _strServerPathMarijuana,
                              fit: BoxFit.fill,
                              errorWidget: (context, url, error) =>
                                  new Icon(Icons.error),
                            ),
                          ),
                        AHorizontalSpace(24.0.scale()),
                        Column(
                          children: [
                            AVerticalSpace(10.0.scale()),
                            Text(
                              "Update marijuana Id:",
                              maxLines: 2,
                              style: textStyleCustomColor(
                                  _kFontSizeEditFieldHint.scale(),
                                  KColorTextGrey),
                              textAlign: TextAlign.center,
                            ),
                            AVerticalSpace(5.0.scale()),
                            ARoundedButton(
                              btnBorderSideColor: kColorCommonButton,btnDisabledColor: Color(0xFF5e6163),btnIconSize:15 ,
                              btnDisabledTextColor:Color(0xFFFFFFFF) ,
                              btnFontWeight: FontWeight.normal,
                              btnBgColor: kColorCommonButton,
                              btnTextColor: Colors.white,
                              btnOnPressed: () {
                                type = "MarijuanaId";
                                _showPicker(context, type);
                              },
                              btnText: "Update",
                              btnHeight: kHeightBtnSplashNormal.scale(),
                              btnWidth: 100.0.scale(),
                              btnFontSize: kFontSizeBtnLarge.scale(),
                              btnElevation: 0,
                            )
                          ],
                        )
                      ])),
                ).leftPadding(18.0.scale()).rightPadding(18.0.scale()),
                AVerticalSpace(_kCommonSpaceBetweenTextField.scale()),
                ARoundedButton(
                  btnBorderSideColor: kColorCommonButton,btnDisabledColor: Color(0xFF5e6163),btnIconSize:15 ,
                  btnDisabledTextColor:Color(0xFFFFFFFF) ,
                  btnFontWeight: FontWeight.normal,
                  btnBgColor: kColorCommonButton,
                  btnTextColor: Colors.white,
                  btnOnPressed: () {
                    if (_textFiledUserName.text.isEmpty) {
                      showSnackBar("Please fill user name field!", context);
                    } else if (_textFiledlastName.text.isEmpty) {
                      showSnackBar("Please fill last name field!", context);
                    } else if (strDateofBirth.isEmpty) {
                      showSnackBar("Please fill dob field!", context);
                    } else if (_textFiledMobileNumber.text.isEmpty) {
                      showSnackBar("Please fill mobile number field!", context);
                    } else if (_textFiledAddress.text.isEmpty) {
                      showSnackBar("Please fill Address field!", context);
                    } else if (_textFiledCity.text.isEmpty) {
                      showSnackBar("Please fill City field!", context);
                    } else if (strState.isEmpty) {
                      showSnackBar("Please fill state field!", context);
                    } else if (_textFiledZipCode.text.isEmpty) {
                      showSnackBar("Please fill zip field!", context);
                    } else {
                      showHideProgress(true);
                      BlocProvider.of<ProfileBloc>(context).add(
                          ProfileEventUpdateUserBtnClick(
                              _textFiledUserName.text,
                              _textFiledlastName.text,
                              _dateStrServer == ""
                                  ? strDateofBirth
                                  : _dateStrServer,
                              _textFiledMobileNumber.text,
                              _textFiledAddress.text,
                              _textFiledCity.text,
                              strState,
                              _textFiledZipCode.text,
                              _currentLat,
                              _currentLong,
                              strPathProfile,
                              strPathLicenseFront,
                              strPathLicenseBack,
                              _customerType,
                              _strServerPathMarijuana));
                    }
                  },
                  btnText: "Update My Information ",
                  btnHeight: kHeightBtnSplashNormal.scale(),
                  btnWidth: kWidthBtnNormal.scale(),
                  btnFontSize: kFontSizeBtnLarge.scale(),
                  btnElevation: 0,
                ),
                AVerticalSpace(20.0.scale()),
              ],
            )
          ],
        ).widgetBgColor(Colors.white),
      ).scroll(disableBounce: true),
    ).pageBgColor(kColorAppBgColor);
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

class _EmailWidget extends StatefulWidget {
  String email;

  _EmailWidget(this.email);

  @override
  __EmailWidgetState createState() => __EmailWidgetState();
}

class __EmailWidgetState extends State<_EmailWidget> {
  TextEditingController _textFiledEmail = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    _textFiledEmail.text = widget.email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Text(
          Stringss.current.txtHintEmail,
          style: textStyleCustomColor(
              _kCommonHintTextFieldFontSize, KColorCommonText),
        ).align(Alignment.centerLeft),
        AVerticalSpace(5.0.scale()),
        TextField(
          controller: _textFiledEmail,
          keyboardType: TextInputType.emailAddress,
          enabled: false,
          autofocus: false,
          cursorColor: KColorTextFieldCommonHint,
          decoration: InputDecoration(
            hintText: "",
            hintStyle: textStyleCustomColor(
                _kCommonTextFieldFontSize.scale(), KColorTextGrey),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        AVerticalSpace(5.0),
        ASeparatorLine(height: .50.scale(), color: KColorSeperatorLineCommomn),
      ],
    );
  }
}

class _UserNameWidget extends StatefulWidget {
  String name;

  _UserNameWidget(this.name);

  @override
  __UserNameWidgetState createState() => __UserNameWidgetState();
}

class __UserNameWidgetState extends State<_UserNameWidget> {
  TextEditingController _textFiledUserName = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _textFiledUserName.text = widget.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Text(
          Stringss.current.txtHintUserName,
          style: textStyleCustomColor(
              _kCommonHintTextFieldFontSize, KColorCommonText),
        ).align(Alignment.centerLeft),
        AVerticalSpace(5.0),
        TextField(
          controller: _textFiledUserName,
          keyboardType: TextInputType.text,
          autofocus: false,
          cursorColor: KColorTextFieldCommonHint,
          decoration: InputDecoration(
            hintText: "",
            hintStyle: textStyleCustomColor(
                _kCommonTextFieldFontSize.scale(), KColorTextGrey),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        AVerticalSpace(5.0),
        ASeparatorLine(height: .50.scale(), color: KColorSeperatorLineCommomn),
      ],
    );
  }
}

class _PasswordWidget extends StatefulWidget {
  @override
  __PasswordWidgetState createState() => __PasswordWidgetState();
}

class __PasswordWidgetState extends State<_PasswordWidget> {
  // TextEditingController _textFiledPassword = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    // _textFiledPassword.text = "abcsdsdf";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Text(
          Stringss.current.txtHintPassWord,
          style: textStyleCustomColor(
              _kCommonHintTextFieldFontSize, KColorCommonText),
        ).align(Alignment.centerLeft),
        AVerticalSpace(5.0),
        InkWell(
          splashColor: Colors.transparent,
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(10.0.scale()),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(8.0.scale()),
              shape: BoxShape.rectangle,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "*********",
                  style: textStyleCustomColor(
                      _kFontSizeEditFieldHint.scale(), KColorTextGrey),
                  textAlign: TextAlign.center,
                ),
                InkWell(
                  onTap: () {
                    BlocProvider.of<ProfileBloc>(context)
                        .add(ChangePasswordEvent());
                  },
                  child: Text(
                    "Change",
                    style: textStyleCustomColor(
                        _kFontSizeEditFieldHint.scale(), kColorCommonButton),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ).align(Alignment.centerLeft),
          ).size(_kTextBirthdateField.scale(), _kHeightTextFieldState.scale()),
        ),
      ],
    );
  }
}

class _PhoneNumber extends StatefulWidget {
  String userMob;

  _PhoneNumber(this.userMob);

  @override
  __PhoneNumberState createState() => __PhoneNumberState();
}

class __PhoneNumberState extends State<_PhoneNumber> {
  TextEditingController _textFiledMobileNumber = TextEditingController();

  @override
  void initState() {
    _textFiledMobileNumber.text = widget.userMob;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Text(
          Stringss.current.txtHintPhone,
          style: textStyleCustomColor(
              _kCommonHintTextFieldFontSize, KColorCommonText),
        ).align(Alignment.centerLeft),
        AVerticalSpace(5.0),
        TextField(
          controller: _textFiledMobileNumber,
          autofocus: false,
          keyboardType: TextInputType.number,
          inputFormatters: [LengthLimitingTextInputFormatter(11)],
          cursorColor: KColorTextFieldCommonHint,
          style: textStyleCustomColor(
              _kCommonTextFieldFontSize.scale(), KColorTextGrey),
          decoration: InputDecoration(
            hintText: "",
            hintStyle: textStyleCustomColor(
                _kFontSizeEditFieldHint.scale(), KColorTextGrey),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        AVerticalSpace(5.0),
        ASeparatorLine(height: .50.scale(), color: KColorSeperatorLineCommomn),
      ],
    );
  }
}

const double _kFontSizeEditFieldHint = 13.0;
const double _kHeightTextFieldState = 55.0;
const double _kHeightBtnCheckout = 45.0;

const double _kTextBirthdateField = 327.0;

class DateOfBirthWidget extends StatefulWidget {
  String strDateofBirth;

  DateOfBirthWidget(this.strDateofBirth);

  @override
  _DateOfBirthWidgetState createState() => _DateOfBirthWidgetState();
}

class _DateOfBirthWidgetState extends State<DateOfBirthWidget> {
  DateTime _date = new DateTime.now();
  TimeOfDay _time = new TimeOfDay.now();

  Future<Null> _selectedDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(DateTime.now().ordinalDate),
        lastDate: new DateTime(2022));

    if (picked != null && picked != _date) {
      print("Date selected ${_date.toString()}");
      setState(() {
        _date = picked;

        if (calculateAge(_date) >= 21) {
          print(_date.toString());
          widget.strDateofBirth =
              DateFormat('MM/dd/yyyy').format(DateTime.parse(_date.toString()));
        } else {
          showSnackBar(Stringss.current.txtAgemessage, context);
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Text(
          Stringss.current.txtHintBirthDate,
          style: textStyleCustomColor(
              _kCommonHintTextFieldFontSize, KColorCommonText),
        ).align(Alignment.centerLeft),
        AVerticalSpace(5.0),
        InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            _selectedDate(context);
          },
          child: Container(
            padding: EdgeInsets.all(10.0.scale()),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(8.0.scale()),
              shape: BoxShape.rectangle,
            ),
            child: Text(
              widget.strDateofBirth,
              style: textStyleCustomColor(
                  _kFontSizeEditFieldHint.scale(), KColorTextGrey),
              textAlign: TextAlign.center,
            ).align(Alignment.centerLeft),
          ).size(_kTextBirthdateField.scale(), _kHeightTextFieldState.scale()),
        ),
        AVerticalSpace(5.0),
        ASeparatorLine(height: 1.0.scale(), color: KColorSeperatorLineCommomn),
      ],
    );
  }
}

class _AddressField extends StatefulWidget {
  String userAddress;

  _AddressField(this.userAddress);

  @override
  __AddressFieldState createState() => __AddressFieldState();
}

class __AddressFieldState extends State<_AddressField> {
  TextEditingController _textFiledAddress = TextEditingController();

  @override
  void initState() {
    _textFiledAddress.text = widget.userAddress;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Text(
          Stringss.current.txtHintAddress,
          style: textStyleCustomColor(
              _kCommonHintTextFieldFontSize, KColorCommonText),
        ).align(Alignment.centerLeft),
        AVerticalSpace(5.0),
        TextField(
          controller: _textFiledAddress,
          keyboardType: TextInputType.text,
          autofocus: false,
          cursorColor: KColorTextFieldCommonHint,
          style: textStyleCustomColor(
              _kCommonTextFieldFontSize.scale(), KColorTextGrey),
          decoration: InputDecoration(
            hintText: "",
            hintStyle: textStyleCustomColor(
                _kFontSizeEditFieldHint.scale(), KColorTextGrey),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        AVerticalSpace(5.0),
        ASeparatorLine(height: .50.scale(), color: KColorSeperatorLineCommomn),
      ],
    );
  }
}
