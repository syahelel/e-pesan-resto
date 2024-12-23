import 'package:e_pesan_resto/global_utility/constant.dart';
import 'package:e_pesan_resto/global_utility/functionality.dart';
import 'package:e_pesan_resto/models/cart_model.dart';
import 'package:e_pesan_resto/theme/font_theme.dart';
import 'package:flutter/material.dart';

class OrderDetailTile extends StatelessWidget {
  final CartModel cart;
  const OrderDetailTile({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                '$BASEURL${cart.productable?.photo}',
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
                    Text(
                      cart.productable?.productTypesId == 1
                          ? 'Makanan'
                          : 'Minuman',
                      style: bold14,
                    ),
                    Text(
                      cart.productable!.name,
                      style: bold14,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Qty : ${cart.quantity}',
                  style: regular14,
                ),
              ],
            ),
          ],
        ),
        Column(
          children: [
            Text(
              'Harga satuan',
              style: regular14,
            ),
            const SizedBox(height: 10,),
            Text(
              cart.productable!.price.toIDR(),
              style: bold14,
            )
          ],
        )
      ],
    );
  }
}
