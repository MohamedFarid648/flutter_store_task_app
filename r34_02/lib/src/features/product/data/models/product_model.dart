class ProductModel {
  final int id;
  final String title;
  final String description;
  final num price;
  final String thumbnail;
  final List<String> images;
  final String category;
  final String brand;
  final num rating;
  final int stock;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.thumbnail,
    required this.images,
    required this.category,
    required this.brand,
    required this.rating,
    required this.stock,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0,
      thumbnail: json['thumbnail'] ?? '',
      images: (json['images'] as List?)?.cast<String>() ?? const [],
      category: json['category'] ?? '',
      brand: json['brand'] ?? '',
      rating: json['rating'] ?? 0,
      stock: json['stock'] ?? 0,
    );
  }
}

class ProductsResponse {
  final List<ProductModel> products;
  final int total;
  final int skip;
  final int limit;

  ProductsResponse({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory ProductsResponse.fromJson(Map<String, dynamic> json) {
    final list = (json['products'] as List?) ?? [];
    return ProductsResponse(
      products: list
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: json['total'] ?? 0,
      skip: json['skip'] ?? 0,
      limit: json['limit'] ?? 0,
    );
  }
}
