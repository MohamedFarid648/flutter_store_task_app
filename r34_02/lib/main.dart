// import 'package:flutter/material.dart';
// import 'package:flutter_store_task_app/src/core/config/config.dart';
// import 'package:flutter_store_task_app/src/core/constants/colors.dart';
// import 'package:flutter_store_task_app/src/core/routes/route_handler.dart';
// import 'package:google_fonts/google_fonts.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await diRegister();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Nectar Grocery',
//       debugShowCheckedModeBanner: false,
//       onGenerateRoute: RouteHandler.generateRoute,

//       theme: ThemeData(
//         primaryColor: AppColors.primary,
//         scaffoldBackgroundColor: Colors.white,
//         textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
//         useMaterial3: true,
//       ),
//       //new way to route
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_task_app/src/core/config/config.dart';
import 'package:flutter_store_task_app/src/core/routes/routes.dart';
import 'package:flutter_store_task_app/src/core/services/session_manager.dart';
import 'package:flutter_store_task_app/src/features/cart/presentation/cubit/cart_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await diRegister();

  // Read session after DI is ready
  final sessionManager = getIt<SessionManager>();
  final isLoggedIn = sessionManager.isLoggedIn;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //  Global cart – available in ALL screens
        BlocProvider<CartCubit>.value(value: getIt<CartCubit>()),

        // add other global cubits (theme, auth, etc.)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Grocery Demo',
        theme: ThemeData(primarySwatch: Colors.green, fontFamily: 'Poppins'),
        initialRoute: isLoggedIn
            ? RouteNames.productsPage
            : RouteNames.loginPage,
        onGenerateRoute: RouteHandler.generateRoute,
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     title: 'Grocery Demo',
  //     debugShowCheckedModeBanner: false,
  //     theme: ThemeData(primarySwatch: Colors.green, fontFamily: 'Poppins'),
  //     initialRoute: isLoggedIn ? RouteNames.productPage : RouteNames.loginPage,
  //     onGenerateRoute: RouteHandler.generateRoute,
  //   );
  // }
}
