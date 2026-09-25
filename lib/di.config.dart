// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'core/di/network_module.dart' as _i177;
import 'core/di/storage_module.dart' as _i540;
import 'core/network/dio_helper.dart' as _i534;
import 'core/storage/token_storage.dart' as _i23;
import 'core/storage/user_storage.dart' as _i663;
import 'features/auth/data/data_sources/remote/auth_remote_ds.dart' as _i981;
import 'features/auth/data/data_sources/remote/auth_remote_ds_impl.dart'
    as _i393;
import 'features/auth/data/repositories/auth_repo_impl.dart' as _i426;
import 'features/auth/domain/repositories/auth_repo.dart' as _i416;
import 'features/auth/domain/use_cases/is_logged_in_usecase.dart' as _i90;
import 'features/auth/domain/use_cases/logout_usecase.dart' as _i53;
import 'features/auth/domain/use_cases/sign_in_usecase.dart' as _i392;
import 'features/auth/domain/use_cases/signUp_usecase.dart' as _i286;
import 'features/auth/presentation/bloc/auth_bloc.dart' as _i363;
import 'features/cart/data/data_sources/remote/cart_ds.dart' as _i585;
import 'features/cart/data/data_sources/remote/cart_ds_impl.dart' as _i149;
import 'features/cart/data/repositories/cart_repo_impl.dart' as _i305;
import 'features/cart/domain/repositories/cart_repository.dart' as _i303;
import 'features/cart/domain/use_cases/add_product_to_cart.dart' as _i148;
import 'features/cart/domain/use_cases/clear_cart_usecase.dart' as _i169;
import 'features/cart/domain/use_cases/get_cart_usecase.dart' as _i883;
import 'features/cart/domain/use_cases/remove_cart_item_usecase.dart' as _i585;
import 'features/cart/domain/use_cases/update_cart_item_count_usecase.dart'
    as _i598;
import 'features/cart/presentation/bloc/cart_bloc.dart' as _i239;
import 'features/categories/data/data_sources/remote/categories_remote_ds.dart'
    as _i82;
import 'features/categories/data/data_sources/remote/categories_remote_ds_impl.dart'
    as _i169;
import 'features/categories/data/repositories/categories_repo_impl.dart'
    as _i104;
import 'features/categories/domain/repositories/categories_repo.dart' as _i238;
import 'features/categories/domain/use_cases/get_categories_usecase.dart'
    as _i37;
import 'features/categories/domain/use_cases/get_sub_categories_usecase.dart'
    as _i490;
import 'features/categories/presentation/bloc/categories_bloc.dart' as _i681;
import 'features/products/data/data_sources/remote/products_remote_ds.dart'
    as _i652;
import 'features/products/data/data_sources/remote/products_remote_ds_impl.dart'
    as _i558;
import 'features/products/data/repositories/products_repo_impl.dart' as _i354;
import 'features/products/domain/repositories/products_repo.dart' as _i485;
import 'features/products/domain/use_cases/get_product_details_usecase.dart'
    as _i248;
import 'features/products/domain/use_cases/get_products_usecase.dart' as _i961;
import 'features/products/presentation/bloc/products_bloc.dart' as _i220;
import 'features/profile/data/data_sources/remote/profile_remote_ds.dart'
    as _i323;
import 'features/profile/data/data_sources/remote/profile_remote_ds_impl.dart'
    as _i493;
import 'features/profile/data/repositories/profile_repo_impl.dart' as _i1029;
import 'features/profile/domain/repositories/profile_repo.dart' as _i136;
import 'features/profile/domain/use_cases/change_password_usecase.dart'
    as _i774;
import 'features/profile/domain/use_cases/get_profile_usecase.dart' as _i891;
import 'features/profile/domain/use_cases/update_profile_usecase.dart' as _i333;
import 'features/profile/presentation/bloc/profile_bloc.dart' as _i284;
import 'features/wishlist/data/data_sources/remote/wishlist_remote_ds.dart'
    as _i570;
import 'features/wishlist/data/data_sources/remote/wishlist_remote_ds_impl.dart'
    as _i276;
import 'features/wishlist/data/repositories/wishlist_repo_impl.dart' as _i714;
import 'features/wishlist/domain/repositories/wishlist_repo.dart' as _i822;
import 'features/wishlist/domain/use_cases/add_to_wishlist_usecase.dart'
    as _i998;
