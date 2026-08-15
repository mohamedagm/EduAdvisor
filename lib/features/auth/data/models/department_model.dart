class DepartmentModel {
  final String id;
  final String nameEN;
  final String nameAR;
  final String code;
  final String descriptionEN;
  final String descriptionAR;
  final bool isActive;
  final String facultyId;
  final DateTime createdAt;
  final DateTime? lastUpdatedAt;

  const DepartmentModel({
    required this.id,
    required this.nameEN,
    required this.nameAR,
    required this.code,
    required this.descriptionEN,
    required this.descriptionAR,
    required this.isActive,
    required this.facultyId,
    required this.createdAt,
    this.lastUpdatedAt,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      id: json['id'] as String,
      nameEN: json['nameEN'] as String,
      nameAR: json['nameAR'] as String,
      code: json['code'] as String,
      descriptionEN: json['descriptionEN'] as String,
      descriptionAR: json['descriptionAR'] as String,
      isActive: json['isActive'] as bool,
      facultyId: json['facultyId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastUpdatedAt: json['lastUpdatedAt'] != null
          ? DateTime.parse(json['lastUpdatedAt'] as String)
          : null,
    );
  }
}
