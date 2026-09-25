import 'package:bloc/bloc.dart';
import 'package:ecommerce_c19/features/wishlist/domain/use_cases/add_to_wishlist_usecase.dart';
import 'package:ecommerce_c19/features/wishlist/domain/use_cases/get_wishlist_usecase.dart';
import 'package:ecommerce_c19/features/wishlist/domain/use_cases/remove_from_wishlist_usecase.dart';
import 'package:ecommerce_c19/features/wishlist/presentation/bloc/wishlist_events.dart';
import 'package:ecommerce_c19/features/wishlist/presentation/bloc/wishlist_states.dart';
import 'package:injectable/injectable.dart';

@injectable
class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final GetWishlistUseCase getWishlistUseCase;
  final AddToWishlistUseCase addToWishlistUseCase;
  final RemoveFromWishlistUseCase removeFromWishlistUseCase;

  WishlistBloc(
    this.getWishlistUseCase,
    this.addToWishlistUseCase,
    this.removeFromWishlistUseCase,
  ) : super(const WishlistState()) {
    on<GetWishlistEvent>((event, emit) async {
      emit(state.copyWith(getWishlistRequestStatus: RequestStatus.loading));

      final result = await getWishlistUseCase();
      result.fold(
        (failure) => emit(
          state.copyWith(
            getWishlistRequestStatus: RequestStatus.error,
            errorMessage: failure.message,
          ),
        ),
        (products) => emit(
          state.copyWith(
            getWishlistRequestStatus: RequestStatus.success,
            products: products,
            ids: {for (final product in products) product.id},
          ),
        ),
      );
    });

    on<ToggleWishlistEvent>((event, emit) async {
      final product = event.product;
      final isFavorite = state.isFavorite(product.id);
      final previous = state;

      // Flip the heart right away and roll back if the request fails.
      emit(
        state.copyWith(
          toggleRequestStatus: RequestStatus.loading,
          ids: isFavorite
              ? ({...state.ids}..remove(product.id))
              : {...state.ids, product.id},
          products: isFavorite
              ? [
                  for (final p in state.products)
                    if (p.id != product.id) p,
                ]
              : [...state.products, product],
        ),
      );

      final result = isFavorite
          ? await removeFromWishlistUseCase(product.id)
          : await addToWishlistUseCase(product.id);
      result.fold(
        (failure) => emit(
          previous.copyWith(
            toggleRequestStatus: RequestStatus.error,
            errorMessage: failure.message,
          ),
        ),
        (ids) => emit(
          state.copyWith(
            toggleRequestStatus: RequestStatus.success,
            ids: ids.toSet(),
          ),
        ),
      );
    });
  }
}
