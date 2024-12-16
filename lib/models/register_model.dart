class ResponseRegisterModel {
  String message;
  RegisterModel data;

  ResponseRegisterModel({
    required this.message,
    required this.data,
  });

  factory ResponseRegisterModel.fromJson(Map<String, dynamic> json) =>
      ResponseRegisterModel(
        message: json['message'],
        data: RegisterModel.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'data': data.toJson(),
      };
}

class RegisterModel {
  int id;
  String name;
  String email;
  String phoneNumber;
  String role;
  DateTime createdAt;
  DateTime updatedAt;

  RegisterModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phoneNumber: json['phone_number'],
        role: json['role'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone_number': phoneNumber,
        'role': role,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };
}
