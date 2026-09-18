/// Formats 7500 as "7,500".
String formatNumber(num value) => value.round().toString().replaceAllMapped(
  RegExp(r'\B(?=(\d{3})+(?!\d))'),
  (_) => ',',
);

/// Formats 3500 as "EGP 3,500".
String formatPrice(num value) => 'EGP ${formatNumber(value)}';
