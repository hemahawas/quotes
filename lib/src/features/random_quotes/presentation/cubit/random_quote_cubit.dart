import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:quotes/src/core/error/failure.dart';
import 'package:quotes/src/core/usecase/usecase.dart';
import 'package:quotes/src/core/utils/app_strings.dart';
import 'package:quotes/src/features/random_quotes/domain/entities/quote.dart';
import 'package:quotes/src/features/random_quotes/domain/usecases/get_random_quote.dart';
import 'package:quotes/src/features/random_quotes/presentation/cubit/random_quote_states.dart';

class RandomQuoteCubit extends Cubit<RandomQuoteStates> {
  final GetRandomQuote getRandomQuoteUseCase;

  RandomQuoteCubit({required this.getRandomQuoteUseCase})
      : super(RandomQuoteInitial());

  Future<void> getRandomQuote() async {
    emit(RandomQuoteIsLoading());
    Either<Failure, Quote> response = await getRandomQuoteUseCase(NoParams());
    emit(response.fold(
        (failure) => RandomQuoteError(msg: _mapFailureTOMsg(failure)),
        (quote) => RandomQuoteLoaded(quote: quote)));
  }
}

String _mapFailureTOMsg(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return AppStrings.serverFailure;
    case CacheFailure:
      return AppStrings.cacheFailure;
    default:
      return AppStrings.unexpectedError;
  }
}
