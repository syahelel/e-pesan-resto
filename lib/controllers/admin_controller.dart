import 'package:e_pesan_resto/controllers/session_controller.dart';
import 'package:e_pesan_resto/domain/api_service.dart';
import 'package:e_pesan_resto/domain/api_service_impl.dart';
import 'package:e_pesan_resto/global/global_state.dart';
import 'package:e_pesan_resto/global_utility/functionality.dart';
import 'package:e_pesan_resto/presentation/homepage/state/admin_home_state.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AdminController {
  static final AdminController _instance = AdminController._internal();

  AdminController._internal();

  factory AdminController() {
    return _instance;
  }

  final ApiService apiService = ApiServiceImpl();
  final session = Get.put(SessionController());
  final adminState = Get.put(AdminHomeState());
  final globalState = Get.put(GlobalState());

  Future<void> addProduct() async {
    var checkConnectivity = await checkInternetConnection();
    globalState.isLoading.value = true;

    if (checkConnectivity) {
      try {
        var token = session.session.value.token;
        var response = await apiService.addProduct(
            token,
            adminState.name.value,
            adminState.description.value,
            adminState.productTypesId.value,
            adminState.price.value,
            adminState.file.value,
            adminState.rate.value);

        // Update on state
        adminState.productData = response.data;
        globalState.statusError.value = false;
        globalState.isLoading.value = false;
        globalState.statusSuccess.value = true;
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

  Future<void> updateStatusOrder(String status, int checkoutableId) async {
    var checkConnectivity = await checkInternetConnection();
    globalState.isLoading.value = true;

    if (checkConnectivity) {
      try {
        var token = session.session.value.token;
        await apiService.updateStatusOrder(token, status, checkoutableId);

        // Update on state
        globalState.statusError.value = false;
        globalState.isLoading.value = false;
        globalState.statusSuccess.value = true;
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

  Future<void> deleteProduct(int productId) async {
    var checkConnectivity = await checkInternetConnection();
    globalState.isLoading.value = true;
    if (checkConnectivity) {
      try {
        var token = session.session.value.token;
        print('id ${productId}');
        await apiService.deleteProduct(token, productId);
        // Update on state
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


  Future<void> updateProduct(int productId, int price) async {
    var checkConnectivity = await checkInternetConnection();
    globalState.isLoading.value = true;

    if (checkConnectivity) {
      try {
        var token = session.session.value.token;
        await apiService.updateProduct(token, productId, price);

        // Update on state
        globalState.statusError.value = false;
        globalState.isLoading.value = false;
        globalState.statusSuccess.value = true;
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
