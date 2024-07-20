import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:quotes/src/core/errors/exceptions.dart';
import 'package:quotes/src/core/errors/failures.dart';
import 'package:quotes/src/core/network/network_info.dart';
import 'package:quotes/src/features/random_quote/data/data_sources/random_quote_local_data_src.dart';
import 'package:quotes/src/features/random_quote/data/data_sources/random_quote_remote_data_src.dart';
import 'package:quotes/src/features/random_quote/domain/entities/quote.dart';
import 'package:quotes/src/features/random_quote/domain/repos/quote_repo.dart';

class QuoteRepoImpl implements QuoteRepo {
  final NetworkInfo networkInfo;
  final RandomQuoteRemoteDataSrc randomQuoteRemoteDataSrc;
  final RandomQuoteLocalDataSrc randomQuoteLocalDataSrc;

  QuoteRepoImpl({
    required this.networkInfo,
    required this.randomQuoteRemoteDataSrc,
    required this.randomQuoteLocalDataSrc,
  });

  @override
  Future<Either<Failures, Quote>> getRandomQuote() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteQuote = await randomQuoteRemoteDataSrc.getRandomQuote();
        randomQuoteLocalDataSrc.cacheQuote(remoteQuote);
        return right(remoteQuote);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localQuote = await randomQuoteLocalDataSrc.getLastRandomQuote();
        return right(localQuote);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
