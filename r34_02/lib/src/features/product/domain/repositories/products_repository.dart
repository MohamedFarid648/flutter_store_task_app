import '../../data/models/product_model.dart';

abstract class ProductsRepository {
  Future<ProductsResponse> getProducts({int limit, int skip});
  Future<ProductModel> getProductById(int id);
}
