import 'package:dio/dio.dart';

class RegisterStudentRequestModel {
  const RegisterStudentRequestModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.studentCode,
    required this.departmentId,
    required this.nationalId,
    required this.password,
    required this.confirmPassword,
    this.profileImage,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String studentCode;
  final String departmentId;
  final String nationalId;
  final String password;
  final String confirmPassword;
  final MultipartFile? profileImage;

  Map<String, dynamic> toMap() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Email': email,
      'StudentCode': studentCode,
      'DepartmentId': departmentId,
      'NationalId': nationalId,
      'Password': password,
      'ConfirmPassword': confirmPassword,
      if (profileImage != null) 'ProfileImage': profileImage,
    };
  }
}
