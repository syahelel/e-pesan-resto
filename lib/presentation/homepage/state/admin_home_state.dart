import 'dart:io';

import 'package:e_pesan_resto/models/add_product_model.dart';
import 'package:e_pesan_resto/models/checkout_model.dart';
import 'package:e_pesan_resto/models/product_model.dart';
import 'package:e_pesan_resto/models/response_model.dart';
import 'package:get/get.dart';

class AdminHomeState extends GetxController {
  var name = ''.obs;
  var description = ''.obs;
  var productTypesId = 0.obs;
  var price = 0.obs;
  var photo = ''.obs;
  var rate = 0.0.obs;
  var file = File('').obs;
  var productData = AddProductResponse(
    name: '',
    description: '',
    productTypesId: '',
    price: '',
    rate: '',
  );
  var isSuccess = false.obs;

  void changeSelectedProduct(ProductModel product) {
    name.value = product.name;
    description.value = product.description;
    productTypesId.value = product.productTypesId;
    price.value = product.price;
    photo.value = product.photo;
    rate.value = product.rate;
  }

  var dataOrder = ResponseModel(
    meta: Meta(code: 0, status: 'unknown', message: 'unkown'),
    data: <CheckoutModel>[],
  ).obs;
}
