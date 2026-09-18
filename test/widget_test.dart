import 'package:dartz/dartz.dart';
import 'package:ecommerce_c19/core/errors/failures.dart';
import 'package:ecommerce_c19/di.dart';
import 'package:ecommerce_c19/features/auth/data/models/auth_response.dart';
import 'package:ecommerce_c19/features/auth/domain/repositories/auth_repo.dart';
import 'package:ecommerce_c19/features/categories/domain/entities/category_entity.dart';
import 'package:ecommerce_c19/features/categories/domain/entities/sub_category_entity.dart';
import 'package:ecommerce_c19/features/categories/domain/repositories/categories_repo.dart';
import 'package:ecommerce_c19/features/products/domain/entities/product_entity.dart';
import 'package:ecommerce_c19/features/products/domain/entities/products_query.dart';
import 'package:ecommerce_c19/features/products/domain/repositories/products_repo.dart';
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

  bool loggedIn = false;

  @override
  Future<bool> isLoggedIn() async => loggedIn;

  @override
  Future<void> logout() async => loggedIn = false;

  @override
  Future<Either<Failure, AuthResponse>> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
    String phone,
  ) async => Right(AuthResponse(message: 'success', token: 'token'));
}

/// Returns [result] for every categories request and counts the calls.
class _FakeCategoriesRepository implements CategoriesRepository {
  Either<Failure, List<CategoryEntity>> result = const Right([
    CategoryEntity(id: '1', name: "Men's Fashion", image: 'men.png'),
    CategoryEntity(id: '2', name: "Women's Fashion", image: 'women.png'),
    CategoryEntity(id: '3', name: 'Music', image: 'music.png'),
  ]);
  int calls = 0;

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories({
    int? limit,
    int? page,
    String? keyword,
  }) async {
    calls++;
    return result;
  }

  static const _subCategories = {
    '1': [
      SubCategoryEntity(id: 's1', name: "Men's Clothing", categoryId: '1'),
      SubCategoryEntity(id: 's2', name: 'Bags & luggage', categoryId: '1'),
    ],
    '2': [
      SubCategoryEntity(id: 's3', name: "Women's Clothing", categoryId: '2'),
    ],
  };

  @override
  Future<Either<Failure, List<SubCategoryEntity>>> getSubCategories({
    String? categoryId,
    int? limit,
    int? page,
  }) async => Right(_subCategories[categoryId] ?? const []);
}

const _tShirt = ProductEntity(
  id: 'p1',
  title: 'Logo T-Shirt Green',
  description: 'Soft cotton',
  imageCover: 'cover.png',
  images: ['1.png', '2.png'],
  price: 744,
  priceAfterDiscount: 379,
  ratingsAverage: 3.7,
  ratingsQuantity: 13,
  sold: 779,
);

class _FakeProductsRepository implements ProductsRepository {
  ProductsQuery? lastQuery;

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts(
    ProductsQuery query,
  ) async {
    lastQuery = query;
    return const Right([_tShirt]);
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductDetails(
    String productId,
  ) async => productId == _tShirt.id
      ? const Right(_tShirt)
      : const Left(ServerFailure('No document for this id', statusCode: 404));
}

void main() {
  late _FakeAuthRepository fakeAuthRepository;
  late _FakeProductsRepository fakeProductsRepository;
  late _FakeCategoriesRepository fakeCategoriesRepository;

  setUpAll(() {
    configureDependencies();
    getIt.allowReassignment = true;
  });

  setUp(() {
    fakeAuthRepository = _FakeAuthRepository();
    getIt.registerFactory<AuthRepository>(() => fakeAuthRepository);
    fakeProductsRepository = _FakeProductsRepository();
    getIt.registerFactory<ProductsRepository>(() => fakeProductsRepository);
    fakeCategoriesRepository = _FakeCategoriesRepository();
    getIt.registerFactory<CategoriesRepository>(() => fakeCategoriesRepository);
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
      await tester.tap(find.text("Men's Clothing"));
      await tester.pumpAndSettle();
      expect(find.byType(ProductCard), findsOneWidget);
      expect(fakeProductsRepository.lastQuery?.subCategoryIds, ['s1']);

      await tester.tap(find.byType(ProductCard));
      await tester.pumpAndSettle();
      expect(find.text('Product Details'), findsOneWidget);
      expect(find.text('Logo T-Shirt Green'), findsOneWidget);
      expect(find.text('EGP 379'), findsWidgets);

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

  Future<void> loginToMainLayout(WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'user@mail.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'secret123');
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();
  }

  testWidgets('home shows API categories and "view all" opens the tab', (
    tester,
  ) async {
    await loginToMainLayout(tester);

    // Home and Categories tabs share one request.
    expect(fakeCategoriesRepository.calls, 1);
    expect(find.text('Music'), findsWidgets);

    await tester.tap(find.text('view all'));
    await tester.pumpAndSettle();
    expect(find.text("Men's Clothing"), findsOneWidget);

    // Picking another category updates the right side.
    await tester.tap(find.text("Women's Fashion").last);
    await tester.pumpAndSettle();
    expect(find.text("Women's Clothing"), findsOneWidget);
    expect(find.text("Men's Clothing"), findsNothing);

    // Music has no subcategories.
    await tester.tap(find.text('Music').last);
    await tester.pumpAndSettle();
    expect(find.text('No subcategories yet'), findsOneWidget);
  });

  testWidgets('categories error shows the message and retries', (tester) async {
    fakeCategoriesRepository.result = const Left(
      NetworkFailure('No internet connection'),
    );
    await loginToMainLayout(tester);

    expect(find.text('No internet connection'), findsWidgets);

    fakeCategoriesRepository.result = const Right([
      CategoryEntity(id: '9', name: 'Books', image: 'books.png'),
    ]);
    await tester.tap(find.text('Try again').first);
    await tester.pumpAndSettle();

    expect(fakeCategoriesRepository.calls, 2);
    expect(find.text('Books'), findsWidgets);
    expect(find.text('No internet connection'), findsNothing);
  });

  testWidgets('splash skips login when a token is saved', (tester) async {
    fakeAuthRepository.loggedIn = true;
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.text('Welcome Back To Route'), findsNothing);
    expect(find.text('Categories'), findsOneWidget);
  });

  testWidgets('logout from profile returns to login', (tester) async {
    fakeAuthRepository.loggedIn = true;
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    await tester.tap(
      find.ancestor(
        of: find.byWidgetPredicate(
          (w) => w is Image && w.semanticLabel == 'Profile',
        ),
        matching: find.byType(InkResponse),
      ),
    );
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Logout'));
    await tester.tap(find.text('Logout'));
    await tester.pumpAndSettle();

    expect(fakeAuthRepository.loggedIn, isFalse);
    expect(find.text('Welcome Back To Route'), findsOneWidget);
  });

  testWidgets('product details shows the API error for a bad id', (
    tester,
  ) async {
    fakeAuthRepository.loggedIn = true;
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    // Wishlist placeholders use real API ids the fake repository doesn't know.
    await tester.tap(
      find.ancestor(
        of: find.byWidgetPredicate(
          (w) => w is Image && w.semanticLabel == 'Wishlist',
        ),
        matching: find.byType(InkResponse),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Logo T-Shirt Green'));
    await tester.pumpAndSettle();

    expect(find.text('No document for this id'), findsOneWidget);
    expect(find.text('Try again'), findsOneWidget);
    expect(find.text('Add to cart'), findsNothing);
  });
}
