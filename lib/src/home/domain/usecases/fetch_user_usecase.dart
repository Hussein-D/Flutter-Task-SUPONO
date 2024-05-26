import 'package:flutter_task_1/core/typedefs/typedefs.dart';
import 'package:flutter_task_1/core/usecases/usecases.dart';
import 'package:flutter_task_1/src/home/domain/repos/home_repo.dart';
import 'package:flutter_task_1/src/onboarding/data/models/local_user_model.dart';

class FetchUser extends UsecaseWithoutParams {
  const FetchUser(this._repo);
  final HomeRepo _repo;
  @override
  FutureResult<LocalUserModel> call() async => _repo.fetchUser();
}
