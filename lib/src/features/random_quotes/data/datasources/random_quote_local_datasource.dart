import 'dart:convert';

import 'package:quotes/src/core/error/exceptions.dart';
import 'package:quotes/src/core/utils/app_strings.dart';
import 'package:quotes/src/features/random_quotes/data/models/quote_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class RandomQuoteLocalDatasource {
  Future<QuoteModel> getLastRandomQuote();
  Future<void> cacheRandomQuote(QuoteModel quote);
  // in data layer, I use the model, not entity.
}

//Here we need a package that can store the data locally
class RandomQuoteLocalDatasourceImpl implements RandomQuoteLocalDatasource {
  SharedPreferences sharedPreferences;

  RandomQuoteLocalDatasourceImpl({required this.sharedPreferences});

  @override
  Future<QuoteModel> getLastRandomQuote() {
    final jsonString =
        sharedPreferences.getString(AppStrings.cachedRandomQuote);
    if (jsonString != null) {
      final cacheRemoteQuote =
          Future.value(QuoteModel.fromJson(json.decode(jsonString)));
      return cacheRemoteQuote;
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheRandomQuote(QuoteModel quote) {
    return sharedPreferences.setString(
        AppStrings.cachedRandomQuote, json.encode(quote));
  }
}
