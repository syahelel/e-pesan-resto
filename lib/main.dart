import 'package:e_pesan_resto/presentation/cart/cart_page.dart';
import 'package:e_pesan_resto/presentation/homepage/admin_homepage.dart';
import 'package:e_pesan_resto/presentation/homepage/user_homepage.dart';
import 'package:e_pesan_resto/presentation/authentication/login_page.dart';
import 'package:e_pesan_resto/presentation/authentication/register_page.dart';
import 'package:e_pesan_resto/welcome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'E RESTO',
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      routes: {
        '/': (context) => const Welcome(),
        '/register': (context) => RegisterPage(),
        '/login': (context) => const Loginpage(),
        
        // Admin
        '/admin-dashboard': (context) => const AdminHomePage(),

        // User
        '/user-dashboard': (context) => const UserHomePage(),
        '/cart': (context) => const CartPage()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
