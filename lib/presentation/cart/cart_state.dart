import 'package:e_pesan_resto/models/cart_model.dart';
import 'package:get/get.dart';

class CartState extends GetxController {
  var data = CartResponse(
          id: 0,
          items: List.empty(),
          createdAt: DateTime(0),
          updatedAt: DateTime(0),
          deletedAt: DateTime(0),
          userId: 0)
      .obs;
}
