import 'package:dartz/dartz.dart';
import 'package:ecommerce_c19/core/errors/failures.dart';
import 'package:ecommerce_c19/features/products/domain/entities/product_entity.dart';
import 'package:ecommerce_c19/features/products/domain/repositories/products_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductDetailsUseCase {
  final ProductsRepository productsRepository;

  GetProductDetailsUseCase({required this.productsRepository});

  Future<Either<Failure, ProductEntity>> call(String productId) {
    return productsRepository.getProductDetails(productId);
  }
}
