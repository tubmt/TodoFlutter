import 'package:data/local/dao/task_database.dart';
import 'package:data/local/sources/task_local.dart';
import 'package:data/remote/sources/task_remote.dart';
import 'package:data/repository/task_repository.dart';
import 'package:get_it/get_it.dart';

class ServiceLocator {
  void init() {
    GetIt getIt = GetIt.instance;
    // Register data base
    getIt.registerLazySingleton<TaskDatabase>(() => TaskDatabase());

    // Register data sources
    getIt.registerLazySingleton<TaskLocal>(() => TaskLocal());
    getIt.registerLazySingleton<TaskRemote>(() => TaskRemote());

    // Register repository
    getIt.registerLazySingleton<TaskRepository>(() => TaskRepository());

  }
}
