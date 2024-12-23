import 'package:e_pesan_resto/models/product_model.dart';
import 'package:get/get.dart';

class UserHomeState extends GetxController {
  var menuItem = 1.obs;
  var status = ''.obs;
  var categoryItem = 1.obs;
  var fullProduct = <ProductModel>[].obs;
  var displayedProduct = <ProductModel>[].obs;
  var displayedProductAdmin = <ProductModel>[].obs;

  var selectedItem = 0.obs;

  void changeMenuItem(int id) {
    menuItem.value = id;
  }

  void initialProduct() => displayedProduct == fullProduct;

  void onCategoryChanged() {
    var filteredProduct = fullProduct
        .where((value) => value.productTypesId == categoryItem.value)
        .toList();
    displayedProduct.value = filteredProduct;
  }

  void onMenuSearch(String query) {
    displayedProduct.value = fullProduct
        .where(
          (value) =>
              value.productTypesId == categoryItem.value &&
              value.name.toLowerCase().contains(
                    query.toLowerCase(),
                  ),
        )
        .toList();
  }

  void onMenuSearchAdmin(String q) {
    displayedProductAdmin.value = fullProduct
        .where(
          (value) => value.name.toLowerCase().contains(
                q.toLowerCase(),
              ),
        )
        .toList();
  }

  void changeCategoryItem(int id) => categoryItem.value = id;
}
