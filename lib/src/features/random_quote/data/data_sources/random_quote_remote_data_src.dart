import 'package:quotes/src/core/api/api_consumer.dart';
import 'package:quotes/src/core/api/endpoint.dart';
import 'package:quotes/src/features/random_quote/data/models/quote_model.dart';

abstract class RandomQuoteRemoteDataSrc {
  Future<QuoteModel> getRandomQuote();
}

class RandomQuoteRemoteDataSrcImpl implements RandomQuoteRemoteDataSrc {
  ApiConsumer apiConsumer;
  RandomQuoteRemoteDataSrcImpl({required this.apiConsumer});

  @override
  Future<QuoteModel> getRandomQuote() async {
    final response = await apiConsumer.get(EndPoints.randomQuote);
    return QuoteModel.fromJson(response);
  }
}
