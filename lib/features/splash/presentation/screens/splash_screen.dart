import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:ecommerce_c19/core/theme/app_colors.dart';
import 'package:ecommerce_c19/core/utils/app_assets.dart';
import 'package:ecommerce_c19/core/routes/app_routes.dart';
import 'package:ecommerce_c19/di.dart';
import 'package:ecommerce_c19/features/auth/domain/use_cases/is_logged_in_usecase.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _openNextScreen();
  }

  Future<void> _openNextScreen() async {
    final (isLoggedIn, _) = await (
      getIt<IsLoggedInUseCase>()(),
      Future<void>.delayed(const Duration(seconds: 2)),
    ).wait;
    if (!mounted) return;
    Navigator.pushReplacementNamed(
      context,
      isLoggedIn ? AppRoutes.main : AppRoutes.login,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          const _Glow(alignment: Alignment.topCenter),
          const _Glow(alignment: Alignment.bottomCenter),
          Center(child: Image.asset(AppAssets.logo, width: 295)),
        ],
      ),
    );
  }
}

/// Soft light ellipse bleeding in from the top or bottom edge.
class _Glow extends StatelessWidget {
  const _Glow({required this.alignment});

  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Align(
      alignment: alignment,
      child: FractionalTranslation(
        translation: Offset(0, alignment.y * 0.45),
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
          child: Container(
            width: size.width * 1.2,
            height: size.height * 0.4,
            decoration: ShapeDecoration(
              shape: const OvalBorder(),
              color: Colors.white.withValues(alpha: 0.45),
            ),
          ),
        ),
      ),
    );
  }
}
