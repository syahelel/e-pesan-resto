class ProductModel {
    ProductModel({
        required this.id,
        required this.codeProduct,
        required this.name,
        required this.description,
        required this.productTypesId,
        required this.price,
        required this.photo,
        required this.deletedAt,
        required this.createdAt,
        required this.updatedAt,
        required this.rate
    });

    final int id;
    final String codeProduct;
    final String name;
    final String description;
    final int productTypesId;
    final int price;
    final String photo;
    final dynamic deletedAt;
    final DateTime createdAt;
    final DateTime updatedAt;
    final double rate;

    factory ProductModel.fromJson(Map<String, dynamic> json){ 
        return ProductModel(
            id: json["id"],
            codeProduct: json["code_product"],
            name: json["name"],
            description: json["description"],
            productTypesId: json["product_types_id"],
            price: json["price"],
            photo: json["photo"],
            deletedAt: json["deleted_at"],
            createdAt: DateTime.tryParse(json["created_at"])!,
            updatedAt: DateTime.tryParse(json["updated_at"])!,
            rate: json['rate'] is int ? (json['rate'] as int).toDouble() : json['rate'],
        );
    }

    static List<ProductModel> fromJsonList(List<dynamic> jsonList) {
      return jsonList.map((json) => ProductModel.fromJson(json)).toList();
    }

}
