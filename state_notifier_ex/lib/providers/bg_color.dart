// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';

class BgColorState extends Equatable {
  const BgColorState({
    required this.color,
  });
  final Color color;

  @override
  List<Object?> get props => [
        color,
      ];

  @override
  bool get stringify => true;

  BgColorState copyWith({
    Color? color,
  }) {
    return BgColorState(
      color: color ?? this.color,
    );
  }
}

class BgColor extends StateNotifier<BgColorState> {
  BgColor()
      : super(
          const BgColorState(
            color: Colors.blue,
          ),
        );

  void changeColor() {
    state = switch (state.color) {
      Colors.blue => state.copyWith(color: Colors.black),
      Colors.black => state.copyWith(color: Colors.red),
      _ => state.copyWith(color: Colors.blue),
    };
  }
}
