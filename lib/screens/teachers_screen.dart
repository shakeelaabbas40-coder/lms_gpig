import 'package:flutter/material.dart';
import '../models/teacher_model.dart';

class TeachersScreen extends StatefulWidget {
  const TeachersScreen({super.key});

  @override
  State<TeachersScreen> createState() => _TeachersScreenState();
}

class _TeachersScreenState extends State<TeachersScreen> {
  // ──────────────────────────────────────────────────────────────────────────
  // TEACHER DATA  ← Add teacher objects here when you are ready.
  // Each TeacherModel supports: name, subject, department, teacherId,
  // email, qualification.  Only `id` and `name` are required.
  //
  // Example entry (uncomment and fill in real data):
  //
  // const TeacherModel(
  //   id: '1',
  //   name: 'Dr. Example Name',
  //   subject: 'Subject Name',
  //   department: 'Computer Science',
  //   teacherId: 'TCH-001',
  //   qualification: 'PhD',
  // ),
  // ──────────────────────────────────────────────────────────────────────────
  static const List<TeacherModel> _allTeachers = [
    // ← Paste teacher entries here
  ];
  // ──────────────────────────────────────────────────────────────────────────

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<TeacherModel> get _filteredTeachers {
    if (_searchQuery.isEmpty) return _allTeachers;
    final q = _searchQuery.toLowerCase();
    return _allTeachers.where((t) {
      return t.name.toLowerCase().contains(q) ||
          t.subject.toLowerCase().contains(q) ||
          t.department.toLowerCase().contains(q) ||
          t.teacherId.toLowerCase().contains(q);
    }).toList();
  }

  // Palette of avatar background colors — cycles through teachers
  static const List<Color> _avatarColors = [
    Color(0xFF2563EB),
    Color(0xFF7C3AED),
    Color(0xFF059669),
    Color(0xFFDC2626),
    Color(0xFFD97706),
    Color(0xFF0891B2),
    Color(0xFFDB2777),
    Color(0xFF65A30D),
  ];

  Color _avatarColor(int index) => _avatarColors[index % _avatarColors.length];

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2563EB);
    final filtered = _filteredTeachers;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Faculty & Teachers',
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: TextField(
              controller: _searchController,
              onChanged: (val) => setState(() => _searchQuery = val),
              decoration: InputDecoration(
                hintText: 'Search by name, subject, department…',
                hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade500),
                prefixIcon: const Icon(Icons.search_rounded, size: 20, color: Colors.grey),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded, size: 18),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
                filled: true,
                fillColor: const Color(0xFFF1F5F9),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Summary Banner
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Row(
              children: [
                const Icon(Icons.people_alt_rounded, size: 16, color: Color(0xFF2563EB)),
                const SizedBox(width: 6),
                Text(
                  _allTeachers.isEmpty
                      ? 'No teachers added yet'
                      : '${_allTeachers.length} Faculty Member${_allTeachers.length == 1 ? '' : 's'}',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Teacher list / empty state
          Expanded(
            child: filtered.isEmpty
                ? _buildEmptyState(isSearching: _searchQuery.isNotEmpty)
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      return _buildTeacherCard(filtered[index], index);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // ─── Empty State ────────────────────────────────────────────────────────
  Widget _buildEmptyState({required bool isSearching}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF2563EB).withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isSearching
                    ? Icons.search_off_rounded
                    : Icons.person_off_rounded,
                size: 56,
                color: const Color(0xFF2563EB).withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              isSearching ? 'No results found' : 'No teachers added yet.',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isSearching
                  ? 'Try a different name, subject, or department.'
                  : 'The faculty list will appear here once\nteacher information is added.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade500,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Teacher Card ────────────────────────────────────────────────────────
  Widget _buildTeacherCard(TeacherModel teacher, int index) {
    final color = _avatarColor(index);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        leading: CircleAvatar(
          radius: 26,
          backgroundColor: color.withOpacity(0.12),
          child: Text(
            teacher.avatarInitials,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        title: Text(
          teacher.name,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (teacher.subject.isNotEmpty) ...[
              const SizedBox(height: 3),
              Row(
                children: [
                  Icon(Icons.book_outlined, size: 13, color: Colors.grey.shade500),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      teacher.subject,
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    ),
                  ),
                ],
              ),
            ],
            if (teacher.department.isNotEmpty) ...[
              const SizedBox(height: 2),
              Row(
                children: [
                  Icon(Icons.account_balance_outlined, size: 13, color: Colors.grey.shade500),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      teacher.department,
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    ),
                  ),
                ],
              ),
            ],
            if (teacher.teacherId.isNotEmpty) ...[
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  teacher.teacherId,
                  style: TextStyle(
                    fontSize: 11,
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
        trailing: teacher.qualification.isNotEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      teacher.qualification,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF059669),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              )
            : null,
      ),
    );
  }
}
