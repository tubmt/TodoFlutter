import 'package:data/local/models/task.dart';

abstract class TaskDataSource {
  Stream<List<Task>> getTasks();

  Future<Task> getTask(int id);

  Future<void> insertTask(Task task);

  Future<void> updateTask(Task task);

  Future<void> deleteTask(int id);
}
