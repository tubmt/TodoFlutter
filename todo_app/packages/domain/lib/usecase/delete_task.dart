import 'package:data/repository/task_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/service_logger.dart';

class DeleteTask {
  final TaskRepository repository = GetIt.I.get<TaskRepository>();

  Future<void> deleteTask(int id) async {
    Log.dx(this, 'deleteTask - repository=${repository.hashCode}');
    (await repository.deleteTask(id));
  }
}
