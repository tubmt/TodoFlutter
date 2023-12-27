import 'package:domain/domain_ex.dart';

sealed class TaskEvent {}

class GetTaskEvent extends TaskEvent {}

class GetTaskStreamEvent extends TaskEvent {
  final List<TaskUi> _taskUis;

  List<TaskUi> get taskUis => _taskUis;

  GetTaskStreamEvent(this._taskUis);
}

class CompletedTaskEvent extends TaskEvent {
  final int _taskId;

  int get taskId => _taskId;

  CompletedTaskEvent(this._taskId, this.isCompleted);

  final bool isCompleted;
}

class DeleteTaskEvent extends TaskEvent {
  final int _taskId;

  int get taskId => _taskId;

  DeleteTaskEvent(this._taskId);
}
