import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:e_pesan_resto/controllers/admin_controller.dart';
import 'package:e_pesan_resto/controllers/home_controller.dart';
import 'package:e_pesan_resto/controllers/session_controller.dart';
import 'package:e_pesan_resto/global/global_state.dart';
import 'package:e_pesan_resto/global_component/custom_dropdown_type_component.dart';
import 'package:e_pesan_resto/global_utility/functionality.dart';
import 'package:e_pesan_resto/presentation/homepage/state/admin_home_state.dart';
import 'package:e_pesan_resto/theme/font_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../global_utility/widget.dart';

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality, int? limit);

class AddProductPage extends StatefulWidget {
  final String name;
  final String desc;
  final int price;
  final double rate;
  const AddProductPage({
    super.key,
    required this.name,
    required this.desc,
    required this.price,
    required this.rate,
  });

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  File? files;
  final _formKey = GlobalKey<FormState>();
  final ahs = Get.put(AdminHomeState());
  final gs = Get.put(GlobalState());
  final ac = Get.put(AdminController());
  final HomeController hm = Get.put(HomeController());
  final ss = Get.put(SessionController());

  @override
  Widget build(BuildContext context) {
    gs.statusError.listen((value) {
      if (value) {
        Future.delayed(const Duration(milliseconds: 500), () {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.topSlide,
            title: 'Error',
            titleTextStyle: bold20,
            descTextStyle: regular14,
            desc: gs.errorMessage.value,
            buttonsTextStyle: regular14,
            btnOkOnPress: () {
              gs.statusError.value = false;
            },
          ).show();
        });
      }
    });

    gs.statusSuccess.listen((value) {
      if (value) {
        Future.delayed(const Duration(milliseconds: 500), () {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.topSlide,
            title: 'Success',
            titleTextStyle: bold20,
            descTextStyle: regular14,
            desc: 'Berhasil menambahkan data',
            buttonsTextStyle: regular14,
            btnOkOnPress: () {
              gs.statusSuccess.value = false;
              hm.getAllProduct(ss.session.value.token);
              Get.offAllNamed('/admin-dashboard');
            },
          ).show();
        });
      }
    });

    Future pickImage() async {
      try {
        final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
        );
        if (image == null) return;
        final imageTemp = File(image.path);
        setState(() {
          files = imageTemp;
          ahs.file.value = imageTemp;
        });
      } on PlatformException catch (e) {
        print('Failed to pick image: $e');
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                              hm.getAllProduct(ss.session.value.token);
                            },
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                              size: 25,
                            ),
                          ),
                          const Text(
                            'Product',
                            style: bold20,
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      const Divider(
                        thickness: 2,
                        color: Colors.black,
                      ),
                      Text(
                        "Harap periksa kembali data yang telah di-input sebelum disubmit !!!",
                        style: regular14,
                        overflow: TextOverflow.clip,
                      ),
                      const SizedBox(height: 23),
                      TextFormField(
                        initialValue: widget.name,
                        decoration: InputDecoration(
                          labelText: "Nama produk",
                          hintText: "Masukan nama produk",
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
                        onChanged: (value) => ahs.name.value = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field kosong | Harap isi terlebih dahulu';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        initialValue: widget.name,
                        maxLines: 5,
                        decoration: InputDecoration(
                          labelText: "Deskripsi produk",
                          hintText: "Masukan deskripsi produk",
                          labelStyle: regular14,
                          hintStyle: regular14.copyWith(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) => ahs.description.value = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field kosong | Harap isi terlebih dahulu';
                          } else if (value.length <= 50) {
                            return 'Deskripsi tidak boleh kurang dari 50 kata';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomDropdownTypeComponent(
                        callback: (value, index) {
                          ahs.productTypesId.value = index;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        initialValue: widget.price.toIDR(),
                        decoration: InputDecoration(
                          labelText: "Harga",
                          hintText: "Masukan harga",
                          labelStyle: regular14,
                          hintStyle: regular14.copyWith(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) =>
                            ahs.price.value = int.parse(value),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field kosong | Harap isi terlebih dahulu';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        initialValue: widget.rate.toString(),
                        decoration: InputDecoration(
                          labelText: "Rating",
                          hintText: "Masukan rating",
                          labelStyle: regular14,
                          hintStyle: regular14.copyWith(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) =>
                            ahs.rate.value = double.parse(value),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field kosong | Harap isi terlebih dahulu';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: () {
                              pickImage();
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                files == null
                                    ? Image.asset(
                                        'assets/images/display_empty_image.jpg',
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.file(
                                        files!,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Masukan gambar yang sesuai',
                                  style: regular14,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (!_formKey.currentState!.validate()) {
                              gs.statusError.value = true;
                              gs.errorMessage.value =
                                  'Harap masukan data dengan benar';
                            } else {
                              if (ahs.file.value != File('') &&
                                  ahs.productTypesId.value != 0) {
                                await ac.addProduct();
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
                            "Kirim",
                            style: bold14.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Obx(
              () {
                if (gs.isLoading.value) {
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