import 'features/wishlist/domain/use_cases/get_wishlist_usecase.dart' as _i39;
import 'features/wishlist/domain/use_cases/remove_from_wishlist_usecase.dart'
    as _i486;
import 'features/wishlist/presentation/bloc/wishlist_bloc.dart' as _i445;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModule = _$NetworkModule();
    final storageModule = _$StorageModule();
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio);
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => storageModule.secureStorage,
    );
    gh.lazySingleton<_i23.TokenStorage>(
      () => _i23.TokenStorage(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i663.UserStorage>(
      () => _i663.UserStorage(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i534.DioHelper>(() => _i534.DioHelper(gh<_i361.Dio>()));
    gh.factory<_i652.ProductsRemoteDataSource>(
      () => _i558.ProductsRemoteDsImpl(dioHelper: gh<_i534.DioHelper>()),
    );
    gh.factory<_i323.ProfileRemoteDataSource>(
      () => _i493.ProfileRemoteDsImpl(
        dioHelper: gh<_i534.DioHelper>(),
        tokenStorage: gh<_i23.TokenStorage>(),
      ),
    );
    gh.factory<_i570.WishlistRemoteDataSource>(
      () => _i276.WishlistRemoteDsImpl(
        dioHelper: gh<_i534.DioHelper>(),
        tokenStorage: gh<_i23.TokenStorage>(),
      ),
    );
    gh.factory<_i981.AuthRemoteDataSource>(
      () => _i393.AuthRemoteDsImpl(dioHelper: gh<_i534.DioHelper>()),
    );
    gh.factory<_i485.ProductsRepository>(
      () => _i354.ProductsRepositoryImpl(
        productsRemoteDataSource: gh<_i652.ProductsRemoteDataSource>(),
      ),
    );
    gh.factory<_i822.WishlistRepository>(
      () => _i714.WishlistRepositoryImpl(
        wishlistRemoteDataSource: gh<_i570.WishlistRemoteDataSource>(),
      ),
    );
    gh.factory<_i82.CategoriesRemoteDataSource>(
      () => _i169.CategoriesRemoteDsImpl(dioHelper: gh<_i534.DioHelper>()),
    );
    gh.factory<_i585.CartDataSource>(
      () => _i149.CartDataSourceImpl(
        dioHelper: gh<_i534.DioHelper>(),
        tokenStorage: gh<_i23.TokenStorage>(),
      ),
    );
    gh.factory<_i248.GetProductDetailsUseCase>(
      () => _i248.GetProductDetailsUseCase(
        productsRepository: gh<_i485.ProductsRepository>(),
      ),
    );
    gh.factory<_i961.GetProductsUseCase>(
      () => _i961.GetProductsUseCase(
        productsRepository: gh<_i485.ProductsRepository>(),
      ),
    );
    gh.factory<_i303.CartRepository>(
      () =>
          _i305.CartRepositoryImpl(cartDataSource: gh<_i585.CartDataSource>()),
    );
    gh.factory<_i148.AddProductToCartUsecase>(
      () => _i148.AddProductToCartUsecase(
        cartRepository: gh<_i303.CartRepository>(),
      ),
    );
    gh.factory<_i169.ClearCartUseCase>(
      () => _i169.ClearCartUseCase(cartRepository: gh<_i303.CartRepository>()),
    );
    gh.factory<_i883.GetCartUseCase>(
      () => _i883.GetCartUseCase(cartRepository: gh<_i303.CartRepository>()),
    );
    gh.factory<_i585.RemoveCartItemUseCase>(
      () => _i585.RemoveCartItemUseCase(
        cartRepository: gh<_i303.CartRepository>(),
      ),
    );
    gh.factory<_i598.UpdateCartItemCountUseCase>(
      () => _i598.UpdateCartItemCountUseCase(
        cartRepository: gh<_i303.CartRepository>(),
      ),
    );
    gh.factory<_i239.CartBloc>(
      () => _i239.CartBloc(
        addProductToCartUsecase: gh<_i148.AddProductToCartUsecase>(),
        getCartUseCase: gh<_i883.GetCartUseCase>(),
        updateCartItemCountUseCase: gh<_i598.UpdateCartItemCountUseCase>(),
        removeCartItemUseCase: gh<_i585.RemoveCartItemUseCase>(),
        clearCartUseCase: gh<_i169.ClearCartUseCase>(),
      ),
    );
    gh.factory<_i998.AddToWishlistUseCase>(
      () => _i998.AddToWishlistUseCase(
        wishlistRepository: gh<_i822.WishlistRepository>(),
      ),
    );
    gh.factory<_i39.GetWishlistUseCase>(
      () => _i39.GetWishlistUseCase(
        wishlistRepository: gh<_i822.WishlistRepository>(),
      ),
    );
    gh.factory<_i486.RemoveFromWishlistUseCase>(
      () => _i486.RemoveFromWishlistUseCase(
        wishlistRepository: gh<_i822.WishlistRepository>(),
      ),
    );
    gh.factory<_i238.CategoriesRepository>(
      () => _i104.CategoriesRepositoryImpl(
        categoriesRemoteDataSource: gh<_i82.CategoriesRemoteDataSource>(),
      ),
    );
    gh.factory<_i136.ProfileRepository>(
      () => _i1029.ProfileRepositoryImpl(
        profileRemoteDataSource: gh<_i323.ProfileRemoteDataSource>(),
        userStorage: gh<_i663.UserStorage>(),
        tokenStorage: gh<_i23.TokenStorage>(),
      ),
    );
    gh.factory<_i774.ChangePasswordUseCase>(
      () => _i774.ChangePasswordUseCase(
        profileRepository: gh<_i136.ProfileRepository>(),
      ),
    );
    gh.factory<_i891.GetProfileUseCase>(
      () => _i891.GetProfileUseCase(
        profileRepository: gh<_i136.ProfileRepository>(),
      ),
    );
    gh.factory<_i333.UpdateProfileUseCase>(
      () => _i333.UpdateProfileUseCase(
        profileRepository: gh<_i136.ProfileRepository>(),
      ),
    );
    gh.factory<_i416.AuthRepository>(
      () => _i426.AuthRepositoryImpl(
        authRemoteDataSource: gh<_i981.AuthRemoteDataSource>(),
        tokenStorage: gh<_i23.TokenStorage>(),
        userStorage: gh<_i663.UserStorage>(),
      ),
    );
    gh.factory<_i284.ProfileBloc>(
      () => _i284.ProfileBloc(
        gh<_i891.GetProfileUseCase>(),
        gh<_i333.UpdateProfileUseCase>(),
        gh<_i774.ChangePasswordUseCase>(),
      ),
    );
    gh.factory<_i220.ProductsBloc>(
      () => _i220.ProductsBloc(
        gh<_i961.GetProductsUseCase>(),
        gh<_i248.GetProductDetailsUseCase>(),
        gh<_i148.AddProductToCartUsecase>(),
        gh<_i598.UpdateCartItemCountUseCase>(),
      ),
    );
    gh.factory<_i90.IsLoggedInUseCase>(
      () => _i90.IsLoggedInUseCase(authRepository: gh<_i416.AuthRepository>()),
    );
    gh.factory<_i53.LogoutUseCase>(
      () => _i53.LogoutUseCase(authRepository: gh<_i416.AuthRepository>()),
    );
    gh.factory<_i286.SignUpUseCase>(
      () => _i286.SignUpUseCase(authRepository: gh<_i416.AuthRepository>()),
    );
    gh.factory<_i392.SignInUseCase>(
      () => _i392.SignInUseCase(authRepository: gh<_i416.AuthRepository>()),
    );
    gh.factory<_i445.WishlistBloc>(
      () => _i445.WishlistBloc(
        gh<_i39.GetWishlistUseCase>(),
        gh<_i998.AddToWishlistUseCase>(),
        gh<_i486.RemoveFromWishlistUseCase>(),
      ),
    );
    gh.factory<_i37.GetCategoriesUseCase>(
      () => _i37.GetCategoriesUseCase(
        categoriesRepository: gh<_i238.CategoriesRepository>(),
      ),
    );
    gh.factory<_i490.GetSubCategoriesUseCase>(
      () => _i490.GetSubCategoriesUseCase(
        categoriesRepository: gh<_i238.CategoriesRepository>(),
      ),
    );
    gh.factory<_i363.AuthBloc>(
      () =>
          _i363.AuthBloc(gh<_i286.SignUpUseCase>(), gh<_i392.SignInUseCase>()),
    );
    gh.factory<_i681.CategoriesBloc>(
      () => _i681.CategoriesBloc(
        gh<_i37.GetCategoriesUseCase>(),
        gh<_i490.GetSubCategoriesUseCase>(),
      ),
    );
    return this;
  }
}

class _$NetworkModule extends _i177.NetworkModule {}

class _$StorageModule extends _i540.StorageModule {}
