// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter_todo_bloc/blocs/switch_bloc/switch_bloc.dart';
import 'package:flutter_todo_bloc/screens/tab_screen.dart';
import 'package:flutter_todo_bloc/services/app_router.dart';
import 'package:flutter_todo_bloc/services/app_theme.dart';

import 'blocs/bloc_exports.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  HydratedBloc.storage = storage;

  runApp(
    MyApp(
      appRouter: AppRouter(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({
    super.key,
    required this.appRouter,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TaskBloc(),
        ),
        BlocProvider(
          create: (context) => SwitchBloc(),
        )
      ],
      child: BlocBuilder<SwitchBloc, SwitchState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: state.switchValue
                ? AppThemes.appThemeData[AppTheme.darkTheme]
                : AppThemes.appThemeData[AppTheme.lightTheme],
            home: const TabScreen(),
            onGenerateRoute: appRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}

class Animal {
  String name, color;

  String? breed;

  Animal({
    required this.name,
    required this.color,
    this.breed,
  });

  void a() {
    var animal1 = Animal(name: "name", color: "color", breed: "any");
  }

  // Animal(this.name, this.color, String? breed);

  // Animal(this.name, this.color) {
  //   name = name;
  //   color = color;
  // }

  
}
