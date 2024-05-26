part of 'onboarding_bloc.dart';

sealed class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object> get props => [];
}

final class OnboardingInitial extends OnboardingState {}

class CheckingIfUserFirstTime extends OnboardingState {}

class CachingUser extends OnboardingState {}

class UserChecked extends OnboardingState {
  final bool isFirstTime;
  const UserChecked({required this.isFirstTime});
}

class UserCached extends OnboardingState {}

class OnboardingError extends OnboardingState {}
