import 'package:flutter_task_1/src/home/data/home_local_data_source.dart/home_local_data_source.dart';
import 'package:flutter_task_1/src/home/data/repos/home_repo_impl.dart';
import 'package:flutter_task_1/src/home/domain/repos/home_repo.dart';
import 'package:flutter_task_1/src/home/domain/usecases/fetch_user_usecase.dart';
import 'package:flutter_task_1/src/home/presentation/bloc/home_screen_bloc.dart';
import 'package:flutter_task_1/src/onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:flutter_task_1/src/onboarding/data/repos/onboarding_impl_repo.dart';
import 'package:flutter_task_1/src/onboarding/domain/repos/onboarding_repo.dart';
import 'package:flutter_task_1/src/onboarding/domain/usecases/cacheuser.dart';
import 'package:flutter_task_1/src/onboarding/domain/usecases/check_if_user_first_time.dart';
import 'package:flutter_task_1/src/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  await registerOnboardingDependency();
  await registerHomeDependency();
}

Future<void> registerOnboardingDependency() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  sl
    ..registerFactory(() => OnboardingBloc(
        checkIfUserFirstTimeUsecase: sl(), cacheUserUsecase: sl()))
    ..registerLazySingleton<CheckIfUserFirstTime>(
        () => CheckIfUserFirstTime(sl()))
    ..registerLazySingleton<CacheUser>(() => CacheUser(sl()))
    ..registerLazySingleton<OnboardingRepo>(() => OnboardingRepoImpl(sl()))
    ..registerLazySingleton<OnboardingLocalDataSource>(
        () => OnboardingLocalDataSrcImp(sl()))
    ..registerLazySingleton<SharedPreferences>(() => prefs);
}

Future<void> registerHomeDependency() async {
  sl
    ..registerFactory(() => HomeScreenBloc(fetchUser: sl()))
    ..registerLazySingleton<FetchUser>(() => FetchUser(sl()))
    ..registerLazySingleton<HomeRepo>(() => HomeRepoImpl(sl()))
    ..registerLazySingleton<HomeRepoLocalDataSouce>(
        () => HomeRepoLocalDataSrcImpl(sl()));
}
