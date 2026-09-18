import 'package:dartz/dartz.dart';
import 'package:ecommerce_c19/core/errors/failures.dart';
import 'package:ecommerce_c19/di.dart';
import 'package:ecommerce_c19/features/auth/data/models/auth_response.dart';
import 'package:ecommerce_c19/features/auth/domain/repositories/auth_repo.dart';
import 'package:ecommerce_c19/features/products/presentation/widgets/product_card.dart';
import 'package:ecommerce_c19/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Answers auth calls without touching the network.
class _FakeAuthRepository implements AuthRepository {
  Either<Failure, AuthResponse> signInResult = Right(
    AuthResponse(message: 'success', token: 'token'),
  );

  @override
  Future<Either<Failure, AuthResponse>> signInWithEmailAndPassword(
    String email,
    String password,
  ) async => signInResult;

  @override
  Future<Either<Failure, AuthResponse>> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
    String phone,
  ) async => Right(AuthResponse(message: 'success', token: 'token'));
}

void main() {
  late _FakeAuthRepository fakeAuthRepository;

  setUpAll(() {
    configureDependencies();
    getIt.allowReassignment = true;
  });

  setUp(() {
    fakeAuthRepository = _FakeAuthRepository();
    getIt.registerFactory<AuthRepository>(() => fakeAuthRepository);
  });

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

  testWidgets('failed login shows the API error and stays on login', (
    tester,
  ) async {
    fakeAuthRepository.signInResult = const Left(
      ServerFailure('Incorrect email or password', statusCode: 401),
    );
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'user@mail.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'wrong-password');
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    expect(find.text('Incorrect email or password'), findsOneWidget);
    expect(find.text('Welcome Back To Route'), findsOneWidget);
  });

  testWidgets('login rejects an invalid email before calling the API', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'not-an-email');
    await tester.enterText(find.byType(TextFormField).at(1), 'secret123');
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    expect(find.text('Enter a valid email address'), findsOneWidget);
  });
}
