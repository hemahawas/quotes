import 'package:equatable/equatable.dart';
import 'package:quotes/src/features/random_quotes/domain/entities/quote.dart';

abstract class RandomQuoteStates extends Equatable {
  // what is the meaning of that?
  const RandomQuoteStates();

  @override
  List<Object> get props => [];
}

class RandomQuoteInitial extends RandomQuoteStates {}

class RandomQuoteIsLoading extends RandomQuoteStates {}

class RandomQuoteLoaded extends RandomQuoteStates {
  final Quote quote;

  const RandomQuoteLoaded({required this.quote});

  @override
  List<Object> get props => [quote];
}

class RandomQuoteError extends RandomQuoteStates {
  final String msg;

  const RandomQuoteError({required this.msg});

  @override
  List<Object> get props => [msg];
}
