import 'package:flutter/material.dart';

import 'package:ecommerce_c19/core/theme/app_colors.dart';
import 'package:ecommerce_c19/core/utils/dummy_data.dart';
import 'package:ecommerce_c19/core/utils/price_formatter.dart';
import 'package:ecommerce_c19/core/widgets/app_network_image.dart';
import 'package:ecommerce_c19/core/widgets/quantity_stepper.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key,
    required this.item,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    required this.onDelete,
  });

  final DummyCartItem item;
  final int quantity;
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
              child: AppNetworkImage(item.product.imageCover),
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
                          item.product.title,
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
                  Row(
                    children: [
                      CircleAvatar(radius: 8, backgroundColor: item.color),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${item.colorName} | Size: ${item.size}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.greyText,
                          ),
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
                            formatPrice(item.product.price),
                            style: titleStyle,
                          ),
                        ),
                      ),
                      QuantityStepper(
                        quantity: quantity,
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
