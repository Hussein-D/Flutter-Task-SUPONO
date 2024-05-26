import 'dart:developer';

import 'package:flutter_task_1/core/enums/gender_enum.dart';
import 'package:flutter_task_1/src/onboarding/data/models/local_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class OnboardingLocalDataSource {
  const OnboardingLocalDataSource();
  Future<void> cacheUser(
      {required String nickname,
      required DateTime birthdate,
      required Gender gender,
      required String image});
  Future<bool> checkIfUserIsFirstTime();
}

const String kIsFirstTimeKey = "isFirstTimeKey";
const String kUserKey = "user";

class OnboardingLocalDataSrcImp implements OnboardingLocalDataSource {
  const OnboardingLocalDataSrcImp(this._prefs);
  final SharedPreferences _prefs;
  @override
  Future<void> cacheUser(
      {required String nickname,
      required DateTime birthdate,
      required Gender gender,
      required String image}) async {
    log("1");
    await _prefs.setBool(kIsFirstTimeKey, false);
    log("2");
    await _prefs.setString(
        kUserKey,
        LocalUserModel.fromMap({
          "nickname": nickname,
          "birthdate": birthdate,
          "gender": fromGenderEnumToString(gender),
          "image": image,
          "subscribed": false
        }).toJson());
    log("3");
  }

  @override
  Future<bool> checkIfUserIsFirstTime() async {
    return _prefs.getBool(kIsFirstTimeKey) ?? true;
  }
}
