import 'package:flutter/foundation.dart';
import 'package:flutter_task_1/core/services/dependency_inversion.dart';
import 'package:flutter_task_1/src/onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:flutter_task_1/src/onboarding/data/models/local_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  void init(LocalUserModel user) {
    _user = user;
  }

  LocalUserModel? _user;
  LocalUserModel? get user => _user;
  void setShowUnlockApp(bool showUnlockApp) async {
    LocalUserModel newUser = _user!.copyWith(subscribed: showUnlockApp);
    _user = newUser;
    await sl<SharedPreferences>().setString(kUserKey, newUser.toJson());
    notifyListeners();
  }
}
