

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/product/domain/entities/spu.dart';
import 'package:mobile/product/domain/handlers/get_random_spus.dart';
import 'package:mobile/product/domain/repositories/spu_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_random_spus_test.mocks.dart';

class SPURepo extends Mock implements SPURepository {}

@GenerateMocks([SPURepo])
void main() {

  late SPURepo mockRepo;
  late GetRandomSPUsHandler handler;

  setUp(() {
    mockRepo = MockSPURepo();
    handler = GetRandomSPUsHandler(repository:mockRepo);
  });  

  final tSPUs = [
    const SPU(id: 1, name: 'pants', description: "man's pants"),
    const SPU(id: 2, name: 'bag', description: "woman's bag")
  ];

  test(
    'should get randomly list of spus ffrom the repository',
    () async {
      // arrange
      when(mockRepo.getRandomSPUs())
      .thenAnswer((_) async => Right(tSPUs));
      // act
      final result = await handler(GetRandomSPUsCommand());
      // assert
      expect(result, Right(tSPUs));
      verify(mockRepo.getRandomSPUs());
      verifyNoMoreInteractions(mockRepo);
    }
  );
} 