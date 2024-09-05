import 'package:flutter/material.dart';
import 'package:flutter_todo_bloc/blocs/bloc_exports.dart';
import 'package:flutter_todo_bloc/models/task.dart';
import 'package:flutter_todo_bloc/widgets/task_list.dart';

class PendingScreen extends StatelessWidget {
  static const id = "task_screen";

  const PendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        List<Task> pendingTasks = state.pendingTasks;

        List<Task> completedTasks = state.completedTasks;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Chip(
                label: Text(
                  "${pendingTasks.length} Pending | ${completedTasks.length} Completed",
                ),
              ),
            ),
            TaskList(tasksList: pendingTasks),
          ],
        );
      },
    );

    
  }
}
