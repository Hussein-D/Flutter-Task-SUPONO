
import 'package:flutter_task_1/core/failures/exceptions.dart';
import 'package:flutter_task_1/src/onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:flutter_task_1/src/onboarding/data/models/local_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class HomeRepoLocalDataSouce {
  const HomeRepoLocalDataSouce();
  Future<LocalUserModel> fetchUser();
}

class HomeRepoLocalDataSrcImpl implements HomeRepoLocalDataSouce {
  const HomeRepoLocalDataSrcImpl(this._prefs);
  final SharedPreferences _prefs;
  @override
  Future<LocalUserModel> fetchUser() async {
    final result = _prefs.getString(kUserKey);
    if (result != null) {
      return LocalUserModel.fromJson(result);
    } else {
      throw const APIException(
          message: 'An error has occured', statusCode: 505);
    }
  }
}
