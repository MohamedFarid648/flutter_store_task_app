import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_task_app/src/core/config/config.dart';
import 'package:flutter_store_task_app/src/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_store_task_app/src/features/auth/presentation/pages/number_page.dart';
import 'package:flutter_store_task_app/src/features/auth/presentation/pages/onboarding_page.dart';
import 'package:flutter_store_task_app/src/features/auth/presentation/pages/register_page.dart';
import 'package:flutter_store_task_app/src/features/auth/presentation/pages/signin_landing_page.dart';
import 'package:flutter_store_task_app/src/features/auth/presentation/pages/splash_page.dart';
import 'package:flutter_store_task_app/src/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:flutter_store_task_app/src/features/cart/presentation/pages/cart_page.dart';
import 'package:flutter_store_task_app/src/features/menu/menu_page.dart';
import 'package:flutter_store_task_app/src/features/product/data/models/product_model.dart';
import 'package:flutter_store_task_app/src/features/product/domain/usecases/get_products_usecase.dart';
import 'package:flutter_store_task_app/src/features/product/logic/products_cubit.dart';
import 'package:flutter_store_task_app/src/features/product/presentation/pages/pages.dart';
import 'routes.dart';

class RouteHandler {
  static Route generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteNames.splashPage:
        return MaterialPageRoute(builder: (context) => const SplashPage());
      // case RouteNames.home_screen:
      //   return MaterialPageRoute(
      //     builder: (context) => HomeScreen(),
      //   );
      case RouteNames.onboardingPage:
        return MaterialPageRoute(builder: (context) => const OnboardingPage());

      case RouteNames.enterNumberPage:
        return MaterialPageRoute(builder: (context) => const NumberPage());

      case RouteNames.signinLandingPage:
        return MaterialPageRoute(
          builder: (context) => const SignInLandingPage(),
        );
      case RouteNames.loginPage:
        return MaterialPageRoute(builder: (context) => const LoginPage());

      case RouteNames.registerPage:
        return MaterialPageRoute(builder: (context) => const RegisterPage());

      //Using .value ensures we reuse the singleton CartCubit from DI instead of creating a fresh one.
      case RouteNames.cart:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<CartCubit>.value(
            value: getIt<CartCubit>(),
            child: const CartPage(),
          ),
        );

      case RouteNames.menu:
        return MaterialPageRoute(builder: (_) => const MenuPage());

      case RouteNames.productsPage:
        final categoryTitle =
            (routeSettings.arguments as String?) ?? 'Beverages';

        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<ProductsCubit>(
                create: (_) =>
                    ProductsCubit(getIt<GetProductsUseCase>())..loadProducts(),
              ),
              BlocProvider<CartCubit>.value(value: getIt<CartCubit>()),
            ],
            child: ProductsGridPage(title: categoryTitle),
          ),
        );

      case RouteNames.productDetailsPage:
        final product = routeSettings.arguments as ProductModel;

        return MaterialPageRoute(
          builder: (_) => ProductDetailsPage(product: product),
        );

      default:
        return MaterialPageRoute(
          builder: (context) =>
              const Scaffold(body: Center(child: Text("No Route Found"))),
        );
    }
  }
}
