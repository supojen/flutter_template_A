import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile/infrastructure/network/network_info.dart';
import 'package:mobile/product/data/datasources/spu_local_datasource.dart';
import 'package:mobile/product/data/datasources/spu_remote_datasource.dart';
import 'package:mobile/product/data/repositories/spu_repository_impl.dart';
import 'package:mobile/product/domain/handlers/get_spu.dart';
import 'package:mobile/product/domain/repositories/spu_repository.dart';
import 'package:mobile/product/presentation/cubit/spu_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

/// sl means Service Locator
/// 
/// Factory   : lifescope == one call
/// Singleton : lifescope == whole app
final sl = GetIt.instance;

Future<void> init() async {

  //! Features - Product
  // cubit
  sl.registerFactory(() {
    return SpuCubit(getSPUHandler: sl());
  });
  // use case 
  sl.registerLazySingleton(() {
    return GetSPUHandler(repository: sl());
  });
  // repository
  sl.registerLazySingleton<SPURepository>(() {
    return SPURepositoryImpl(
      remoteDataSource: sl(), 
      localDataSource: sl(), 
      networkInfo: sl()
    );
  });
  // data sources
  sl.registerLazySingleton<SPULocalDataSource>(() {
    return SPULocalDataSourceImpl(
      preferences: sl()
    );
  });
  sl.registerLazySingleton<SPURemoteDataSource>(() {
    return SPURemoteDataSourceImpl(
      client: sl()
    );
  });

  //! Infrastructure
  sl.registerLazySingleton<NetworkInfo>(() {
    return NetworkInfoImpl(
      checker: sl()
    );
  });
  final sharedPreference = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() { 
    return sharedPreference;
  });
  sl.registerLazySingleton(() {
    return http.Client();
  });
  sl.registerLazySingleton(() {
    return InternetConnectionChecker();
  });
}