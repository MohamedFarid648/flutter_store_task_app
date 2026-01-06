import '../../data/models/product_model.dart';
import '../repositories/products_repository.dart';

class GetProductDetailsUseCase {
  final ProductsRepository _repository;

  GetProductDetailsUseCase(this._repository);

  Future<ProductModel> call(int id) {
    return _repository.getProductById(id);
  }
}
