import 'package:dio/dio.dart';

class RegisterStudentRequestModel {
  const RegisterStudentRequestModel({
    required this.fullNameAR,
    required this.fullNameEN,
    required this.email,
    required this.facultyId,
    required this.studentCode,
    required this.departmentId,
    required this.nationalId,
    required this.password,
    required this.confirmPassword,
    this.profileImage,
  });

  final String fullNameAR;
  final String fullNameEN;
  final String email;
  final String facultyId;
  final String studentCode;
  final String departmentId;
  final String nationalId;
  final String password;
  final String confirmPassword;
  final MultipartFile? profileImage;

  Map<String, dynamic> toMap() {
    return {
      'FullNameAR': fullNameAR,
      'FullNameEN': fullNameEN,
      'Email': email,
      'FacultyId': facultyId,
      'StudentCode': studentCode,
      'DepartmentId': departmentId,
      'NationalId': nationalId,
      'Password': password,
      'ConfirmPassword': confirmPassword,
      if (profileImage != null) 'ProfileImage': profileImage,
    };
  }
}
