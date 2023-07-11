

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/infrastructure/error/exceptions.dart';
import 'package:mobile/product/data/datasources/spu_local_datasource.dart';
import 'package:mobile/product/data/models/spu_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../fixtures/fixture_reader.dart';
import 'spu_local_datasource_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late SPULocalDataSourceImpl dataSource;
  late MockSharedPreferences mockPreferences;

  setUp(() {
    mockPreferences = MockSharedPreferences();
    dataSource = SPULocalDataSourceImpl(preferences: mockPreferences);
  });

  group('getLastSPU', () { 

    const tId = 1;
    const tName = 'name #1';
    const tDescription = 'description';
    const tSPUModel = SPUModel(
      id: tId, 
      name: tName, 
      description: tDescription
    );

    test(
      'should return spu when there is one in the cahce',
      () async {
        // arrange
        when(mockPreferences.getString(any)).thenAnswer((_) => fixture('spu.json'));
        // act
        final result = await dataSource.getLastSPU(tId);
        // assert
        expect(result, equals(tSPUModel));
      }
    ); 

    test(
      'should throw a cacheException when there is no cahce',
      () async {
        // arrange
        when(mockPreferences.getString(any)).thenReturn(null);
        // act
        var call = dataSource.getLastSPU;
        // assert
        expect(() => call(tId), throwsA(const TypeMatcher<CacheException>()));
      }
    );
  });

  group('cacheSPU', () {

    const tId = 1;
    const tName = 'name #1';
    const tDescription = 'description';
    const tSPUModel = SPUModel(
      id: tId, 
      name: tName, 
      description: tDescription
    );

    // ? 這個 Unit Test 意義是什麼 
    test(
      'should cahce the data',
      () async {
        // arrange 
        when(mockPreferences.setString(any, any)).thenAnswer((_)async => true);
        final expectedJsonString = json.encode(tSPUModel.toJson());
        // act 
        await dataSource.cacheSPU(tSPUModel);
        // assert
        verify(mockPreferences.setString(
          any,
          expectedJsonString
          ));
      }
    );
  });


}