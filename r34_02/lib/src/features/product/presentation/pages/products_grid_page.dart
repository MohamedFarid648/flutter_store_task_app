import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_task_app/src/core/routes/routes.dart';
import 'package:flutter_store_task_app/src/features/product/data/models/product_model.dart';
import 'package:flutter_store_task_app/src/features/product/logic/products_cubit.dart';

class ProductsGridPage extends StatelessWidget {
  final String title;

  const ProductsGridPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return PopScope(
      //  Never allow popping this page (Android back / browser back)
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F3F2),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF2F3F2),
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false, // No back arrow
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF181725),
            ),
          ),
          actions: [
            // Menu icon – opens menu page
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.menu);
              },
            ),
            // Cart icon – opens cart page
            IconButton(
              icon: const Icon(Icons.shopping_cart_outlined),
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.cart);
              },
            ),
          ],
        ),
        body: SafeArea(
          child: BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.errorMessage != null &&
                  state.errorMessage!.isNotEmpty) {
                return Center(
                  child: Text(
                    state.errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              final products = state.products;

              if (products.isEmpty) {
                return const Center(child: Text('No products found'));
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  padding: const EdgeInsets.only(bottom: 24),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isSmallScreen ? 2 : 4,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    // card aspect ratio similar to Figma
                    childAspectRatio: 0.62,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];

                    return _ProductCard(
                      product: product,
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          RouteNames.productDetailsPage,
                          arguments: product,
                        );
                      },
                      onAddToCart: () {},
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;

  const _ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 16, 12, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product image
              Expanded(
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 4 / 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        product.thumbnail,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => Image.asset(
                          'assets/images/product_placeholder.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Name
              Text(
                product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF181725),
                ),
              ),
              const SizedBox(height: 4),
              // Subtitle (size, "Price")
              Text(
                '${product.category}, Price',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12, color: Color(0xFF7C7C7C)),
              ),
              const SizedBox(height: 8),
              // Price + plus button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF181725),
                    ),
                  ),
                  GestureDetector(
                    onTap: onAddToCart,
                    child: Container(
                      height: 36,
                      width: 36,
                      decoration: const BoxDecoration(
                        color: Color(0xFF53B175),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
