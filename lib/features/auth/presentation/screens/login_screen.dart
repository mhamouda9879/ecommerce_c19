import 'package:flutter/material.dart';

import 'package:ecommerce_c19/core/utils/app_assets.dart';
import 'package:ecommerce_c19/core/theme/app_colors.dart';
import 'package:ecommerce_c19/core/routes/app_routes.dart';
import 'package:ecommerce_c19/core/utils/validators.dart';
import 'package:ecommerce_c19/features/auth/presentation/widgets/auth_button.dart';
import 'package:ecommerce_c19/features/auth/presentation/widgets/auth_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (!_formKey.currentState!.validate()) return;
    // TODO: call the sign-in API before navigating.
    Navigator.pushReplacementNamed(context, AppRoutes.main);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 40, 16, 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Image.asset(AppAssets.logo, width: 240)),
                const SizedBox(height: 80),
                const Text(
                  'Welcome Back To Route',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  'Please sign in with your mail',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 32),
                AuthTextField(
                  label: 'User Name',
                  hint: 'enter your name',
                  controller: _nameController,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.required,
                ),
                const SizedBox(height: 28),
                AuthTextField(
                  label: 'Password',
                  hint: 'enter your password',
                  controller: _passwordController,
                  textInputAction: TextInputAction.done,
                  isPassword: true,
                  validator: Validators.required,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.white,
                      padding: EdgeInsets.zero,
                    ),
                    child: const Text(
                      'Forgot password',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 44),
                AuthButton(text: 'Login', onPressed: _login),
                const SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.register),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.white,
                    ),
                    child: const Text(
                      'Don’t have an account? Create Account',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
