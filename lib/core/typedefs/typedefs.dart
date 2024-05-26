import 'package:dartz/dartz.dart';
import 'package:flutter_task_1/core/failures/failure.dart';

typedef FutureVoid = Future<Either<Failure, void>>;
typedef FutureResult<T> = Future<Either<Failure, T>>;
typedef DataMap = Map<String, dynamic>;
