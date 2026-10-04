class ResultModel {
  final String courseCode;
  final String courseTitle;
  final int creditHours;
  final int totalMarks;
  final int obtainedMarks;
  final String grade;
  final double gradePoint;
  final String remarks;

  ResultModel({
    required this.courseCode,
    required this.courseTitle,
    required this.creditHours,
    required this.totalMarks,
    required this.obtainedMarks,
    required this.grade,
    required this.gradePoint,
    required this.remarks,
  });

  double get percentage => (obtainedMarks / totalMarks) * 100;
}
