import 'package:dartz/dartz.dart';
import 'package:mobile/infrastructure/error/exceptions.dart';
import 'package:mobile/infrastructure/error/failures.dart';
import 'package:mobile/infrastructure/network/network_info.dart';
import 'package:mobile/product/data/datasources/spu_local_datasource.dart';
import 'package:mobile/product/data/datasources/spu_remote_datasource.dart';
import 'package:mobile/product/domain/entities/spu.dart';
import 'package:mobile/product/domain/repositories/spu_repository.dart';

class SPURepositoryImpl implements SPURepository {

  final SPURemoteDataSource remoteDataSource;
  final SPULocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  SPURepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo});

  
  @override
  Future<Either<Failure, List<SPU>>> getRandomSPUs() async {
    
    var isConnected = await networkInfo.isConnected;
    
    if(isConnected) {
      try {
        var spus = await remoteDataSource.getRandomSPUs();
        return Right(spus); 
      }
      on ServerException {
        return const Left(ServerFailure());
      }
    }
    else {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, SPU>> getSPU(int id) async {
    
    var isConnected = await networkInfo.isConnected;

    if(isConnected) {
      try{
        var spuModel = await remoteDataSource.getSPU(id);
        await localDataSource.cacheSPU(spuModel);
        return Right(spuModel);
      }
      on ServerException {
        return const Left(ServerFailure());
      }   
    }
    else {
      try {
        var spuModel = await localDataSource.getLastSPU(id);
        return Right(spuModel);
      } 
      on CacheException {
        return const Left(CacheFailure());
      }
    }
  }

}