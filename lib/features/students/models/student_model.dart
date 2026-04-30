
class Student {
  final String id;
  final String fullName;
  final String email;
  final double gpa;
  final int semester;

  const Student({
    required this.id,
    required this.fullName,
    required this.email,
    required this.gpa,
    required this.semester,
  });

  String get initials {
    final parts = fullName.trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}';
    return parts[0][0];
  }
}

// ─────────────────────────────────────────────
// DUMMY DATA
// ─────────────────────────────────────────────

final List<Student> allStudents = [
  const Student(id:'1', fullName:'Aliaa Mohamed',   email:'am9177@fayoum.edu.eg',  gpa:3.4, semester:4),
  const Student(id:'2', fullName:'Omar Khaled',     email:'ok1234@fayoum.edu.eg',  gpa:3.8, semester:2),
  const Student(id:'3', fullName:'Sara Ahmed',      email:'sa5678@fayoum.edu.eg',  gpa:2.9, semester:6),
  const Student(id:'4', fullName:'Mohamed Hassan',  email:'mh9999@fayoum.edu.eg',  gpa:3.1, semester:3),
  const Student(id:'5', fullName:'Nada Youssef',    email:'ny4321@fayoum.edu.eg',  gpa:3.6, semester:5),
  const Student(id:'6', fullName:'Ahmed Tarek',     email:'at7777@fayoum.edu.eg',  gpa:2.7, semester:1),
];
