import 'package:e_pesan_resto/models/checkout_model.dart';
import 'package:e_pesan_resto/models/response_model.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class OrderState extends GetxController {
  var paymentUrl = ''.obs;
  var snapToken = ''.obs;
  var statusSuccess = false.obs;
  var statusError = false.obs;
  var statusUnfinish = false.obs;
  var dataOrder = ResponseModel(
    meta: Meta(code: 0, status: 'unknown', message: 'unkown'),
    data: <CheckoutModel>[],
  ).obs;
}
