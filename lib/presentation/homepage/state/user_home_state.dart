import 'package:e_pesan_resto/models/product_model.dart';
import 'package:get/get.dart';

class UserHomeState extends GetxController {
  var menuItem = 1.obs;
  var status = ''.obs;
  var categoryItem = 1.obs;
  var fullProduct = <ProductModel>[].obs;
  var displayedProduct = <ProductModel>[].obs;
  var isLoading = false.obs;
  var statusError = false.obs;
  var statusSuccess = false.obs;
  var errorMessage = ''.obs;

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

  void changeCategoryItem(int id) => categoryItem.value = id;
}
