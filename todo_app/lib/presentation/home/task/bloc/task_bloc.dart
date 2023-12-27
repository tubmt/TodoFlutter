import 'package:domain/domain_ex.dart';
import 'package:todo_app/presentation/home/task/bloc/task_event.dart';
import 'package:todo_app/presentation/home/task/bloc/task_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/service_logger.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final tag = 'TaskBloc';

  TaskBloc(super.initialState) {
    on<GetTaskEvent>(_onGetTaskEvent);
    on<GetTaskStreamEvent>(_onGetTaskStreamEvent);
    on<CompletedTaskEvent>(_onCompletedTaskEvent);
    on<DeleteTaskEvent>(_onDeleteTaskEvent);
  }

  Future<void> _onGetTaskEvent(
      GetTaskEvent event, Emitter<TaskState> emit) async {
    Log.d(tag, "_onGetTaskEvent - start=$event");
    emit(LoadingState());
    Log.d(tag, "_onGetTaskEvent - running use-case");
    GetAllTasks().getTaskUis().listen((taskUis) {
      Log.d(tag, "_onGetTaskEvent - hash=${taskUis.hashCode}, listen=$taskUis");
      add(GetTaskStreamEvent(taskUis));
    });
    Log.d(tag, "_onGetTaskEvent - end");
  }

  Future<void> _onGetTaskStreamEvent(
      GetTaskStreamEvent event, Emitter<TaskState> emit) async {
    Log.d(tag, "_onGetTaskStreamEvent - start=$event");
    emit(LoadedState(event.taskUis));
    Log.d(tag, "_onGetTaskStreamEvent - end");
  }

  Future<void> _onCompletedTaskEvent(
      CompletedTaskEvent event, Emitter<TaskState> emit) async {
    Log.d(tag, "_onCompletedTaskEvent - start=${event.taskId}");
    await UpdateTask().updateTask(event.taskId, event.isCompleted);
    Log.d(tag, "_onCompletedTaskEvent - end");
  }

  Future<void> _onDeleteTaskEvent(
      DeleteTaskEvent event, Emitter<TaskState> emit) async {
    Log.d(tag, "_onDeleteTaskEvent - start=${event.taskId}");
    await DeleteTask().deleteTask(event.taskId);
    Log.d(tag, "_onDeleteTaskEvent - end");
  }
}
