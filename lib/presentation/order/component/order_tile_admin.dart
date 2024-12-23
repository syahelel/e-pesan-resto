import 'package:e_pesan_resto/global_utility/functionality.dart';
import 'package:e_pesan_resto/models/checkout_model.dart';
import 'package:e_pesan_resto/presentation/order/order_state.dart';
import 'package:e_pesan_resto/theme/font_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderTileAdmin extends StatelessWidget {
  final CheckoutModel model;
  const OrderTileAdmin({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final ahs = Get.put(OrderState());
    var date = model.createdAt;
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
                Text(
                  'Order Id',
                  style: regular14,
                ),
                Text(
                  model.orderId!,
                  style: bold14,
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              thickness: 2,
            ),
            const SizedBox(
              height: 5,
            ),
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Senin',
                      style: regular14,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          checkIconStatus(model.status!),
                          width: 25,
                          height: 25,
                          colorFilter: ColorFilter.mode(
                            checkIconColorStatus(model.status!),
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          model.status!,
                          style: bold14.copyWith(
                              color: checkIconColorStatus(model.status!)),
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
                      model.totalPrice!.toIDR(),
                      style: bold14,
                    ),
                  ],
                ),
                FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    ahs.index.value = model.checkoutableId!;
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
