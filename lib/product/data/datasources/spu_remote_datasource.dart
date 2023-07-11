import 'dart:convert';

import 'package:mobile/infrastructure/error/exceptions.dart';
import 'package:mobile/product/data/models/spu_model.dart';
import 'package:http/http.dart' as http;

abstract class SPURemoteDataSource {

  /// Calls the https://7838d083-84ef-4ddb-81f9-2b111974212b.mock.pstmn.io/spu
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<SPUModel>> getRandomSPUs();

  /// Calls the https://7838d083-84ef-4ddb-81f9-2b111974212b.mock.pstmn.io/spu/{id}
  ///
  /// Throws a [ServerException] for all error codes.
  Future<SPUModel> getSPU(int id);
}



class SPURemoteDataSourceImpl implements SPURemoteDataSource {
  
  final http.Client client;

  SPURemoteDataSourceImpl({required this.client});

  
  @override
  Future<List<SPUModel>> getRandomSPUs() async {
    
    final response = await client.get(
      Uri.parse('https://7838d083-84ef-4ddb-81f9-2b111974212b.mock.pstmn.io/spu/random'),
      headers: {
        'Content-Type': 'application/json'
      }
    );

    if(response.statusCode == 200) {
      List<dynamic> rawData = json.decode(response.body);
      List<SPUModel> spus = [] ;
      for (var element in rawData) { 
        spus.add(SPUModel.fromJson(element));
      }
      return spus;
    }
    else {
      throw ServerException();
    }

  }

  @override
  Future<SPUModel> getSPU(int id) async {
    
    final response = await client.get(
      Uri.parse('https://7838d083-84ef-4ddb-81f9-2b111974212b.mock.pstmn.io/spu/$id'),
      headers: {
        'Content-Type' : 'application/json'
      }
    );

    if (response.statusCode == 200) {
      return SPUModel.fromJson(json.decode(response.body));
    }
    else {
      throw ServerException();
    }
  }

}