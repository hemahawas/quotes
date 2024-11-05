import 'package:quotes/src/core/api/api_consumer.dart';
import 'package:quotes/src/core/api/end_points.dart';
import 'package:quotes/src/features/random_quotes/data/models/quote_model.dart';

abstract class RandomQuotesRemoteDatasource {
  Future<QuoteModel> getRandomQuote();
}

// Here we need a package that access to API

class RandomQuotesRemoteDatasourceImpl implements RandomQuotesRemoteDatasource {
  ApiConsumer apiConsumer;
  RandomQuotesRemoteDatasourceImpl({required this.apiConsumer});

  @override
  Future<QuoteModel> getRandomQuote() async {
    final response = await apiConsumer.get(EndPoints.randomQuote);
    return QuoteModel.fromJson(response);
  }
}
