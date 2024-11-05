import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quotes/src/config/routes/app_routes.dart';
import 'package:quotes/src/core/utils/assets_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  _goNext() => Navigator.pushReplacementNamed(context, Routes.randomQuoteRoute);

  _start() {
    _timer = Timer(const Duration(seconds: 2), () => _goNext());
  }

  @override
  void initState() {
    super.initState();
    _start();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Image.asset(ImgAssets.quoteImage),
        ),
      ),
    );
  }
}
