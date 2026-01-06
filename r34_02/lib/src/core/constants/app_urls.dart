class AppUrls {
  static const String baseUrl = 'https://dummyjson.com';

  // Auth
  static const String login = '/auth/login';
  static const String register = '/users/add';

  // Products
  static const String products = '/products';
  static String productById(int id) => '/products/$id';
}
