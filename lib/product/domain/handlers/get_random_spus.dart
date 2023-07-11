import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/infrastructure/error/failures.dart';
import 'package:mobile/infrastructure/handlers/handler.dart';
import 'package:mobile/product/domain/repositories/spu_repository.dart';

import '../entities/spu.dart';

class GetRandomSPUsHandler implements Handler<List<SPU>, GetRandomSPUsCommand> {

  final SPURepository repository;

  GetRandomSPUsHandler({required this.repository});

  @override
  Future<Either<Failure, List<SPU>>> call(GetRandomSPUsCommand params) {
    return repository.getRandomSPUs();
  }
}


class GetRandomSPUsCommand extends Equatable {
  @override
  List<Object?> get props => [];
}