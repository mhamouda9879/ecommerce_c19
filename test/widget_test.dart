import 'package:ecommerce_c19/features/products/presentation/widgets/product_card.dart';
import 'package:ecommerce_c19/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Match the design's phone frame (430 x 932).
  setUp(() {
    final view =
        TestWidgetsFlutterBinding.instance.platformDispatcher.views.first;
    view.physicalSize = const Size(430, 932);
    view.devicePixelRatio = 1;
  });
  tearDown(() {
    TestWidgetsFlutterBinding.instance.platformDispatcher.views.first
      ..resetPhysicalSize()
      ..resetDevicePixelRatio();
  });

  testWidgets('splash navigates to login, login links to sign up', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Welcome Back To Route'), findsNothing);

    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    expect(find.text('Welcome Back To Route'), findsOneWidget);

    await tester.tap(find.text('Don’t have an account? Create Account'));
    await tester.pumpAndSettle();
    expect(find.text('Sign up'), findsOneWidget);
  });

  testWidgets('sign up shows validation errors for empty form', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Don’t have an account? Create Account'));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Sign up'));
    await tester.tap(find.text('Sign up'));
    await tester.pump();
    expect(find.text('This field is required'), findsNWidgets(4));
  });

  testWidgets(
    'login opens the shop; categories lead to products, details, cart',
    (tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).at(0), 'user@mail.com');
      await tester.enterText(find.byType(TextFormField).at(1), 'secret123');
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      await tester.tap(
        find.ancestor(
          of: find.byWidgetPredicate(
            (w) => w is Image && w.semanticLabel == 'Categories',
          ),
          matching: find.byType(InkResponse),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('T-shirts'));
      await tester.pumpAndSettle();
      expect(find.byType(ProductCard), findsWidgets);

      await tester.tap(find.byType(ProductCard).first);
      await tester.pumpAndSettle();
      expect(find.text('Product Details'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.shopping_cart_outlined));
      await tester.pumpAndSettle();
      expect(find.text('Check Out'), findsOneWidget);
    },
  );
}
