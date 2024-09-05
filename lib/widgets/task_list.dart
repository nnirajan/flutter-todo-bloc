import 'package:flutter/material.dart';
import 'package:flutter_todo_bloc/models/task.dart';
import 'package:flutter_todo_bloc/widgets/task_tile.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasksList;

  const TaskList({
    super.key,
    required this.tasksList,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: ExpansionPanelList.radio(
          children: tasksList.map((task) {
            return ExpansionPanelRadio(
              value: task.id,
              headerBuilder: (context, isExpanded) {
                return TaskTile(task: task);
              },
              // body: Align(
              //   alignment: Alignment.topLeft,
              //   child: Container(
              //     color: Colors.red,
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         const Text("Title"),
              //         Text(task.title),
              //         const Text("description"),
              //         Text(task.description),
              //       ],
              //     ),
              //   ),
              // ),
              body: Container(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Title:"),
                    Text(task.title),
                    const Text("Description:"),
                    Text(task.description),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}


// Expanded(
//       child: ListView.builder(
//         itemCount: tasksList.length,
//         itemBuilder: (context, index) {
//           final task = tasksList[index];

//           return TaskTile(task: task);
//         },
//       ),
//     );