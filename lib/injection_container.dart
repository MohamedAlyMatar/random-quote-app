import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:quotes/src/core/api/api_consumer.dart';
import 'package:quotes/src/core/api/app_interceptor.dart';
import 'package:quotes/src/core/api/dio_consumer.dart';
import 'package:quotes/src/core/network/network_info.dart';
import 'package:quotes/src/features/random_quote/data/data_sources/random_quote_remote_data_src.dart';
import 'package:quotes/src/features/random_quote/data/repos/quote_repo_impl.dart';
import 'package:quotes/src/features/random_quote/domain/repos/quote_repo.dart';
import 'package:quotes/src/features/random_quote/domain/useCases/get_random_quote.dart';
import 'package:quotes/src/features/random_quote/presentation/cubit/random_quote_cubit.dart';
import 'package:quotes/src/features/splash/data/datasources/lang_local_data_src.dart';
import 'package:quotes/src/features/splash/data/repositories/lang_repo_impl.dart';
import 'package:quotes/src/features/splash/domain/repositories/lang_repo.dart';
import 'package:quotes/src/features/splash/domain/usecases/change_lang.dart';
import 'package:quotes/src/features/splash/domain/usecases/get_saved_lang.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'src/features/random_quote/data/data_sources/random_quote_local_data_src.dart';
import 'package:http/http.dart' as http;

// import 'src/features/splash/presentation/cubit/locale_cubit.dart';
import 'package:quotes/src/features/splash/presentation/cubit/locale_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  // Blocs
  sl.registerFactory(() => RandomQuoteCubit(getRandomQuoteUseCase: sl.call()));
  sl.registerFactory<LocaleCubit>(
      () => LocaleCubit(getSavedLangUseCase: sl(), changeLangUseCase: sl()));

  // use cases
  sl.registerLazySingleton(() => GetRandomQuote(quoteRepository: sl.call()));
  sl.registerLazySingleton<GetSavedLangUseCase>(
      () => GetSavedLangUseCase(langRepo: sl()));
  sl.registerLazySingleton<ChangeLangUseCase>(
      () => ChangeLangUseCase(langRepo: sl()));

  // repository
  sl.registerLazySingleton<QuoteRepo>(() => QuoteRepoImpl(
      networkInfo: sl.call(),
      randomQuoteRemoteDataSrc: sl.call(),
      randomQuoteLocalDataSrc: sl.call()));
  sl.registerLazySingleton<LangRepo>(
      () => LangRepoImpl(langLocalDataSrc: sl()));

  // data sources
  sl.registerLazySingleton<RandomQuoteRemoteDataSrc>(
      () => RandomQuoteRemoteDataSrcImpl(apiConsumer: sl.call()));
  sl.registerLazySingleton<RandomQuoteLocalDataSrc>(
      () => RandomQuoteLocalDataSrcImpl(sharedPreferences: sl.call()));
  sl.registerLazySingleton<LangLocalDataSrc>(
      () => LangLocalDataSrcImpl(sharedPreferences: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(internetConnectionChecker: sl.call()));
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl.call()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => AppInterceptor());
  sl.registerLazySingleton(() => LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        logPrint: (object) => print(object.toString()),
      ));
  sl.registerLazySingleton(() => Dio());
}
