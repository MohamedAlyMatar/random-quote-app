import 'package:dartz/dartz.dart';
import 'package:quotes/src/core/errors/failures.dart';
import 'package:quotes/src/core/use_cases/use_case.dart';
import 'package:quotes/src/features/random_quote/domain/entities/quote.dart';
import 'package:quotes/src/features/random_quote/domain/repos/quote_repo.dart';

class GetRandomQuote implements UseCase<Quote, NoParams> {
  final QuoteRepo quoteRepository;

  GetRandomQuote({required this.quoteRepository});
  @override
  Future<Either<Failures, Quote>> call(NoParams params) =>
      quoteRepository.getRandomQuote();
}