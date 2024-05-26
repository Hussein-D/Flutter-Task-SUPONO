import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_task_1/core/enums/gender_enum.dart';
import 'package:flutter_task_1/src/onboarding/domain/usecases/cacheuser.dart';
import 'package:flutter_task_1/src/onboarding/domain/usecases/check_if_user_first_time.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc(
      {required CheckIfUserFirstTime checkIfUserFirstTimeUsecase,
      required CacheUser cacheUserUsecase})
      : _checkIfUserFirstTime = checkIfUserFirstTimeUsecase,
        _cacheUser = cacheUserUsecase,
        super(OnboardingInitial()) {
    on<CheckIfUserFirstTimeEvent>(_checkIfUserFirstTimeHandler);
    on<CacheUserEvent>(_cacheUserHandler);
  }
  Future<void> _checkIfUserFirstTimeHandler(
      CheckIfUserFirstTimeEvent event, Emitter<OnboardingState> emit) async {
    emit(CheckingIfUserFirstTime());
    final result = await _checkIfUserFirstTime();
    result.fold((l) => emit(OnboardingError()),
        (r) => emit(UserChecked(isFirstTime: r)));
  }

  Future<void> _cacheUserHandler(
      CacheUserEvent event, Emitter<OnboardingState> emit) async {
    emit(CachingUser());
    CacheUserParams params = CacheUserParams(
        nickname: event.nickname,
        birthdate: event.birthdate,
        gender: event.gender,
        image: event.image);
    final result = await _cacheUser(params);
    result.fold((l) => emit(OnboardingError()), (r) => emit(UserCached()));
  }

  final CheckIfUserFirstTime _checkIfUserFirstTime;
  final CacheUser _cacheUser;
}
