import 'package:equatable/equatable.dart';
import 'package:grambunny_customer/home/home.dart';
import 'package:grambunny_customer/profile/profile.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class ChangePasswordState extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileUploadCompleteState extends ProfileState {
  ProfileUploadCompleteState();

  @override
  List<Object> get props => [];
}

class ProfileToHomeNavigateState extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileGetUserDataState extends ProfileState {
  UserDetailResponseModel userDetailInfo;
  List<StatesList> stateArrayList;

  ProfileGetUserDataState(this.userDetailInfo, this.stateArrayList);

  @override
  List<Object> get props => [userDetailInfo, stateArrayList];
}

class ProfileUpdateUserDataState extends ProfileState {
  UserDetailResponseModel userDetailInfo;
  List<StatesList> stateArrayList;

  ProfileUpdateUserDataState(this.userDetailInfo, this.stateArrayList);

  @override
  List<Object> get props => [userDetailInfo, stateArrayList];
}

class ProfileErrorState extends ProfileState {
  String msg;

  ProfileErrorState(this.msg);

  @override
  List<Object> get props => [msg];
}

class ChangePasswordApiCompleteState extends ProfileState {
  String msg;

  ChangePasswordApiCompleteState(this.msg);

  @override
  List<Object> get props => [msg];
}

class ChangePasswordApiErrorState extends ProfileState {
  String msg;

  ChangePasswordApiErrorState(this.msg);

  @override
  List<Object> get props => [msg];
}
