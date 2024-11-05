import 'package:dartz/dartz.dart';
import 'package:quotes/src/core/error/failure.dart';
import 'package:quotes/src/core/usecase/usecase.dart';
import 'package:quotes/src/features/random_quotes/domain/entities/quote.dart';
import 'package:quotes/src/features/random_quotes/domain/repositories/quote_repository.dart';

class GetRandomQuote implements Usecase<Quote, NoParams> {
  final QuoteRepository quoteRepository;

  GetRandomQuote({required this.quoteRepository});

  @override
  Future<Either<Failure, Quote>> call(NoParams params) =>
      quoteRepository.getRandomQuote();
}
