import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:e_pesan_resto/controllers/auth_controller.dart';
import 'package:e_pesan_resto/global_utility/widget.dart';
import 'package:e_pesan_resto/presentation/authentication/auth_state.dart';
import 'package:e_pesan_resto/theme/font_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final authController = Get.put(AuthController());
  final authState = Get.put(AuthState());
 
  @override
  Widget build(BuildContext context) {
    final cm = TextEditingController();

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
            desc: 'Berhasil register akun',
            buttonsTextStyle: regular14,
            btnOkOnPress: () {
              authState.statusSuccess.value = false;
              Get.offNamed('/login');
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
                          Text("CHEF FOOD", style: bold16),
                          const SizedBox(height: 32),
                  
                          // Login Title
                          const Text(
                            "Register",
                            style: regular20,
                          ),
                          const SizedBox(height: 24),
                  
                          // Name Input Field
                          TextFormField(
                            decoration: InputDecoration(
                              hintStyle: regular14.copyWith(color: Colors.grey),
                              labelStyle: regular14,
                              labelText: "Name",
                              hintText: "Enter your Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Field kosong | Harap isi terlebih dahulu';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            onChanged: (value) => authState.nameState.value = value,
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 16),
                  
                          // Email Input Field
                          TextFormField(
                            decoration: InputDecoration(
                              hintStyle: regular14.copyWith(color: Colors.grey),
                              labelStyle: regular14,
                              labelText: "Email",
                              hintText: "Enter your email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Field kosong | Harap isi terlebih dahulu';
                              } else if (!value.contains('@gmail.com')) {
                                return 'Format email salah | Harap periksa kembali';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) =>
                                authState.emailState.value = value,
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 16),
                  
                          // No HP Input Field
                          TextFormField(
                            decoration: InputDecoration(
                              hintStyle: regular14.copyWith(color: Colors.grey),
                              labelStyle: regular14,
                              labelText: "No Handphone",
                              hintText: "Enter your No Handphone",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Field kosong | Harap isi terlebih dahulu';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            onChanged: (value) =>
                                authState.phoneNumberState.value = value,
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 16),
                  
                          // Password Input Field
                          TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                              hintStyle: regular14.copyWith(color: Colors.grey),
                              labelStyle: regular14,
                              labelText: "Password",
                              hintText: "Enter your password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Field kosong | Harap isi terlebih dahulu';
                              }
                              return null;
                            },
                            onChanged: (value) =>
                                authState.passwordState.value = value,
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 24),
                  
                          // Confirm Password Input Field
                          TextFormField(
                            controller: cm,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintStyle: regular14.copyWith(color: Colors.grey),
                              labelStyle: regular14,
                              labelText: "Confirm Password",
                              hintText: "re-enter your password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Field kosong | Harap isi terlebih dahulu';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.done,
                          ),
                          const SizedBox(height: 24),
                  
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
                                  if (authState.passwordState.value != cm.text) {
                                    authState.statusError.value = true;
                                    authState.errorMessage.value =
                                        'Password tidak sesuai';
                                  } else {
                                    authController.register();
                                  }
                                }
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
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                  
                          // Register Link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account? ",
                                style: regular14,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.offNamed('/login');
                                },
                                child: Text(
                                  "Login",
                                  style: regular14.copyWith(
                                    color: Colors.orange,
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
