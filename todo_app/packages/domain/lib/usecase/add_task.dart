import 'package:data/repository/task_repository.dart';
import 'package:domain/model/task_ui.dart';
import 'package:logger/service_logger.dart';
import 'package:get_it/get_it.dart';

class AddTask {
  final TaskRepository repository = GetIt.I.get<TaskRepository>();

  Future<void> addTask(TaskUi taskUi) async {
    Log.dx(this, 'addTask - repository=${repository.hashCode}');
    await repository.insertTask(taskUi.toTask());
  }
}
