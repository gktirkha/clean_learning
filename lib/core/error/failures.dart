import 'package:fpdart/fpdart.dart';

class Failure {
  Failure([this.message = 'An unexpected Error Occurred']);

  final String message;
}

typedef FailableEither<T> = Either<Failure, T>;
