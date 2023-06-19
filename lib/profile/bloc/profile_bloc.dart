import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:grambunny_customer/hm_root/hm_root.dart';
import 'package:grambunny_customer/networking/networking.dart';
import 'package:grambunny_customer/services/services.dart';
import 'package:grambunny_customer/utils/utils.dart';

import 'bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  UserRepository? _userRepository;

  ProfileBloc({required UserRepository userRepository}) : super(ProfileInitial()) {
    _userRepository = userRepository;

    on<ProfileEventBackBtnClick>(mapProfileEventBackBtnClick);
    on<ProfileEventProfileReset>(mapProfileEventProfileReset);
    on<ProfileEventGetUserData>(mapProfileEventGetUserData);
    on<ProfileEventUpdateUserBtnClick>(mapEventUpdateUserBtnClick);
    on<ChangePasswordEvent>(mapChangePasswordEvent);
    on<ChangePasswordEventForSubmitButton>(mapChangePasswordEventForSubmitButton);
    on<ChangePasswordPageResetPageEvent>(mapChangePasswordPageResetPageEvent);
    on<ProfileImageUploadEventBtnClick>(mapProfileImageUploadEventBtnClick);

  }



   mapProfileImageUploadEventBtnClick(
      ProfileImageUploadEventBtnClick event,Emitter<ProfileState> emitter) async {
    NetworkApiCallState<bool> apiCallState =
        await _userRepository!.uploadImageCopyAPI(
            imageCopyPath: event.strPathMarijuanaId, paramName: event.strParam);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        emitter (ProfileUploadCompleteState());
      } else {
        emitter (ChangePasswordApiErrorState(apiCallState.message!));
      }
    } else if (apiCallState.status == NetworkRequestStatus.ERROR) {
      if (apiCallState.message == "Unknown Error") {
        emitter ( ChangePasswordApiErrorState("Something went wrong"));
      } else {
        emitter ( ChangePasswordApiErrorState("Something went wrong"));
      }
    }
  }

   mapChangePasswordPageResetPageEvent(ChangePasswordPageResetPageEvent event,Emitter<ProfileState> emitter) async {
     emitter( ChangePasswordState());
  }

   mapChangePasswordEventForSubmitButton(
      ChangePasswordEventForSubmitButton event,Emitter<ProfileState> emitter) async {
    NetworkApiCallState<bool> apiCallState =
        await _userRepository!.changePasswordAPI(
            old_Password: event.old_Password, new_Password: event.new_Password);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        emitter( ChangePasswordApiCompleteState(apiCallState.message!));
      } else {
        emitter( ChangePasswordApiErrorState(apiCallState.message!));
      }
    } else if (apiCallState.status == NetworkRequestStatus.ERROR) {
      if (apiCallState.message == "Unknown Error") {
        emitter(  ChangePasswordApiErrorState("Something went wrong"));
      } else {
        emitter(  ChangePasswordApiErrorState("Something went wrong"));
      }
    }
  }

   mapEventUpdateUserBtnClick(
      ProfileEventUpdateUserBtnClick event,Emitter<ProfileState> emitter) async{
    //_userRepository.ScreenName = HomeMainPageScreen;

    NetworkApiCallState<bool> apiCallState =
        await _userRepository!.postUpdateUserInfoApi(
            firstName: event.firstName,
            lastName: event.lastName,
            address: event.address,
            city: event.city,
            lat: event.currentLat,
            long: event.currentLong,
            mobileNo: event.mobileNumber,
            zipCode: event.zipCode,
            State: event.strState,
            userPath: event.strPathProfile,
            frontCopyPath: event.strPathLicenseFront,
            backCopyPath: event.strPathLicenseBack);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        NetworkApiCallState<bool> apiCallState1 =
            await _userRepository!.getUserDetailApi();
        String profileImage =
            _userRepository!.getUserDetailInfo()!.data.userInfo.profileURL;
        sharedPrefs.setUserProfileImage = profileImage;
        emitter( ProfileUpdateUserDataState(_userRepository!.getUserDetailInfo()!,
            _userRepository!.getStateArrayList()!));
      } else {
        emitter(  ProfileErrorState(apiCallState.message!));
      }
    } else if (apiCallState.status == NetworkRequestStatus.ERROR) {
      if (apiCallState.message == "Unknown Error") {
        emitter( ProfileErrorState("Something went wrong"));
      } else {
        emitter( ProfileErrorState("Something went wrong"));
      }
    }
  }

  mapProfileEventGetUserData(ProfileEventGetUserData event,Emitter<ProfileState> emitter) async* {
    //_userRepository.ScreenName = HomeMainPageScreen;
    NetworkApiCallState<bool> apiCallState =
        await _userRepository!.getUserDetailApi();

    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        print("demo name");
        NetworkApiCallState<bool> apiCallState =
            await _userRepository!.getStateListApi();
        print("demo name");
        print(_userRepository!.getUserDetailInfo()!.data.userInfo.profileImage);
        sharedPrefs.setUserProfileImage =
            _userRepository!.getUserDetailInfo()!.data.userInfo.profileURL;

        emitter (ProfileGetUserDataState(_userRepository!.getUserDetailInfo()!,
            _userRepository!.getStateArrayList()!));
      } else {
        emitter ( ProfileErrorState(apiCallState.message!));
      }
    } else if (apiCallState.status == NetworkRequestStatus.ERROR) {
      if (apiCallState.message == "Unknown Error") {
        emitter ( ProfileErrorState("Something went wrong"));
      } else {
        emitter ( ProfileErrorState("Something went wrong"));
      }
    }
  }

   mapProfileEventProfileReset(ProfileEventProfileReset event,Emitter<ProfileState> emitter) async {
     emitter (ProfileInitial());
  }

   mapChangePasswordEvent(ChangePasswordEvent event,Emitter<ProfileState> emitter) async {
     emitter( ChangePasswordState());
  }

 mapProfileEventBackBtnClick(ProfileEventBackBtnClick event,Emitter<ProfileState> emitter) async {
    if (state is ProfileInitial) {
      print("profile back");
      //_userRepository.ScreenName = HomeMainPageScreen;
      emitter( ProfileToHomeNavigateState());
    } else if (state is ChangePasswordApiCompleteState) {
      emitter( ProfileInitial());
    } else if (state is ChangePasswordState) {
      emitter( ProfileInitial());
    }
  }
}
