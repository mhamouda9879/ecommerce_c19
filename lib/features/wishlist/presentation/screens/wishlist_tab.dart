import 'package:flutter/material.dart';

import 'package:ecommerce_c19/core/routes/app_routes.dart';
import 'package:ecommerce_c19/core/utils/dummy_data.dart';
import 'package:ecommerce_c19/core/widgets/app_header.dart';
import 'package:ecommerce_c19/features/wishlist/presentation/widgets/wishlist_item_card.dart';

class WishlistTab extends StatelessWidget {
  const WishlistTab({super.key});

  @override
  Widget build(BuildContext context) {
    const items = DummyData.wishlist;

    return Column(
      children: [
        const AppHeader(),
        const SizedBox(height: 24),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(height: 24),
            itemBuilder: (context, index) => WishlistItemCard(
              item: items[index],
              onTap: () => Navigator.pushNamed(
                context,
                AppRoutes.productDetails,
                arguments: items[index].product.id,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
