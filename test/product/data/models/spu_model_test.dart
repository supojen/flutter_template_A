


import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/product/data/models/spu_model.dart';
import 'package:mobile/product/domain/entities/spu.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {

  const id = 1;
  const name = 'pants';
  const description = 'good pants';

  const tSPUModel = SPUModel(
    id: id,
    name: name, 
    description: description
  );


  test(
    'should be a subclass offf spu entity',
    () async {
      // assert
      expect(tSPUModel, isA<SPU>());
    }
  );

  group('fromJson',() {
    test(
      'should return a valid model when the JSON is valid format',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(fixture('spu.json'));
        // act
        final result = SPUModel.fromJson(jsonMap);
        // assert
        expect(result, tSPUModel);
      }
    );
  });

  group('toJson',() {
    test(
      'should return a JSON map containing the perper data',
      () async {
        // act'
        final result = tSPUModel.toJson();
        // assert
        expect(result["id"], id);
        expect(result["name"], name);
        expect(result["description"], description);
      }
    );
  });
}



