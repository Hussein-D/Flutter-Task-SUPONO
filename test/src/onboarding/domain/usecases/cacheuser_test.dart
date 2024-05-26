import 'package:dartz/dartz.dart';
import 'package:flutter_task_1/core/enums/gender_enum.dart';
import 'package:flutter_task_1/core/failures/failure.dart';
import 'package:flutter_task_1/src/onboarding/domain/repos/onboarding_repo.dart';
import 'package:flutter_task_1/src/onboarding/domain/usecases/cacheuser.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'onboarding_repo.mock.dart';

void main() {
  late OnboardingRepo repo;
  late CacheUser usecase;
  final tParams = CacheUserParams.empty();
  const tFailure = CacheFailure(
      message: 'Can not store data in local storage', statusCode: 505);
  setUp(() {
    repo = MockOnboardingRepo();
    usecase = CacheUser(repo);
    registerFallbackValue(DateTime);
    registerFallbackValue(Gender);
  });

  group('cacheUser', () {
    test('should call [OnboardingRepo.cacheUser] and complete successfully ',
        () async {
      when(
        () => repo.cacheUser(
            nickname: any(named: "nickname"),
            birthdate: any(named: "birthdate"),
            gender: tParams.gender,
            image: tParams.image),
      ).thenAnswer((_) async => const Right(null));
      await usecase(tParams);
      verify(() => repo.cacheUser(
          nickname: tParams.nickname,
          birthdate: tParams.birthdate,
          gender: tParams.gender,
          image: tParams.image)).called(1);
      verifyNoMoreInteractions(repo);
    });
    test('should call [OnboardingRepo.cacheUser] and return a failure',
        () async {
      when(
        () => repo.cacheUser(
            nickname: any(named: "nickname"),
            birthdate: any(named: "birthdate"),
            gender: tParams.gender,
            image: tParams.image),
      ).thenAnswer((_) async => const Left(tFailure));
      await usecase(tParams);
      verify(() => repo.cacheUser(
          nickname: tParams.nickname,
          birthdate: tParams.birthdate,
          gender: tParams.gender,
          image: tParams.image)).called(1);
      verifyNoMoreInteractions(repo);
    });
  });
}
