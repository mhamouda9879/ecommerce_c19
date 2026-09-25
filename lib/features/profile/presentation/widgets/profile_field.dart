import 'package:flutter/material.dart';

import 'package:ecommerce_c19/core/theme/app_colors.dart';

/// Label above a read-only rounded field with an edit icon.
class ProfileField extends StatelessWidget {
  const ProfileField({
    super.key,
    required this.label,
    required this.value,
    required this.onEdit,
    this.obscure = false,
  });

  final String label;
  final String value;
  final VoidCallback onEdit;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(color: AppColors.border),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 14),
        TextFormField(
          // initialValue is read once; a new key rebuilds it after an edit.
          key: ValueKey(value),
          initialValue: value,
          readOnly: true,
          obscureText: obscure,
          obscuringCharacter: '*',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.darkText,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 17,
            ),
            border: border,
            enabledBorder: border,
            focusedBorder: border,
            suffixIcon: IconButton(
              onPressed: onEdit,
              icon: const Icon(
                Icons.border_color_outlined,
                size: 20,
                color: AppColors.darkText,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
