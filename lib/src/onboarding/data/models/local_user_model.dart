import 'dart:convert';

import 'package:flutter_task_1/core/enums/gender_enum.dart';
import 'package:flutter_task_1/core/typedefs/typedefs.dart';
import 'package:flutter_task_1/src/onboarding/domain/entities/local_user.dart';

class LocalUserModel extends LocalUser {
  const LocalUserModel(
      {required super.nickname,
      required super.birthdate,
      required super.gender,
      required super.image,
      super.subscribed = false});

  LocalUserModel.empty()
      : this(
            nickname: "empty.nickname",
            birthdate: DateTime.now(),
            gender: Gender.MALE,
            image: "empty.image");

  LocalUserModel.fromMap(DataMap map)
      : this(
            nickname: map["nickname"],
            birthdate: map["birthdate"].runtimeType == String
                ? DateTime.parse(map["birthdate"])
                : map["birthdate"],
            gender: fromIntToGenderEnum(int.parse(map["gender"])),
            image: map["image"],
            subscribed: map["subscribed"]);

  LocalUserModel.fromJson(String json) : this.fromMap(jsonDecode(json));

  String toJson() => jsonEncode(toMap());

  DataMap toMap() => {
        'nickname': nickname,
        'birthdate': birthdate.toString(),
        'gender': fromGenderEnumToString(gender),
        'image': image,
        'subscribed': subscribed
      };

  LocalUserModel copyWith({
    String? nickname,
    DateTime? birthdate,
    Gender? gender,
    String? image,
    bool? subscribed,
  }) {
    return LocalUserModel(
        nickname: nickname ?? this.nickname,
        birthdate: birthdate ?? this.birthdate,
        gender: gender ?? this.gender,
        image: image ?? this.image,
        subscribed: subscribed ?? this.subscribed);
  }
  @override
  List<Object?> get props => [nickname, birthdate, gender];
}
