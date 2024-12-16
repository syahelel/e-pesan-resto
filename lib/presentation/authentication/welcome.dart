import 'package:e_pesan_resto/theme/font_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Welcome extends StatelessWidget {
  const Welcome ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             Image.asset(
                  'assets/images/display_logos.png',
                  fit: BoxFit.contain,
                  width: 300,
                  height: 300,
                ),
              const SizedBox(height: 20),

              // Welcome Text
              Text(
                "Welcome to CHEF FOOD",
                style: bold20.copyWith(
                  fontSize: 24,
                )
              ),
              const SizedBox(height: 8),

              // Subtitle Text
              Text(
                "Hidangan Lezat Berkualitas dan Bergizi",
                style: regular14.copyWith(
                  color: Colors.grey
                )
              ),
              const SizedBox(height: 40),

              // Register Button
              SizedBox(
                height: 50,
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed('/register');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Register",
                    style: regular14.copyWith(
                      color: Colors.white,
                      fontSize: 16
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Login Button
              SizedBox(
                height: 50,
                width: 300,
                child: OutlinedButton(
                  onPressed: () {
                    Get.toNamed('/login');
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Login",
                    style: regular14.copyWith(
                      fontSize: 16
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}