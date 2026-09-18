import 'package:flutter/material.dart';

import 'package:ecommerce_c19/core/theme/app_colors.dart';

/// Vertical list of category names; the selected one is white with a blue bar.
class CategorySideMenu extends StatelessWidget {
  const CategorySideMenu({
    super.key,
    required this.names,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<String> names;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  static const _radius = BorderRadius.horizontal(left: Radius.circular(10));

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        border: Border.all(color: AppColors.border),
        borderRadius: _radius,
      ),
      child: ClipRRect(
        borderRadius: _radius,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: names.length,
          itemBuilder: (context, index) => _SideMenuItem(
            name: names[index],
            selected: index == selectedIndex,
            onTap: () => onSelected(index),
          ),
        ),
      ),
    );
  }
}

class _SideMenuItem extends StatelessWidget {
  const _SideMenuItem({
    required this.name,
    required this.selected,
    required this.onTap,
  });

  final String name;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.white : Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 66),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(width: 5),
                if (selected) ...[
                  Container(
                    width: 8,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: 4),
                ] else
                  const SizedBox(width: 3),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 4,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
