import 'package:ecommerce_c19/di.dart';
import 'package:ecommerce_c19/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_c19/features/auth/presentation/bloc/auth_events.dart';
import 'package:ecommerce_c19/features/auth/presentation/bloc/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    BlocProvider.of<AuthBloc>(context).add(
      SignInWithEmailAndPasswordEvent(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listenWhen: (previous, current) =>
            previous.signInRequestStatus != current.signInRequestStatus,
        listener: (context, state) {
          if (state.signInRequestStatus == RequestStatus.success) {
            Navigator.pushReplacementNamed(context, AppRoutes.main);
          } else if (state.signInRequestStatus == RequestStatus.error) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? 'An error occurred'),
                ),
              );
          }
        },
        builder: (context, state) {
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
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: Validators.email,
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
                      AuthButton(
                        text: 'Login',
                        isLoading:
                            state.signInRequestStatus == RequestStatus.loading,
                        onPressed: () => _login(context),
                      ),
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
        },
      ),
    );
  }
}
