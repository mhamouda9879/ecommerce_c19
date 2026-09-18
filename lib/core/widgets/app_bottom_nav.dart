import 'package:flutter/material.dart';

import 'package:ecommerce_c19/core/theme/app_colors.dart';
import 'package:ecommerce_c19/core/utils/app_assets.dart';

/// Blue bottom bar: Home, Categories, Wishlist, Profile.
/// The selected tab's icon sits in a white circle.
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const _items = [
    (icon: AppAssets.homeIcon, label: 'Home'),
    (icon: AppAssets.categoryIcon, label: 'Categories'),
    (icon: AppAssets.heartIcon, label: 'Wishlist'),
    (icon: AppAssets.userIcon, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (var i = 0; i < _items.length; i++)
                _NavItem(
                  icon: _items[i].icon,
                  label: _items[i].label,
                  selected: i == currentIndex,
                  onTap: () => onTap(i),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      child: InkResponse(
        onTap: onTap,
        radius: 28,
        child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: selected
              ? const BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                )
              : null,
          child: Image.asset(
            icon,
            width: 24,
            semanticLabel: label,
            color: selected ? AppColors.primary : AppColors.white,
          ),
        ),
      ),
    );
  }
}
