import 'package:e_pesan_resto/controllers/cart_controller.dart';
import 'package:e_pesan_resto/global_utility/functionality.dart';
import 'package:e_pesan_resto/global_utility/widget.dart';
import 'package:e_pesan_resto/models/product_model.dart';
import 'package:e_pesan_resto/theme/font_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../global_utility/constant.dart';

class DetailProductPage extends StatelessWidget {
  final ProductModel product;
  const DetailProductPage({super.key, required this.product});

  Widget tileProductDetail() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.shade300,
        boxShadow: const [
          BoxShadow(color: Colors.black87, blurRadius: 10, offset: Offset(2, 1))
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Kategori',
                  style: bold14,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  product.productTypesId == 1 ? 'Makanan' : 'Minuman',
                  style: regular14.copyWith(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Rate',
                  style: bold14,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/icon_star.svg',
                      colorFilter: const ColorFilter.mode(
                        Colors.orange,
                        BlendMode.srcIn,
                      ),
                      width: 18,
                      height: 18,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      product.rate.toString(),
                      style: regular14.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Harga',
                  style: bold14,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  product.price.toIDR(),
                  style: bold14.copyWith(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Container(
              height: 40,
              width: 2,
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
            ),
            SvgPicture.asset(
              product.productTypesId == 1
                  ? 'assets/images/icon_makanan.svg'
                  : 'assets/images/icon_minuman.svg',
              colorFilter: const ColorFilter.mode(
                Colors.black,
                BlendMode.srcIn,
              ),
              width: 30,
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cc = Get.put(CartController());

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height,
                          ),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      child: Image.network(
                        '$BASEURL${product.photo}',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 255,
                      ),
                    ),
                    Positioned(
                      top: 60,
                      left: 20,
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: 42,
                          width: 42,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(15)),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 210,
                      left: 20,
                      right: 20,
                      child: tileProductDetail(),
                    ),
                    Positioned(
                      left: 20,
                      right: 20,
                      top: 300,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Deskripsi Produk',
                            style: bold20,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            product.description,
                            style: regular14,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return selectQuanityProduct((value) {
                cc.addItemIntocart(value, product.id);
                Get.back();
              });
            },
          );
        },
        backgroundColor: Colors.orange,
        splashColor: Colors.orange[300],
        icon: const Icon(
          Icons.add,
          color: Colors.white,
          size: 12,
        ),
        label: Text(
          'Keranjang',
          style: bold14.copyWith(color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
