import 'package:e_pesan_resto/models/login_model.dart';
import 'package:get/get.dart';

class AuthState extends GetxController {
  var nameState = ''.obs;
  var emailState = ''.obs;
  var phoneNumberState = ''.obs;
  var roleState = 'user'.obs;
  var passwordState = ''.obs;
  var authModel  = 
    LoginModel(
      id: 0,
      name: '',
      email: '',
      phoneNumber: '',
      role: '',
      createdAt: DateTime(0),
      updatedAt: DateTime(0),
    ).obs;

  var isLoading = false.obs;
  var statusError = false.obs;
  var statusSuccess = false.obs;
  var errorMessage = ''.obs;

}
