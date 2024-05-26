import 'package:flutter_task_1/core/typedefs/typedefs.dart';

abstract class UsecaseWithoutParams<Type> {
  const UsecaseWithoutParams();
  FutureResult<Type> call();
}

abstract class UsecaseWithParams<Type, Params> {
  const UsecaseWithParams();
  FutureResult<Type> call(Params params);
}
