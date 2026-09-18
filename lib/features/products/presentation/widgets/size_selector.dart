import 'package:flutter/material.dart';

import 'package:ecommerce_c19/core/theme/app_colors.dart';

class SizeSelector extends StatelessWidget {
  const SizeSelector({
    super.key,
    required this.sizes,
    required this.selected,
    required this.onSelected,
  });

  final List<int> sizes;
  final int selected;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 7,
      children: [
        for (final size in sizes)
          InkResponse(
            onTap: () => onSelected(size),
            child: Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: size == selected
                  ? const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    )
                  : null,
              child: Text(
                '$size',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: size == selected
                      ? AppColors.white
                      : AppColors.darkText,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
