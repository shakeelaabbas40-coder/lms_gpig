import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: const Text('Course Name'),
        subtitle: const Text('Teacher Name'),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {},
      ),
    );
  }
}