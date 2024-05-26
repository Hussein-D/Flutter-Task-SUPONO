part of 'onboarding_bloc.dart';

sealed class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object> get props => [];
}

class CheckIfUserFirstTimeEvent extends OnboardingEvent {}

class CacheUserEvent extends OnboardingEvent {
  final String nickname;
  final DateTime birthdate;
  final Gender gender;
  final String image;
  const CacheUserEvent(
      {required this.birthdate,
      required this.gender,
      required this.nickname,
      required this.image});
}
