import '../../data/models/product_model.dart';
import '../repositories/products_repository.dart';

class GetProductsUseCase {
  final ProductsRepository _repository;

  GetProductsUseCase(this._repository);

  Future<ProductsResponse> call({int limit = 20, int skip = 0}) {
    return _repository.getProducts(limit: limit, skip: skip);
  }
}
