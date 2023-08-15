// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';
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

class FilteredToDos extends StateNotifier<FilteredToDoState> with LocatorMixin {
  FilteredToDos()
      : super(
          FilteredToDoState.initial(),
        );

  @override
  void update(Locator watch) {
    final Filter filter = watch<ToDoFilterState>().filter;
    final String searchTerm = watch<ToDoSearchState>().searchTerm;
    final List<ToDo> toDos = watch<ToDoListState>().toDos;

    List<ToDo> _filteredToDos;

    switch (filter) {
      case Filter.active:
        _filteredToDos = toDos.where((toDo) => !toDo.isCompleted).toList();
        break;
      case Filter.completed:
        _filteredToDos = toDos.where((toDo) => toDo.isCompleted).toList();
        break;
      default:
        _filteredToDos = toDos;
        break;
    }

    if (searchTerm.isNotEmpty) {
      _filteredToDos = _filteredToDos
          .where(
            (toDo) => toDo.desc.toLowerCase().contains(searchTerm),
          )
          .toList();
    }

    state = state.copyWith(filteredToDos: _filteredToDos);
    super.update(watch);
  }
}
