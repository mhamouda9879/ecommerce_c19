import 'package:flutter/material.dart';

import 'package:ecommerce_c19/core/theme/app_colors.dart';
import 'package:ecommerce_c19/core/utils/dummy_data.dart';
import 'package:ecommerce_c19/core/utils/price_formatter.dart';
import 'package:ecommerce_c19/core/widgets/app_network_image.dart';
import 'package:ecommerce_c19/core/widgets/favorite_button.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, required this.onTap});

  final DummyProduct product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 14);

    return Material(
      color: AppColors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppColors.border),
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AppNetworkImage(product.imageCover),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: FavoriteButton(isFavorite: false, onTap: () {}),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textStyle,
                  ),
                  Text(
                    product.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textStyle,
                  ),
                  const SizedBox(height: 4),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text(formatPrice(product.price), style: textStyle),
                        if (product.oldPrice case final oldPrice?) ...[
                          const SizedBox(width: 12),
                          Text(
                            formatPrice(oldPrice),
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.oldPrice,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: AppColors.oldPrice,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                'Review (${product.rating.toStringAsFixed(1)})',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.star,
                              color: AppColors.star,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                      const _AddButton(),
                    ],
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

class _AddButton extends StatelessWidget {
  const _AddButton();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primary,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: () {},
        customBorder: const CircleBorder(),
        child: const SizedBox.square(
          dimension: 30,
          child: Icon(Icons.add, color: AppColors.white, size: 20),
        ),
      ),
    );
  }
}
