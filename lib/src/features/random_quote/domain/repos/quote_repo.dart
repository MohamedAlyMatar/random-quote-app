import 'package:dartz/dartz.dart';
import 'package:quotes/src/core/errors/failures.dart';
import '../entities/quote.dart';

abstract class QuoteRepo {
  Future<Either<Failures, Quote>> getRandomQuote();
}