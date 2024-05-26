import 'package:equatable/equatable.dart';
import 'package:flutter_task_1/core/enums/gender_enum.dart';

class LocalUser extends Equatable {
  const LocalUser(
      {required this.nickname,
      required this.birthdate,
      required this.gender,
      required this.image,
      this.subscribed = false});

  LocalUser.empty()
      : this(
            nickname: "",
            birthdate: DateTime.now(),
            gender: Gender.MALE,
            image: "");
  final String nickname;
  final DateTime birthdate;
  final Gender gender;
  final String image;
  final bool? subscribed;
  @override
  List<Object?> get props => [nickname, birthdate, gender];
}
