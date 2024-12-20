import 'package:e_pesan_resto/presentation/cart/cart_page.dart';
import 'package:e_pesan_resto/presentation/cart/cart_state.dart';
import 'package:e_pesan_resto/presentation/homepage/admin_homepage.dart';
import 'package:e_pesan_resto/presentation/homepage/state/user_home_state.dart';
import 'package:e_pesan_resto/presentation/homepage/user_homepage.dart';
import 'package:e_pesan_resto/presentation/authentication/login_page.dart';
import 'package:e_pesan_resto/presentation/authentication/register_page.dart';
import 'package:e_pesan_resto/presentation/order/detail_order_page.dart';
import 'package:e_pesan_resto/presentation/order/order_page.dart';
import 'package:e_pesan_resto/presentation/product/detail_product_page.dart';
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
    final userHomeState = Get.put(UserHomeState());
    final cartState = Get.put(CartState());

    return GetMaterialApp(
      title: 'E RESTO',
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      routes: {
        '/': (context) => const Welcome(),
        '/register': (context) => const RegisterPage(),
        '/login': (context) => const Loginpage(),

        // Admin
        '/admin-dashboard': (context) => const AdminHomePage(),

        // User
        '/user-dashboard': (context) => const UserHomePage(),
        '/cart': (context) => const CartPage(),
        '/order': (context) => const OrderPage(),
        '/order-detail': (context) => DetailOrderPage(cartResponse: cartState.data.value),
        '/detail-product': (context) => DetailProductPage(
              product: userHomeState.fullProduct
                  .where((e) => e.id == userHomeState.selectedItem.value)
                  .first,
            )
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
