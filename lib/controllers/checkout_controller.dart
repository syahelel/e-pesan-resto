import 'package:e_pesan_resto/presentation/homepage/state/admin_home_state.dart';
import 'package:get/instance_manager.dart';

import '../domain/api_service.dart';
import '../domain/api_service_impl.dart';
import '../global/global_state.dart';
import '../global_utility/functionality.dart';
import '../presentation/order/order_state.dart';
import 'session_controller.dart';

class CheckoutController {
  static final CheckoutController _instance = CheckoutController._internal();

  CheckoutController._internal();

  factory CheckoutController() {
    return _instance;
  }
  final ApiService apiService = ApiServiceImpl();
  final globalState = Get.put(GlobalState());
  final session = Get.put(SessionController());
  final orderState = Get.put(OrderState());
  final adminHomeState = Get.put(AdminHomeState());
  
  Future<void> getAllCheckout() async {
    var checkConnectivity = await checkInternetConnection();
    globalState.isLoading.value = true;

    if (checkConnectivity) {
      try {
        var token = session.session.value.token;
        var userId = session.session.value.id;
        var response = await apiService.allCheckout(token, userId);
        globalState.isLoading.value = false;
        orderState.dataOrder.value = response;
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

   Future<void> getAllCheckoutAdmin() async {
    var checkConnectivity = await checkInternetConnection();
    globalState.isLoading.value = true;

    if (checkConnectivity) {
      try {
        var token = session.session.value.token;
        var response = await apiService.allCheckoutForAdmin(token);
        globalState.isLoading.value = false;
        adminHomeState.dataOrder.value = response;
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
