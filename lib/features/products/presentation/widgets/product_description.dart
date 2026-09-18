import 'package:flutter/material.dart';

import 'package:ecommerce_c19/core/theme/app_colors.dart';

/// Shortened description with an inline "Read More" / "Read Less" toggle.
class ProductDescription extends StatefulWidget {
  const ProductDescription({super.key, required this.text});

  final String text;

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  static const _collapsedLength = 110;

  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final text = widget.text;
    final isLong = text.length > _collapsedLength;
    final shown = !isLong || _expanded
        ? text
        : '${text.substring(0, _collapsedLength).trimRight()}......';

    return GestureDetector(
      onTap: isLong ? () => setState(() => _expanded = !_expanded) : null,
      child: Text.rich(
        TextSpan(
          text: shown,
          style: const TextStyle(fontSize: 14, color: AppColors.greyText),
          children: [
            if (isLong)
              TextSpan(
                text: _expanded ? ' Read Less' : 'Read More',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.darkText,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
