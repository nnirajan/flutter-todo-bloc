import 'package:flutter/material.dart';
import 'package:flutter_todo_bloc/blocs/bloc_exports.dart';
import 'package:flutter_todo_bloc/models/task.dart';
import 'package:flutter_todo_bloc/screens/my_drawer.dart';
import 'package:flutter_todo_bloc/widgets/task_list.dart';

class RecycleBin extends StatelessWidget {
  static const id = "recycle_bin";

  const RecycleBin({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        List<Task> removedTasks = state.removedTasks;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Recycle Bin"),
          ),
          drawer: const MyDrawer(),
          body: Column(
            children: [
              Text("${state.removedTasks.length} Tasks"),
              TaskList(tasksList: removedTasks),
            ],
          ),
        );
      },
    );
  }
}
