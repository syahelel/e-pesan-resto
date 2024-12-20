import 'package:e_pesan_resto/controllers/session_controller.dart';
import 'package:e_pesan_resto/domain/api_service.dart';
import 'package:e_pesan_resto/domain/api_service_impl.dart';
import 'package:e_pesan_resto/global/global_state.dart';
import 'package:e_pesan_resto/global_utility/functionality.dart';
import 'package:e_pesan_resto/presentation/cart/cart_state.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CartController {
  static final CartController _instance = CartController._internal();

  CartController._internal();

  factory CartController() {
    return _instance;
  }

  final ApiService apiService = ApiServiceImpl();
  final cartState = Get.put(CartState());
  final session = Get.put(SessionController());
  final globalState = Get.put(GlobalState());

  Future<void> getCart() async {
    var checkConnectivity = await checkInternetConnection();
    globalState.isLoading.value = true;

    if (checkConnectivity) {
      try {
        var token = session.session.value.token;
        var userId = session.session.value.id;
        var response = await apiService.getCart(token, userId);

        globalState.isLoading.value = false;
        cartState.data.value = response.data;
      } catch (e) {
        globalState.statusError.value = true;
        globalState.isLoading.value = false;
        globalState.errorMessage.value = e.toString();
      }
    } else {
      globalState.isLoading.value = false;
      globalState.statusError.value = true;
      globalState.errorMessage.value = 'Tidak ada koneksi internet';
    }
  }

  Future<void> addItemIntocart(int quantity, int productId) async {
    var checkConnectivity = await checkInternetConnection();
    globalState.isLoading.value = true;

    if (checkConnectivity) {
      try {
        var token = session.session.value.token;
        var userId = session.session.value.id;
        await apiService.insertToCart(token, userId, quantity, productId);
        globalState.isLoading.value = false;
      } catch (e) {
        globalState.statusError.value = true;
        globalState.isLoading.value = false;
        globalState.errorMessage.value = e.toString();
      }
    } else {
      globalState.isLoading.value = false;
      globalState.statusError.value = true;
      globalState.errorMessage.value = 'Tidak ada koneksi internet';
    }
  }

  Future<void> updateItemOnCart(int quantity, int cartItemId) async {
    var checkConnectivity = await checkInternetConnection();
    globalState.isLoading.value = true;

    if (checkConnectivity) {
      try {
        var token = session.session.value.token;
        var userId = session.session.value.id;
        await apiService.updateItemOnCart(token, userId, quantity, cartItemId);
        await getCart();
        globalState.isLoading.value = false;
      } catch (e) {
        globalState.statusError.value = true;
        globalState.isLoading.value = false;
        globalState.errorMessage.value = e.toString();
      }
    } else {
      globalState.isLoading.value = false;
      globalState.statusError.value = true;
      globalState.errorMessage.value = 'Tidak ada koneksi internet';
    }
  }

  Future<void> deleteItemOnCart(int cartItemId) async {
    var checkConnectivity = await checkInternetConnection();
    globalState.isLoading.value = true;

    if (checkConnectivity) {
      try {
        var token = session.session.value.token;
        await apiService.deleteItemOnCart(token, cartItemId);
        await getCart();
        globalState.isLoading.value = false;
      } catch (e) {
        globalState.statusError.value = true;
        globalState.isLoading.value = false;
        globalState.errorMessage.value = e.toString();
      }
    } else {
      globalState.isLoading.value = false;
      globalState.statusError.value = true;
      globalState.errorMessage.value = 'Tidak ada koneksi internet';
    }
  }
}
