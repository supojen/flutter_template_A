import 'package:dartz/dartz.dart';

import '../../../infrastructure/error/failures.dart';
import '../entities/spu.dart';


abstract class SPURepository {
  Future<Either<Failure,SPU>> getSPU(int id);
  Future<Either<Failure,List<SPU>>> getRandomSPUs();
}