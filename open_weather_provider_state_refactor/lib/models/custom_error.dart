// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CustomError extends Equatable {
  const CustomError({
    this.errMsg = '',
  });
  final String errMsg;

  @override
  String toString() => 'CustomError(errMsg: $errMsg)';

  @override
  bool get stringify => true;

  CustomError copyWith({
    String? errMsg,
  }) {
    return CustomError(
      errMsg: errMsg ?? this.errMsg,
    );
  }

  @override
  List<Object> get props => [
        errMsg,
      ];
}
