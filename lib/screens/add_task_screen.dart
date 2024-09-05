import 'package:flutter/material.dart';

import 'package:flutter_todo_bloc/blocs/bloc_exports.dart';
import 'package:flutter_todo_bloc/models/task.dart';

class AddTaskScreen extends StatelessWidget {
  static const id = "add_task_screen";

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            "Add Task",
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 20),
          TextField(
            autofocus: true,
            controller: _titleController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Title"),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            autofocus: true,
            controller: _descriptionController,
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
                  final title = _titleController.text;
                  final description = _descriptionController.text;

                  final task = Task(
                    id: uuid.v4(),
                    title: title,
                    description: description,
                    createdAt: DateTime.now().toString(),
                  );

                  context.read<TaskBloc>().add(AddTaskEvent(task: task));

                  Navigator.pop(context);
                },
                child: const Text("Add"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
