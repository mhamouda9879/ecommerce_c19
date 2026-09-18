import 'package:ecommerce_c19/di.dart';
import 'package:ecommerce_c19/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_c19/features/auth/presentation/bloc/auth_events.dart';
import 'package:ecommerce_c19/features/auth/presentation/bloc/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_c19/core/theme/app_colors.dart';
import 'package:ecommerce_c19/core/routes/app_routes.dart';
import 'package:ecommerce_c19/core/utils/app_assets.dart';
import 'package:ecommerce_c19/core/utils/validators.dart';
import 'package:ecommerce_c19/features/auth/presentation/widgets/auth_button.dart';
import 'package:ecommerce_c19/features/auth/presentation/widgets/auth_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.signUpRequestStatus == RequestStatus.success) {
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          } else if (state.signUpRequestStatus == RequestStatus.error) {
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
                      const SizedBox(height: 40),
                      AuthTextField(
                        label: 'Full Name',
                        hint: 'enter your full name',
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                        validator: Validators.required,
                      ),
                      const SizedBox(height: 28),
                      AuthTextField(
                        label: 'Mobile Number',
                        hint: 'enter your mobile no.',
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        validator: Validators.required,
                      ),
                      const SizedBox(height: 28),
                      AuthTextField(
                        label: 'E-mail address',
                        hint: 'enter your email address',
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
                        validator: Validators.password,
                      ),
                      const SizedBox(height: 56),
                      AuthButton(
                        text: 'Sign up',
                        isLoading:
                            state.signUpRequestStatus == RequestStatus.loading,
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) return;

                          BlocProvider.of<AuthBloc>(context).add(
                            SignUpWithEmailAndPasswordEvent(
                              email: _emailController.text,
                              password: _passwordController.text,
                              name: _nameController.text,
                              phone: _phoneController.text,
                            ),
                          );
                        },
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
