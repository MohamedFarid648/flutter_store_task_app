import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_store_task_app/src/features/product/data/models/product_model.dart';

class CartItem extends Equatable {
  final ProductModel product;
  final int quantity;

  const CartItem({required this.product, this.quantity = 1});

  CartItem copyWith({ProductModel? product, int? quantity}) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [product, quantity];
}

class CartState extends Equatable {
  final List<CartItem> items;

  const CartState({this.items = const []});

  double get total =>
      items.fold(0, (sum, item) => sum + (item.product.price * item.quantity));

  CartState copyWith({List<CartItem>? items}) {
    return CartState(items: items ?? this.items);
  }

  @override
  List<Object?> get props => [items];
}

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  /// Add a single unit (used by the "+" button in grid)
  void addProduct(ProductModel product) {
    addProductWithQuantity(product, 1);
  }

  /// Add N units (used by "Add To Basket" in details)
  void addProductWithQuantity(ProductModel product, int quantity) {
    if (quantity <= 0) return;

    final items = List<CartItem>.from(state.items);
    final index = items.indexWhere((i) => i.product.id == product.id);

    if (index >= 0) {
      final updated = items[index].copyWith(
        quantity: items[index].quantity + quantity,
      );
      items[index] = updated;
    } else {
      items.add(CartItem(product: product, quantity: quantity));
    }

    emit(state.copyWith(items: items));
  }

  void removeProduct(ProductModel product) {
    final items = List<CartItem>.from(state.items);
    items.removeWhere((i) => i.product.id == product.id);
    emit(state.copyWith(items: items));
  }

  void clear() {
    emit(const CartState(items: []));
  }
}
