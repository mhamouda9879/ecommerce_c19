import 'package:bloc/bloc.dart';
import 'package:ecommerce_c19/features/products/domain/use_cases/get_product_details_usecase.dart';
import 'package:ecommerce_c19/features/products/domain/use_cases/get_products_usecase.dart';
import 'package:ecommerce_c19/features/products/presentation/bloc/products_events.dart';
import 'package:ecommerce_c19/features/products/presentation/bloc/products_states.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProductsUseCase getProductsUseCase;
  final GetProductDetailsUseCase getProductDetailsUseCase;

  ProductsBloc(this.getProductsUseCase, this.getProductDetailsUseCase)
    : super(const ProductsState()) {
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
