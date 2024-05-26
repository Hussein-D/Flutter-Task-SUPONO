
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_task_1/src/home/domain/usecases/fetch_user_usecase.dart';
import 'package:flutter_task_1/src/onboarding/data/models/local_user_model.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc({required FetchUser fetchUser})
      : _fetchUser = fetchUser,
        super(HomeScreenInitial()) {
    on<LoadHomeScreenEvent>(_loadHomeScreenEventHandler);
  }
  Future<void> _loadHomeScreenEventHandler(
      LoadHomeScreenEvent event, Emitter<HomeScreenState> emit) async {
    emit(HomeScreenLoading());
    final result = await _fetchUser();
    result.fold(
        (l) => emit(HomeScreenError()), (r) => emit(HomeScreenLoaded(user: r)));
  }

  final FetchUser _fetchUser;
}
