import 'package:e_pesan_resto/domain/api_service.dart';
import 'package:e_pesan_resto/domain/api_service_impl.dart';
import 'package:e_pesan_resto/global/global_state.dart';
import 'package:e_pesan_resto/global_utility/functionality.dart';
import 'package:e_pesan_resto/presentation/homepage/state/user_home_state.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HomeController {
  static final HomeController _instance = HomeController._internal();

  HomeController._internal();

  factory HomeController() {
    return _instance;
  }

  final UserHomeState userHomeState = Get.put(UserHomeState());
  final GlobalState globalState = Get.put(GlobalState());
  ApiService apiService = ApiServiceImpl();

  Future<void> getAllProduct(String token) async {
    var checkConnectivity = await checkInternetConnection();
    globalState.isLoading.value = true;

    if (checkConnectivity) {
      try {
        var result = await apiService.getAllProduct(token);

        // Update on state
        userHomeState.fullProduct.value = result.data;
        userHomeState.displayedProductAdmin.value = result.data;
        userHomeState.displayedProduct.value = result.data.where((value) => value.productTypesId == 1).toList();
        globalState.statusError.value = false;
        globalState.isLoading.value = false;
      } catch (e) {
        globalState.statusError.value = true;
        globalState.isLoading.value = true;
        globalState.errorMessage.value = e.toString();
      }
    } else {
      globalState.isLoading.value = true;
      globalState.statusError.value = true;
      globalState.errorMessage.value = 'Tidak ada koneksi internet';
    }
  }

}