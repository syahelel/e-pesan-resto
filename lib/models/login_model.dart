class ResponseLoginModel {
    ResponseLoginModel({
        required this.tokenType,
        required this.token,
        required this.data,
    });

    final String tokenType;
    final String token;
    final LoginModel data;

    factory ResponseLoginModel.fromJson(Map<String, dynamic> json){ 
        return ResponseLoginModel(
            tokenType: json["token_type"],
            token: json["token"],
            data: LoginModel.fromJson(json["data"]),
        );
    }

}

class LoginModel {
    LoginModel({
        required this.id,
        required this.name,
        required this.email,
        required this.phoneNumber,
        required this.role,
        required this.createdAt,
        required this.updatedAt,
    });

    final int id;
    final String name;
    final String email;
    final String phoneNumber;
    final String role;
    final DateTime createdAt;
    final DateTime updatedAt;

    factory LoginModel.fromJson(Map<String, dynamic> json){ 
        return LoginModel(
            id: json["id"],
            name: json["name"],
            email: json["email"],
            phoneNumber: json["phone_number"],
            role: json["role"],
            createdAt: DateTime.tryParse(json["created_at"])!,
            updatedAt: DateTime.tryParse(json["updated_at"])!,
        );
    }

}