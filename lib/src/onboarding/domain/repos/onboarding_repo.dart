import 'package:flutter_task_1/core/enums/gender_enum.dart';
import 'package:flutter_task_1/core/typedefs/typedefs.dart';

abstract class OnboardingRepo {
  const OnboardingRepo();
  FutureVoid cacheUser(
      {required String nickname,
      required DateTime birthdate,
      required Gender gender,
      required String image});
  FutureResult<bool> checkIfUserFirstTime();
}
