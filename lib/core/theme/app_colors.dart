import 'package:flutter/material.dart';

abstract class AppColors {
  static const primary = Color(0xFF004182);
  static const white = Colors.white;

  /// Main text color on white screens.
  static const darkText = Color(0xFF06004F);

  /// Secondary text (60% of [darkText]).
  static const greyText = Color(0x9906004F);

  /// Card and input borders (30% of [primary]).
  static const border = Color(0x4D004182);

  /// Struck-through old prices (60% of [primary]).
  static const oldPrice = Color(0x99004182);

  /// Category side menu and image placeholders.
  static const lightBlue = Color(0xFFEDF1F5);

  static const star = Color(0xFFFDD835);

  // Auth screens (on the blue background).
  static const hint = Color(0xB3000000);
  static const icon = Color(0xFF8E8E8E);
  static const error = Color(0xFFFFB4AB);
}
