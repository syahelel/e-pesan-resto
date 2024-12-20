import 'package:e_pesan_resto/theme/font_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
                  'Jumlah quantity',
                  style: regular14,
                ),
              ),
              Flexible(
                flex: 1,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: controller,
                  autofocus: true,
                  
                  decoration: InputDecoration(
                    hintText: 'quantity',
                    hintStyle: regular14.copyWith(color: Colors.grey),
                  ),
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
                onSubmit(
                  int.parse(controller.text),
                );
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
  );
}
