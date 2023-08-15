import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/todos_home_page.dart';
import 'providers/providers.dart';

void main() {
  runApp(
    const ToDoProviderApp(),
  );
}

class ToDoProviderApp extends StatelessWidget {
  const ToDoProviderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ToDoFilter>(
          create: (_) => ToDoFilter(),
        ),
        ChangeNotifierProvider<ToDoSearch>(
          create: (_) => ToDoSearch(),
        ),
        ChangeNotifierProvider<ToDoList>(
          create: (_) => ToDoList(),
        ),
        ProxyProvider<ToDoList, ActiveToDoCount>(
          update: (
            context,
            toDoList,
            _,
          ) =>
              ActiveToDoCount(
            toDoList: toDoList,
          ),
        ),
        ProxyProvider3<ToDoFilter, ToDoSearch, ToDoList, FilteredToDos>(
          update: (
            context,
            toDoFilter,
            toDoSearch,
            toDoList,
            _,
          ) =>
              FilteredToDos(
            toDoFilter: toDoFilter,
            toDoSearch: toDoSearch,
            toDoList: toDoList,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'ToDo App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ToDoHomePage(),
      ),
    );
  }
}
