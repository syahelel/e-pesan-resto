import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:e_pesan_resto/global_utility/functionality.dart';
import 'package:e_pesan_resto/presentation/order/order_state.dart';
import 'package:e_pesan_resto/presentation/order/payment_screen.dart';
import 'package:e_pesan_resto/theme/font_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controllers/payment_controller.dart';
import '../../homepage/state/user_home_state.dart';

class OrderTile extends StatelessWidget {
  final int index;
  const OrderTile({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final os = Get.put(OrderState());
    final pc = Get.put(PaymentController());
    final indexedOs = os.dataOrder.value.data[index];
    final uhs = Get.put(UserHomeState());

    var date = indexedOs.createdAt;
    var format = DateFormat('dd-MM-yyyy');
    String dateOnFormat = format.format(date!);

    os.paymentUrl.listen(
      (value) async {
        if (value.isNotEmpty || value != '') {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentScreen(url: value),
            ),
          );

          if (result == 'finish') {
            os.statusSuccess.value = true;
          } else if (result == 'error') {
            os.statusError.value = true;
          } else {
            os.statusUnfinish.value = true;
          }
        }
      },
    );

    os.statusUnfinish.listen((value) {
      if (value) {
        Future.delayed(const Duration(milliseconds: 500), () {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.warning,
            animType: AnimType.topSlide,
            title: 'Pending',
            titleTextStyle: bold20,
            descTextStyle: regular14,
            desc: 'Pembayaran tertunda, harap coba kembali',
            buttonsTextStyle: regular14,
            btnOkOnPress: () {
              os.statusError.value = false;
              uhs.changeMenuItem(2);
              Get.offAllNamed('/user-dashboard');
            },
          ).show();
        });
      }
    });

    os.statusError.listen((value) {
      if (value) {
        Future.delayed(const Duration(milliseconds: 500), () {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.topSlide,
            title: 'Erorr',
            titleTextStyle: bold20,
            descTextStyle: regular14,
            desc: 'Pembayaran gagal, harap coba kembali',
            buttonsTextStyle: regular14,
            btnOkOnPress: () {
              os.statusError.value = false;
              uhs.changeMenuItem(2);
              Get.offAllNamed('/user-dashboard');
            },
          ).show();
        });
      }
    });

    os.statusSuccess.listen((value) {
      if (value) {
        Future.delayed(const Duration(milliseconds: 500), () {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.topSlide,
            title: 'Success',
            titleTextStyle: bold20,
            descTextStyle: regular14,
            desc: 'Pembayaran berhasil',
            buttonsTextStyle: regular14,
            btnOkOnPress: () {
              os.statusSuccess.value = false;
              uhs.changeMenuItem(2);
              Get.offAllNamed('/user-dashboard');
            },
          ).show();
        });
      }
    });

    return Card(
      color: Colors.white,
      shadowColor: Colors.grey,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('EEEE').format(date),
                      style: regular14,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      dateOnFormat,
                      style: bold14,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Senin',
                      style: regular14,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          checkIconStatus(indexedOs.status!),
                          width: 25,
                          height: 25,
                          colorFilter:  ColorFilter.mode(
                            checkIconColorStatus(indexedOs.status!),
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          indexedOs.status!,
                          style: bold14.copyWith(
                            color: checkIconColorStatus(indexedOs.status!)
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 22,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total',
                      style: regular14,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      indexedOs.totalPrice!.toIDR(),
                      style: bold14,
                    ),
                  ],
                ),
                indexedOs.paymentPrice != 0 ?
                FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 6,
                    ),
                    child: Text(
                      'Detail',
                      style: regular14.copyWith(color: Colors.white),
                    ),
                  ),
                ): 
                FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: Colors.orange),
                  onPressed: () {
                    pc.createPaymentWithOrderId(indexedOs.checkoutableId!, indexedOs.orderId!);

                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 6,
                    ),
                    child: Text(
                      'Bayar',
                      style: regular14.copyWith(color: Colors.white),
                    ),
                  ),
                ), 
              ],
            )
          ],
        ),
      ),
    );
  }
}
