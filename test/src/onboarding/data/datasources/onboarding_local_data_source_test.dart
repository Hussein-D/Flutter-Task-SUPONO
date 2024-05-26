import 'package:flutter_task_1/core/enums/gender_enum.dart';
import 'package:flutter_task_1/core/failures/exceptions.dart';
import 'package:flutter_task_1/src/onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late OnboardingLocalDataSource impl;
  late SharedPreferences prefs;
  const tException =
      APIException(message: 'Can not access local storage', statusCode: 505);
  setUp(() {
    prefs = MockSharedPreferences();
    impl = OnboardingLocalDataSrcImp(prefs);
  });

  group('cacheUser', () {
    test('should call [SharedPreferences.setBool] and complete successfully',
        () async {
      when(() => prefs.setBool(any(), any()))
          .thenAnswer((_) async => Future.value(true));
      expect(
          impl.cacheUser(
              nickname: "",
              birthdate: DateTime.now(),
              gender: Gender.MALE,
              image: ""),
          completes);
      verify(() => prefs.setBool(kIsFirstTimeKey, false)).called(1);
      verifyNoMoreInteractions(prefs);
    });
    test('should call [SharedPreferences.setBool] and throw an Exception',
        () async {
      when(() => prefs.setBool(any(), any())).thenThrow(tException);
      expect(
          impl.cacheUser(
              nickname: "",
              birthdate: DateTime.now(),
              gender: Gender.MALE,
              image: ""),
          throwsA(tException));
      verify(() => prefs.setBool(kIsFirstTimeKey, false)).called(1);
      verifyNoMoreInteractions(prefs);
    });
  });
  group('checkIfUserIsFirstTime', () {
    test('should call [SharedPreferences.getBool] and return the right data',
        () async {
      when(() => prefs.getBool(any())).thenAnswer((_) => true);
      final result = await impl.checkIfUserIsFirstTime();
      expect(result, true);
      verify(() => prefs.getBool(kIsFirstTimeKey)).called(1);
      verifyNoMoreInteractions(prefs);
    });
    test('should call [SharedPreferences.getBool] and throw an Exception',
        () async {
      when(() => prefs.getBool(any())).thenThrow(tException);
      expect(impl.checkIfUserIsFirstTime(), throwsA(isA<APIException>()));
      verify(() => prefs.getBool(kIsFirstTimeKey)).called(1);
      verifyNoMoreInteractions(prefs);
    });
  });
}
