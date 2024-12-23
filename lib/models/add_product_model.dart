class AddProductResponse {
    AddProductResponse({
        required this.name,
        required this.description,
        required this.productTypesId,
        required this.price,
        required this.rate,
    });

    final String? name;
    final String? description;
    final String? productTypesId;
    final String? price;
    final String? rate;

    factory AddProductResponse.fromJson(Map<String, dynamic> json){ 
        return AddProductResponse(
            name: json["name"],
            description: json["description"],
            productTypesId: json["product_types_id"],
            price: json["price"],
            rate: json["rate"],
        );
    }

}
