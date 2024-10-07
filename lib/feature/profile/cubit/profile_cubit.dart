import 'package:bloc/bloc.dart';
import 'package:chat_app/core/database/cache.dart';
import 'package:chat_app/feature/profile/data/model/user_profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  UserProfileModel? model;
  List<UserProfileModel> userProfileData = [];
  String userId = Cache.getValue(key: 'userId');

  ProfileCubit() : super(ProfileInitial());

  Future<void> getUserProfile() async {
    await FirebaseFirestore.instance.collection('users').doc(userId).get().then((onValue) {
      userProfileData.add(UserProfileModel.fromJson(jsonData: onValue.data()));
      print(userProfileData[0].firstName);
      emit(GetUserProfileDataSuccess());
    });
  }
}
