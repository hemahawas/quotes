import 'package:dartz/dartz.dart';
import 'package:quotes/src/core/error/exceptions.dart';
import 'package:quotes/src/core/error/failure.dart';
import 'package:quotes/src/core/network/network_info.dart';
import 'package:quotes/src/features/random_quotes/data/datasources/random_quote_local_datasource.dart';
import 'package:quotes/src/features/random_quotes/data/datasources/random_quotes_remote_datasource.dart';
import 'package:quotes/src/features/random_quotes/domain/entities/quote.dart';
import 'package:quotes/src/features/random_quotes/domain/repositories/quote_repository.dart';

class QuoteRepositoryImpl implements QuoteRepository {
  final NetworkInfo networkInfo;
  final RandomQuotesRemoteDatasource randomQuotesRemoteDatasource;
  final RandomQuoteLocalDatasource randomQuoteLocalDatasource;

  QuoteRepositoryImpl(
      {required this.randomQuotesRemoteDatasource,
      required this.randomQuoteLocalDatasource,
      required this.networkInfo});

  @override
  Future<Either<Failure, Quote>> getRandomQuote() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteQuote = await randomQuotesRemoteDatasource.getRandomQuote();
        randomQuoteLocalDatasource.cacheRandomQuote(remoteQuote);
        return Right(remoteQuote);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localQuote =
            await randomQuoteLocalDatasource.getLastRandomQuote();
        return Right(localQuote);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
