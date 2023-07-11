




import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/infrastructure/error/exceptions.dart';
import 'package:mobile/infrastructure/error/failures.dart';
import 'package:mobile/infrastructure/network/network_info.dart';
import 'package:mobile/product/data/datasources/spu_local_datasource.dart';
import 'package:mobile/product/data/datasources/spu_remote_datasource.dart';
import 'package:mobile/product/data/models/spu_model.dart';
import 'package:mobile/product/data/repositories/spu_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'spu_repository_impl_test.mocks.dart';


@GenerateMocks([SPURemoteDataSource, SPULocalDataSource, NetworkInfo])
void main() {
  
  late SPURepositoryImpl repository;
  late MockSPURemoteDataSource mockSPURemoteDataSource;
  late MockSPULocalDataSource mockSPULocalDataSource;
  late MockNetworkInfo mockNetworkInfo;


  setUp(() {
    mockSPURemoteDataSource = MockSPURemoteDataSource();
    mockSPULocalDataSource = MockSPULocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = SPURepositoryImpl(
      remoteDataSource: mockSPURemoteDataSource,
      localDataSource: mockSPULocalDataSource,
      networkInfo: mockNetworkInfo
    );
  });

  group('Get SPU', () {
    
    const tId = 1;
    const tName = 'pants';
    const tDescription = 'good pants';
    const tSPUModel = SPUModel(
      id: tId, 
      name: tName, 
      description: tDescription
    );
    const tSPU = tSPUModel;

    group('device is online', () { 
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('should cache theb spu data when we get the spu information', () async {
        // Arrange
        when(mockSPURemoteDataSource.getSPU(tId)).thenAnswer((_) async => tSPUModel);
        // Act 
        final result = await repository.getSPU(tId);
        // Assert
        verify(mockSPURemoteDataSource.getSPU(tId));
        expect(result,equals(const Right(tSPU)));
      });

      test('should return SPU when it exist and it is successful', () async {
        // Arrange
        when(mockSPURemoteDataSource.getSPU(tId)).thenAnswer((_) async => tSPUModel);
        // Act 
        await repository.getSPU(tId);
        // Assert
        verify(mockSPULocalDataSource.cacheSPU(tSPUModel));
      });

      test('should return server failure when it is unsuccessful', () async {
        // Arrange
        when(mockSPURemoteDataSource.getSPU(tId)).thenAnswer((_) async => throw ServerException());
        // Act 
        var result = await repository.getSPU(tId);
        // Assert
        verify(mockSPURemoteDataSource.getSPU(tId));
        verifyZeroInteractions(mockSPULocalDataSource);
        expect(result, equals(const Left(ServerFailure())));
      });
    });

    group('device is offline',() {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
        'should return last cached data when the cached data is present', 
        () async {
          // arrange
          when(mockSPULocalDataSource.getLastSPU(any)).thenAnswer((_) async => tSPUModel);
          // act
          final result = await repository.getSPU(tId);
          //assert
          verifyNoMoreInteractions(mockSPURemoteDataSource);
          verify(mockSPULocalDataSource.getLastSPU(any));
          expect(result, equals(const Right(tSPU)));
      });

      test(
        'should return last cacheFailure when the cached data is not present', 
        () async {
          // arrange
          when(mockSPULocalDataSource.getLastSPU(any)).thenAnswer((_) async => throw CacheException()) ;
          // act
          final result = await repository.getSPU(tId);
          //assert
          verifyNoMoreInteractions(mockSPURemoteDataSource);
          verify(mockSPULocalDataSource.getLastSPU(any));
          expect(result, equals(const Left(CacheFailure())));
      });


    });

  });


  group('Get random SPUs', () {
    
    final tSPUModels = [
      const SPUModel(
        id: 1, 
        name: 'product #1', 
        description: 'some description'
      ),
      const SPUModel(
        id: 2, 
        name: 'product #2', 
        description: 'some description'
      ),
    ];

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
        'should get spus when it is online', 
        () async {
          // arrange
          when(mockSPURemoteDataSource.getRandomSPUs()).thenAnswer((_) async => tSPUModels);
          // act 
          var result = await repository.getRandomSPUs();
          // assert
          verify(mockSPURemoteDataSource.getRandomSPUs());
          expect(result, Right(tSPUModels));
        }
      );
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
        'should return ServerFfailure when it is ofline', 
        () async {
          // act
          var result = await repository.getRandomSPUs();
          // assert
          verifyNoMoreInteractions(mockSPURemoteDataSource);
          expect(result, const Left(ServerFailure()));
        }
      );
    });

  });
}