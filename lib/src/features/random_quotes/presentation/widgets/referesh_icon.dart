import 'package:flutter/material.dart';
import 'package:quotes/src/core/utils/app_colors.dart';

class RefereshIcon extends StatelessWidget {
  const RefereshIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary,
      ),
      child: const Icon(Icons.refresh,color: Colors.white,size: 50.0,),
    );
  }
}