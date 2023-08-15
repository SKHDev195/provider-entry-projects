// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:todo_provider_refactor/models/todo_model.dart';

class ToDoFilterState extends Equatable {
  const ToDoFilterState({
    required this.filter,
  });

  final Filter filter;

  factory ToDoFilterState.initial() {
    return const ToDoFilterState(
      filter: Filter.all,
    );
  }

  @override
  List<Object?> get props => [
        filter,
      ];

  @override
  bool get stringify => true;

  ToDoFilterState copyWith({
    Filter? filter,
  }) {
    return ToDoFilterState(
      filter: filter ?? this.filter,
    );
  }
}

class ToDoFilter extends StateNotifier<ToDoFilterState> {
  ToDoFilter()
      : super(
          ToDoFilterState.initial(),
        );

  void changeFilter(Filter newFilter) {
    state = state.copyWith(filter: newFilter);
  }
}
