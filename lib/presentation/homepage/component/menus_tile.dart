import 'package:e_pesan_resto/controllers/cart_controller.dart';
import 'package:e_pesan_resto/global_utility/constant.dart';
import 'package:e_pesan_resto/global_utility/functionality.dart';
import 'package:e_pesan_resto/global_utility/widget.dart';
import 'package:e_pesan_resto/presentation/homepage/state/user_home_state.dart';
import 'package:e_pesan_resto/theme/font_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MenusTile extends StatelessWidget {
  final int index;
  const MenusTile({
    super.key,
    required this.index,
  });

  Widget addToCartContainer() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '+ Keranjang',
          style: regular14.copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final uhs = Get.put(UserHomeState());
    final cc = Get.put(CartController());

    return Obx(() {
      if (index >= uhs.fullProduct.length) {
        return const SizedBox.shrink();
      }

      final uhsItemOnIndexed = uhs.displayedProduct[index];

      return Card(
        color: Colors.white,
        shadowColor: Colors.black54,
        elevation: 5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  uhs.selectedItem.value = uhsItemOnIndexed.id;
                  Get.toNamed('/detail-product');
                },
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      child: Image.network(
                        '$BASEURL${uhsItemOnIndexed.photo}',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 125,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 2,
                          child: Text(
                            uhsItemOnIndexed.name,
                            style: regular14,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/icon_star.svg',
                                colorFilter: const ColorFilter.mode(
                                  Colors.orange,
                                  BlendMode.srcIn,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  uhsItemOnIndexed.rate.toString(),
                                  style: regular14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Harga :',
                          style: regular14,
                        ),
                        Text(
                          uhsItemOnIndexed.price.toIDR(),
                          style: bold14.copyWith(color: Colors.orange),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return selectQuanityProduct((value) {
                        cc.addItemIntocart(value, uhsItemOnIndexed.id);
                        Get.back();  
                      });
                    },
                  );
                },
                child: addToCartContainer(),
              ),
            ],
          ),
        ),
      );
    });
  }
}
