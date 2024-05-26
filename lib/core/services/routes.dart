import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_1/core/common/views/page_under_construction.dart';
import 'package:flutter_task_1/core/services/dependency_inversion.dart';
import 'package:flutter_task_1/src/home/presentation/bloc/home_screen_bloc.dart';
import 'package:flutter_task_1/src/home/presentation/views/home_screen.dart';
import 'package:flutter_task_1/src/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:flutter_task_1/src/onboarding/presentation/views/onboarding_screen.dart';
import 'package:flutter_task_1/src/settings/presentation/views/settings_screen.dart';

Route<dynamic> generateRouter(RouteSettings settings) {
  switch (settings.name) {
    case SettingsScreen.route:
      return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, animation, __) => FadeTransition(
                opacity: animation,
                child: const SettingsScreen(),
              ));
    case HomeScreen.route:
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (_, animation, __) => FadeTransition(
          opacity: animation,
          child: BlocProvider(
            create: (context) => sl<HomeScreenBloc>(),
            child: const HomeScreen(),
          ),
        ),
      );
    case OnboardingScreen.route:
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (_, animation, __) => FadeTransition(
          opacity: animation,
          child: BlocProvider(
            create: (context) => sl<OnboardingBloc>(),
            child: const OnboardingScreen(),
          ),
        ),
      );
    default:
      return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, animation, __) => const PageUnderConstruction());
  }
}
