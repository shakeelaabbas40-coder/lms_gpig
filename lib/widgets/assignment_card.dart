import 'package:flutter/material.dart';

class AssignmentCard extends StatelessWidget {
  const AssignmentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: const Text('Assignment'),
        subtitle: const Text('Due Date'),
        trailing: const Icon(Icons.assignment),
        onTap: () {},
      ),
    );
  }
}