class LessonModel {
  final String id;
  final String title;
  final String duration;
  final bool isCompleted;
  final bool isLocked;
  final String type; // 'video', 'reading', 'assignment'

  LessonModel({
    required this.id,
    required this.title,
    required this.duration,
    this.isCompleted = false,
    this.isLocked = false,
    this.type = 'video',
  });
}

class CourseModel {
  final String id;
  final String code;
  final String title;
  final String instructor;
  final String instructorAvatar;
  final String category;
  final double rating;
  final int totalReviews;
  final int studentsEnrolled;
  final String duration;
  final int totalLessons;
  final double progress; // 0.0 to 1.0
  final bool isEnrolled;
  final String description;
  final List<String> learningOutcomes;
  final List<LessonModel> lessons;
  final int colorHex;

  CourseModel({
    required this.id,
    required this.code,
    required this.title,
    required this.instructor,
    this.instructorAvatar = '',
    required this.category,
    this.rating = 4.8,
    this.totalReviews = 1420,
    this.studentsEnrolled = 3540,
    this.duration = '12 Hours',
    this.totalLessons = 24,
    this.progress = 0.0,
    this.isEnrolled = false,
    required this.description,
    required this.learningOutcomes,
    required this.lessons,
    this.colorHex = 0xFF4F46E5,
  });

  CourseModel copyWith({
    bool? isEnrolled,
    double? progress,
  }) {
    return CourseModel(
      id: id,
      code: code,
      title: title,
      instructor: instructor,
      instructorAvatar: instructorAvatar,
      category: category,
      rating: rating,
      totalReviews: totalReviews,
      studentsEnrolled: studentsEnrolled,
      duration: duration,
      totalLessons: totalLessons,
      progress: progress ?? this.progress,
      isEnrolled: isEnrolled ?? this.isEnrolled,
      description: description,
      learningOutcomes: learningOutcomes,
      lessons: lessons,
      colorHex: colorHex,
    );
  }
}