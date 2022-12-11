import 'core/network/network_info.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - post

  // Bloc

  // sl.registerFactory(() => PostsBloc(getAllPosts: sl()));
  // sl.registerFactory(() => AddDeleteUpdatePostBloc(
  //     addPostUsecase: sl(), deletePostUsecase: sl(), updatePostUsecase: sl()));

  // // Usecases
  // sl.registerLazySingleton(() => GetAllPostesUsecase(sl()));
  // sl.registerLazySingleton(() => AddPostUsecase(sl()));
  // sl.registerLazySingleton(() => DeletePostUsecase(sl()));
  // sl.registerLazySingleton(() => UpdatePostUsecase(sl()));

  // Repository
  // sl.registerLazySingleton<PostsRepository>(() => PostsRepositoryImpl(
  //     remoteDateSource: sl(), localDateSource: sl(), networkInfo: sl()));

  // // Datasources
  // sl.registerLazySingleton<PostRemoteDateSource>(
  //     () => PostRemoteDataSourceImpl(client: sl()));
  // sl.registerLazySingleton<PostLocalDateSource>(
  //     () => PostLocalDateSourceImpl(sharedPreferences: sl()));

  // core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
