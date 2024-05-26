import 'package:flutter_task_1/core/typedefs/typedefs.dart';
import 'package:flutter_task_1/src/onboarding/data/models/local_user_model.dart';

abstract class HomeRepo {
  const HomeRepo();
  FutureResult<LocalUserModel> fetchUser();
}
