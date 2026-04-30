import 'dart:async';

import 'package:flutter/material.dart';

import 'package:quran_app/config/app/const/image_const.dart';
import 'package:quran_app/config/app/const/page_const.dart';
import 'package:quran_app/config/app/theme/app_colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(PageConst.navigationPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black500,
      body: Center(
        child: ShaderMask(
          shaderCallback:
              (bounds) => LinearGradient(
                colors: [
                  AppColors.green500,

                  AppColors.orangeRed500,
                  AppColors.yellow500,
                  AppColors.blue500,
                ],
              ).createShader(bounds),
          child: Image.asset(
            AppImages.splash,
            scale: 1.5,
            color: Colors.white,
            colorBlendMode: BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
