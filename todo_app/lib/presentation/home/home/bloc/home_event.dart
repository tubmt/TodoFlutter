import 'package:domain/domain_ex.dart';

sealed class HomeEvent {}

class AddTaskEvent extends HomeEvent {
  final TaskUi _taskUi;

  TaskUi get taskUi => _taskUi;

  AddTaskEvent(this._taskUi);
}
