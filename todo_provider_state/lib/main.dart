import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
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
        StateNotifierProvider<ToDoFilter, ToDoFilterState>(
          create: (_) => ToDoFilter(),
        ),
        StateNotifierProvider<ToDoSearch, ToDoSearchState>(
          create: (_) => ToDoSearch(),
        ),
        StateNotifierProvider<ToDoList, ToDoListState>(
          create: (_) => ToDoList(),
        ),
        StateNotifierProvider<ActiveToDoCount, ActiveToDoCountState>(
          create: (_) => ActiveToDoCount(),
        ),
        StateNotifierProvider<FilteredToDos, FilteredToDoState>(
          create: (_) => FilteredToDos(),
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
