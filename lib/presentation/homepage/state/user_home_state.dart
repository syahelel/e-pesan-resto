import 'package:e_pesan_resto/models/product_model.dart';
import 'package:get/get.dart';

class UserHomeState extends GetxController {
  var menuItem = 1.obs;
  var status = ''.obs;
  var categoryItem = 1.obs;
  var fullProduct = <ProductModel>[].obs;

  var displayedProduct= <ProductModel>[].obs;

  var isLoading = false.obs;
  var statusError = false.obs;
  var statusSuccess = false.obs;
  var errorMessage = ''.obs;

  void changeMenuItem(int id) {
    menuItem.value = id;
  }

  void initialProduct() => displayedProduct = fullProduct;

  void changeCategoryItem(int id) => categoryItem.value = id;
}
