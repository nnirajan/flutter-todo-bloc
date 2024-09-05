import 'package:flutter/material.dart';
import 'package:flutter_todo_bloc/screens/recycle_bin.dart';
import 'package:flutter_todo_bloc/screens/tab_screen.dart';
import 'package:flutter_todo_bloc/screens/tab_screens/pending_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routerSettings) {
    switch (routerSettings.name) {
      case PendingScreen.id:
        return MaterialPageRoute(builder: (_) => const PendingScreen());

      case RecycleBin.id:
        return MaterialPageRoute(builder: (_) => const RecycleBin());

      case TabScreen.id:
        return MaterialPageRoute(builder: (_) => const TabScreen());

      default:
        return null;
    }
  }
}
