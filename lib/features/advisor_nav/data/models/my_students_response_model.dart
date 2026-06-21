class MyStudentModel {
  final String id;
  final String name;
  final String email;
  final String imageUrl;
  final double gpa;
  final int semester;

  MyStudentModel({
    required this.id,
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.gpa,
    required this.semester,
  });

  factory MyStudentModel.fromJson(Map<String, dynamic> json) {
    final rawEmail = json['email'] ?? '';
    final rawImageUrl = json['imageUrl'] ?? '';

    final looksLikeUrl = rawEmail.toString().startsWith('http');

    final correctedEmail = looksLikeUrl ? rawImageUrl : rawEmail;
    final correctedImageUrl = looksLikeUrl ? rawEmail : rawImageUrl;

    return MyStudentModel(
      id: json['id'] ?? '',
      name: json['name'] ?? json['fullName'] ?? '',
      email: correctedEmail.toString(),
      imageUrl: correctedImageUrl.toString(),
      gpa: (json['gpa'] ?? json['gpaScore'] ?? 0.0).toDouble(),
      semester: json['semester'] ?? json['level'] ?? json['academicYear'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
      'gpa': gpa,
      'semester': semester,
    };
  }
}
