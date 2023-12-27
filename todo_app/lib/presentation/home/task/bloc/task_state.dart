import 'package:domain/domain_ex.dart';

sealed class TaskState {}

class LoadingState extends TaskState {}

class LoadedState extends TaskState {
  final List<TaskUi> _tasks;

  LoadedState(this._tasks);

  List<TaskUi> get tasks => _tasks;
}