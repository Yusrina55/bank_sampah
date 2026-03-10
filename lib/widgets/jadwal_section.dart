import 'package:flutter/material.dart';
import '../theme.dart';

class JadwalSection extends StatelessWidget {
  final String title;
  final List<String> schedules;
  final Function(String value)? onTap;

  const JadwalSection({
    super.key,
    required this.title,
    required this.schedules,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// TITLE
        Text(
          title,
          style: semiBold12.copyWith(color: textblack),
        ),

        const SizedBox(height: 10),

        /// LIST SCHEDULE
        ...schedules.map(
          (item) => GestureDetector(
            onTap: () {
              if (onTap != null) {
                onTap!(item);
              }
            },
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
              ),
              child: Text(
                item,
                style: regular12.copyWith(color: textblack),
              ),
            ),
          ),
        ),
      ],
    );
  }
}