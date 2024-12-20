import 'package:e_pesan_resto/controllers/checkout_controller.dart';
import 'package:e_pesan_resto/presentation/order/component/order_tile.dart';
import 'package:e_pesan_resto/presentation/order/order_state.dart';
import 'package:e_pesan_resto/theme/font_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

import '../../global/global_state.dart';
import '../../global_utility/widget.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final cc = Get.put(CheckoutController());
  final os = Get.put(OrderState());
  final gs = Get.put(GlobalState());

  @override
  void initState() {
    super.initState();
    cc.getAllCheckout();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height,
              )
            ],
          ),
        ),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 70,
                ),
                const Text(
                  '#Transaksi',
                  style: bold20,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 14,
                ),
                const Divider(
                  thickness: 2,
                ),
                Obx(
                  () {
                    if (os.dataOrder.value.data.isEmpty) {
                      SizedBox(
                        height: 500,
                        width: double.infinity,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/display_empty_cart.png',
                                width: 300,
                                height: 300,
                              ),
                              const Text(
                                'Keranjang Kosong',
                                style: regular20,
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: os.dataOrder.value.data.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:  EdgeInsets.only(
                            bottom: os.dataOrder.value.data.length == index + 1 ? 100 : 20,
                          ),
                          child: OrderTile(
                            index: index,
                          ),
                        );
                      },
                    );
                  },
                )
              ],
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
    );
  }
}
