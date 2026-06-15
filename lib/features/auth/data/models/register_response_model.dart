class RegisterResponseModel {
  const RegisterResponseModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.isVerified,
  });

  final String id;
  final String fullName;
  final String email;
  final bool isVerified;

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      id: json['id'] as String? ?? '',
      fullName: json['fullName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      isVerified: json['isVerified'] as bool? ?? false,
    );
  }
}
