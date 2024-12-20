import 'package:e_pesan_resto/global_utility/constant.dart';
import 'package:e_pesan_resto/presentation/cart/cart_state.dart';
import 'package:e_pesan_resto/theme/font_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/cart_controller.dart';
import '../../../global_utility/widget.dart';

class CartTile extends StatelessWidget {
  final int index;
  const CartTile({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final cs = Get.put(CartState());
    final cc = Get.put(CartController());

    return Obx(
      () {
        final indexedCs = cs.data.value.items[index];

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    '$BASEURL${indexedCs.productable?.photo}',
                    fit: BoxFit.cover,
                    width: 80,
                    height: 80,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Makanan',
                          style: bold14,
                        ),
                        Text(
                          indexedCs.productable!.name,
                          style: bold14,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Qty : ${indexedCs.quantity}',
                      style: regular14,
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    cc.deleteItemOnCart(indexedCs.id!);
                  },
                  child: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                    size: 25,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return selectQuanityProduct((value) {
                        cc.updateItemOnCart(value, indexedCs.id!);
                        Get.back();  
                      });
                    },
                  );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey.shade400),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 9,
                      ),
                      child: Text(
                        'Ubah',
                        style: regular14,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        );
      },
    );
  }
}
