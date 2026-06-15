class AuthUserModel {
  const AuthUserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.isVerified,
    required this.role,
  });

  final String id;
  final String fullName;
  final String email;
  final bool isVerified;
  final String role;

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      id: json['id'] as String? ?? '',
      fullName: json['fullName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      isVerified: json['isVerified'] as bool? ?? false,
      role: json['role'] as String? ?? '',
    );
  }
}
