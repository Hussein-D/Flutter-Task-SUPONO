import 'package:flutter_task_1/core/typedefs/typedefs.dart';
import 'package:flutter_task_1/core/usecases/usecases.dart';
import 'package:flutter_task_1/src/onboarding/domain/repos/onboarding_repo.dart';

class CheckIfUserFirstTime extends UsecaseWithoutParams<bool> {
  const CheckIfUserFirstTime(this._repo);
  final OnboardingRepo _repo;
  @override
  FutureResult<bool> call() async => _repo.checkIfUserFirstTime();
}
