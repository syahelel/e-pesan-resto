import 'package:e_pesan_resto/models/cart_model.dart';
import 'package:e_pesan_resto/models/login_model.dart';
import 'package:e_pesan_resto/models/payment_token_model.dart';
import 'package:e_pesan_resto/models/product_model.dart';
import 'package:e_pesan_resto/models/register_model.dart';
import 'package:e_pesan_resto/models/response_model.dart';

import '../models/checkout_model.dart';

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

  Future<ResponseModel<CartResponse>> getCart(String token, int userId);

  Future<ResponseModel<CartModel>> insertToCart(
    String token,
    int userId,
    int quantity,
    int productId,
  );

  Future<ResponseModel> updateItemOnCart(
    String token,
    int userId,
    int quantity,
    int cartItemID,
  );

  Future<ResponseModel> deleteItemOnCart(String token, int cartItemId);

  Future<ResponseModel<PaymentTokenModel>> createPayment(
    String token,
    int cartId,
  );

   Future<ResponseModel<PaymentTokenModel>> createPaymentWithOrderId(
    String token,
    int cartId,
    String orderId,
  );

  Future<ResponseModel<List<CheckoutModel>>> allCheckout(String token, int userID);
}
