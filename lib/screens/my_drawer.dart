import 'package:flutter/material.dart';
import 'package:flutter_todo_bloc/blocs/bloc_exports.dart';
import 'package:flutter_todo_bloc/blocs/switch_bloc/switch_bloc.dart';
import 'package:flutter_todo_bloc/screens/recycle_bin.dart';
import 'package:flutter_todo_bloc/screens/tab_screen.dart';


class MyDrawer extends StatelessWidget {
  static const id = "my_drawer";

  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              color: Colors.grey,
              child: const Text("Task Drawer"),
            ),
            BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                final allTasks = state.pendingTasks;

                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(TabScreen.id);
                  },
                  child: ListTile(
                    leading: const Icon(Icons.folder_special),
                    title: const Text("My Tasks"),
                    trailing: Text("${allTasks.length}"),
                  ),
                );
              },
            ),
            const Divider(),
            BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                final deletedTasks = state.removedTasks;

                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(RecycleBin.id);
                  },
                  child: ListTile(
                    leading: const Icon(Icons.delete),
                    title: const Text("Bin"),
                    trailing: Text("${deletedTasks.length}"),
                  ),
                );
              },
            ),
            const Divider(),
            BlocBuilder<SwitchBloc, SwitchState>(
              builder: (context, state) {
                return ListTile(
                  title: Text(
                    state.switchValue ? "Light mode" : "Dark Mode",
                  ),
                  trailing: Switch(
                    value: state.switchValue,
                    onChanged: (value) {
                      context.read<SwitchBloc>().add(SwitchUpdateEvent());
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
