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
        ChangeNotifierProxyProvider<ToDoList, ActiveToDoCount>(
          create: (context) => ActiveToDoCount(
            initialActiveToDoCount: context.read<ToDoList>().state.toDos.length,
          ),
          update: (context, toDoList, activeToDoCount) =>
              activeToDoCount!..update(toDoList),
        ),
        ChangeNotifierProxyProvider3<ToDoFilter, ToDoSearch, ToDoList,
            FilteredToDos>(
          create: (context) => FilteredToDos(
            initialFilteredToDos: context.read<ToDoList>().state.toDos,
          ),
          update: (context, toDoFilter, toDoSearch, toDoList, filteredToDos) =>
              filteredToDos!
                ..update(
                  toDoFilter,
                  toDoSearch,
                  toDoList,
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
