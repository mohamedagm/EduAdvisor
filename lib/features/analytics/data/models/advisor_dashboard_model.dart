class AdvisorDashboardModel {
  const AdvisorDashboardModel({
    required this.totalStudents,
    required this.pendingRegistrationRequests,
    required this.gpaDistribution,
  });

  final int totalStudents;
  final int pendingRegistrationRequests;
  final GpaDistributionModel gpaDistribution;

  factory AdvisorDashboardModel.fromJson(Map<String, dynamic> json) {
    return AdvisorDashboardModel(
      totalStudents: json['totalStudents'] as int? ?? 0,
      pendingRegistrationRequests:
          json['pendingRegistrationRequests'] as int? ?? 0,
      gpaDistribution: GpaDistributionModel.fromJson(
        Map<String, dynamic>.from(json['gpaDistribution'] as Map? ?? {}),
      ),
    );
  }
}

class GpaDistributionModel {
  const GpaDistributionModel({
    required this.highGpaCount,
    required this.highGpaPercentage,
    required this.midGpaCount,
    required this.midGpaPercentage,
    required this.lowGpaCount,
    required this.lowGpaPercentage,
  });

  final int highGpaCount;
  final num highGpaPercentage;
  final int midGpaCount;
  final num midGpaPercentage;
  final int lowGpaCount;
  final num lowGpaPercentage;

  factory GpaDistributionModel.fromJson(Map<String, dynamic> json) {
    return GpaDistributionModel(
      highGpaCount: json['highGpaCount'] as int? ?? 0,
      highGpaPercentage: json['highGpaPercentage'] as num? ?? 0,
      midGpaCount: json['midGpaCount'] as int? ?? 0,
      midGpaPercentage: json['midGpaPercentage'] as num? ?? 0,
      lowGpaCount: json['lowGpaCount'] as int? ?? 0,
      lowGpaPercentage: json['lowGpaPercentage'] as num? ?? 0,
    );
  }
}
