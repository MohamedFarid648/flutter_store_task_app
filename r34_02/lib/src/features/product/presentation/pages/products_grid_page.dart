import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_task_app/src/core/config/config.dart';
import 'package:flutter_store_task_app/src/core/routes/routes.dart';

import '../../data/models/product_model.dart';
import '../../logic/products_cubit.dart';

class ProductsGridPage extends StatelessWidget {
  const ProductsGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductsCubit(getIt())..loadProducts(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Beverages'), centerTitle: true),
        body: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.errorMessage != null) {
              return Center(child: Text(state.errorMessage!));
            }

            final products = state.products;

            return Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 260,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (_, index) {
                  final product = products[index];
                  return _ProductCard(product: product);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final ProductModel product;

  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          RouteNames.product_details_screen,
          arguments: product.id,
        );

        // Navigator.of(
        //   context,
        // ).pushNamed(RouteNames.product_details_screen, arguments: product.id);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: Image.network(
                    product.thumbnail,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) {
                      // ✅ default image if network fails
                      return Image.asset(
                        'assets/images/product_placeholder.png',
                        fit: BoxFit.contain,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '\$${product.price}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: 44,
                  width: 44,
                  decoration: const BoxDecoration(
                    color: Color(0xFF53B175),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
