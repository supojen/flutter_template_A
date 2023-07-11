import 'package:dartz/dartz.dart';
import 'package:mobile/infrastructure/error/failures.dart';

abstract class Handler<Type, Params> {
  Future<Either<Failure,Type>> call(Params params);
}