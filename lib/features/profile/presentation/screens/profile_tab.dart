import 'package:flutter/material.dart';

import 'package:ecommerce_c19/core/theme/app_colors.dart';
import 'package:ecommerce_c19/core/utils/dummy_data.dart';
import 'package:ecommerce_c19/core/widgets/app_header.dart';
import 'package:ecommerce_c19/features/profile/presentation/widgets/profile_field.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    const user = DummyData.user;

    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        const AppHeader(showSearch: false),
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
              ProfileField(label: 'Your full name', value: user.name),
              const SizedBox(height: 24),
              ProfileField(label: 'Your E-mail', value: user.email),
              const SizedBox(height: 24),
              ProfileField(
                label: 'Your password',
                value: user.password,
                obscure: true,
              ),
              const SizedBox(height: 24),
              ProfileField(label: 'Your mobile number', value: user.phone),
              const SizedBox(height: 24),
              ProfileField(label: 'Your Address', value: user.address),
            ],
          ),
        ),
      ],
    );
  }
}
