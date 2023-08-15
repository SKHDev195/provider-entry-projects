// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:state_notifier_ex/providers/bg_color.dart';

class CounterState extends Equatable {
  const CounterState({
    required this.count,
  });
  final int count;

  @override
  List<Object> get props => [
        count,
      ];

  @override
  bool get stringify => true;

  CounterState copyWith({
    int? count,
  }) {
    return CounterState(
      count: count ?? this.count,
    );
  }
}

class Counter extends StateNotifier<CounterState> with LocatorMixin {
  Counter()
      : super(
          const CounterState(
            count: 0,
          ),
        );

  void changeCount() {
    Color currentColor = read<BgColor>().state.color;

    state = switch (currentColor) {
      Colors.black => state.copyWith(count: state.count + 10),
      Colors.red => state.copyWith(count: state.count - 10),
      _ => state.copyWith(count: state.count + 1),
    };
  }
}
