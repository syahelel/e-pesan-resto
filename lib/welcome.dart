import 'package:e_pesan_resto/controllers/session_controller.dart';
import 'package:e_pesan_resto/global_utility/widget.dart';
import 'package:e_pesan_resto/presentation/authentication/auth_state.dart';
import 'package:e_pesan_resto/theme/font_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final authState = Get.put(AuthState());
  final sessionController = Get.put(SessionController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      sessionController.initialCondition();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
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
                  Text("Welcome to CHEF FOOD",
                      style: bold20.copyWith(
                        fontSize: 24,
                      )),
                  const SizedBox(height: 8),

                  // Subtitle Text
                  Text("Hidangan Lezat Berkualitas dan Bergizi",
                      style: regular14.copyWith(color: Colors.grey)),
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
                            color: Colors.white, fontSize: 16),
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
                        style: regular14.copyWith(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(
            () {
              if (authState.isLoading.value) {
                return Container(
                  decoration: const BoxDecoration(color: Colors.black45),
                  child: loadingWidget,
                );
              }
              return Container();
            },
          ),
        ]),
      ),
    );
  }
}
