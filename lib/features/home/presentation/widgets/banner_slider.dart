import 'package:flutter/material.dart';

import 'package:ecommerce_c19/core/utils/app_assets.dart';

/// Swipeable offer banners. The page dots are drawn inside each banner image.
class BannerSlider extends StatelessWidget {
  const BannerSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width - 32;

    return SizedBox(
      height: width * 200 / 396,
      child: PageView.builder(
        itemCount: AppAssets.banners.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(AppAssets.banners[index], fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
