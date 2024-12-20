import 'package:get/get.dart';

class GlobalState extends GetxController {
  var isLoading = false.obs;
  var statusError = false.obs;
  var statusSuccess = false.obs;
  var errorMessage = ''.obs;
}
