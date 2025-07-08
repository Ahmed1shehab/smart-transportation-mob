
 

import 'package:flutter/material.dart';

class CircleTab extends StatelessWidget {
  final String title;
  final bool selected;

  const CircleTab({super.key, required this.title, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.circle,
            size: 10, color: selected ? Colors.black : Colors.grey),
        const SizedBox(width: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: selected ? Colors.black : Colors.grey,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
