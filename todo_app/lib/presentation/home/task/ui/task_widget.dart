import 'package:todo_app/presentation/home/task/bloc/task_bloc.dart';
import 'package:todo_app/presentation/home/task/bloc/task_event.dart';
import 'package:todo_app/presentation/home/task/bloc/task_state.dart';
import 'package:todo_app/presentation/home/task/ui/widget/task_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/service_logger.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => TaskBloc(LoadingState())..add(GetTaskEvent()),
        child: const _TaskWidget());
  }
}

class _TaskWidget extends StatelessWidget {
  final tag = "_TaskWidget";

  const _TaskWidget();

  @override
  Widget build(BuildContext context) {
    Log.d(tag, "build");
    return Center(
      child: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          Log.d(tag, "build - state=$state");
          switch (state) {
            case LoadingState():
              return const Center(child: CupertinoActivityIndicator());
            case LoadedState():
              if (state.tasks.isEmpty) {
                return Center(
                  child: Text(
                    'Add New Task',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                );
              } else {
                return buildList(context, state);
              }
          }
        },
      ),
    );
  }

  Widget buildList(BuildContext context, LoadedState state) {
    var tasks = state.tasks;
    return CupertinoScrollbar(
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          var task = tasks[index];
          return TaskItemWidget(
            taskUi: task,
            onToggleCompleted: (isCompleted) {
              Log.d(tag, "buildList - isCompleted=$isCompleted");
              context.read<TaskBloc>().add(
                    CompletedTaskEvent(
                      task.id,
                      isCompleted,
                    ),
                  );
            },
            onDismissed: (_) {
              Log.d(tag, "buildList - onDismissed");
              context.read<TaskBloc>().add(DeleteTaskEvent(task.id));
            },
            onTap: () {
              Log.d(tag, "buildList - onTap");
              // Navigator.of(context).push(
              //   EditTodoPage.route(initialTodo: todo),
              // );
            },
          );
        },
      ),
    );
  }
}
