import 'package:e_pesan_resto/controllers/checkout_controller.dart';
import 'package:e_pesan_resto/global/global_state.dart';
import 'package:e_pesan_resto/global_utility/widget.dart';
import 'package:e_pesan_resto/models/checkout_model.dart';
import 'package:e_pesan_resto/presentation/homepage/state/admin_home_state.dart';
import 'package:e_pesan_resto/presentation/order/component/order_tile_admin.dart';
import 'package:e_pesan_resto/theme/font_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final cc = Get.put(CheckoutController());
  final ahs = Get.put(AdminHomeState());
  final gs = Get.put(GlobalState());

  @override
  void initState() {
    super.initState();
    cc.getAllCheckoutAdmin();
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
                      List<CheckoutModel> listDataDisplayed = ahs
                          .dataOrder.value.data
                          .where((element) =>
                              element.status!.contains('process') ||
                              element.status!.contains('complete'))
                          .toList();

                      if (ahs.dataOrder.value.data.isEmpty) {
                        return SizedBox(
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
                                  'Transaksi Kosong',
                                  style: regular20,
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: listDataDisplayed.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var indexItem = listDataDisplayed[index];
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: listDataDisplayed.length == index + 1
                                  ? 100
                                  : 20,
                            ),
                            child: OrderTileAdmin(
                              model: indexItem,
                            ),
                          );
                        },
                      );
                    },
                  ),
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
      ),
    );
  }
}
