import 'package:flutter/material.dart';
import '../theme.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final String total;

  const SummaryCard({
    super.key,
    required this.title,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: bordergrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: regular12),
          const SizedBox(height: 8),
          Text(
            total,
            style: medium16.copyWith(color: blue1),
          ),
        ],
      ),
    );
  }
}
