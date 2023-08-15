// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider_refactor/models/todo_model.dart';
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

class ActiveToDoCount extends StateNotifier<ActiveToDoCountState>
    with LocatorMixin {
  ActiveToDoCount()
      : super(
          ActiveToDoCountState.initial(),
        );

  @override
  void update(Locator watch) {
    final List<ToDo> toDos = watch<ToDoListState>().toDos;

    state = state.copyWith(
      activeToDoCount: toDos.where((toDo) => !toDo.isCompleted).toList().length,
    );
    super.update(watch);
  }
}
