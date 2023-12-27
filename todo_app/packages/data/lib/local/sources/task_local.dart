import 'dart:async';
import 'dart:developer';

import 'package:data/local/dao/task_database.dart';
import 'package:data/local/models/task.dart';
import 'package:data/source/task_data_source.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/service_logger.dart';

class TaskLocal implements TaskDataSource {
  final TaskDatabase _database = GetIt.I.get<TaskDatabase>();

  TaskLocal() {
    Log.d(tag, 'TaskLocal - hash=$this');
    _init();
  }

  final tag = 'TaskLocal';

  final _streamController = StreamController<List<Task>>.broadcast();
  List<Task> _localTasks = [];

  void _init() async {
    _localTasks = await _database.getTasks();
    _streamController.add(_localTasks);
  }

  @override
  Future<Task> getTask(int id) {
    return _database.getTask(id);
  }

  @override
  Stream<List<Task>> getTasks() {
    log("TaskLocal - getTasks");
    return _streamController.stream;
  }

  @override
  Future<void> insertTask(Task task) async {
    Log.d(tag, 'insertTask - task=$task');
    _localTasks.add(task);
    Log.d(tag, 'insertTask - size=$_localTasks');
    _streamController.add(_localTasks);
    return _database.insertTask(task);
  }

  @override
  Future<void> updateTask(Task task) async {
    Log.d(tag, 'updateTask - task=$task');
    int index = _localTasks.indexWhere((element) => element.id == task.id);
    Log.d(tag, 'updateTask - index=$index');
    _localTasks[index] = task;
    _streamController.add(_localTasks);
    return _database.updateTask(task);
  }

  @override
  Future<void> deleteTask(int id) async {
    Log.d(tag, 'deleteTask - id=$id');
    _localTasks.removeWhere((element) => element.id == id);
    Log.d(tag, 'deleteTask - size=${_localTasks.length}');
    _streamController.add(_localTasks);
    return _database.deleteTask(id);
  }
}
