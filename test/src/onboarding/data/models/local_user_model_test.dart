import 'dart:convert';

import 'package:flutter_task_1/core/typedefs/typedefs.dart';
import 'package:flutter_task_1/src/onboarding/data/models/local_user_model.dart';
import 'package:flutter_task_1/src/onboarding/domain/entities/local_user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  // setUp(() {});

  final tUserModel = LocalUserModel.empty();
  test('is [LocalUserModel] a subtype of [LocalUser]', () {
    expect(tUserModel, isA<LocalUser>());
  });
  group('fromMap', () {
    DataMap map = jsonDecode(fixtureRead('user.json'));
    test('should return a [LocalUserModel]', () {
      final tuser = LocalUserModel.fromMap(map);
      expect(tuser, isA<LocalUser>());
    });

    test('should throw an error', () {
      DataMap modifiedMap = map..remove("nickname");
      expect(() => LocalUserModel.fromMap(modifiedMap), throwsA(isA<Error>()));
    });
  });
  group('toMap', () {
    test('should return a map', () {
      final tMap = tUserModel.toMap();
      expect(tMap, isA<DataMap>());
    });
  });
  group('toJson', () {
    test('should return a json', () {
      final tJson = tUserModel.toJson();
      expect(tJson, isA<String>());
    });
  });
  group('fromJson', () {
    test('should return a [LocalUserModel]', () {
      expect(LocalUserModel.fromJson(fixtureRead('user.json')),
          isA<LocalUserModel>());
    });
  });
  group('copyWith', () {
    test('should return a new [LocalUserModel] with updated value', () {
      final tUser = LocalUserModel.empty();
      final updatedUser = tUser.copyWith(nickname: "my new name");
      expect(updatedUser.nickname,
          "my new name");
    });
  });
}
