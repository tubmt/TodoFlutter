import 'package:domain/domain_ex.dart';

sealed class StatsState {}

class LoadingState extends StatsState {}

class LoadedState extends StatsState {
  final StatsUi _statsUi;

  LoadedState(this._statsUi);

  StatsUi get statsUi => _statsUi;
}
