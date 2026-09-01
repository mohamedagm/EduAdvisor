class RecommendedCourseModel {
  const RecommendedCourseModel({
    required this.code,
    required this.title,
    required this.progressPercentage,
    required this.credits,
  });

  final String code;
  final String title;
  final String progressPercentage;
  final int credits;
}

const List<RecommendedCourseModel> recommendedCourses = [
  RecommendedCourseModel(
    code: 'IS 311',
    title: 'Database Systems',
    progressPercentage: '75%',
    credits: 3,
  ),
  RecommendedCourseModel(
    code: 'CS 201',
    title: 'Data Structures',
    progressPercentage: '90%',
    credits: 4,
  ),
  RecommendedCourseModel(
    code: 'SE 305',
    title: 'Software Engineering',
    progressPercentage: '60%',
    credits: 3,
  ),
  RecommendedCourseModel(
    code: 'AI 402',
    title: 'Machine Learning',
    progressPercentage: '85%',
    credits: 3,
  ),
  RecommendedCourseModel(
    code: 'MATH 101',
    title: 'Calculus I',
    progressPercentage: '40%',
    credits: 3,
  ),
  RecommendedCourseModel(
    code: 'CS 315',
    title: 'Computer Networks',
    progressPercentage: '70%',
    credits: 3,
  ),
  RecommendedCourseModel(
    code: 'SE 310',
    title: 'Human Computer Interaction',
    progressPercentage: '55%',
    credits: 3,
  ),
];
