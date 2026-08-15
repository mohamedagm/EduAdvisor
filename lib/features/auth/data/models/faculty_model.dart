class FacultyModel {
  final String id;
  final String nameEN;
  final String nameAR;
  final String abbreviation;
  final String descriptionEN;
  final String descriptionAR;
  final String? website;
  final String? email;
  final String? logoUrl;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? lastUpdatedAt;

  const FacultyModel({
    required this.id,
    required this.nameEN,
    required this.nameAR,
    required this.abbreviation,
    required this.descriptionEN,
    required this.descriptionAR,
    this.website,
    this.email,
    this.logoUrl,
    required this.isActive,
    required this.createdAt,
    this.lastUpdatedAt,
  });

  factory FacultyModel.fromJson(Map<String, dynamic> json) {
    return FacultyModel(
      id: json['id'] as String,
      nameEN: json['nameEN'] as String,
      nameAR: json['nameAR'] as String,
      abbreviation: json['abbreviation'] as String,
      descriptionEN: json['descriptionEN'] as String,
      descriptionAR: json['descriptionAR'] as String,
      website: json['website'] as String?,
      email: json['email'] as String?,
      logoUrl: json['logoUrl'] as String?,
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastUpdatedAt: json['lastUpdatedAt'] != null
          ? DateTime.parse(json['lastUpdatedAt'] as String)
          : null,
    );
  }
}
