import 'package:e_pesan_resto/controllers/session_controller.dart';
import 'package:e_pesan_resto/domain/api_service.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

import '../domain/api_service_impl.dart';
import '../global/global_state.dart';
import '../global_utility/functionality.dart';
import '../presentation/order/order_state.dart';

class PaymentController {
  static final PaymentController _instance = PaymentController._internal();

  PaymentController._internal();

  factory PaymentController() {
    return _instance;
  }

  final ApiService apiService = ApiServiceImpl();
  final globalState = Get.put(GlobalState());
  final session = Get.put(SessionController());
  final orderState = Get.put(OrderState());

  Future<void> createPayment(int cartId) async {
    var checkConnectivity = await checkInternetConnection();
    globalState.isLoading.value = true;

    if (checkConnectivity) {
      try {
        var token = session.session.value.token;
        var response = await apiService.createPayment(token, cartId);

        globalState.isLoading.value = false;
        var data = response.data;
        orderState.paymentUrl.value = data.redirectPayment!;
        orderState.snapToken.value = data.snapToken!;
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

   Future<void> createPaymentWithOrderId(int cartId, String orderId) async {
    var checkConnectivity = await checkInternetConnection();
    globalState.isLoading.value = true;

    if (checkConnectivity) {
      try {
        var token = session.session.value.token;
        var response = await apiService.createPaymentWithOrderId(token, cartId, orderId);
        globalState.isLoading.value = false;
        var data = response.data;
        orderState.paymentUrl.value = data.redirectPayment!;
        orderState.snapToken.value = data.snapToken!;
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
