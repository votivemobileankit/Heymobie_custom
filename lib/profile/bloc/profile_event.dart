import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileEventBackBtnClick extends ProfileEvent {}

class ProfileEventProfileReset extends ProfileEvent {}

class ProfileEventGetUserData extends ProfileEvent {
  @override
  List<Object> get props => [];
}

class ProfileImageUploadEventBtnClick extends ProfileEvent {
  String strParam;
  String strPathMarijuanaId;

  ProfileImageUploadEventBtnClick(this.strParam, this.strPathMarijuanaId);

  @override
  List<Object> get props => [strParam, strPathMarijuanaId];
}

class ChangePasswordEvent extends ProfileEvent {
  // TODO: implement props
  @override
  List<Object> get props => [];
}

class ChangePasswordEventForSubmitButton extends ProfileEvent {
  String old_Password;
  String new_Password;

  ChangePasswordEventForSubmitButton(this.old_Password, this.new_Password);

  @override
  List<Object> get props => [old_Password, new_Password];
}

class ChangePasswordPageResetPageEvent extends ProfileEvent {
  @override
  List<Object> get props => [];
}

class ProfileEventUpdateUserBtnClick extends ProfileEvent {
  String firstName;
  String lastName;
  String strDateofBirth;
  String mobileNumber;
  String address;
  String city;
  String strState;
  String zipCode;
  double currentLat;
  double currentLong;
  String strPathProfile;
  String strPathLicenseFront;
  String strPathLicenseBack;
  String customerType;
  String strServerPathMarijuana;

  ProfileEventUpdateUserBtnClick(
    this.firstName,
    this.lastName,
    this.strDateofBirth,
    this.mobileNumber,
    this.address,
    this.city,
    this.strState,
    this.zipCode,
    this.currentLat,
    this.currentLong,
    this.strPathProfile,
    this.strPathLicenseFront,
    this.strPathLicenseBack,
    this.customerType,
    this.strServerPathMarijuana,
  );

  @override
  List<Object> get props => [
        firstName,
        lastName,
        strDateofBirth,
        mobileNumber,
        address,
        city,
        strState,
        zipCode,
        currentLat,
        currentLong,
        strPathProfile,
        strPathLicenseFront,
        strPathLicenseBack,
        customerType,
        strServerPathMarijuana
      ];
}
