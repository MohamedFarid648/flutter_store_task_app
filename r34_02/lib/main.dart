import 'package:flutter/material.dart';
import 'package:flutter_store_task_app/src/core/config/config.dart';
import 'package:flutter_store_task_app/src/core/constants/colors.dart';
import 'package:flutter_store_task_app/src/core/routes/route_handler.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await diRegister();
  runApp(const MyApp());
}

// void main() {
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nectar Grocery',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteHandler.generateRoute,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        useMaterial3: true,
      ),
      //new way to route
    );
  }
}
