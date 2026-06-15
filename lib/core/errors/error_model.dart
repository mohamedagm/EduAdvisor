class ErrorModel {
  const ErrorModel({
    required this.isSuccess,
    required this.message,
    required this.statusCode,
    this.data,
  });

  final bool isSuccess;
  final String message;
  final int statusCode;
  final dynamic data;

  factory ErrorModel.fromJson(
    Map<String, dynamic> json, {
    int? fallbackStatusCode,
  }) {
    return ErrorModel(
      isSuccess: json['isSuccess'] as bool? ?? false,
      message: json['message'] as String? ?? 'Something went wrong',
      statusCode: json['statusCode'] as int? ?? fallbackStatusCode ?? 0,
      data: json['data'],
    );
  }

  factory ErrorModel.message(String message, {int statusCode = 0}) {
    return ErrorModel(
      isSuccess: false,
      message: message,
      statusCode: statusCode,
    );
  }
}
