import 'package:flutter/material.dart';

import 'package:ecommerce_c19/core/routes/app_routes.dart';

/// Back arrow, centered title, and search + cart actions.
class InnerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const InnerAppBar({super.key, required this.title});

  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: IconButton(
        onPressed: () => Navigator.maybePop(context),
        icon: const Icon(Icons.arrow_back),
      ),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.search, size: 30)),
        IconButton(
          onPressed: () {
            if (ModalRoute.of(context)?.settings.name != AppRoutes.cart) {
              Navigator.pushNamed(context, AppRoutes.cart);
            }
          },
          icon: const Icon(Icons.shopping_cart_outlined, size: 30),
        ),
        const SizedBox(width: 4),
      ],
    );
  }
}
