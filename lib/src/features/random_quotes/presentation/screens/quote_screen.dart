import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quotes/src/core/utils/app_colors.dart';
import 'package:quotes/src/features/random_quotes/presentation/cubit/random_quote_cubit.dart';
import 'package:quotes/src/features/random_quotes/presentation/cubit/random_quote_states.dart';

import 'package:quotes/src/features/random_quotes/presentation/widgets/quote_content.dart';
import 'package:quotes/src/features/random_quotes/presentation/widgets/quotes_appbar.dart';
import 'package:quotes/src/features/random_quotes/presentation/widgets/referesh_icon.dart';

import 'package:quotes/src/core/widgets/error_widget.dart' as error_widget;

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  Future<void> _getRandomQoute() =>
      BlocProvider.of<RandomQuoteCubit>(context).getRandomQuote();

  @override
  void initState() {
    super.initState();
    _getRandomQoute();
  }

  Widget _buildQuoteContent() {
    return BlocBuilder<RandomQuoteCubit, RandomQuoteStates>(
      builder: (context, state) {
        if (state is RandomQuoteIsLoading) {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primary,
            ),
          );
        } else if (state is RandomQuoteError) {
          return error_widget.ErrorWidget(
            onPress: () => _getRandomQoute(),
          );
        } else if (state is RandomQuoteLoaded) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              QuoteContent(
                quote: state.quote,
              ),
              InkWell(
                  onTap: () => _getRandomQoute(), child: const RefereshIcon()),
            ],
          );
        } else {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primary,
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () => _getRandomQoute(),
        child: Scaffold(
          appBar: const QuotesAppbar(),
          body: Center(
            child: _buildQuoteContent(),
          ),
        ));
  }
}
