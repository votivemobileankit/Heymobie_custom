import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:grambunny_customer/hm_root/hm_root.dart';
import 'package:grambunny_customer/networking/networking.dart';
import 'package:grambunny_customer/services/services.dart';
import 'package:grambunny_customer/utils/utils.dart';

import 'bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  UserRepository _userRepository;

  ProfileBloc({UserRepository userRepository}) : super(ProfileInitial()) {
    _userRepository = userRepository;
  }

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    switch (event.runtimeType) {
      case ProfileEventBackBtnClick:
        yield* mapProfileEventBackBtnClick();
        break;
      case ProfileEventProfileReset:
        yield* mapProfileEventProfileReset();
        break;
      case ProfileEventGetUserData:
        yield* mapProfileEventGetUserData();
        break;
      case ProfileEventUpdateUserBtnClick:
        yield* mapEventUpdateUserBtnClick(event);
        break;
      case ChangePasswordEvent:
        yield* mapChangePasswordEvent();
        break;
      case ChangePasswordEventForSubmitButton:
        yield* mapChangePasswordEventForSubmitButton(event);
        break;
      case ChangePasswordPageResetPageEvent:
        yield* mapChangePasswordPageResetPageEvent();
        break;
      case ProfileImageUploadEventBtnClick:
        yield* mapProfileImageUploadEventBtnClick(event);
        break;
    }
  }

  Stream<ProfileState> mapProfileImageUploadEventBtnClick(
      ProfileImageUploadEventBtnClick event) async* {
    NetworkApiCallState<bool> apiCallState =
        await _userRepository.uploadImageCopyAPI(
            imageCopyPath: event.strPathMarijuanaId, paramName: event.strParam);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        yield ProfileUploadCompleteState();
      } else {
        yield ChangePasswordApiErrorState(apiCallState.message);
      }
    } else if (apiCallState.status == NetworkRequestStatus.ERROR) {
      if (apiCallState.message == "Unknown Error") {
        yield ChangePasswordApiErrorState("Something went wrong");
      } else {
        yield ChangePasswordApiErrorState("Something went wrong");
      }
    }
  }

  Stream<ProfileState> mapChangePasswordPageResetPageEvent() async* {
    yield ChangePasswordState();
  }

  Stream<ProfileState> mapChangePasswordEventForSubmitButton(
      ChangePasswordEventForSubmitButton event) async* {
    NetworkApiCallState<bool> apiCallState =
        await _userRepository.changePasswordAPI(
            old_Password: event.old_Password, new_Password: event.new_Password);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        yield ChangePasswordApiCompleteState(apiCallState.message);
      } else {
        yield ChangePasswordApiErrorState(apiCallState.message);
      }
    } else if (apiCallState.status == NetworkRequestStatus.ERROR) {
      if (apiCallState.message == "Unknown Error") {
        yield ChangePasswordApiErrorState("Something went wrong");
      } else {
        yield ChangePasswordApiErrorState("Something went wrong");
      }
    }
  }

  Stream<ProfileState> mapEventUpdateUserBtnClick(
      ProfileEventUpdateUserBtnClick event) async* {
    //_userRepository.ScreenName = HomeMainPageScreen;

    NetworkApiCallState<bool> apiCallState =
        await _userRepository.postUpdateUserInfoApi(
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
            await _userRepository.getUserDetailApi();
        String profileImage =
            _userRepository.getUserDetailInfo().data.userInfo.profileURL;
        sharedPrefs.setUserProfileImage = profileImage;
        yield ProfileUpdateUserDataState(_userRepository.getUserDetailInfo(),
            _userRepository.getStateArrayList());
      } else {
        yield ProfileErrorState(apiCallState.message);
      }
    } else if (apiCallState.status == NetworkRequestStatus.ERROR) {
      if (apiCallState.message == "Unknown Error") {
        yield ProfileErrorState("Something went wrong");
      } else {
        yield ProfileErrorState("Something went wrong");
      }
    }
  }

  Stream<ProfileState> mapProfileEventGetUserData() async* {
    //_userRepository.ScreenName = HomeMainPageScreen;
    NetworkApiCallState<bool> apiCallState =
        await _userRepository.getUserDetailApi();

    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      if (apiCallState.statusValue == "1") {
        print("demo name");
        NetworkApiCallState<bool> apiCallState =
            await _userRepository.getStateListApi();
        print("demo name");
        print(_userRepository.getUserDetailInfo().data.userInfo.profileImage);
        sharedPrefs.setUserProfileImage =
            _userRepository.getUserDetailInfo().data.userInfo.profileURL;

        yield ProfileGetUserDataState(_userRepository.getUserDetailInfo(),
            _userRepository.getStateArrayList());
      } else {
        yield ProfileErrorState(apiCallState.message);
      }
    } else if (apiCallState.status == NetworkRequestStatus.ERROR) {
      if (apiCallState.message == "Unknown Error") {
        yield ProfileErrorState("Something went wrong");
      } else {
        yield ProfileErrorState("Something went wrong");
      }
    }
  }

  Stream<ProfileState> mapProfileEventProfileReset() async* {
    yield ProfileInitial();
  }

  Stream<ProfileState> mapChangePasswordEvent() async* {
    yield ChangePasswordState();
  }

  Stream<ProfileState> mapProfileEventBackBtnClick() async* {
    if (state is ProfileInitial) {
      print("profile back");
      //_userRepository.ScreenName = HomeMainPageScreen;
      yield ProfileToHomeNavigateState();
    } else if (state is ChangePasswordApiCompleteState) {
      yield ProfileInitial();
    } else if (state is ChangePasswordState) {
      yield ProfileInitial();
    }
  }
}
