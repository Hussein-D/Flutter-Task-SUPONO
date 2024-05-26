import 'package:dartz/dartz.dart';
import 'package:flutter_task_1/core/failures/failure.dart';
import 'package:flutter_task_1/src/onboarding/domain/repos/onboarding_repo.dart';
import 'package:flutter_task_1/src/onboarding/domain/usecases/check_if_user_first_time.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'onboarding_repo.mock.dart';

void main() {
  late OnboardingRepo repo;
  late CheckIfUserFirstTime usecase;
  const tFailure = CacheFailure(
      message: 'No access permission to local storage', statusCode: 505);
  setUp(() {
    repo = MockOnboardingRepo();
    usecase = CheckIfUserFirstTime(repo);
  });
  group('checkIfUserFirstTime', () {
    test(
        'should call [OnboardingRepo.checkIfUserFirstTime] method and return the right data',
        () async {
      // Arrange
      when(() => repo.checkIfUserFirstTime())
          .thenAnswer((_) async => const Right(true));

      //Act
      final result = await usecase();

      //Assert
      expect(result, equals(const Right(true)));
      verify(() => repo.checkIfUserFirstTime()).called(1);
      verifyNoMoreInteractions(repo);
    });
    test(
        'should call [OnboardingRepo.checkIfUserFirstTime] method and throw an error',
        () async {
      // Arrange
      when(() => repo.checkIfUserFirstTime())
          .thenAnswer((_) async => const Left(tFailure));

      //Act
      final result = await usecase();

      //Assert
      expect(result, equals(const Left(tFailure)));
      verify(() => repo.checkIfUserFirstTime()).called(1);
      verifyNoMoreInteractions(repo);
    });
  });
}
