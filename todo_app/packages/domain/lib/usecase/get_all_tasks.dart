import 'package:data/repository/task_repository.dart';
import 'package:domain/model/task_ui.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/service_logger.dart';

class GetAllTasks {
  final TaskRepository repository = GetIt.I.get<TaskRepository>();

  Stream<List<TaskUi>> getTaskUis() {
    Log.dx(this, 'getTaskUis - repository=${repository.hashCode}');
    var result = repository.getTasks().asyncMap((tasks) {
      Log.d('GetAllTasks', 'getTaskUis - onDataChanged=$tasks');
      return tasks
          .map((e) => TaskUi(e.id, e.title, e.description, e.isCompleted))
          .toList();
    });
    Log.d('GetAllTasks', 'getTaskUis - result=$result');
    return result;
  }
}
