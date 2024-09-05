import 'package:flutter/material.dart';
import 'package:flutter_todo_bloc/screens/add_task_screen.dart';
import 'package:flutter_todo_bloc/screens/my_drawer.dart';
import 'package:flutter_todo_bloc/screens/tab_screens/completed_screen.dart';
import 'package:flutter_todo_bloc/screens/tab_screens/favorite_screen.dart';
import 'package:flutter_todo_bloc/screens/tab_screens/pending_screen.dart';

enum Tabs {
  pending,
  completed,
  favorite;

  String get title {
    switch (this) {
      case Tabs.pending:
        return "Pending Tasks";
      case Tabs.completed:
        return "Completed Tasks";
      case Tabs.favorite:
        return "Favorite Tasks";
    }
  }

  Icon get icon {
    switch (this) {
      case Tabs.pending:
        return const Icon(Icons.incomplete_circle_sharp);
      case Tabs.completed:
        return const Icon(Icons.done);
      case Tabs.favorite:
        return const Icon(Icons.favorite);
    }
  }

  Widget get screen {
    switch (this) {
      case Tabs.pending:
        return const PendingScreen();
      case Tabs.completed:
        return const CompletedScreen();
      case Tabs.favorite:
        return const FavoriteScreen();
    }
  }
}

class TabScreen extends StatefulWidget {
  static const id = "tab_screen";

  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedPageIndex = 0;

  static const List<Tabs> _tabs = [
    Tabs.pending,
    Tabs.completed,
    Tabs.favorite,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tabs[_selectedPageIndex].title),
        actions: [
          IconButton(
            onPressed: () {
              _addTask(context);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const MyDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: (value) {
          setState(() {
            _selectedPageIndex = value;
          });
        },

        // option 1
        // items: const [
        //   BottomNavigationBarItem(
        //     icon: Icon(Icons.list),
        //     label: "Pending Tasks",
        //   ),
        //   BottomNavigationBarItem(
        //     icon: Icon(Icons.done),
        //     label: "Completed Tasks",
        //   ),
        //   BottomNavigationBarItem(
        //     icon: Icon(Icons.favorite),
        //     label: "Favorite Tasks",
        //   ),
        // ],

        // option 2
        // items: List.generate(_tabs.length, (index) {
        //   return BottomNavigationBarItem(
        //     icon: _tabs[index].icon,
        //     label: _tabs[index].title,
        //   );
        // }),

        // option 3
        items: [
          for (var tab in _tabs)
            BottomNavigationBarItem(
              icon: tab.icon,
              label: tab.title,
            ),
        ],
      ),
      floatingActionButton: _tabs[_selectedPageIndex] == Tabs.pending
          ? FloatingActionButton(
              onPressed: () {
                _addTask(context);
              },
              tooltip: "Add Task",
              child: const Icon(Icons.add),
            )
          : null,

      // option 1
      // body: switch (_tabs[_selectedPageIndex]) {
      //   Tabs.pending => const PendingScreen(),
      //   Tabs.completed => const CompletedScreen(),
      //   Tabs.favorite => const FavoriteScreen(),
      // },

      // option 2
      body: _tabs[_selectedPageIndex].screen,
    );
  }

  void _addTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: AddTaskScreen(),
          ),
        );
      },
    );
  }
}
