// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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

class ToDoSearch with ChangeNotifier {
  ToDoSearchState _state = ToDoSearchState.initial();
  ToDoSearchState get state => _state;

  void setSearchTerm(String newSearchTerm) {
    _state = _state.copyWith(searchTerm: newSearchTerm);
    notifyListeners();
  }
}
