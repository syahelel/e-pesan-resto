import 'package:e_pesan_resto/controllers/session_controller.dart';
import 'package:e_pesan_resto/domain/api_service.dart';
import 'package:e_pesan_resto/domain/api_service_impl.dart';
import 'package:e_pesan_resto/presentation/authentication/auth_state.dart';
import 'package:get/get.dart';

import '../global_utility/functionality.dart';

class AuthController {
  static final AuthController _instance = AuthController._internal();

  AuthController._internal();

  factory AuthController() {
    return _instance;
  }

  ApiService apiService = ApiServiceImpl();
  final authState = Get.put(AuthState());
  final session = Get.put(SessionController());

  Future<void> register() async {
    var checkConnectivity = await checkInternetConnection();
    authState.isLoading.value = true;

    if (checkConnectivity) {
      try {
        await apiService.register(
          authState.nameState.value,
          authState.emailState.value,
          authState.phoneNumberState.value,
          authState.roleState.value,
          authState.passwordState.value,
        );

        // Update on state
        authState.statusError.value = false;
        authState.isLoading.value = false;
        authState.statusSuccess.value = true;
      } catch (e) {
        authState.statusError.value = true;
        authState.isLoading.value = false;
        authState.errorMessage.value = e.toString();
      }
    } else {
      authState.isLoading.value = false;
      authState.statusError.value = true;
      authState.errorMessage.value = 'Tidak ada koneksi internet';
    }
  }

  Future<void> login() async {
    var checkConnectivity = await checkInternetConnection();
    authState.isLoading.value = true;

    if (checkConnectivity) {
      try {
        var response = await apiService.login(
          authState.emailState.value,
          authState.passwordState.value,
        );

        // Update on state
        authState.authModel.value = response.data.data;
        authState.statusError.value = false;
        authState.isLoading.value = false;
        authState.statusSuccess.value = true;

        session.setPreference(
          authState.authModel.value.id,
          authState.authModel.value.name,
          authState.authModel.value.email,
          response.data.token,
          authState.authModel.value.role.contains('admin') ? true : false
        );
        
      } catch (e) {
        authState.statusError.value = true;
        authState.isLoading.value = false;
        authState.errorMessage.value = e.reactive.toString();
      }
    } else {
      authState.isLoading.value = false;
      authState.statusError.value = true;
      authState.errorMessage.value = 'Tidak ada koneksi internet';
    }
  }
}
