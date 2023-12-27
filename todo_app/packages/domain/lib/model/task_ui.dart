import 'package:data/local/models/task.dart';

class TaskUi {
  final int _id;
  final String title;
  var description = "";
  var isCompleted = false;

  TaskUi(this._id, this.title, this.description, this.isCompleted);

  int get id => _id;

  Task toTask() {
    return Task(title, description, isCompleted);
  }

  factory TaskUi.fromTask(Task task) {
    return TaskUi(task.id, task.title, task.description, task.isCompleted);
  }

  @override
  String toString() {
    return 'TaskUi{_id: $_id, title: $title, isCompleted: $isCompleted}';
  }
}
