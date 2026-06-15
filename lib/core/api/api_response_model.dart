class ApiResponseModel {
  const ApiResponseModel({
    required this.isSuccess,
    required this.message,
    required this.statusCode,
    this.data,
  });

  final bool isSuccess;
  final String message;
  final int statusCode;
  final dynamic data;

  factory ApiResponseModel.fromJson(
    Map<String, dynamic> json, {
    int? fallbackStatusCode,
  }) {
    return ApiResponseModel(
      isSuccess: json['isSuccess'] as bool? ?? false,
      message: json['message'] as String? ?? 'Something went wrong',
      statusCode: json['statusCode'] as int? ?? fallbackStatusCode ?? 0,
      data: json['data'],
    );
  }

  factory ApiResponseModel.message(String message, {int statusCode = 0}) {
    return ApiResponseModel(
      isSuccess: false,
      message: message,
      statusCode: statusCode,
    );
  }

  Map<String, List<String>> get validationErrors {
    if (data is! Map) {
      return {};
    }

    final dataMap = data as Map;
    return dataMap.map((key, value) {
      if (value is List) {
        return MapEntry(
          key.toString(),
          value.map((message) => message.toString()).toList(),
        );
      }

      return MapEntry(key.toString(), [value.toString()]);
    });
  }

  bool get hasValidationErrors => validationErrors.isNotEmpty;

  String get displayMessage {
    if (hasValidationErrors) {
      return validationErrors.values.first.first;
    }

    return message;
  }

  Map<String, dynamic> toJson() {
    return {
      'isSuccess': isSuccess,
      'message': message,
      'statusCode': statusCode,
      'data': data,
    };
  }
}
