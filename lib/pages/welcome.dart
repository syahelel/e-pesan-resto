import 'package:e_pesan_resto/pages/loginpage.dart';
import 'package:e_pesan_resto/pages/registerpage.dart';
import 'package:flutter/material.dart';


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
              // Logo Section
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(
                  'assets/images/chamber_logo.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),

              // Welcome Text
              const Text(
                "Welcome to CO’Z Resto",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),

              // Subtitle Text
              const Text(
                "Hidangan Lezat Berkualitas dan Bergizi",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 40),

              // Register Button
              SizedBox(
                width: 250,
                child: ElevatedButton(
                  onPressed: () {
                    // Add action for register button
                    Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()),
                        );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Register",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 5),

              // Login Button
              SizedBox(
                width: 250,
                child: OutlinedButton(
                  onPressed: () {
                    // Navigasi ke halaman Login
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Loginpage()));
                    
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 16, color: Colors.black),
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