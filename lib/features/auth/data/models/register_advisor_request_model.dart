import 'package:dio/dio.dart';

class RegisterAdvisorRequestModel {
  const RegisterAdvisorRequestModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.departmentId,
    required this.nationalId,
    required this.phone,
    required this.password,
    required this.confirmPassword,
    this.profileImage,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String departmentId;
  final String nationalId;
  final String phone;
  final String password;
  final String confirmPassword;
  final MultipartFile? profileImage;

  Map<String, dynamic> toMap() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Email': email,
      'DepartmentId': departmentId,
      'NationalId': nationalId,
      'Phone': phone,
      'Password': password,
      'ConfirmPassword': confirmPassword,
      if (profileImage != null) 'ProfileImage': profileImage,
    };
  }
}
