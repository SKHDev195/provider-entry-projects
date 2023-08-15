// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

Uuid uuid = const Uuid();

class ToDo extends Equatable {
  ToDo({
    String? id,
    required this.desc,
    this.isCompleted = false,
  }) : id = id ?? uuid.v4();

  final String id;
  final String desc;
  final bool isCompleted;

  @override
  List<Object?> get props => [
        id,
        desc,
        isCompleted,
      ];

  @override
  bool get stringify => true;
}

enum Filter {
  all,
  active,
  completed,
}
