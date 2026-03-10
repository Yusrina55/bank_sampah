import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme.dart';

class RekapDetailCard extends StatelessWidget {
  final String date;
  final String name;
  final String amount;

  const RekapDetailCard({
    super.key,
    required this.date,
    required this.name,
    required this.amount,
  });

  Widget _row(String iconPath, String text) {
    return Row(
      children: [
        SvgPicture.asset(
          iconPath,
          width: 16,
          height: 16,
          colorFilter: ColorFilter.mode(blue1, BlendMode.srcIn),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: regular12.copyWith(color: textblack),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: bordergrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _row('assets/icons/calendar.svg', date),
          const SizedBox(height: 6),
          _row('assets/icons/recap.svg', name),
          const SizedBox(height: 6),
          _row('assets/icons/uang.svg', amount),
        ],
      ),
    );
  }
}