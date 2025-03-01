import 'package:e_pesan_resto/global_utility/functionality.dart';
import 'package:e_pesan_resto/presentation/order/order_state.dart';
import 'package:e_pesan_resto/theme/font_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controllers/payment_controller.dart';

class OrderTile extends StatelessWidget {
  final int index;
  const OrderTile({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final os = Get.put(OrderState());
    final pc = Get.put(PaymentController());
    final indexedOs = os.dataOrder.value.data[index];

    var date = indexedOs.createdAt;
    var format = DateFormat('dd-MM-yyyy');
    String dateOnFormat = format.format(date!);

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
                          colorFilter: ColorFilter.mode(
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
                              color: checkIconColorStatus(indexedOs.status!)),
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
                !indexedOs.status!.contains('pending')
                    ? FilledButton(
                        style: FilledButton.styleFrom(
                            backgroundColor: Colors.green),
                        onPressed: () {
                          os.index.value = indexedOs.checkoutableId!;
                          Get.toNamed('/order-detail-nonpay');
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
                      )
                    : FilledButton(
                        style: FilledButton.styleFrom(
                            backgroundColor: Colors.orange),
                        onPressed: () {
                          pc.createPaymentWithOrderId(
                            indexedOs.checkoutableId!,
                            indexedOs.orderId!,
                          );
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
