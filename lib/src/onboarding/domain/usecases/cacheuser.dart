import 'package:equatable/equatable.dart';
import 'package:flutter_task_1/core/enums/gender_enum.dart';
import 'package:flutter_task_1/core/typedefs/typedefs.dart';
import 'package:flutter_task_1/core/usecases/usecases.dart';
import 'package:flutter_task_1/src/onboarding/domain/repos/onboarding_repo.dart';

class CacheUser extends UsecaseWithParams<void, CacheUserParams> {
  const CacheUser(this._repo);
  final OnboardingRepo _repo;
  @override
  FutureResult<void> call(CacheUserParams params) async => _repo.cacheUser(
      nickname: params.nickname,
      birthdate: params.birthdate,
      gender: params.gender,
      image: params.image);
}

class CacheUserParams extends Equatable {
  const CacheUserParams(
      {required this.nickname,
      required this.birthdate,
      required this.gender,
      required this.image});
  final String nickname;
  final DateTime birthdate;
  final Gender gender;
  final String image;
  CacheUserParams.empty()
      : this(
            nickname: "",
            birthdate: DateTime.now(),
            gender: Gender.MALE,
            image: "");
  @override
  List<Object?> get props => [];
}
