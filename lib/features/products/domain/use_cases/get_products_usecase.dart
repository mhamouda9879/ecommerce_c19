import 'package:dartz/dartz.dart';
import 'package:ecommerce_c19/core/errors/failures.dart';
import 'package:ecommerce_c19/features/products/domain/entities/products_query.dart';
import 'package:ecommerce_c19/features/products/domain/entities/product_entity.dart';
import 'package:ecommerce_c19/features/products/domain/repositories/products_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductsUseCase {
  final ProductsRepository productsRepository;

  GetProductsUseCase({required this.productsRepository});

  Future<Either<Failure, List<ProductEntity>>> call([
    ProductsQuery query = const ProductsQuery(),
  ]) {
    return productsRepository.getProducts(query);
  }
}
