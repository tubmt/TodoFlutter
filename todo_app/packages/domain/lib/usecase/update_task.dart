import 'package:data/repository/task_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/service_logger.dart';

class UpdateTask {
  final TaskRepository repository = GetIt.I.get<TaskRepository>();

  final tag = 'UpdateTask';

  Future<void> updateTask(int id, bool isCompleted) async {
    Log.d(tag, 'updateTask - repository=${repository.hashCode}');
    var task = await repository.getTask(id);
    task.isCompleted = isCompleted;
    Log.d(tag, 'updateTask - id=$id, task=$task');
    await repository.updateTask(task);
  }
}
