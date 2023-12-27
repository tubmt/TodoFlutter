import 'dart:developer';
import 'package:domain/domain_ex.dart';
import 'package:todo_app/presentation/home/home/bloc/home_bloc.dart';
import 'package:todo_app/presentation/home/home/bloc/home_event.dart';
import 'package:todo_app/presentation/home/home/bloc/home_state.dart';
import 'package:todo_app/presentation/home/stats/ui/stats_widget.dart';
import 'package:todo_app/presentation/home/task/bloc/task_bloc.dart';
import 'package:todo_app/presentation/home/task/bloc/task_event.dart' as task_event;
import 'package:todo_app/presentation/home/task/bloc/task_state.dart' as task_state;
import 'package:todo_app/presentation/home/task/ui/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => HomeBloc(LoadingState())),
    ], child: const HomeScreen());
  }
}

class _HomeScreenState extends State<HomeScreen> {
  var _index = 0;

  final Map<String, Icon> _navigationItems = {
    'Tasks': const Icon(Icons.task_outlined),
    'Stats': const Icon(Icons.summarize_outlined),
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("HomeScreen - build");
    return Scaffold(
      appBar: AppBar(title: Text('My Tasks'.toUpperCase())),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        items: _navigationItems.entries
            .map((e) => BottomNavigationBarItem(
                icon: e.value,
                label: e.key,
                backgroundColor: Colors.transparent))
            .toList(),
        onTap: (data) => {changePage(data)},
      ),
      floatingActionButton: FloatingActionButton(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50))),
        onPressed: () {
          addTask(context);
        },
        child: Icon(Icons.add_circle_outline,
            color: Theme.of(context).buttonTheme.colorScheme?.onSecondary),
      ),
      body: IndexedStack(
        index: _index,
        children: const [TaskPage(), StatsPage()],
      ),
    );
  }

  void addTask(BuildContext context) {
    log("addTask");
    var curT = DateTime.now().millisecondsSinceEpoch;
    context
        .read<HomeBloc>()
        .add(AddTaskEvent(TaskUi(0, "Task $curT", "Description $curT", false)));
  }

  void changePage(int index) {
    log("changePage index=$index");
    if (index == _index) {
      log("changePage - the same");
      return;
    }
    setState(() {
      _index = index;
    });
  }
}
