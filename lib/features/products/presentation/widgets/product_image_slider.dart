import 'package:flutter/material.dart';

import 'package:ecommerce_c19/core/theme/app_colors.dart';
import 'package:ecommerce_c19/core/widgets/app_network_image.dart';
import 'package:ecommerce_c19/core/widgets/favorite_button.dart';

/// Swipeable product images with a favorite button and page indicator.
class ProductImageSlider extends StatefulWidget {
  const ProductImageSlider({super.key, required this.images});

  final List<String> images;

  @override
  State<ProductImageSlider> createState() => _ProductImageSliderState();
}

class _ProductImageSliderState extends State<ProductImageSlider> {
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(
          fit: StackFit.expand,
          children: [
            PageView.builder(
              itemCount: widget.images.length,
              onPageChanged: (page) => setState(() => _page = page),
              itemBuilder: (context, index) =>
                  AppNetworkImage(widget.images[index]),
            ),
            Positioned(
              top: 14,
              right: 14,
              child: FavoriteButton(isFavorite: false, onTap: () {}),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < widget.images.length; i++)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: i == _page ? 30 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: i == _page ? AppColors.primary : null,
                        border: Border.all(color: AppColors.primary),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
