import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/product_model.dart';
import '../domain/usecases/get_products_usecase.dart';

class ProductsState {
  final bool isLoading;
  final List<ProductModel> products;
  final String? errorMessage;

  ProductsState({
    required this.isLoading,
    required this.products,
    this.errorMessage,
  });

  factory ProductsState.initial() =>
      ProductsState(isLoading: false, products: const []);

  ProductsState copyWith({
    bool? isLoading,
    List<ProductModel>? products,
    String? errorMessage,
  }) {
    return ProductsState(
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
      errorMessage: errorMessage,
    );
  }
}

class ProductsCubit extends Cubit<ProductsState> {
  final GetProductsUseCase _getProducts;

  ProductsCubit(this._getProducts) : super(ProductsState.initial());

  Future<void> loadProducts() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final response = await _getProducts(limit: 30, skip: 0);
      emit(state.copyWith(isLoading: false, products: response.products));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
