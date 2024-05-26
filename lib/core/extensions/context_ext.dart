import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_1/core/app/providers/app_provider.dart';
import 'package:flutter_task_1/src/home/presentation/bloc/home_screen_bloc.dart';
import 'package:flutter_task_1/src/onboarding/presentation/bloc/onboarding_bloc.dart';

extension ContextExt on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get size => mediaQuery.size;
  double get height => size.height;
  double get width => size.width;
  OnboardingBloc get onBoardingBloc => read<OnboardingBloc>();
  HomeScreenBloc get homeBloc => read<HomeScreenBloc>();
  AppProvider get appProvider => read<AppProvider>();
  ThemeData get themeData => Theme.of(this);
  TextTheme get textTheme => themeData.textTheme;
}
