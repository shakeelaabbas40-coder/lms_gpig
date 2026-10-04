import '../models/user_model.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  UserModel? _currentUser = UserModel(
    id: 'usr_001',
    name: 'Sarah Khan',
    email: 'sarah.khan@university.edu',
    role: 'Student',
    studentId: 'LMS-2024-892',
    department: 'Department of Computer Science',
    semester: '6th Semester',
    phone: '+92 300 1234567',
    gpa: 3.82,
    enrolledCourses: 4,
    completedCourses: 12,
    totalCredits: 78,
  );

  UserModel? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  Future<bool> login(String email, String password, {String role = 'Student'}) async {
    await Future.delayed(const Duration(milliseconds: 600));
    _currentUser = UserModel(
      id: 'usr_001',
      name: email.contains('@') ? email.split('@')[0].toUpperCase() : 'Sarah Khan',
      email: email.isNotEmpty ? email : 'sarah.khan@university.edu',
      role: role,
      studentId: role == 'Student' ? 'LMS-2024-892' : 'FAC-2021-043',
      department: 'Department of Computer Science',
      semester: role == 'Student' ? '6th Semester' : 'Faculty Member',
      phone: '+92 300 1234567',
      gpa: 3.82,
    );
    return true;
  }

  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String role,
    required String studentId,
    required String department,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));
    _currentUser = UserModel(
      id: 'usr_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      email: email,
      role: role,
      studentId: studentId.isNotEmpty ? studentId : 'LMS-NEW-001',
      department: department.isNotEmpty ? department : 'Computer Science',
      semester: '1st Semester',
      gpa: 4.0,
      enrolledCourses: 0,
      completedCourses: 0,
      totalCredits: 0,
    );
    return true;
  }

  void updateProfile({
    String? name,
    String? phone,
    String? department,
    String? semester,
  }) {
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(
        name: name,
        phone: phone,
        department: department,
        semester: semester,
      );
    }
  }

  void logout() {
    _currentUser = null;
  }
}