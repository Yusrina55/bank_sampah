import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme.dart';

class OperationalCard extends StatelessWidget {
  final String date;
  final String note;
  final String amount;

  const OperationalCard({
    super.key,
    required this.date,
    required this.note,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// DATE
          Row(
            children: [
              SvgPicture.asset(
                "assets/icons/calendar.svg",
                width: 18,
              ),
              const SizedBox(width: 8),
              Text(
                date,
                style: regular12,
              ),
            ],
          ),

          const SizedBox(height: 8),

          /// NOTE
          Row(
            children: [
              SvgPicture.asset(
                "assets/icons/recap.svg",
                width: 18,
              ),
              const SizedBox(width: 8),
              Text(
                note,
                style: regular12,
              ),
            ],
          ),

          const SizedBox(height: 8),

          /// AMOUNT
          Row(
            children: [
              SvgPicture.asset(
                "assets/icons/uang.svg",
                width: 18,
              ),
              const SizedBox(width: 8),
              Text(
                amount,
                style: regular12,
              ),
            ],
          ),
        ],
      ),
    );
  }
}