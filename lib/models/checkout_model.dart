class CheckoutModel {
  CheckoutModel({
    required this.id,
    required this.accountId,
    required this.status,
    required this.totalPrice,
    required this.checkoutableId,
    required this.checkoutableType,
    required this.paymentPrice,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.orderId,
  });

  final int? id;
  final int? accountId;
  final String? status;
  final int? totalPrice;
  final int? checkoutableId;
  final String? checkoutableType;
  final int? paymentPrice;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? orderId;

  factory CheckoutModel.fromJson(Map<String, dynamic> json) {
    return CheckoutModel(
      id: json["id"],
      accountId: json["account_id"],
      status: json["status"],
      totalPrice: json["total_price"],
      checkoutableId: json["checkoutable_id"],
      checkoutableType: json["checkoutable_type"],
      paymentPrice: json["payment_price"],
      deletedAt: json["deleted_at"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      orderId: json["order_id"],
    );
  }

  static List<CheckoutModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CheckoutModel.fromJson(json)).toList();
  }
}
