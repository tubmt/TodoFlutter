import 'package:domain/domain_ex.dart';

sealed class StatsEvent {}

class GetStatsEvent extends StatsEvent {}

class GetStatsStreamEvent extends StatsEvent {
  final List<TaskUi> _taskUis;

  List<TaskUi> get taskUis => _taskUis;

  GetStatsStreamEvent(this._taskUis);
}
