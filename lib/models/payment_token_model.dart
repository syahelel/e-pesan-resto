class PaymentTokenModel {
    PaymentTokenModel({
        required this.snapToken,
        required this.redirectPayment,
    });

    final String? snapToken;
    final String? redirectPayment;

    factory PaymentTokenModel.fromJson(Map<String, dynamic> json){ 
        return PaymentTokenModel(
            snapToken: json["snap_token"],
            redirectPayment: json["redirect_payment"],
        );
    }

}
