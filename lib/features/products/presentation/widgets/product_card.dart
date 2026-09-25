import 'package:ecommerce_c19/di.dart';
import 'package:ecommerce_c19/features/products/presentation/bloc/products_bloc.dart';
import 'package:ecommerce_c19/features/products/presentation/bloc/products_events.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce_c19/core/theme/app_colors.dart';
import 'package:ecommerce_c19/core/utils/price_formatter.dart';
import 'package:ecommerce_c19/core/widgets/app_network_image.dart';
import 'package:ecommerce_c19/features/products/domain/entities/product_entity.dart';
import 'package:ecommerce_c19/features/wishlist/presentation/widgets/wishlist_button.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, required this.onTap});

  final ProductEntity product;
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
                    child: WishlistButton(product: product),
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
                        Text(formatPrice(product.finalPrice), style: textStyle),
                        if (product.priceAfterDiscount != null) ...[
                          const SizedBox(width: 12),
                          Text(
                            formatPrice(product.price),
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
                                'Review (${product.ratingsAverage.toStringAsFixed(1)})',
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
                      _AddButton(product.id),
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
  String productId;
  _AddButton(this.productId);

  @override
  Widget build(BuildContext context) {
    print('productId: $productId');
    return Material(
      color: AppColors.primary,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: () {
          getIt<ProductsBloc>().add(AddToCartEvent(productId));
        },
        customBorder: const CircleBorder(),
        child: const SizedBox.square(
          dimension: 30,
          child: Icon(Icons.add, color: AppColors.white, size: 20),
        ),
      ),
    );
  }
}
