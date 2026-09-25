import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce_c19/core/routes/app_routes.dart';
import 'package:ecommerce_c19/core/theme/app_colors.dart';
import 'package:ecommerce_c19/core/utils/validators.dart';
import 'package:ecommerce_c19/core/widgets/app_header.dart';
import 'package:ecommerce_c19/di.dart';
import 'package:ecommerce_c19/features/auth/domain/use_cases/logout_usecase.dart';
import 'package:ecommerce_c19/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:ecommerce_c19/features/profile/presentation/bloc/profile_events.dart';
import 'package:ecommerce_c19/features/profile/presentation/bloc/profile_states.dart';
import 'package:ecommerce_c19/features/profile/presentation/widgets/edit_profile_dialogs.dart';
import 'package:ecommerce_c19/features/profile/presentation/widgets/profile_field.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  Future<void> _logout(BuildContext context) async {
    await getIt<LogoutUseCase>()();
    if (!context.mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (_) => false);
  }

  Future<void> _edit(
    BuildContext context, {
    required String title,
    required String value,
    required UpdateProfileEvent Function(String value) toEvent,
    FormFieldValidator<String>? validator,
    TextInputType? keyboardType,
  }) async {
    final newValue = await showEditFieldDialog(
      context,
      title: title,
      initialValue: value,
      validator: validator,
      keyboardType: keyboardType,
    );
    if (newValue == null || newValue == value || !context.mounted) return;
    context.read<ProfileBloc>().add(toEvent(newValue));
  }

  Future<void> _changePassword(BuildContext context) async {
    final passwords = await showChangePasswordDialog(context);
    if (passwords == null || !context.mounted) return;
    context.read<ProfileBloc>().add(
      ChangePasswordEvent(
        currentPassword: passwords.currentPassword,
        newPassword: passwords.newPassword,
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) =>
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileBloc>()..add(GetProfileEvent()),
      child: MultiBlocListener(
        listeners: [
          BlocListener<ProfileBloc, ProfileState>(
            listenWhen: (previous, current) =>
                previous.updateProfileRequestStatus !=
                current.updateProfileRequestStatus,
            listener: (context, state) =>
                switch (state.updateProfileRequestStatus) {
                  RequestStatus.success => _showSnackBar(
                    context,
                    'Profile updated',
                  ),
                  RequestStatus.error => _showSnackBar(
                    context,
                    state.errorMessage ?? 'Could not update profile',
                  ),
                  _ => null,
                },
          ),
          BlocListener<ProfileBloc, ProfileState>(
            listenWhen: (previous, current) =>
                previous.changePasswordRequestStatus !=
                current.changePasswordRequestStatus,
            listener: (context, state) =>
                switch (state.changePasswordRequestStatus) {
                  RequestStatus.success => _showSnackBar(
                    context,
                    'Password changed',
                  ),
                  RequestStatus.error => _showSnackBar(
                    context,
                    state.errorMessage ?? 'Could not change password',
                  ),
                  _ => null,
                },
          ),
        ],
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            final user = state.user;
            final isSaving =
                state.updateProfileRequestStatus == RequestStatus.loading ||
                state.changePasswordRequestStatus == RequestStatus.loading;

            return ListView(
              padding: const EdgeInsets.only(bottom: 24),
              children: [
                const AppHeader(showSearch: false),
                if (isSaving)
                  const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: LinearProgressIndicator(color: AppColors.primary),
                  ),
                if (user != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        Text(
                          'Welcome, ${user.name.split(' ').first}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          user.email,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.greyText,
                          ),
                        ),
                        const SizedBox(height: 40),
                        ProfileField(
                          label: 'Your full name',
                          value: user.name,
                          onEdit: () => _edit(
                            context,
                            title: 'Full name',
                            value: user.name,
                            toEvent: (name) => UpdateProfileEvent(name: name),
                          ),
                        ),
                        const SizedBox(height: 24),
                        ProfileField(
                          label: 'Your E-mail',
                          value: user.email,
                          onEdit: () => _edit(
                            context,
                            title: 'E-mail',
                            value: user.email,
                            validator: Validators.email,
                            keyboardType: TextInputType.emailAddress,
                            toEvent: (email) =>
                                UpdateProfileEvent(email: email),
                          ),
                        ),
                        const SizedBox(height: 24),
                        ProfileField(
                          label: 'Your password',
                          // The real password is never stored.
                          value: '********',
                          obscure: true,
                          onEdit: () => _changePassword(context),
                        ),
                        const SizedBox(height: 24),
                        ProfileField(
                          label: 'Your mobile number',
                          value: user.phone,
                          onEdit: () => _edit(
                            context,
                            title: 'Mobile number',
                            value: user.phone,
                            keyboardType: TextInputType.phone,
                            toEvent: (phone) =>
                                UpdateProfileEvent(phone: phone),
                          ),
                        ),
                        const SizedBox(height: 32),
                        TextButton.icon(
                          onPressed: () => _logout(context),
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            padding: EdgeInsets.zero,
                          ),
                          icon: const Icon(Icons.logout),
                          label: const Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
