
import 'package:e_pesan_resto/models/login_model.dart';
import 'package:e_pesan_resto/models/product_model.dart';
import 'package:e_pesan_resto/models/register_model.dart';
import 'package:e_pesan_resto/models/response_model.dart';

abstract class ApiService {

  Future<ResponseModel<ResponseRegisterModel>> register(
    String name,
    String email,
    String phoneNumber,
    String role,
    String password,
  );

  Future<ResponseModel<ResponseLoginModel>> login(
    String email,
    String password,
  );

  Future<ResponseModel<List<ProductModel>>> getAllProduct(String token);
}