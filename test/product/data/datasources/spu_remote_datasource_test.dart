import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/infrastructure/error/exceptions.dart';
import 'package:mobile/product/data/datasources/spu_remote_datasource.dart';
import 'package:mobile/product/data/models/spu_model.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../fixtures/fixture_reader.dart';
import 'spu_remote_datasource_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockHttpClient;
  late SPURemoteDataSourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = SPURemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getSPU',() {
    const tId = 1;
    final tSPUModel = SPUModel.fromJson(json.decode(fixture('spu.json')));

    test(
      'should perform a get request on a URL with number being the endpoint and with application/json head',
      () async {
        // arrange
        when(mockHttpClient.get(any, headers:anyNamed('headers') ))
        .thenAnswer((_) async => http.Response(fixture('spu.json'),200));
        // act
        await dataSource.getSPU(tId);
        // assert
        verify(mockHttpClient.get(
          Uri.parse('https://7838d083-84ef-4ddb-81f9-2b111974212b.mock.pstmn.io/spu/$tId'),
          headers: {'Content-Type' : 'application/json'}
        ));
      }
    );

    test(
      'should return spu when the response code is 200 (success)',
      () async {
        // arrange
        when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('spu.json'), 200));
        // act
        final result = await dataSource.getSPU(tId);
        // assert
        expect(result, tSPUModel);
      }
    );

    test(
      'should throw ServerException when the response code is not 200',
      () async {
        // arrange
        when(mockHttpClient.get(any,headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
        // act
        final call = dataSource.getSPU;
        // assert
        expect(() async => call(tId), throwsA(const TypeMatcher<ServerException>()));
      }
    );

  });


  group('getRandomSPUs', () {     
  });


}