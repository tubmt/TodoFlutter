import 'package:data/local/models/task.dart';
import 'package:logger/service_logger.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TaskDatabase {
  final tag = 'TaskDatabase';
  final _dbName = 'AppDb';
  final _dbVersion = 1;


  TaskDatabase() {
    Log.d(tag, 'TaskDatabase - hash=$this');
  }

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // Initialize the DB first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Log.d(tag, "_initDatabase");
    final dbRoot = await getDatabasesPath();

    // Set the path to the database. Note: Using the `join` function from the
    // `dbPath` package is best practice to ensure the path is correctly
    // constructed for each platform.
    final dbPath = join(dbRoot, '$_dbName.db');

    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.

    Log.d(tag, "_initDatabase - hash=$hashCode, open=$dbPath, root=$dbRoot");
    return await openDatabase(
      dbPath,
      onCreate: _onCreate,
      version: _dbVersion,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  // When the database is first created, create a table to store breeds
  // and a table to store dogs.
  Future<void> _onCreate(Database db, int version) async {
    // Run the CREATE {breeds} TABLE statement on the database.
    Log.d(tag, "_onCreate");
    await db.execute(
      """CREATE TABLE ${Task.tableName}(
      ${Task.clId} INTEGER PRIMARY KEY, 
      ${Task.clTitle} TEXT, ${Task.clDescription} TEXT, ${Task.clIsComplected} BLOB)""",
    );
  }

  // Define a function that inserts task into the task database
  Future<void> insertTask(Task task) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the Task into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same task is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      Task.tableName,
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the tasks from the task table.
  Future<List<Task>> getTasks() async {
    // Get a reference to the database.
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(Task.tableName);
    return List.generate(maps.length, (index) => Task.fromMap(maps[index]));
  }

  Future<Task> getTask(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db
        .query(Task.tableName, where: '${Task.clId} = ?', whereArgs: [id]);
    return Task.fromMap(maps[0]);
  }

  // A method that updates a task data from the task table.
  Future<void> updateTask(Task task) async {
    // Get a reference to the database.
    final db = await database;
    await db.update(
      Task.tableName,
      task.toMap(),
      where: '${Task.clId} = ?',
      whereArgs: [task.id],
    );
  }

  // A method that deletes a task data from the task table.
  Future<void> deleteTask(int id) async {
    // Get a reference to the database.
    final db = await database;
    await db.delete(
      Task.tableName,
      where: '${Task.clId} = ?',
      whereArgs: [id],
    );
  }
}
