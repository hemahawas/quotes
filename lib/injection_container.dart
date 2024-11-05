import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:quotes/src/core/api/api_consumer.dart';
import 'package:quotes/src/core/api/app_interceptors.dart';
import 'package:quotes/src/core/api/dio_consumer.dart';
import 'package:quotes/src/core/network/network_info.dart';
import 'package:quotes/src/features/random_quotes/data/datasources/random_quote_local_datasource.dart';
import 'package:quotes/src/features/random_quotes/data/datasources/random_quotes_remote_datasource.dart';
import 'package:quotes/src/features/random_quotes/data/repositories/quote_repository_impl.dart';
import 'package:quotes/src/features/random_quotes/domain/repositories/quote_repository.dart';
import 'package:quotes/src/features/random_quotes/domain/usecases/get_random_quote.dart';
import 'package:quotes/src/features/random_quotes/presentation/cubit/random_quote_cubit.dart';
import 'package:quotes/src/features/splash/data/datasources/lang_local_datasource.dart';
import 'package:quotes/src/features/splash/data/repositories/lang_repository_impl.dart';
import 'package:quotes/src/features/splash/domain/repositories/lang_repository.dart';
import 'package:quotes/src/features/splash/domain/usecases/change_lang.dart';
import 'package:quotes/src/features/splash/domain/usecases/get_saved_lang.dart';
import 'package:quotes/src/features/splash/presentation/cubit/locale_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// If there are many features, create a single dependency injection
//for each single feature

final sl = GetIt.instance;

Future<void> init() async {
  //! Features
  // Blocs

  sl.registerFactory(
    () => RandomQuoteCubit(getRandomQuoteUseCase: sl()),
  );

  sl.registerFactory(
    () => LocaleCubit(changeLangUseCase: sl(), getSavedLangUseCase: sl()),
  );

  // Use case
  sl.registerLazySingleton(() => GetRandomQuote(quoteRepository: sl()));

  sl.registerLazySingleton(() => ChangeLangUseCase(langRepository: sl()));
  sl.registerLazySingleton(() => GetSavedLangUseCase(langRepository: sl()));

  //Repository
  sl.registerLazySingleton<QuoteRepository>(() => QuoteRepositoryImpl(
      randomQuotesRemoteDatasource: sl(),
      randomQuoteLocalDatasource: sl(),
      networkInfo: sl()));

  sl.registerLazySingleton<LangRepository>(
    () => LangRepositoryImpl(langLocalDataSource: sl()),
  );
  // Data sources
  sl.registerLazySingleton<RandomQuoteLocalDatasource>(
      () => RandomQuoteLocalDatasourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<RandomQuotesRemoteDatasource>(
      () => RandomQuotesRemoteDatasourceImpl(apiConsumer: sl()));

  sl.registerLazySingleton<LangLocalDataSource>(
      () => LangLocalDataSourceImpl(sharedPreferences: sl()));
  //! Core

  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));

  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => AppInterceptors());
  sl.registerLazySingleton(() => LogInterceptor(
        request: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        requestHeader: true,
      ));
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
