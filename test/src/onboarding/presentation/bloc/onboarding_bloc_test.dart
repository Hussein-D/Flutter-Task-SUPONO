import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_task_1/core/enums/gender_enum.dart';
import 'package:flutter_task_1/core/failures/failure.dart';
import 'package:flutter_task_1/src/onboarding/domain/usecases/cacheuser.dart';
import 'package:flutter_task_1/src/onboarding/domain/usecases/check_if_user_first_time.dart';
import 'package:flutter_task_1/src/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCheckIfUserFirstTime extends Mock implements CheckIfUserFirstTime {}

class MockCacheUser extends Mock implements CacheUser {}

void main() {
  late OnboardingBloc bloc;
  late CheckIfUserFirstTime checkIfUserFirstTimeUsecase;
  late CacheUser cacheUserUsecase;
  final CacheUserParams tParams = CacheUserParams(
      nickname: "empty.name",
      birthdate: DateTime.now(),
      gender: Gender.MALE,
      image: "empty.image");
  setUp(() {
    checkIfUserFirstTimeUsecase = MockCheckIfUserFirstTime();
    cacheUserUsecase = MockCacheUser();
    bloc = OnboardingBloc(
        checkIfUserFirstTimeUsecase: checkIfUserFirstTimeUsecase,
        cacheUserUsecase: cacheUserUsecase);
  });
  test('is initial state of bloc [OnboardingInitial]', () {
    expect(bloc.state, OnboardingInitial());
  });
  group('checkUser', () {
    blocTest<OnboardingBloc, OnboardingState>(
        'should emit [CheckingIfUserFirstTime , UserChecked]',
        build: () {
          when(() => checkIfUserFirstTimeUsecase())
              .thenAnswer((_) async => const Right(true));
          return bloc;
        },
        act: (bloc) {
          bloc.add(CheckIfUserFirstTimeEvent());
        },
        expect: () =>
            [CheckingIfUserFirstTime(), const UserChecked(isFirstTime: true)]);
    blocTest<OnboardingBloc, OnboardingState>(
        'should emit [CheckingIfUserFirstTime , OnboardingError]',
        build: () {
          when(() => checkIfUserFirstTimeUsecase()).thenAnswer((_) async =>
              const Left(CacheFailure(
                  message: "Error accessing local storage", statusCode: 505)));
          return bloc;
        },
        act: (bloc) {
          bloc.add(CheckIfUserFirstTimeEvent());
        },
        expect: () => [CheckingIfUserFirstTime(), OnboardingError()]);
  });
  group('cacheUser', () {
    blocTest<OnboardingBloc, OnboardingState>(
        'should emit [CachingUser , UserCached]',
        build: () {
          when(() => cacheUserUsecase(tParams))
              .thenAnswer((_) async => const Right(null));
          return bloc;
        },
        act: (bloc) {
          bloc.add(CacheUserEvent(
              nickname: tParams.nickname,
              birthdate: tParams.birthdate,
              gender: tParams.gender,
              image: tParams.image));
        },
        expect: () => [CachingUser(), UserCached()]);
    blocTest<OnboardingBloc, OnboardingState>(
        'should emit [CachingUser , OnboardingError]',
        build: () {
          when(() => cacheUserUsecase(tParams)).thenAnswer((_) async =>
              const Left(CacheFailure(
                  message: "Error accessing local storage", statusCode: 505)));
          return bloc;
        },
        act: (bloc) {
          bloc.add(CacheUserEvent(
              birthdate: DateTime.now(),
              nickname: "",
              gender: Gender.MALE,
              image: ""));
        },
        expect: () => [CachingUser(), OnboardingError()]);
  });
}
