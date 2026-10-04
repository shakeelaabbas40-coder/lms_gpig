class UserModel {
  final String id;
  final String name;
  final String email;
  final String role; // 'Student' or 'Instructor'
  final String studentId;
  final String department;
  final String semester;
  final String phone;
  final String avatarUrl;
  final double gpa;
  final int enrolledCourses;
  final int completedCourses;
  final int totalCredits;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.role = 'Student',
    this.studentId = 'LMS-2024-892',
    this.department = 'Computer Science & Software Engineering',
    this.semester = '6th Semester',
    this.phone = '+92 300 1234567',
    this.avatarUrl = '',
    this.gpa = 3.82,
    this.enrolledCourses = 5,
    this.completedCourses = 12,
    this.totalCredits = 78,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? role,
    String? studentId,
    String? department,
    String? semester,
    String? phone,
    String? avatarUrl,
    double? gpa,
    int? enrolledCourses,
    int? completedCourses,
    int? totalCredits,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      studentId: studentId ?? this.studentId,
      department: department ?? this.department,
      semester: semester ?? this.semester,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      gpa: gpa ?? this.gpa,
      enrolledCourses: enrolledCourses ?? this.enrolledCourses,
      completedCourses: completedCourses ?? this.completedCourses,
      totalCredits: totalCredits ?? this.totalCredits,
    );
  }
}