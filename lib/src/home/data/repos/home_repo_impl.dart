import 'package:dartz/dartz.dart';
import 'package:flutter_task_1/core/failures/exceptions.dart';
import 'package:flutter_task_1/core/failures/failure.dart';
import 'package:flutter_task_1/core/typedefs/typedefs.dart';
import 'package:flutter_task_1/src/home/data/home_local_data_source.dart/home_local_data_source.dart';
import 'package:flutter_task_1/src/home/domain/repos/home_repo.dart';
import 'package:flutter_task_1/src/onboarding/data/models/local_user_model.dart';

class HomeRepoImpl implements HomeRepo {
  const HomeRepoImpl(this._dataSouce);
  final HomeRepoLocalDataSouce _dataSouce;

  @override
  FutureResult<LocalUserModel> fetchUser() async {
    try {
      final result = await _dataSouce.fetchUser();
      return Right(result);
    } on APIException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
