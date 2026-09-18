import 'package:flutter/material.dart';

import 'package:ecommerce_c19/core/widgets/app_network_image.dart';

/// Round category image with the name underneath.
class HomeCategoryItem extends StatelessWidget {
  const HomeCategoryItem({
    super.key,
    required this.name,
    required this.image,
    required this.onTap,
  });

  final String name;
  final String image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: ClipOval(child: AppNetworkImage(image)),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
