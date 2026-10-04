class AssignmentModel {
  final String id;
  final String title;
  final String courseTitle;
  final String courseCode;
  final String dueDate;
  final int totalPoints;
  final int? obtainedPoints;
  final String status; // 'pending', 'submitted', 'graded'
  final String description;
  final String instructions;
  final String? submissionDate;
  final String? submissionNote;
  final String? teacherFeedback;

  AssignmentModel({
    required this.id,
    required this.title,
    required this.courseTitle,
    required this.courseCode,
    required this.dueDate,
    required this.totalPoints,
    this.obtainedPoints,
    this.status = 'pending',
    required this.description,
    required this.instructions,
    this.submissionDate,
    this.submissionNote,
    this.teacherFeedback,
  });

  AssignmentModel copyWith({
    String? status,
    int? obtainedPoints,
    String? submissionDate,
    String? submissionNote,
    String? teacherFeedback,
  }) {
    return AssignmentModel(
      id: id,
      title: title,
      courseTitle: courseTitle,
      courseCode: courseCode,
      dueDate: dueDate,
      totalPoints: totalPoints,
      obtainedPoints: obtainedPoints ?? this.obtainedPoints,
      status: status ?? this.status,
      description: description,
      instructions: instructions,
      submissionDate: submissionDate ?? this.submissionDate,
      submissionNote: submissionNote ?? this.submissionNote,
      teacherFeedback: teacherFeedback ?? this.teacherFeedback,
    );
  }
}