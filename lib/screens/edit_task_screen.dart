import 'package:flutter/material.dart';
import 'package:flutter_todo_bloc/blocs/bloc_exports.dart';
import 'package:flutter_todo_bloc/models/task.dart';

class EditTaskScreen extends StatefulWidget {
  static const id = "edit_task_screen";

  final Task task;

  const EditTaskScreen({
    required this.task,
    super.key,
  });

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    titleController.text = widget.task.title;

    descriptionController.text = widget.task.description;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            "Edit Task",
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 20),
          TextField(
            autofocus: true,
            controller: titleController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Title"),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            autofocus: true,
            controller: descriptionController,
            minLines: 3,
            maxLines: 5,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Description"),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  final title = titleController.text;
                  final description = descriptionController.text;

                  final editedTask = Task(
                    id: widget.task.id,
                    title: title,
                    description: description,
                    createdAt: DateTime.now().toString(),
                    isDone: false,
                    isFavorite: widget.task.isFavorite,
                  );

                  context.read<TaskBloc>().add(
                      EditTaskEvent(oldTask: widget.task, newTask: editedTask));

                  Navigator.pop(context);
                },
                child: const Text("Save"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
