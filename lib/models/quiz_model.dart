class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctOptionIndex;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctOptionIndex,
  });
}

class QuizModel {
  final String id;
  final String title;
  final String courseTitle;
  final String courseCode;
  final int totalQuestions;
  final int durationMinutes;
  final int totalMarks;
  final int? score;
  final bool isCompleted;
  final String dueDate;
  final List<QuizQuestion> questions;

  QuizModel({
    required this.id,
    required this.title,
    required this.courseTitle,
    required this.courseCode,
    required this.totalQuestions,
    required this.durationMinutes,
    required this.totalMarks,
    this.score,
    this.isCompleted = false,
    required this.dueDate,
    required this.questions,
  });

  QuizModel copyWith({
    bool? isCompleted,
    int? score,
  }) {
    return QuizModel(
      id: id,
      title: title,
      courseTitle: courseTitle,
      courseCode: courseCode,
      totalQuestions: totalQuestions,
      durationMinutes: durationMinutes,
      totalMarks: totalMarks,
      score: score ?? this.score,
      isCompleted: isCompleted ?? this.isCompleted,
      dueDate: dueDate,
      questions: questions,
    );
  }
}
