import 'package:flutter/material.dart';
import '../services/course_service.dart';
import '../services/auth_service.dart';
import '../models/result_model.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  final courseService = CourseService();
  final authService = AuthService();
  String _selectedSemester = 'Current (Spring 2026)';

  @override
  Widget build(BuildContext context) {
    final user = authService.currentUser;
    final results = courseService.getResults();
    const primaryColor = Color(0xFF2563EB);

    double totalQualityPoints = 0;
    int totalCredits = 0;
    for (var r in results) {
      totalQualityPoints += (r.gradePoint * r.creditHours);
      totalCredits += r.creditHours;
    }
    final semesterGpa = totalCredits > 0 ? (totalQualityPoints / totalCredits).toStringAsFixed(2) : '3.82';

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF1E293B), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Academic Grades & Results',
          style: TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.download_rounded, color: primaryColor),
            tooltip: 'Download Transcript',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Downloading Official Transcript PDF...'),
                  backgroundColor: Color(0xFF10B981),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // GPA Summary Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.name ?? 'Sarah Khan',
                            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            user?.studentId ?? 'LMS-2024-892',
                            style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.verified_rounded, color: Colors.greenAccent, size: 16),
                            SizedBox(width: 4),
                            Text('Good Standing', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.white24, height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildSummaryItem('Current GPA', semesterGpa),
                      Container(height: 30, width: 1, color: Colors.white24),
                      _buildSummaryItem('Cumulative CGPA', '${user?.gpa ?? 3.82}'),
                      Container(height: 30, width: 1, color: Colors.white24),
                      _buildSummaryItem('Credits Earned', '$totalCredits / 16'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Semester Dropdown
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Course Breakdown',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
                ),
                DropdownButton<String>(
                  value: _selectedSemester,
                  underline: const SizedBox(),
                  icon: const Icon(Icons.keyboard_arrow_down_rounded, color: primaryColor),
                  style: const TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 13),
                  items: const [
                    DropdownMenuItem(value: 'Current (Spring 2026)', child: Text('Current (Spring 2026)')),
                    DropdownMenuItem(value: 'Fall 2025', child: Text('Fall 2025')),
                    DropdownMenuItem(value: 'Spring 2025', child: Text('Spring 2025')),
                  ],
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedSemester = val);
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Results List
            ...results.map((item) => _buildResultCard(item)).toList(),

            const SizedBox(height: 20),
            // Download button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Downloading Official Transcript with QR Verification...'),
                      backgroundColor: Color(0xFF10B981),
                    ),
                  );
                },
                icon: const Icon(Icons.picture_as_pdf_rounded, color: primaryColor),
                label: const Text('Download Official Grade Sheet (PDF)', style: TextStyle(fontWeight: FontWeight.bold)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: primaryColor),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Text(label, style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 11)),
      ],
    );
  }

  Widget _buildResultCard(ResultModel item) {
    Color gradeColor;
    if (item.grade.startsWith('A')) {
      gradeColor = const Color(0xFF10B981); // Green
    } else if (item.grade.startsWith('B')) {
      gradeColor = const Color(0xFF2563EB); // Blue
    } else {
      gradeColor = const Color(0xFFEA580C); // Orange
    }

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
            blurRadius: 8,
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  item.courseCode,
                  style: const TextStyle(color: Color(0xFF2563EB), fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: gradeColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Grade: ${item.grade} (${item.gradePoint.toStringAsFixed(2)})',
                  style: TextStyle(color: gradeColor, fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            item.courseTitle,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Text('${item.creditHours} Credit Hours', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
              const Spacer(),
              Text(
                'Marks: ${item.obtainedMarks}/${item.totalMarks} (${item.percentage.toInt()}%)',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF334155)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: item.percentage / 100,
              minHeight: 5,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(gradeColor),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Remarks: ${item.remarks}',
            style: TextStyle(fontSize: 11, color: Colors.grey.shade600, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}