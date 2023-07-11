import 'package:dartz/dartz.dart';
import 'package:mobile/product/domain/entities/spu.dart';
import 'package:mobile/product/domain/repositories/spu_repository.dart';
import 'package:mobile/product/domain/handlers/get_spu.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'get_spu_test.mocks.dart';

class SPURepo extends Mock implements SPURepository {}

@GenerateMocks([SPURepo])
void main() {

  late SPURepo mockRepository;
  late GetSPUHandler usecase;

  setUp(() {
    mockRepository = MockSPURepo();
    usecase = GetSPUHandler(repository:mockRepository);
  });

  const tId = 1;
  const tSPU = SPU(id: tId, name: 'pants', description: 'fahsion pants');

  test(
    'should get spu if the id is exists',
    () async {
      // arrange
      when(mockRepository.getSPU(tId))
      .thenAnswer((_) async => const Right(tSPU));
      // act
      final result = await usecase(const GetSPUCommand(id: tId)); 
      // assert
      expect(result, const Right(tSPU));
      verify(mockRepository.getSPU(tId));        
      verifyNoMoreInteractions(mockRepository);
    }
  );
}