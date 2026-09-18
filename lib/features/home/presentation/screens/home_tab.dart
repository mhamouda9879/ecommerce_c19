import 'package:flutter/material.dart';

import 'package:ecommerce_c19/core/widgets/app_header.dart';
import 'package:ecommerce_c19/features/home/presentation/widgets/banner_slider.dart';

// No design for this tab yet: only the header and the banner slider from assets.
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 16),
      children: const [AppHeader(), SizedBox(height: 16), BannerSlider()],
    );
  }
}
