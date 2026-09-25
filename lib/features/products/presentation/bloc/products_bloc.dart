import 'package:bloc/bloc.dart';
import 'package:ecommerce_c19/features/cart/domain/use_cases/add_product_to_cart.dart';
import 'package:ecommerce_c19/features/cart/domain/use_cases/update_cart_item_count_usecase.dart';
import 'package:ecommerce_c19/features/products/domain/use_cases/get_product_details_usecase.dart';
import 'package:ecommerce_c19/features/products/domain/use_cases/get_products_usecase.dart';
import 'package:ecommerce_c19/features/products/presentation/bloc/products_events.dart';
import 'package:ecommerce_c19/features/products/presentation/bloc/products_states.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProductsUseCase getProductsUseCase;
  final GetProductDetailsUseCase getProductDetailsUseCase;
  final AddProductToCartUsecase addProductToCartUseCase;
  final UpdateCartItemCountUseCase updateCartItemCountUseCase;

  ProductsBloc(
    this.getProductsUseCase,
    this.getProductDetailsUseCase,
    this.addProductToCartUseCase,
    this.updateCartItemCountUseCase,
  ) : super(const ProductsState()) {
    on<AddToCartEvent>((event, emit) async {
      emit(
        state.copyWith(addProductToCartRequestStatus: RequestStatus.loading),
      );

      var result = await addProductToCartUseCase(event.productId);
      // The add endpoint always adds one; set the chosen quantity after it.
      if (result.isRight() && event.quantity > 1) {
        final updated = await updateCartItemCountUseCase(
          event.productId,
          event.quantity,
        );
        result = updated.map((_) => true);
      }
      result.fold(
        (failure) => emit(
          state.copyWith(
            addProductToCartRequestStatus: RequestStatus.error,
            errorMessage: failure.message,
          ),
        ),
        (success) => emit(
          state.copyWith(
            addProductToCartRequestStatus: RequestStatus.success,
            isAddedToCart: success,
          ),
        ),
      );
    });
    on<GetProductsEvent>((event, emit) async {
      emit(state.copyWith(productsRequestStatus: RequestStatus.loading));

      final result = await getProductsUseCase(event.query);
      result.fold(
        (failure) => emit(
          state.copyWith(
            productsRequestStatus: RequestStatus.error,
            errorMessage: failure.message,
          ),
        ),
        (products) => emit(
          state.copyWith(
            productsRequestStatus: RequestStatus.success,
            products: products,
          ),
        ),
      );
    });

    on<GetProductDetailsEvent>((event, emit) async {
      emit(state.copyWith(productDetailsRequestStatus: RequestStatus.loading));

      final result = await getProductDetailsUseCase(event.productId);
      result.fold(
        (failure) => emit(
          state.copyWith(
            productDetailsRequestStatus: RequestStatus.error,
            errorMessage: failure.message,
          ),
        ),
        (product) => emit(
          state.copyWith(
            productDetailsRequestStatus: RequestStatus.success,
            productDetails: product,
          ),
        ),
      );
    });
  }
}
