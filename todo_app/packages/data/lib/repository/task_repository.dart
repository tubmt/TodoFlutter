import 'package:data/local/models/task.dart';
import 'package:data/local/sources/task_local.dart';
import 'package:data/remote/sources/task_remote.dart';
import 'package:data/source/task_data_source.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/service_logger.dart';

class TaskRepository extends TaskDataSource {
  late final TaskDataSource _taskLocal = GetIt.I.get<TaskLocal>();
  late final TaskDataSource _taskRemote = GetIt.I.get<TaskRemote>();

  final tag = 'TaskRepository';

  TaskRepository() {
    Log.d("TaskRepository",
        'TaskRepository - init -- hash=$hashCode, local=${_taskLocal.hashCode}, remote=${_taskRemote.hashCode}');
  }

  @override
  Future<void> deleteTask(int id) async {
    _taskLocal.deleteTask(id);
  }

  @override
  Future<Task> getTask(int id) {
    Log.d(tag, "getTask - local=${_taskLocal.hashCode}");
    return _taskLocal.getTask(id);
  }

  @override
  Stream<List<Task>> getTasks() {
    Log.d(tag, "getTasks - local=${_taskLocal.hashCode}");
    return _taskLocal.getTasks();
  }

  @override
  Future<void> insertTask(Task task) async {
    Log.d(tag, "insertTask - local=${_taskLocal.hashCode}");
    _taskLocal.insertTask(task);
  }

  @override
  Future<void> updateTask(Task task) async {
    Log.d(tag, "updateTask - task=$task - local=${_taskLocal.hashCode}");
    _taskLocal.updateTask(task);
  }
}
