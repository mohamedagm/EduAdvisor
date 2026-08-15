import 'package:dio/dio.dart';

class RegisterAdvisorRequestModel {
  const RegisterAdvisorRequestModel({
    required this.fullNameAR,
    required this.fullNameEN,
    required this.email,
    required this.facultyId,
    required this.departmentId,
    required this.nationalId,
    required this.phone,
    required this.password,
    required this.confirmPassword,
    this.profileImage,
  });

  final String fullNameAR;
  final String fullNameEN;
  final String email;
  final String facultyId;
  final String departmentId;
  final String nationalId;
  final String phone;
  final String password;
  final String confirmPassword;
  final MultipartFile? profileImage;

  Map<String, dynamic> toMap() {
    return {
      'FullNameAR': fullNameAR,
      'FullNameEN': fullNameEN,
      'Email': email,
      'FacultyId': facultyId,
      'DepartmentId': departmentId,
      'NationalId': nationalId,
      'Phone': phone,
      'Password': password,
      'ConfirmPassword': confirmPassword,
      if (profileImage != null) 'ProfileImage': profileImage,
    };
  }
}
