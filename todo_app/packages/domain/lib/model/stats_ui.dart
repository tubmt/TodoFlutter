import 'package:domain/model/task_ui.dart';

class StatsUi {
  final int _completedCount;
  final int _activeCount;

  StatsUi(this._completedCount, this._activeCount);

  int get completedCount => _completedCount;

  int get activeCount => _activeCount;

  factory StatsUi.fromTask(List<TaskUi> tasks) {
    int total = tasks.length;
    int completed = tasks.where((e) => e.isCompleted).toList().length;

    return StatsUi(completed, total - completed);
  }
}
