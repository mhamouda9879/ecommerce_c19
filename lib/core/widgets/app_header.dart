import 'package:flutter/material.dart';

import 'package:ecommerce_c19/core/routes/app_routes.dart';
import 'package:ecommerce_c19/core/theme/app_colors.dart';
import 'package:ecommerce_c19/core/utils/app_assets.dart';

/// Blue logo, plus the search field and cart button when [showSearch] is true.
class AppHeader extends StatelessWidget {
  const AppHeader({super.key, this.showSearch = true});

  final bool showSearch;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: const BorderSide(color: AppColors.primary),
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(AppAssets.logo, width: 66, color: AppColors.primary),
          if (showSearch) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'what do you search for?',
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: AppColors.greyText,
                      ),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 20, right: 8),
                        child: Icon(
                          Icons.search,
                          size: 30,
                          color: AppColors.primary,
                        ),
                      ),
                      prefixIconConstraints: const BoxConstraints(),
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      border: border,
                      enabledBorder: border,
                      focusedBorder: border,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                IconButton(
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.cart),
                  icon: const Icon(Icons.shopping_cart_outlined, size: 30),
                  color: AppColors.primary,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
