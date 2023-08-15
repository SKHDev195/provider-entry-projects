// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo_provider_refactor/models/todo_model.dart';
import 'package:todo_provider_refactor/providers/todo_filter.dart';
import 'package:todo_provider_refactor/providers/todo_list.dart';
import 'package:todo_provider_refactor/providers/todo_search.dart';

class FilteredToDoState extends Equatable {
  FilteredToDoState({
    required this.filteredToDos,
  });
  final List<ToDo> filteredToDos;

  factory FilteredToDoState.initial() {
    return FilteredToDoState(filteredToDos: const []);
  }

  @override
  List<Object?> get props => [
        filteredToDos,
      ];

  @override
  bool get stringify => true;

  FilteredToDoState copyWith({
    List<ToDo>? filteredToDos,
  }) {
    return FilteredToDoState(
      filteredToDos: filteredToDos ?? this.filteredToDos,
    );
  }
}

class FilteredToDos {
  FilteredToDos({
    required this.toDoFilter,
    required this.toDoSearch,
    required this.toDoList,
  });

  final ToDoFilter toDoFilter;
  final ToDoSearch toDoSearch;
  final ToDoList toDoList;

  FilteredToDoState get state {
    List<ToDo> _filteredToDos;
    String currentSearchTerm = toDoSearch.state.searchTerm;

    switch (toDoFilter.state.filter) {
      case Filter.active:
        _filteredToDos =
            toDoList.state.toDos.where((toDo) => !toDo.isCompleted).toList();
        break;
      case Filter.completed:
        _filteredToDos =
            toDoList.state.toDos.where((toDo) => toDo.isCompleted).toList();
        break;
      default:
        _filteredToDos = toDoList.state.toDos;
        break;
    }

    if (currentSearchTerm.isNotEmpty) {
      _filteredToDos = _filteredToDos
          .where(
            (toDo) => toDo.desc.toLowerCase().contains(currentSearchTerm),
          )
          .toList();
    }

    return FilteredToDoState(filteredToDos: _filteredToDos);
  }
}
