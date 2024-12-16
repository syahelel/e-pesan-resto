import 'dart:convert';

import 'package:e_pesan_resto/domain/api_service.dart';
import 'package:e_pesan_resto/global_utility/constant.dart';
import 'package:e_pesan_resto/models/login_model.dart';
import 'package:e_pesan_resto/models/product_model.dart';
import 'package:e_pesan_resto/models/register_model.dart';
import 'package:e_pesan_resto/models/response_model.dart';
import 'package:http/http.dart' as http;

class ApiServiceImpl implements ApiService {

  static final ApiServiceImpl _instance = ApiServiceImpl._internal();

  ApiServiceImpl._internal();

  factory ApiServiceImpl() {
    return _instance;
  }

  @override
  Future<ResponseModel<ResponseRegisterModel>> register(
    String name,
    String email,
    String phoneNumber,
    String role,
    String password,
  ) async {
    final uri = Uri.parse('$BASEURL/api/register');
    final response = await http.post(uri,
      body: {
        'name': name,
        'email': email,
        'phone_number': phoneNumber,
        'role': role,
        'password': password
      } 
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return ResponseModel<ResponseRegisterModel>.fromJson(
        body,
        (result) => ResponseRegisterModel.fromJson(result)
      );
    } else if (response.statusCode == 300) {
      throw Exception('Input tidak sesuai | mohon periksa kembali');
    } else {
      throw Exception('Terjadi kesalahan pada server | harap mencoba kembali secara berkala: ${response.statusCode}');
    }
  }

  @override
  Future<ResponseModel<ResponseLoginModel>> login(String email, String password) async {
    final uri = Uri.parse('$BASEURL/api/login');
    final response = await http.post(uri,
      body: {
        'email': email,
        'password': password
      } 
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return ResponseModel<ResponseLoginModel>.fromJson(
        body,
        (result) => ResponseLoginModel.fromJson(result)
      );
    } else if (response.statusCode == 300) {
      throw Exception('Input tidak sesuai | mohon periksa kembali');
    } else {
      throw Exception('Terjadi kesalahan pada server | harap mencoba kembali secara berkala: ${response.statusCode}');
    }
  }

  @override
  Future<ResponseModel<List<ProductModel>>> getAllProduct(String token) async {
    final uri = Uri.parse('$BASEURL/api/product');
    final response = await http.get(uri, headers: {'Authorization': 'Bearer $token'});

     if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      // return ResponseModelList.fromJson(body);
      return ResponseModel.fromJsonList(body, (result) => ProductModel.fromJsonList(result));
    } else if (response.statusCode == 300) {
      throw Exception('Input tidak sesuai | mohon periksa kembali');
    } else {
      throw Exception('Terjadi kesalahan pada server | harap mencoba kembali secara berkala: ${response.statusCode}');
    }
  }
}
