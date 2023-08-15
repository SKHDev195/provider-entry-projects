// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo_provider/models/todo_model.dart';
import 'package:todo_provider/providers/todo_filter.dart';
import 'package:todo_provider/providers/todo_list.dart';
import 'package:todo_provider/providers/todo_search.dart';

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

class FilteredToDos with ChangeNotifier {
  FilteredToDos({
    required this.initialFilteredToDos,
  }) {
    _state = FilteredToDoState(
      filteredToDos: initialFilteredToDos,
    );
  }

  late FilteredToDoState _state;
  FilteredToDoState get state => _state;
  final List<ToDo> initialFilteredToDos;

  void update(
    ToDoFilter toDoFilter,
    ToDoSearch toDoSearch,
    ToDoList toDoList,
  ) {
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

    _state = _state.copyWith(filteredToDos: _filteredToDos);
    notifyListeners();
  }
}
