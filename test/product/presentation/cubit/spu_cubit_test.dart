import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/infrastructure/error/failures.dart';
import 'package:mobile/product/data/models/spu_model.dart';
import 'package:mobile/product/domain/handlers/get_spu.dart';
import 'package:mobile/product/presentation/cubit/spu_cubit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/fixture_reader.dart';
import 'spu_cubit_test.mocks.dart';

@GenerateMocks([GetSPUHandler])
void main() {
   
  late MockGetSPUHandler mockHandler;
  late SpuCubit cubit;

  setUp(() {
  mockHandler = MockGetSPUHandler();
  cubit = SpuCubit(getSPUHandler:mockHandler);
  });


  test('initial state should be loading',() {
    // assert
    expect(cubit.state, equals(SpuLoadingState()));
  });


  group('getSpuById',() {

    const tId = 1;
    final tSPU = SPUModel.fromJson(json.decode(fixture('spu.json')));


    test(
      'Should change the state to loaded state when handler execute the command successfully',
      () async {
        // arrange
        when(mockHandler.call(any)).thenAnswer((_) async => Right(tSPU));
        // act
        await cubit.getSPUById(tId);
        // assert
        expect(cubit.state, equals(SpuLoadedState(spu: tSPU)));
      }
    );

    test(
      'Should change the state to error state when handler execute the command un-sucessfully',
      () async {
        // arrange
        when(mockHandler.call(any)).thenAnswer((_) async => const Left(ServerFailure()));
        // act
        await cubit.getSPUById(tId);
        // assert
        expect(cubit.state, isA<SpuErrorState>());
      }
    );
  });
}