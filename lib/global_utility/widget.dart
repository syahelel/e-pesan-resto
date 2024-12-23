import 'package:e_pesan_resto/theme/font_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

final loadingWidget = SpinKitChasingDots(
  itemBuilder: (context, index) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.all(
          Radius.circular(100),
        ),
      ),
    );
  },
);

Widget selectQuanityProduct(Function(int) onSubmit) {
  var controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  return Container(
    width: double.infinity,
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              height: 5,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(12)),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: Text(
                    'Jumlah item',
                    style: regular14,
                  ),
                ),Flexible(
                  flex: 1,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    controller: controller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field kosong | Harap isi terlebih dahulu';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Jumlah",
                      hintText: "Masukan jumlah item",
                      labelStyle: regular14,
                      hintStyle: regular14.copyWith(
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    textInputAction: TextInputAction.done,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () 
                {
                  if (_formKey.currentState!.validate()) {
                    onSubmit(int.parse(controller.text));
                  } 
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                ),
                child: Text(
                  'Selesai',
                  style: regular14.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget updateProductWidget(Function(int) onSubmit) {
  var controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  return Container(
    width: double.infinity,
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              height: 5,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(12)),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: Text(
                    'Harga',
                    style: regular14,
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: controller,
                    autofocus: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field kosong | Harap isi terlebih dahulu';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Harga",
                      hintText: "Masukan harga produk",
                      labelStyle: regular14,
                      hintStyle: regular14.copyWith(
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    textInputAction: TextInputAction.done,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                     onSubmit(
                      int.parse(controller.text),
                    );
                  }
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                ),
                child: Text(
                  'Selesai',
                  style: regular14.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget deleteProductWidget(Function() onSubmit) {
  return Container(
    width: double.infinity,
    height: 170,
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            height: 5,
            width: 100,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(12)),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Apakah anda yakin untuk menghapus item ini?',
            style: regular14,
            overflow: TextOverflow.clip,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      Get.back();
                    },
                    style:
                        FilledButton.styleFrom(backgroundColor: Colors.white),
                    child: Text(
                      'Batal',
                      style: regular14.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: FilledButton(
                    onPressed: onSubmit,
                    style: FilledButton.styleFrom(backgroundColor: Colors.red),
                    child: Text(
                      'Hapus',
                      style: regular14.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    ),
  );
}
