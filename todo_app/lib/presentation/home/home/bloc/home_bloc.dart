import 'package:domain/domain_ex.dart';
import 'package:todo_app/presentation/home/home/bloc/home_event.dart';
import 'package:todo_app/presentation/home/home/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/service_logger.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(super.initialState) {
    Log.dx(this, "HomeBloc - initialState");
    on<AddTaskEvent>(_onAddTaskEvent);
  }

  Future<void> _onAddTaskEvent(
      AddTaskEvent event, Emitter<HomeState> emit) async {
    Log.dx(this, "_onAddTaskEvent - start=${event.taskUi}");
    emit(LoadingState());
    await AddTask().addTask(event.taskUi);
    emit(LoadedState());
    Log.dx(this, "_onAddTaskEvent - end");
  }
}
