import 'package:todo_app/presentation/home/stats/bloc/stats_bloc.dart';
import 'package:todo_app/presentation/home/stats/bloc/stats_event.dart';
import 'package:todo_app/presentation/home/stats/bloc/stats_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/service_logger.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => StatsBloc(LoadingState())..add(GetStatsEvent()),
        child: _StatsWidget());
  }
}

class _StatsWidget extends StatelessWidget {
  final tag = "_StatsWidget";

  @override
  Widget build(BuildContext context) {
    Log.d(tag, "build");
    return BlocBuilder<StatsBloc, StatsState>(
      builder: (context, state) {
        Log.d(tag, "build - state=$state");
        switch (state) {
          case LoadingState():
            return const Center(child: CupertinoActivityIndicator());
          case LoadedState():
            return buildStats(context, state);
        }
      },
    );
  }

  Widget buildStats(BuildContext context, LoadedState state) {
    Log.d(tag, "buildStats - state=$state");
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 0, right: 20, bottom: 0),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.titleMedium,
                "Completed Task"),
            Text(
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.titleLarge,
                "${state.statsUi.completedCount}"),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.titleMedium,
                "Active Task"),
            Text(
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.titleLarge,
                "${state.statsUi.activeCount}"),
          ]),
        ],
      ),
    );
  }
}
