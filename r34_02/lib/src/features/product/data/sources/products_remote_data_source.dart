import 'package:dio/dio.dart';
import 'package:flutter_store_task_app/src/core/constants/app_urls.dart';

import '../models/product_model.dart';

abstract class ProductsRemoteDataSource {
  Future<ProductsResponse> getProducts({int limit, int skip});
  Future<ProductModel> getProductById(int id);
}

class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final Dio _dio;

  ProductsRemoteDataSourceImpl(this._dio);

  @override
  Future<ProductsResponse> getProducts({int limit = 20, int skip = 0}) async {
    try {
      final response = await _dio.get(
        AppUrls.products,
        queryParameters: {'limit': limit, 'skip': skip},
      );

      print(response);
      return ProductsResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception(
        'Failed to load products: ${e.response?.statusCode ?? ''}',
      );
    }
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    try {
      final response = await _dio.get(AppUrls.productById(id));
      return ProductModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception(
        'Failed to load product: ${e.response?.statusCode ?? ''}',
      );
    }
  }
}
