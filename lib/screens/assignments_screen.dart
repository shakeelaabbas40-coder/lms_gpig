import 'package:flutter/material.dart';
import '../models/assignment_model.dart';
import '../services/course_service.dart';
import '../widgets/assignment_card.dart';

class AssignmentsScreen extends StatefulWidget {
  const AssignmentsScreen({super.key});

  @override
  State<AssignmentsScreen> createState() => _AssignmentsScreenState();
}

class _AssignmentsScreenState extends State<AssignmentsScreen> with SingleTickerProviderStateMixin {
  final courseService = CourseService();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showAssignmentDetail(AssignmentModel assignment) {
    final noteController = TextEditingController();
    bool isFileSelected = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 20,
              left: 20,
              right: 20,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          assignment.courseCode,
                          style: const TextStyle(
                            color: Color(0xFF2563EB),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    assignment.title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    assignment.courseTitle,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 16),

                  // Meta card
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text('Due Date', style: TextStyle(fontSize: 11, color: Colors.grey)),
                            const SizedBox(height: 4),
                            Text(assignment.dueDate, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Container(height: 24, width: 1, color: Colors.grey.shade300),
                        Column(
                          children: [
                            const Text('Total Marks', style: TextStyle(fontSize: 11, color: Colors.grey)),
                            const SizedBox(height: 4),
                            Text('${assignment.totalPoints} Points', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Container(height: 24, width: 1, color: Colors.grey.shade300),
                        Column(
                          children: [
                            const Text('Status', style: TextStyle(fontSize: 11, color: Colors.grey)),
                            const SizedBox(height: 4),
                            Text(
                              assignment.status.toUpperCase(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: assignment.status == 'graded'
                                    ? Colors.green
                                    : (assignment.status == 'submitted' ? Colors.blue : Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  const Text('Instructions', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text(
                    assignment.instructions,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade700, height: 1.4),
                  ),

                  if (assignment.status == 'graded') ...[
                    const SizedBox(height: 18),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.green.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.stars_rounded, color: Colors.green, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                'Score: ${assignment.obtainedPoints} / ${assignment.totalPoints}',
                                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                              ),
                            ],
                          ),
                          if (assignment.teacherFeedback != null) ...[
                            const SizedBox(height: 6),
                            Text(
                              'Feedback: ${assignment.teacherFeedback}',
                              style: TextStyle(fontSize: 12, color: Colors.green.shade900),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ] else if (assignment.status == 'pending') ...[
                    const SizedBox(height: 20),
                    const Text('Your Submission', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: noteController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Add submission comment or repository / document link...',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        contentPadding: const EdgeInsets.all(12),
                      ),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      onPressed: () {
                        setSheetState(() => isFileSelected = true);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('File attached: assignment_solution.zip')),
                        );
                      },
                      icon: Icon(
                        isFileSelected ? Icons.check_circle_rounded : Icons.attach_file_rounded,
                        color: isFileSelected ? Colors.green : const Color(0xFF2563EB),
                      ),
                      label: Text(
                        isFileSelected ? 'assignment_solution.zip (Attached)' : 'Attach Submission File (.pdf, .zip)',
                        style: TextStyle(color: isFileSelected ? Colors.green : const Color(0xFF2563EB)),
                      ),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        minimumSize: const Size(double.infinity, 44),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        courseService.submitAssignment(
                          assignment.id,
                          noteController.text.trim().isNotEmpty ? noteController.text.trim() : 'Assignment files uploaded.',
                        );
                        Navigator.pop(context);
                        setState(() {});
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Assignment submitted successfully!'),
                            backgroundColor: Color(0xFF10B981),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2563EB),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Turn In Assignment', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ] else ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blue.shade200),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle_outline_rounded, color: Colors.blue),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Submitted on ${assignment.submissionDate ?? 'recently'}. Awaiting instructor evaluation.',
                              style: TextStyle(fontSize: 12, color: Colors.blue.shade900),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2563EB);
    final allAssignments = courseService.getAssignments();
    final pendingList = allAssignments.where((a) => a.status == 'pending').toList();
    final submittedList = allAssignments.where((a) => a.status == 'submitted').toList();
    final gradedList = allAssignments.where((a) => a.status == 'graded').toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Assignments & Tasks',
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: primaryColor,
          indicatorWeight: 3,
          labelColor: primaryColor,
          unselectedLabelColor: Colors.grey.shade600,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          tabs: [
            Tab(text: 'To-Do (${pendingList.length})'),
            Tab(text: 'Submitted (${submittedList.length})'),
            Tab(text: 'Graded (${gradedList.length})'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAssignmentList(pendingList, 'No pending tasks! You are all caught up 🎉'),
          _buildAssignmentList(submittedList, 'No assignments currently awaiting grading.'),
          _buildAssignmentList(gradedList, 'No graded assignments yet.'),
        ],
      ),
    );
  }

  Widget _buildAssignmentList(List<AssignmentModel> assignments, String emptyMsg) {
    if (assignments.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.task_alt_rounded, size: 54, color: Colors.grey.shade400),
              const SizedBox(height: 12),
              Text(
                emptyMsg,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: assignments.length,
      itemBuilder: (context, index) {
        final item = assignments[index];
        return AssignmentCard(
          assignment: item,
          onTap: () => _showAssignmentDetail(item),
        );
      },
    );
  }
}