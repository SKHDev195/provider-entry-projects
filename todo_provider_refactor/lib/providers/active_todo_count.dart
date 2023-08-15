// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo_provider_refactor/providers/todo_list.dart';

class ActiveToDoCountState extends Equatable {
  ActiveToDoCountState({
    required this.activeToDoCount,
  });

  final int activeToDoCount;

  factory ActiveToDoCountState.initial() {
    return ActiveToDoCountState(activeToDoCount: 0);
  }

  @override
  List<Object?> get props => [
        activeToDoCount,
      ];

  @override
  bool get stringify => true;

  ActiveToDoCountState copyWith({
    int? activeToDoCount,
  }) {
    return ActiveToDoCountState(
      activeToDoCount: activeToDoCount ?? this.activeToDoCount,
    );
  }
}

class ActiveToDoCount {
  ActiveToDoCount({
    required this.toDoList,
  });
  final ToDoList toDoList;

  ActiveToDoCountState get state => ActiveToDoCountState(
        activeToDoCount: toDoList.state.toDos
            .where((toDo) => !toDo.isCompleted)
            .toList()
            .length,
      );
}
