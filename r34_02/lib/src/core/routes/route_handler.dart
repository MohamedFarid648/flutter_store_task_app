import 'package:flutter/material.dart';
import 'package:flutter_store_task_app/src/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_store_task_app/src/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter_store_task_app/src/features/auth/presentation/pages/number_screen.dart';
import 'package:flutter_store_task_app/src/features/auth/presentation/pages/onboarding_screen.dart';
import 'package:flutter_store_task_app/src/features/auth/presentation/pages/register_page.dart';
import 'package:flutter_store_task_app/src/features/auth/presentation/pages/signin_landing_screen.dart';
import 'package:flutter_store_task_app/src/features/auth/presentation/pages/splash_screen.dart';
import 'package:flutter_store_task_app/src/features/product/presentation/pages/pages.dart';
import 'package:flutter_store_task_app/src/features/product/presentation/pages/product_details_page.dart';
import 'package:flutter_store_task_app/src/features/product/presentation/pages/products_grid_page.dart';
import 'routes.dart';

class RouteHandler {
  static Route generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteNames.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      // case RouteNames.home_screen:
      //   return MaterialPageRoute(
      //     builder: (context) => HomeScreen(),
      //   );
      case RouteNames.onboarding_screen:
        return MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        );

      case RouteNames.enter_number_screen:
        return MaterialPageRoute(builder: (context) => const NumberScreen());

      case RouteNames.signin_landing_screen:
        return MaterialPageRoute(
          builder: (context) => const SignInLandingScreen(),
        );
      case RouteNames.login_screen:
        return MaterialPageRoute(builder: (context) => const LoginPage());

      case RouteNames.register_screen:
        return MaterialPageRoute(builder: (context) => const RegisterPage());

      // case RouteNames.product_screen:
      //   return MaterialPageRoute(builder: (context) => const ProductPage());

      // case RouteNames.product_details_screen:
      //   return MaterialPageRoute(builder: (context) => const ProductDetailsPage(1));

      case RouteNames.product_screen:
        return MaterialPageRoute(builder: (_) => const ProductsGridPage());

      case RouteNames.product_details_screen:
        final int productId = routeSettings.arguments as int; // get id
        return MaterialPageRoute(
          builder: (_) => ProductDetailsPage(
            productId: productId, // pass id
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (context) =>
              const Scaffold(body: Center(child: Text("No Route Found"))),
        );
    }
  }
}
