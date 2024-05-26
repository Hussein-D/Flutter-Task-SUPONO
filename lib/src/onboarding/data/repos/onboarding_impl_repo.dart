import 'package:dartz/dartz.dart';
import 'package:flutter_task_1/core/enums/gender_enum.dart';
import 'package:flutter_task_1/core/failures/exceptions.dart';
import 'package:flutter_task_1/core/failures/failure.dart';
import 'package:flutter_task_1/core/typedefs/typedefs.dart';
import 'package:flutter_task_1/src/onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:flutter_task_1/src/onboarding/domain/repos/onboarding_repo.dart';

class OnboardingRepoImpl implements OnboardingRepo {
  const OnboardingRepoImpl(this._dataSource);
  final OnboardingLocalDataSource _dataSource;
  @override
  FutureVoid cacheUser(
      {required String nickname,
      required DateTime birthdate,
      required Gender gender,
      required String image}) async {
    try {
      await _dataSource.cacheUser(
          nickname: nickname,
          birthdate: birthdate,
          gender: gender,
          image: image);
      return const Right(null);
    } on APIException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      throw Left(CacheFailure(message: e.toString(), statusCode: 505));
    }
  }

  @override
  FutureResult<bool> checkIfUserFirstTime() async {
    try {
      final result = await _dataSource.checkIfUserIsFirstTime();
      return Right(result);
    } on APIException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      throw Left(CacheFailure(message: e.toString(), statusCode: 505));
    }
  }
}
