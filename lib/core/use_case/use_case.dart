import '../error/failures.dart';

abstract interface class UseCase<T, P> {
  Future<FailableEither<T>> call(P params);
}

class NoParams {}
