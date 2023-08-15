// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';

class ToDoSearchState extends Equatable {
  const ToDoSearchState({
    required this.searchTerm,
  });

  final String searchTerm;

  factory ToDoSearchState.initial() {
    return const ToDoSearchState(searchTerm: '');
  }

  ToDoSearchState copyWith({
    String? searchTerm,
  }) {
    return ToDoSearchState(
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }

  @override
  List<Object?> get props => [
        searchTerm,
      ];
}

class ToDoSearch extends StateNotifier<ToDoSearchState> {
  ToDoSearch()
      : super(
          ToDoSearchState.initial(),
        );

  void setSearchTerm(String newSearchTerm) {
    state = state.copyWith(searchTerm: newSearchTerm);
  }
}
