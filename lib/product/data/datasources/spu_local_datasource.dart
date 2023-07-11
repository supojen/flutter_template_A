import 'dart:convert';

import 'package:mobile/infrastructure/error/exceptions.dart';
import 'package:mobile/product/data/models/spu_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


abstract class SPULocalDataSource {

  /// Get the cached [SPUModel] which was gotton the last time
  /// the user has an internete connection.
  ///
  /// Throws a [CacheException] for all error codes.
  Future<SPUModel> getLastSPU(int id);

  
  Future<void> cacheSPU(SPUModel model);
}


const prefix = 'SPU:';

class SPULocalDataSourceImpl implements SPULocalDataSource {
  
  final SharedPreferences preferences;

  SPULocalDataSourceImpl({required this.preferences});
  
  @override
  Future<void> cacheSPU(SPUModel model) async {
    var jsonString = json.encode(model.toJson());
    preferences.setString('$prefix${model.id}', jsonString);
  }
  
  /// Get the cached [SPUModel] which was gotton the last time
  /// the user has an internete connection.
  ///
  /// Throws a [CacheException] for all error codes.
  @override
  Future<SPUModel> getLastSPU(int id) {
    final rawData = preferences.getString('$prefix$id');
    
    if(rawData != null) {
      return Future.value(SPUModel.fromJson(json.decode(rawData)));
    }
    else {
      throw CacheException();
    }
  }

  
}