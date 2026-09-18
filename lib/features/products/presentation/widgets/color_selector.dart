import 'package:flutter/material.dart';

import 'package:ecommerce_c19/core/theme/app_colors.dart';

class ColorSelector extends StatelessWidget {
  const ColorSelector({
    super.key,
    required this.colors,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<Color> colors;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        for (var i = 0; i < colors.length; i++)
          InkResponse(
            onTap: () => onSelected(i),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: colors[i],
                shape: BoxShape.circle,
              ),
              child: i == selectedIndex
                  ? const Icon(Icons.check, color: AppColors.white, size: 18)
                  : null,
            ),
          ),
      ],
    );
  }
}
