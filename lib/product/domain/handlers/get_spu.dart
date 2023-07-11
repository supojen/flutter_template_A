import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../infrastructure/error/failures.dart';
import '../../../infrastructure/handlers/handler.dart';
import '../entities/spu.dart';
import '../repositories/spu_repository.dart';

class GetSPUHandler implements Handler<SPU,GetSPUCommand> {
  final SPURepository repository;

  GetSPUHandler({
    required this.repository
  });

  @override
  Future<Either<Failure,SPU>> call(GetSPUCommand params) async {
    return await repository.getSPU(params.id);
  }
}

class GetSPUCommand extends Equatable {
  final int id;

  const GetSPUCommand({required this.id});
  
  @override
  List<Object?> get props => [id];
}