import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/src/config/locale/app_localizations.dart';
import 'package:quotes/src/core/utils/app_colors.dart';
import 'package:quotes/src/features/splash/presentation/cubit/locale_cubit.dart';

class QuotesAppbar extends StatelessWidget implements PreferredSizeWidget {
  const QuotesAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () {
            if (AppLocalizations.of(context)!.isEnLocale) {
              BlocProvider.of<LocaleCubit>(context).toArabic();
            } else {
              BlocProvider.of<LocaleCubit>(context).toEnglish();
            }
          },
          icon: Icon(
            Icons.translate_outlined,
            color: AppColors.primary,
          )),
      title: Text(AppLocalizations.of(context)!.translate('app_name')!),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
