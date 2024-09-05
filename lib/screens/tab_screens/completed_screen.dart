import 'package:flutter/material.dart';
import 'package:flutter_todo_bloc/blocs/bloc_exports.dart';
import 'package:flutter_todo_bloc/models/task.dart';
import 'package:flutter_todo_bloc/widgets/task_list.dart';

class CompletedScreen extends StatelessWidget {
  static const id = "completed_screen";

  const CompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        List<Task> tasksList = state.completedTasks;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Chip(
                label: Text("${tasksList.length} Tasks"),
              ),
            ),
            TaskList(tasksList: tasksList),
          ],
        );
      },
    );
  }
}
