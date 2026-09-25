import 'package:flutter/material.dart';

import 'package:ecommerce_c19/core/theme/app_colors.dart';
import 'package:ecommerce_c19/core/utils/price_formatter.dart';
import 'package:ecommerce_c19/core/widgets/app_network_image.dart';
import 'package:ecommerce_c19/core/widgets/quantity_stepper.dart';
import 'package:ecommerce_c19/features/cart/domain/entities/cart_entity.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key,
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
    required this.onDelete,
  });

  final CartItemEntity item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
    final borderRadius = BorderRadius.circular(15);

    return Container(
      height: 113,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: borderRadius,
      ),
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
              child: AppNetworkImage(item.imageCover),
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
                          item.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: titleStyle,
                        ),
                      ),
                      InkResponse(
                        onTap: onDelete,
                        child: const Icon(
                          Icons.delete_outline,
                          color: AppColors.darkText,
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
                          child: Text(
                            formatPrice(item.price),
                            style: titleStyle,
                          ),
                        ),
                      ),
                      QuantityStepper(
                        quantity: item.count,
                        onIncrement: onIncrement,
                        onDecrement: onDecrement,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
