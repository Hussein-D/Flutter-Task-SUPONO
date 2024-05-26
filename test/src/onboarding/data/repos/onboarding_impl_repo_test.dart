import 'package:dartz/dartz.dart';
import 'package:flutter_task_1/core/enums/gender_enum.dart';
import 'package:flutter_task_1/core/failures/exceptions.dart';
import 'package:flutter_task_1/core/failures/failure.dart';
import 'package:flutter_task_1/src/onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:flutter_task_1/src/onboarding/data/models/local_user_model.dart';
import 'package:flutter_task_1/src/onboarding/data/repos/onboarding_impl_repo.dart';
import 'package:flutter_task_1/src/onboarding/domain/repos/onboarding_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOnboardingLocalDataSource extends Mock
    implements OnboardingLocalDataSource {}

void main() {
  late OnboardingLocalDataSource dataSource;
  late OnboardingRepo repo;
  final tUser = LocalUserModel.empty();
  const tException =
      APIException(message: 'An error has occured', statusCode: 505);
  setUp(() {
    dataSource = MockOnboardingLocalDataSource();
    repo = OnboardingRepoImpl(dataSource);
    registerFallbackValue(DateTime);
  });
  group('cacheUser', () {
    test(
        'should call [OnboardingDataSource.cacheUser] method and complete successfully',
        () async {
      when(() => dataSource.cacheUser(
          nickname: any(named: "nickname"),
          birthdate: any(named: "birthdate"),
          gender: Gender.MALE,
          image: any(named: "image"))).thenAnswer((_) async => Future.value());
      final result = await repo.cacheUser(
          nickname: tUser.nickname,
          birthdate: tUser.birthdate,
          gender: tUser.gender,
          image: tUser.image);
      expect(result, const Right(null));
      verify(() => dataSource.cacheUser(
          nickname: tUser.nickname,
          birthdate: tUser.birthdate,
          gender: tUser.gender,
          image: tUser.image)).called(1);
      verifyNoMoreInteractions(dataSource);
    });
    test(
        'should call [OnboardingDataSource.cacheUser] method and throw an Exception',
        () async {
      when(() => dataSource.cacheUser(
          nickname: any(named: "nickname"),
          birthdate: any(named: "birthdate"),
          gender: Gender.MALE,
          image: any(named: "image"))).thenThrow(tException);
      final result = await repo.cacheUser(
          nickname: tUser.nickname,
          birthdate: tUser.birthdate,
          gender: tUser.gender,
          image: tUser.image);
      expect(
          result,
          equals(const Left<Failure, void>(
              CacheFailure(message: "An error has occured", statusCode: 505))));
      verify(() => dataSource.cacheUser(
          nickname: tUser.nickname,
          birthdate: tUser.birthdate,
          gender: tUser.gender,
          image: tUser.image)).called(1);
      verifyNoMoreInteractions(dataSource);
    });
  });
}
