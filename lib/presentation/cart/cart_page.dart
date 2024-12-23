import 'package:e_pesan_resto/global/global_state.dart';
import 'package:e_pesan_resto/global_utility/functionality.dart';
import 'package:e_pesan_resto/presentation/cart/cart_state.dart';
import 'package:e_pesan_resto/presentation/cart/component/cart_tile.dart';
import 'package:e_pesan_resto/theme/font_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../global_utility/widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final cs = Get.put(CartState());
  final cc = Get.put(CartController());
  final gs = Get.put(GlobalState());

  @override
  void initState() {
    super.initState();
    cc.getCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        '#Keranjang',
                        style: bold20,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Obx(
                        () => Text(
                          '${cs.data.value.items.length} item',
                          style: regular14,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
                      child: Text(
                        'Periksa kembali makanan/minuman yang anda pesan',
                        style: regular14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Obx(
                  () {
                    var data = cs.data.value.items;
                    print('cart: $data');
                    return data.isEmpty
                        ? SizedBox(
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
                          )
                        : ListView.builder(
                            itemCount: data.length,
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 30),
                                child: CartTile(index: index),
                              );
                            },
                          );
                  },
                )
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 10),
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.grey.shade300,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.orange,
                      blurRadius: 5,
                      offset: Offset(2, 1),
                    )
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: regular14,
                          ),
                          Obx(() {
                            return Text(
                              calculateCartItem(cs.data.value.items),
                              style: bold16,
                            );
                          })
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          if (cs.data.value.items.isNotEmpty) {
                            Get.toNamed('/order-detail');
                          }
                        },
                        child: Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(50)),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: SvgPicture.asset(
                              'assets/images/icon_order.svg',
                              width: 25,
                              height: 25,
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
    );
  }
}
