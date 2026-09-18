import 'package:flutter/material.dart';

import 'package:ecommerce_c19/core/theme/app_colors.dart';
import 'package:ecommerce_c19/core/utils/dummy_data.dart';
import 'package:ecommerce_c19/core/utils/price_formatter.dart';
import 'package:ecommerce_c19/core/widgets/app_network_image.dart';
import 'package:ecommerce_c19/core/widgets/favorite_button.dart';

class WishlistItemCard extends StatelessWidget {
  const WishlistItemCard({super.key, required this.item, required this.onTap});

  final DummyWishlistItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
    final product = item.product;
    final borderRadius = BorderRadius.circular(15);

    return Material(
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppColors.border),
        borderRadius: borderRadius,
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 113,
          child: Row(
            children: [
              Container(
                width: 120,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.border),
                  borderRadius: borderRadius,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: AppNetworkImage(product.imageCover),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              product.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: titleStyle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          FavoriteButton(isFavorite: true, onTap: () {}),
                        ],
                      ),
                      Row(
                        children: [
                          CircleAvatar(radius: 7, backgroundColor: item.color),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              '${item.colorName} color',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Text(
                                    formatPrice(product.price),
                                    style: titleStyle,
                                  ),
                                  if (product.oldPrice case final oldPrice?)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Text(
                                        formatPrice(oldPrice),
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: AppColors.oldPrice,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          decorationColor: AppColors.oldPrice,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.white,
                              elevation: 0,
                              minimumSize: const Size(0, 36),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: const Text(
                              'Add to Cart',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
