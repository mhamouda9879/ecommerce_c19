import 'package:ecommerce_c19/features/products/domain/entities/products_query.dart';
import 'package:ecommerce_c19/features/products/data/models/product_model.dart';
import 'package:ecommerce_c19/features/products/data/models/products_response.dart';

abstract class ProductsRemoteDataSource {
  Future<ProductsResponse> getProducts(ProductsQuery query);

  Future<ProductModel> getProductDetails(String productId);
}
