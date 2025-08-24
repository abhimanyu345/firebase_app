import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';
import 'auth/login_screen.dart';
import 'auth/otp_screen.dart';
import 'auth/home_screen.dart';
import 'views/object_list_screen.dart';
import 'views/object_form_screen.dart';
import 'views/object_detail_screen.dart';
import 'controllers/auth_controller.dart';
import 'controllers/api_controller.dart';
import 'models/object_model.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Cargo Intern App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.indigo,
        primaryColor: Colors.indigo.shade700,
        scaffoldBackgroundColor: Colors.grey.shade50,

        // AppBar styling
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.indigo.shade700,
          foregroundColor: Colors.white,
          elevation: 3,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),

        // Text styling
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.grey.shade900, fontSize: 16),
          bodyMedium: TextStyle(color: Colors.grey.shade800, fontSize: 14),
          titleLarge: TextStyle(color: Colors.indigo.shade900, fontWeight: FontWeight.bold),
        ),

        // Global TextField design
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.indigo.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.indigo.shade700, width: 2),
          ),
          hintStyle: TextStyle(color: Colors.grey.shade500),
        ),

        // ElevatedButton styling
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo.shade700,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
            textStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        // Card styling
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 4,
          shadowColor: Colors.grey.shade300,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),

        // Snackbar styling
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.indigo.shade700,
          contentTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          behavior: SnackBarBehavior.floating,
        ),

        // FloatingActionButton styling
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.indigo.shade700,
          foregroundColor: Colors.white,
        ),
      ),
      initialBinding: BindingsBuilder(() {
        // Initialize controllers
        Get.put(AuthController());
        Get.put(ApiController());
      }),
      initialRoute: '/login',
      getPages: [
        // Authentication routes
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/otp', page: () => OTPScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),

        // Object CRUD routes
        GetPage(name: '/objects/list', page: () => ObjectListScreen()),
        GetPage(name: '/objects/form', page: () => ObjectFormScreen()),

        // Pass ObjectModel as argument
        GetPage(
          name: '/objects/detail',
          page: () {
            final obj = Get.arguments as ObjectModel;
            return ObjectDetailScreen(object: obj);
          },
        ),
      ],
    );
  }
}
