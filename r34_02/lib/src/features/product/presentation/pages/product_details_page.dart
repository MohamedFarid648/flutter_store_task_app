import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductModel product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late final PageController _pageController;
  int _currentPage = 0;
  int _quantity = 1;

  List<String> get _images {
    final imgs = widget.product.images;
    if (imgs.isNotEmpty) {
      return imgs;
    }
    return [widget.product.thumbnail];
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TOP IMAGE AREA + BACK / SHARE + INDICATOR
                    SizedBox(
                      height: isSmall ? size.height * 0.35 : 320,
                      child: Stack(
                        children: [
                          PageView.builder(
                            controller: _pageController,
                            itemCount: _images.length,
                            onPageChanged: (index) {
                              setState(() => _currentPage = index);
                            },
                            itemBuilder: (_, index) {
                              final url = _images[index];
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF2F3F2),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: Image.network(
                                    url,
                                    fit: BoxFit.contain,
                                    errorBuilder: (_, __, ___) => Image.asset(
                                      'assets/images/product_placeholder.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          // Back button
                          Positioned(
                            top: 16,
                            left: 16,
                            child: _CircleIconButton(
                              icon: Icons.arrow_back,
                              onTap: () => Navigator.of(context).pop(),
                            ),
                          ),
                          // Share button
                          Positioned(
                            top: 16,
                            right: 16,
                            child: _CircleIconButton(
                              icon: Icons.share_outlined,
                              onTap: () {
                                // TODO: share
                              },
                            ),
                          ),
                          if (_images.length > 1)
                            Positioned(
                              bottom: 16,
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  _images.length,
                                  (index) => AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 3,
                                    ),
                                    width: _currentPage == index ? 16 : 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: _currentPage == index
                                          ? const Color(0xFF53B175)
                                          : const Color(0xFFB3B3B3),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title + subtitle
                          Text(
                            product.title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF181725),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${product.category}, Price',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF7C7C7C),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Quantity selector + price
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _QuantitySelector(
                                quantity: _quantity,
                                onDecrement: () {
                                  if (_quantity > 1) {
                                    setState(() => _quantity--);
                                  }
                                },
                                onIncrement: () {
                                  setState(() => _quantity++);
                                },
                              ),
                              Text(
                                '\$${(product.price * _quantity).toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF181725),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          const Divider(),
                          const SizedBox(height: 16),

                          // Product detail
                          const Text(
                            'Product Detail',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF181725),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            product.description,
                            style: const TextStyle(
                              fontSize: 13,
                              height: 1.5,
                              color: Color(0xFF7C7C7C),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Nutritions
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Nutritions',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF181725),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEAF3E8),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  '100gr',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF53B175),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Divider(),
                          const SizedBox(height: 16),

                          // Review
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Review',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF181725),
                                ),
                              ),
                              Row(
                                children: List.generate(
                                  5,
                                  (index) => const Icon(
                                    Icons.star,
                                    size: 18,
                                    color: Color(0xFFFFA41B),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // BOTTOM "ADD TO BASKET" BUTTON
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: add to cart logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF53B175),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: const Text(
                      'Add To Basket',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleIconButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      elevation: 2,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          height: 40,
          width: 40,
          child: Icon(icon, size: 20, color: const Color(0xFF181725)),
        ),
      ),
    );
  }
}

class _QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const _QuantitySelector({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _squareButton(icon: Icons.remove, onTap: onDecrement),
        const SizedBox(width: 16),
        Text(
          '$quantity',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(width: 16),
        _squareButton(icon: Icons.add, onTap: onIncrement),
      ],
    );
  }

  Widget _squareButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E2E2)),
          color: Colors.white,
        ),
        child: Icon(icon, size: 20, color: const Color(0xFF181725)),
      ),
    );
  }
}
