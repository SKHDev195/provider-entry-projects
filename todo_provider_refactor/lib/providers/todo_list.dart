// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo_provider_refactor/models/todo_model.dart';

class ToDoListState extends Equatable {
  const ToDoListState({
    required this.toDos,
  });
  final List<ToDo> toDos;

  factory ToDoListState.initial() {
    return ToDoListState(
      toDos: [
        ToDo(
          id: '1',
          desc: 'Clean the room',
        ),
        ToDo(
          id: '2',
          desc: 'Wash the dishes',
        ),
        ToDo(
          id: '3',
          desc: 'Donate to a charity',
        ),
      ],
    );
  }

  @override
  List<Object?> get props => [
        toDos,
      ];

  @override
  bool get stringify => true;

  ToDoListState copyWith({
    List<ToDo>? toDos,
  }) {
    return ToDoListState(
      toDos: toDos ?? this.toDos,
    );
  }
}

class ToDoList with ChangeNotifier {
  ToDoListState _state = ToDoListState.initial();
  ToDoListState get state => _state;

  void addNewToDo(String toDoDesc) {
    final newToDo = ToDo(desc: toDoDesc);
    final newToDos = [..._state.toDos, newToDo];

    _state = _state.copyWith(
      toDos: newToDos,
    );
    notifyListeners();
  }

  void changeToDoDesc(String id, String newToDoDesc) {
    final newTodos = _state.toDos.map((ToDo toDo) {
      if (toDo.id == id) {
        return ToDo(
          id: id,
          desc: newToDoDesc,
          isCompleted: toDo.isCompleted,
        );
      }
      return toDo;
    }).toList();

    _state = _state.copyWith(toDos: newTodos);
    notifyListeners();
  }

  void toggleToDo(String id) {
    final newTodos = _state.toDos.map((ToDo toDo) {
      if (toDo.id == id) {
        return ToDo(
          id: id,
          desc: toDo.desc,
          isCompleted: !toDo.isCompleted,
        );
      }
      return toDo;
    }).toList();

    _state = _state.copyWith(toDos: newTodos);
    notifyListeners();
  }

  void removeToDo(ToDo toDoToRemove) {
    final newTodos = _state.toDos
        .where(
          (ToDo toDo) => toDo.id != toDoToRemove.id,
        )
        .toList();

    _state = _state.copyWith(
      toDos: newTodos,
    );
    notifyListeners();
  }
}
