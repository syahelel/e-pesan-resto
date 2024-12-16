import 'package:e_pesan_resto/models/product_model.dart';

class ResponseModelList {
    ResponseModelList({
        required this.meta,
        required this.data,
    });

    final Meta? meta;
    final List<ProductModel> data;

    factory ResponseModelList.fromJson(Map<String, dynamic> json){ 
        return ResponseModelList(
            meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
            data: json["data"] == null ? [] : List<ProductModel>.from(json["data"]!.map((x) => ProductModel.fromJson(x))),
        );
    }

}

class Meta {
    Meta({
        required this.code,
        required this.status,
        required this.message,
    });

    final int? code;
    final String? status;
    final String? message;

    factory Meta.fromJson(Map<String, dynamic> json){ 
        return Meta(
            code: json["code"],
            status: json["status"],
            message: json["message"],
        );
    }

}
