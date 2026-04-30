


import 'package:flutter/material.dart';

class EmptyRequestsWidget extends StatelessWidget {
  const EmptyRequestsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: const [
          Icon(Icons.inbox_outlined, size: 50),
          SizedBox(height: 10),
          Text('No requests found'),
        ],
      ),
    );
  }
}