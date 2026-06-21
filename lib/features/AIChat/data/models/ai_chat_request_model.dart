class AiChatRequestModel {
  const AiChatRequestModel({
    required this.studentId,
    required this.studentContext,
    required this.question,
  });

  final String studentId;
  final String studentContext;
  final String question;

  Map<String, dynamic> toJson() {
    return {
      'student_id': studentId,
      'student_context': studentContext,
      'question': question,
    };
  }
}
