import 'package:flutter_store_task_app/src/features/product/data/sources/products_remote_data_source.dart';

import '../../domain/repositories/products_repository.dart';
import '../models/product_model.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSource remoteDataSource;

  ProductsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ProductsResponse> getProducts({int limit = 20, int skip = 0}) {
    return remoteDataSource.getProducts(limit: limit, skip: skip);
  }

  @override
  Future<ProductModel> getProductById(int id) {
    return remoteDataSource.getProductById(id);
  }
}
