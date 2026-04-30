class StudentRequest {
  final String id;
  final String studentName;
  final String semester;
  final String major;
  String status;
  final DateTime submittedAt;

  StudentRequest({
    required this.id,
    required this.studentName,
    required this.semester,
    required this.major,
    required this.status,
    required this.submittedAt,
  });

  factory StudentRequest.fromJson(Map<String, dynamic> json) {
    return StudentRequest(
      id: json['id'],
      studentName: json['student_name'],
      semester: json['semester'],
      major: json['major'],
      status: json['status'],
      submittedAt: DateTime.parse(json['submitted_at']),
    );
  }
}

////////////////////////

final List<StudentRequest> dummyRequests = [
  StudentRequest(
    id: '1',
    studentName: 'Aliaa Mohamed',
    semester: 'Semester 4',
    major: 'Information System',
    status: 'Pending',
    submittedAt: DateTime.now(),
  ),
  StudentRequest(
    id: '2',
    studentName: 'Ahmed Hassan',
    semester: 'Semester 3',
    major: 'Computer Science',
    status: 'Approved',
    submittedAt: DateTime.now(),
  ),
  StudentRequest(
    id: '3',
    studentName: 'Nour Ibrahim',
    semester: 'Semester 5',
    major: 'Software Engineering',
    status: 'Rejected',
    submittedAt: DateTime.now(),
  ),

   StudentRequest(
    id: '4',
    studentName: 'Aliaa Mohamed',
    semester: 'Semester 4',
    major: 'Information System',
    status: 'Pending',
    submittedAt: DateTime.now(),
  ),
   StudentRequest(
    id: '5',
    studentName: 'Aliaa Mohamed',
    semester: 'Semester 4',
    major: 'Information System',
    status: 'Pending',
    submittedAt: DateTime.now(),
  ),
   StudentRequest(
    id: '6',
    studentName: 'Aliaa Mohamed',
    semester: 'Semester 4',
    major: 'Information System',
    status: 'Pending',
    submittedAt: DateTime.now(),
  ),
   StudentRequest(
    id: '7',
    studentName: 'Aliaa Mohamed',
    semester: 'Semester 4',
    major: 'Information System',
    status: 'Pending',
    submittedAt: DateTime.now(),
  ),
];