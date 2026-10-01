import 'package:flutter/material.dart';

class CourseDetailScreen extends StatelessWidget {
  const CourseDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Details'),
      ),
      body: const Center(
        child: Text(
          'Course Details',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}