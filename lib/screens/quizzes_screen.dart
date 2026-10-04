import 'package:flutter/material.dart';
import '../models/quiz_model.dart';
import '../services/course_service.dart';
import 'results_screen.dart';

class QuizzesScreen extends StatefulWidget {
  const QuizzesScreen({super.key});

  @override
  State<QuizzesScreen> createState() => _QuizzesScreenState();
}

class _QuizzesScreenState extends State<QuizzesScreen> {
  final courseService = CourseService();

  void _startQuiz(QuizModel quiz) {
    int currentQuestionIndex = 0;
    final Map<int, int> selectedAnswers = {};

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setQuizState) {
          final question = quiz.questions[currentQuestionIndex];

          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        quiz.courseCode,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF2563EB)),
                      ),
                      Text(
                        'Question ${currentQuestionIndex + 1} of ${quiz.questions.length}',
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade50,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.amber.shade300),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.timer_outlined, size: 14, color: Colors.orange),
                      const SizedBox(width: 4),
                      Text(
                        '${quiz.durationMinutes}m',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.orange),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Question text
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        question.question,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Options
                    ...List.generate(question.options.length, (optIdx) {
                      final option = question.options[optIdx];
                      final isSelected = selectedAnswers[currentQuestionIndex] == optIdx;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFFEFF6FF) : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isSelected ? const Color(0xFF2563EB) : Colors.grey.shade300,
                            width: isSelected ? 1.6 : 1,
                          ),
                        ),
                        child: RadioListTile<int>(
                          value: optIdx,
                          groupValue: selectedAnswers[currentQuestionIndex],
                          activeColor: const Color(0xFF2563EB),
                          title: Text(
                            option,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              color: isSelected ? const Color(0xFF2563EB) : Colors.grey.shade800,
                            ),
                          ),
                          onChanged: (val) {
                            setQuizState(() {
                              selectedAnswers[currentQuestionIndex] = val!;
                            });
                          },
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            actions: [
              if (currentQuestionIndex > 0)
                TextButton(
                  onPressed: () {
                    setQuizState(() => currentQuestionIndex--);
                  },
                  child: const Text('Previous'),
                ),
              if (currentQuestionIndex < quiz.questions.length - 1)
                ElevatedButton(
                  onPressed: selectedAnswers.containsKey(currentQuestionIndex)
                      ? () {
                          setQuizState(() => currentQuestionIndex++);
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Next'),
                )
              else
                ElevatedButton(
                  onPressed: () {
                    // Calculate score
                    int correctCount = 0;
                    for (int i = 0; i < quiz.questions.length; i++) {
                      if (selectedAnswers[i] == quiz.questions[i].correctOptionIndex) {
                        correctCount++;
                      }
                    }
                    final pointsPerQuestion = quiz.totalMarks / quiz.questions.length;
                    final totalScore = (correctCount * pointsPerQuestion).round();

                    courseService.submitQuiz(quiz.id, totalScore);
                    Navigator.pop(context); // close quiz dialog
                    setState(() {});

                    // Show Results Dialog
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        title: const Center(
                          child: Text('Quiz Results 🎉', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '$totalScore / ${quiz.totalMarks}',
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2563EB),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Correct Answers: $correctCount out of ${quiz.questions.length}',
                              style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                            ),
                            const SizedBox(height: 14),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                              decoration: BoxDecoration(
                                color: totalScore >= (quiz.totalMarks * 0.5) ? Colors.green.shade50 : Colors.red.shade50,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                totalScore >= (quiz.totalMarks * 0.5) ? 'Status: PASSED' : 'Status: NEEDS IMPROVEMENT',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: totalScore >= (quiz.totalMarks * 0.5) ? Colors.green : Colors.red,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2563EB),
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Done'),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Submit Quiz'),
                ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2563EB);
    final quizzes = courseService.getQuizzes();
    final available = quizzes.where((q) => !q.isCompleted).toList();
    final completed = quizzes.where((q) => q.isCompleted).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Quizzes & Assessments',
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ResultsScreen()),
              );
            },
            icon: const Icon(Icons.grade_rounded, size: 18, color: primaryColor),
            label: const Text(
              'Transcripts',
              style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Banner
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Interactive Online Quizzes',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Test your knowledge, get instant scores, and earn course credits.',
                        style: TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.psychology_rounded, color: Colors.white, size: 32),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Available Quizzes
          Text(
            'Available to Attempt (${available.length})',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
          ),
          const SizedBox(height: 10),
          if (available.isEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text('No quizzes pending at this moment! 🏆'),
              ),
            )
          else
            ...available.map((quiz) => _buildQuizCard(quiz, isCompleted: false)),

          const SizedBox(height: 24),

          // Completed Quizzes
          Text(
            'Completed Tests (${completed.length})',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
          ),
          const SizedBox(height: 10),
          ...completed.map((quiz) => _buildQuizCard(quiz, isCompleted: true)),
        ],
      ),
    );
  }

  Widget _buildQuizCard(QuizModel quiz, {required bool isCompleted}) {
    const primaryColor = Color(0xFF2563EB);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  quiz.courseCode,
                  style: const TextStyle(color: primaryColor, fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isCompleted ? Colors.green.shade50 : Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  isCompleted ? 'Score: ${quiz.score}/${quiz.totalMarks}' : '${quiz.durationMinutes} Minutes',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: isCompleted ? Colors.green : Colors.orange.shade800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            quiz.title,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
          ),
          const SizedBox(height: 4),
          Text(
            quiz.courseTitle,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.help_outline_rounded, size: 14, color: Colors.grey.shade500),
              const SizedBox(width: 4),
              Text(
                '${quiz.totalQuestions} Questions',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              const SizedBox(width: 12),
              Icon(Icons.calendar_today_rounded, size: 14, color: Colors.grey.shade500),
              const SizedBox(width: 4),
              Text(
                quiz.dueDate,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: isCompleted ? null : () => _startQuiz(quiz),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isCompleted ? Colors.grey.shade300 : primaryColor,
                  foregroundColor: isCompleted ? Colors.grey.shade700 : Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                ),
                child: Text(isCompleted ? 'Completed' : 'Start Quiz', style: const TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}