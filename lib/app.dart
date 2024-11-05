import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/src/config/locale/app_localizations_setup.dart';
import 'package:quotes/src/config/routes/app_routes.dart';
import 'package:quotes/src/config/themes/app_theme.dart';
import 'package:quotes/src/core/utils/app_strings.dart';
import 'package:quotes/src/features/splash/presentation/cubit/locale_cubit.dart';
import 'package:quotes/src/features/splash/presentation/cubit/locale_states.dart';
import 'package:quotes/src/features/splash/presentation/screens/splash_screen.dart';
import 'injection_container.dart' as di;

class QuotesApp extends StatelessWidget {
  const QuotesApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => di.sl<LocaleCubit>()),
        ],
        child: BlocBuilder<LocaleCubit, LocaleState>(
            buildWhen: (previousState, currentState) {
              return previousState != currentState;
            },
            builder: (context, state) => MaterialApp(
                  title: AppStrings.appName,
                  theme: appTheme(),
                  locale: state.locale,
                  debugShowCheckedModeBanner: false,
                  home: const SplashScreen(),
                  onGenerateRoute: AppRoutes.onGenerateRoute,
                  supportedLocales: AppLocalizationsSetup.supportedLocales,
                  localeResolutionCallback:
                      AppLocalizationsSetup.localeResolutionCallback,
                  localizationsDelegates:
                      AppLocalizationsSetup.localizationsDelegates,
                )));
  }
}
