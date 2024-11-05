import 'package:dartz/dartz.dart';
import 'package:quotes/src/core/error/failure.dart';
import 'package:quotes/src/features/random_quotes/domain/entities/quote.dart';

abstract class QuoteRepository {
  Future<Either<Failure, Quote>> getRandomQuote();
}
