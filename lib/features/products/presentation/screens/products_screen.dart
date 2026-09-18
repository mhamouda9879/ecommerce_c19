import 'package:flutter/material.dart';

import 'package:ecommerce_c19/core/routes/app_routes.dart';
import 'package:ecommerce_c19/core/utils/dummy_data.dart';
import 'package:ecommerce_c19/core/widgets/app_bottom_nav.dart';
import 'package:ecommerce_c19/core/widgets/app_header.dart';
import 'package:ecommerce_c19/features/products/presentation/widgets/product_card.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const products = DummyData.products;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const AppHeader(),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 191 / 237,
                ),
                itemBuilder: (context, index) => ProductCard(
                  product: products[index],
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRoutes.productDetails,
                    arguments: products[index],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // Opened from the Categories tab, so that tab stays highlighted.
      bottomNavigationBar: AppBottomNav(
        currentIndex: 1,
        onTap: (index) => Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.main,
          (_) => false,
          arguments: index,
        ),
      ),
    );
  }
}
