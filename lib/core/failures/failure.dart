import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({required this.message, required this.statusCode});
  final String message;
  final int statusCode;
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message, required super.statusCode});
  @override
  List<Object?> get props => [message, statusCode];
}
