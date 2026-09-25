import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_c19/core/errors/failures.dart';
import 'package:ecommerce_c19/features/cart/domain/entities/cart_entity.dart';
import 'package:ecommerce_c19/features/cart/domain/use_cases/add_product_to_cart.dart';
import 'package:ecommerce_c19/features/cart/domain/use_cases/clear_cart_usecase.dart';
import 'package:ecommerce_c19/features/cart/domain/use_cases/get_cart_usecase.dart';
import 'package:ecommerce_c19/features/cart/domain/use_cases/remove_cart_item_usecase.dart';
import 'package:ecommerce_c19/features/cart/domain/use_cases/update_cart_item_count_usecase.dart';
import 'package:ecommerce_c19/features/cart/presentation/bloc/cart_events.dart';
import 'package:ecommerce_c19/features/cart/presentation/bloc/cart_states.dart';
import 'package:injectable/injectable.dart';

@injectable
class CartBloc extends Bloc<CartEvents, CartStates> {
  final AddProductToCartUsecase addProductToCartUsecase;
  final GetCartUseCase getCartUseCase;
  final UpdateCartItemCountUseCase updateCartItemCountUseCase;
  final RemoveCartItemUseCase removeCartItemUseCase;
  final ClearCartUseCase clearCartUseCase;

  CartBloc({
    required this.addProductToCartUsecase,
    required this.getCartUseCase,
    required this.updateCartItemCountUseCase,
    required this.removeCartItemUseCase,
    required this.clearCartUseCase,
  }) : super(CartStates()) {
    on<AddToCartEvent>(_onAddToCart);

    on<GetCartEvent>((event, emit) async {
      emit(state.copyWith(getCartRequestStatus: RequestStatus.loading));

      final result = await getCartUseCase();
      result.fold(
        (failure) => emit(
          state.copyWith(
            getCartRequestStatus: RequestStatus.error,
            errorMessage: failure.message,
          ),
        ),
        (cart) => emit(
          state.copyWith(
            getCartRequestStatus: RequestStatus.success,
            cart: cart,
          ),
        ),
      );
    });

    on<UpdateCartItemCountEvent>(
      (event, emit) => _updateCart(
        emit,
        () => updateCartItemCountUseCase(event.productId, event.count),
      ),
    );

    on<RemoveCartItemEvent>(
      (event, emit) =>
          _updateCart(emit, () => removeCartItemUseCase(event.productId)),
    );

    on<ClearCartEvent>(
      (event, emit) => _updateCart(emit, () async {
        final result = await clearCartUseCase();
        return result.map((_) => const CartEntity(totalPrice: 0, items: []));
      }),
    );
  }

  Future<void> _updateCart(
    Emitter<CartStates> emit,
    Future<Either<Failure, CartEntity>> Function() call,
  ) async {
    emit(state.copyWith(updateCartRequestStatus: RequestStatus.loading));

    final result = await call();
    result.fold(
      (failure) => emit(
        state.copyWith(
          updateCartRequestStatus: RequestStatus.error,
          errorMessage: failure.message,
        ),
      ),
      (cart) => emit(
        state.copyWith(
          updateCartRequestStatus: RequestStatus.success,
          cart: cart,
        ),
      ),
    );
  }

  Future<void> _onAddToCart(
    AddToCartEvent event,
    Emitter<CartStates> emit,
  ) async {
    emit(state.copyWith(requestStatus: RequestStatus.loading));
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
  }
}
