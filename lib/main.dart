import 'package:ecommerce_c19/di.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce_c19/core/routes/app_routes.dart';
import 'package:ecommerce_c19/core/theme/app_theme.dart';
import 'package:ecommerce_c19/features/auth/presentation/screens/login_screen.dart';
import 'package:ecommerce_c19/features/auth/presentation/screens/register_screen.dart';
import 'package:ecommerce_c19/features/cart/presentation/screens/cart_screen.dart';
import 'package:ecommerce_c19/features/main_layout/presentation/screens/main_layout_screen.dart';
import 'package:ecommerce_c19/features/products/presentation/screens/product_details_screen.dart';
import 'package:ecommerce_c19/features/products/presentation/screens/products_screen.dart';
import 'package:ecommerce_c19/features/splash/presentation/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Route',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (_) => const SplashScreen(),
        AppRoutes.login: (_) => const LoginScreen(),
        AppRoutes.register: (_) => const RegisterScreen(),
        AppRoutes.main: (context) => MainLayoutScreen(
          initialIndex: ModalRoute.of(context)?.settings.arguments as int? ?? 0,
        ),
        AppRoutes.products: (_) => const ProductsScreen(),
        AppRoutes.productDetails: (_) => const ProductDetailsScreen(),
        AppRoutes.cart: (_) => const CartScreen(),
      },
    );
  }
}
