import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:e_pesan_resto/controllers/auth_controller.dart';
import 'package:e_pesan_resto/global_utility/widget.dart';
import 'package:e_pesan_resto/presentation/authentication/auth_state.dart';
import 'package:e_pesan_resto/theme/font_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loginpage extends StatelessWidget {
  const Loginpage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final authState = Get.put(AuthState());
    final authController = Get.put(AuthController());

    authState.statusError.listen((value) {
      if (value) {
        Future.delayed(const Duration(milliseconds: 500), () {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.topSlide,
            title: 'Error',
            titleTextStyle: bold20,
            descTextStyle: regular14,
            desc: authState.errorMessage.value,
            buttonsTextStyle: regular14,
            btnOkOnPress: () {
              authState.statusError.value = false;
            },
          ).show();
        });
      }
    });

    authState.statusSuccess.listen((value) {
      if (value) {
        Future.delayed(const Duration(milliseconds: 500), () {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.topSlide,
            title: 'Sukses',
            titleTextStyle: bold20,
            descTextStyle: regular14,
            desc: 'Berhasil login akun',
            buttonsTextStyle: regular14,
            btnOkOnPress: () {
              authState.statusSuccess.value = false;
              if (authState.authModel.value.role == 'user') {
                Get.offAllNamed('/user-dashboard');
              } else {
                Get.offAllNamed('/admin-dashboard');
              }
            },
          ).show();
        });
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         const SizedBox(
                            height: 50,
                          ),
                        // Logo
                        Image.asset(
                          'assets/images/display_logos.png',
                          fit: BoxFit.contain,
                          width: 100,
                          height: 100,
                        ),
                        const SizedBox(height: 16),
                
                        // App Name
                        const Text(
                          "CHEFF FOOD",
                          style: bold20,
                        ),
                        const SizedBox(height: 32),
                
                        // Login Title
                        const Text(
                          "Login",
                          style: regular20,
                        ),
                        const SizedBox(height: 24),
                
                        // Email Input Field
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Email",
                            hintText: "Enter your email",
                            labelStyle: regular14,
                            hintStyle: regular14.copyWith(
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          onChanged: (value) => authState.emailState.value = value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Field kosong | Harap isi terlebih dahulu';
                            } else if (!value.contains('@gmail.com')) {
                              return 'Format email salah | Harap periksa kembali';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                
                        // Password Input Field
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Password",
                            hintText: "Enter your password",
                            labelStyle: regular14,
                            hintStyle: regular14.copyWith(
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          textInputAction: TextInputAction.done,
                          onChanged: (value) => authState.passwordState.value = value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Field kosong | Harap isi terlebih dahulu';
                            } 
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                
                        // Login Button
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) {
                                authState.statusError.value = true;
                                authState.errorMessage.value =
                                    'Harap masukan data dengan benar';
                              } else {
                                print('hasi: ${authState.emailState.value}, ${authState.passwordState.value}');
                                authController.login();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              "Login",
                              style: bold14.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                
                        // Register Link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don’t have an account? ",
                              style: TextStyle(color: Colors.black),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed('/register');
                              },
                              child: const Text(
                                "Register",
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
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
          ],
        ),
      ),
    );
  }
}
