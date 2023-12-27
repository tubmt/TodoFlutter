import 'package:data/local/models/task.dart';
import 'package:data/source/task_data_source.dart';
import 'package:logger/service_logger.dart';

class TaskRemote implements TaskDataSource {
  TaskRemote() {
    Log.d(tag, 'TaskRemote - hash=$this');
  }

  final tag = 'TaskRemote';

  @override
  Future<void> deleteTask(int id) {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }

  @override
  Future<Task> getTask(int id) {
    // TODO: implement getTask
    throw UnimplementedError();
  }

  @override
  Stream<List<Task>> getTasks() {
    // TODO: implement getTasks
    throw UnimplementedError();
  }

  @override
  Future<void> insertTask(Task task) {
    // TODO: implement insertTask
    throw UnimplementedError();
  }

  @override
  Future<void> updateTask(Task task) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }
}
