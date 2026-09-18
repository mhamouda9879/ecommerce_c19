import 'package:flutter/material.dart';

import 'package:ecommerce_c19/core/widgets/app_header.dart';
import 'package:ecommerce_c19/features/home/presentation/widgets/banner_slider.dart';
import 'package:ecommerce_c19/features/home/presentation/widgets/home_categories_section.dart';

// No design for this tab yet: header, banner slider and categories.
class HomeTab extends StatelessWidget {
  const HomeTab({super.key, required this.onViewAllCategories});

  final VoidCallback onViewAllCategories;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 16),
      children: [
        const AppHeader(),
        const SizedBox(height: 16),
        const BannerSlider(),
        const SizedBox(height: 24),
        HomeCategoriesSection(onViewAll: onViewAllCategories),
      ],
    );
  }
}
