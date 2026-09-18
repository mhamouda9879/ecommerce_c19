abstract class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';

  /// Bottom-nav shell. Optional `int` argument selects the starting tab.
  static const main = '/main';

  static const products = '/products';

  /// Expects a `DummyProduct` argument.
  static const productDetails = '/product-details';

  static const cart = '/cart';
}
