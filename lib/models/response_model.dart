class ResponseModel<T> {
  Meta meta;
  T data;

  ResponseModel({
    required this.meta,
    required this.data,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json,
      T Function(Map<String, dynamic>) fromDataJson) {
    return ResponseModel<T>(
      meta: Meta.fromJson(json['meta']),
      data: fromDataJson(json['data']),
    );
  }

  factory ResponseModel.fromJsonList(Map<String, dynamic> json,
      T Function(List<dynamic>) fromDataJson) {
    return ResponseModel<T>(
      meta: Meta.fromJson(json['meta']),
      data: fromDataJson(json['data']),
    );
  }


  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toDataJson) {
    return {
      'meta': meta.toJson(),
      'data': toDataJson(data),
    };
  }
}

class Meta {
  int code;
  String status;
  String message;

  Meta({
    required this.code,
    required this.status,
    required this.message,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        code: json['code'],
        status: json['status'],
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'status': status,
        'message': message,
      };
}
