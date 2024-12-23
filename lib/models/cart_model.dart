import 'package:e_pesan_resto/models/login_model.dart';
import 'package:e_pesan_resto/models/product_model.dart';

class CartResponse {
    CartResponse({
        required this.id,
        required this.userId,
        required this.deletedAt,
        required this.createdAt,
        required this.updatedAt,
        required this.items,
        required this.account
    });

    final int? id;
    final int? userId;
    final dynamic deletedAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final List<CartModel> items;
    final LoginModel? account;

    factory CartResponse.fromJson(Map<String, dynamic> json){ 
        return CartResponse(
            id: json["id"],
            userId: json["user_id"],
            deletedAt: json["deleted_at"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            items: json["items"] == null ? [] : List<CartModel>.from(json["items"]!.map((x) => CartModel.fromJson(x))),
            account: json["account"] == null ? null : LoginModel.fromJson(json["account"])
        );
    }

}

class CartModel {
    CartModel({
        required this.id,
        required this.cartId,
        required this.productableId,
        required this.productableType,
        required this.quantity,
        required this.price,
        required this.deletedAt,
        required this.createdAt,
        required this.updatedAt,
           required this.productable,

    });

    final int? id;
    final int? cartId;
    final int? productableId;
    final String? productableType;
    final int? quantity;
    final int? price;
    final dynamic deletedAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final ProductModel? productable;

    factory CartModel.fromJson(Map<String, dynamic> json){ 
        return CartModel(
            id: json["id"],
            cartId: json["cart_id"],
            productableId: json["productable_id"],
            productableType: json["productable_type"],
            quantity: json["quantity"],
            price: json["price"],
            deletedAt: json["deleted_at"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            productable: json["productable"] == null ? null : ProductModel.fromJson(json["productable"])
        );
    }

}
