import 'package:flutter/material.dart';

class DifferenceSection extends StatelessWidget {
  const DifferenceSection({
    super.key,
    this.title,
    this.description,
  });

  final String? title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null ?
        Text(
          title!,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[500]),
        ) : const SizedBox(),
        const SizedBox(height: 10),
        description != null ?
        Text(
          description!,
          style: const TextStyle(fontSize: 10, color: Colors.white70),
        ) : const SizedBox(),
      ],
    );
  }
}