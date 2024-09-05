import 'package:flutter/material.dart';
import 'package:flutter_todo_bloc/models/task.dart';
import 'package:flutter_todo_bloc/screens/edit_task_screen.dart';
import 'package:flutter_todo_bloc/widgets/popup_menu.dart';
import 'package:intl/intl.dart';

import '../blocs/bloc_exports.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  const TaskTile({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(task.isFavorite == false
                    ? Icons.star_outline
                    : Icons.star_outlined),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        decoration: task.isDone == true
                            ? TextDecoration.lineThrough
                            : null,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      DateFormat()
                          .add_yMMM()
                          .add_Hms()
                          .format(DateTime.parse(task.createdAt)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Checkbox(
              value: task.isDone,
              onChanged: (value) {
                if (task.isDeleted == false) {
                  _completeTask(context);
                }
              },
            ),
            PopupMenu(
              task: task,
              onEdit: () => _onEditTapped(context),
              onBookmarked: () => _bookmarked(context),
              onDelete: () => _removeOrDelete(context),
              onRestore: () => _onRestoreTapped(context),
            ),
          ],
        ),
      ],
    );
  }

  void _completeTask(BuildContext context) {
    context.read<TaskBloc>().add(UpdateTaskEvent(task: task));
  }

  void _onEditTapped(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: EditTaskScreen(task: task),
          ),
        );
      },
    );
  }

  void _bookmarked(BuildContext context) {
    context.read<TaskBloc>().add(FavoriteTaskEvent(task: task));
  }

  void _removeOrDelete(BuildContext context) {
    if (task.isDeleted == true) {
      context.read<TaskBloc>().add(DeleteTaskEvent(task: task));
    } else {
      context.read<TaskBloc>().add(RemoveTaskEvent(task: task));
    }
  }

  void _onRestoreTapped(BuildContext context) {
    context.read<TaskBloc>().add(RestoreTaskEvent(task: task));
  }
}
