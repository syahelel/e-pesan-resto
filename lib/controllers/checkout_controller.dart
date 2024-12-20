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
  
  Future<void> getAllCheckout() async {
    var checkConnectivity = await checkInternetConnection();
    globalState.isLoading.value = true;

    if (checkConnectivity) {
      try {

        print('berhasil connect');
        var token = session.session.value.token;
        var userId = session.session.value.id;
        var response = await apiService.allCheckout(token, userId);
        print('lewat services');
        globalState.isLoading.value = false;
        orderState.dataOrder.value = response;
        print('masuk ke response: ${response.data}');
      } catch (e) {
        print('exception: ${e.toString()}');
        globalState.statusError.value = true;
        globalState.isLoading.value = false;
        globalState.errorMessage.value = e.toString();
      }
    } else {
      print('gagal koneski');
      globalState.isLoading.value = false;
      globalState.statusError.value = true;
      globalState.errorMessage.value = 'Tidak ada koneksi internet';
    }
  }
}
