import 'package:domain/domain_ex.dart';
import 'package:todo_app/presentation/home/stats/bloc/stats_event.dart';
import 'package:todo_app/presentation/home/stats/bloc/stats_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/service_logger.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final tag = "StatsBloc";

  StatsBloc(super.initialState) {
    Log.d(tag, "StatsBloc");
    on<GetStatsEvent>(_onGetStatsEvent);
    on<GetStatsStreamEvent>(_onGetStatsStreamEvent);
  }

  Future<void> _onGetStatsEvent(
      GetStatsEvent event, Emitter<StatsState> emit) async {
    Log.d(tag, "_onGetStatsEvent - start=$event");
    emit(LoadingState());
    Log.d(tag, "_onGetTaskEvent - getTaskUis use-case");
    GetAllTasks().getTaskUis().listen((event) {
      add(GetStatsStreamEvent(event));
    });
    Log.d(tag, "_onGetTaskEvent - end");
  }

  Future<void> _onGetStatsStreamEvent(
      GetStatsStreamEvent event, Emitter<StatsState> emit) async {
    Log.d(tag, "_onGetStatsStreamEvent - start=$event");
    emit(LoadedState(StatsUi.fromTask(event.taskUis)));
    Log.d(tag, "_onGetStatsStreamEvent - end");
  }
}
