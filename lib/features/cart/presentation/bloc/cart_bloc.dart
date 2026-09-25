import 'package:bloc/bloc.dart';
import 'package:ecommerce_c19/core/utils/request_status.dart';
import 'package:ecommerce_c19/features/cart/domain/use_cases/add_product_to_cart.dart';
import 'package:ecommerce_c19/features/cart/presentation/bloc/cart_events.dart';
import 'package:ecommerce_c19/features/cart/presentation/bloc/cart_states.dart';

class CartBloc extends Bloc<CartEvents, CartStates> {
  final AddProductToCartUsecase addProductToCartUsecase;

  CartBloc({required this.addProductToCartUsecase}) : super(CartStates()) {
    on<AddToCartEvent>(_onAddToCart);
  }

  Future<void> _onAddToCart(
    AddToCartEvent event,
    Emitter<CartStates> emit,
  ) async {
    emit(state.copyWith(requestStatus: RequestStatus.loading));
    try {
      final result = await addProductToCartUsecase(event.productId);

      result.fold(
        (failure) {
          emit(
            state.copyWith(
              requestStatus: RequestStatus.error,
              errorMessage: failure.message,
            ),
          );
        },
        (success) {
          emit(
            state.copyWith(
              requestStatus: RequestStatus.success,
              isAddedToCart: success,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          requestStatus: RequestStatus.error,
          errorMessage: 'An error occurred while adding product to cart',
        ),
      );
    }
  }
}
