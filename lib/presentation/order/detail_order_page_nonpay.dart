import 'package:e_pesan_resto/controllers/admin_controller.dart';
import 'package:e_pesan_resto/controllers/checkout_controller.dart';
import 'package:e_pesan_resto/global/global_state.dart';
import 'package:e_pesan_resto/global_component/custom_dropdown_status_component.dart';
import 'package:e_pesan_resto/global_utility/widget.dart';
import 'package:e_pesan_resto/presentation/cart/cart_state.dart';
import 'package:e_pesan_resto/presentation/order/component/order_detail_tile.dart';
import 'package:e_pesan_resto/presentation/order/order_state.dart';
import 'package:e_pesan_resto/theme/font_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/cart_controller.dart';
import '../../global_utility/functionality.dart';

class DetailOrderPageNonpay extends StatefulWidget {
  final int index;
  final bool isAdmin;
  const DetailOrderPageNonpay(
      {super.key, required this.index, required this.isAdmin});

  @override
  State<DetailOrderPageNonpay> createState() => _DetailOrderPageNonpayState();
}

class _DetailOrderPageNonpayState extends State<DetailOrderPageNonpay> {
  final oState = Get.put(OrderState());
  final cController = Get.put(CartController());
  final cS = Get.put(CartState());
  final cc = Get.put(CheckoutController());
  final ac = Get.put(AdminController());


  @override
  void initState() {
    super.initState();
    cController.getCartById(widget.index);
  }

  Widget head() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Get.back();
            cc.getAllCheckoutAdmin();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            size: 24,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        const Text(
          'Detail Pesanan',
          style: bold20,
        ),
      ],
    );
  }

  Widget componentDetail(String left, String right) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(left, style: regular14),
        Text(
          right,
          style: regular14,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var date = DateTime.now();
    var format = DateFormat('dd-MM-yyyy');
    String dateOnFormat = format.format(date);

    final gs = Get.put(GlobalState());

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height,
                )
              ],
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 70,
                    ),
                    head(),
                    const SizedBox(
                      height: 30,
                    ),
                    componentDetail(
                      DateFormat('EEEE').format(date),
                      dateOnFormat,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    componentDetail(
                      'Total harga',
                      calculateCartItem(cS.data.value.items),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    componentDetail(
                      'Pemesan',
                      cS.data.value.account!.name,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(thickness: 2, color: Colors.black,),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Item',
                      style: bold16,
                    ),
                    ListView.builder(
                      itemCount: cS.data.value.items.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: OrderDetailTile(
                            cart: cS.data.value.items[index],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 25,
            right: 25,
            child: widget.isAdmin
                ? CustomDropdownStatusComponent(
                    callbackDropdown: (value, index) {
                      var status = 'process';
                      var checkoutableId = cS.data.value.id;
                      if (index == 1) {
                        status = 'process';
                      } else {
                        status = 'complete';
                      }
                      ac.updateStatusOrder(status, checkoutableId!);
                    },
                  )
                : const SizedBox(),
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
