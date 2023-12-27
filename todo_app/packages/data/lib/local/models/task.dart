import 'package:equatable/equatable.dart';

class Task extends Equatable {
  var _id = 0;
  var title = "";
  var description = "";
  var isCompleted = false;
  var createdAt = DateTime.now().millisecondsSinceEpoch;
  var updatedAt = DateTime.now().millisecondsSinceEpoch;

  static const String tableName = 'Task';
  static const String clId = 'id';
  static const String clTitle = 'title';
  static const String clDescription = 'description';
  static const String clIsComplected = 'isComplected';
  static const String clCreatedAt = 'createdAt';
  static const String clUpdatedAt = 'updatedAt';

  Task(this.title, this.description, this.isCompleted) : super() {
    _id = DateTime.now().millisecondsSinceEpoch;
  }

  @override
  List<Object> get props {
    return [_id, title];
  }

  int get id => _id;

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      clTitle: title,
      clDescription: description,
      clIsComplected: isCompleted == true ? 1 : 0
    };
    if (_id != 0) {
      map[clId] = _id;
    }
    return map;
  }

  Task.fromMap(Map<String, dynamic> map) {
    _id = map[clId];
    title = map[clTitle];
    description = map[clDescription];
    isCompleted = map[clIsComplected] == 1;
  }

  @override
  String toString() {
    return 'Task{_id: $_id, title: $title, isCompleted: $isCompleted}';
  }
}
