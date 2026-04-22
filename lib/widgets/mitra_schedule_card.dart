import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme.dart';

class MitraScheduleCard extends StatelessWidget {
  final String time;
  final String date;
  final String? name;       
  final String? jenisSampah;
  final double weight;
  final VoidCallback? onTap;

  const MitraScheduleCard({
    super.key,
    required this.time,
    required this.date,
    this.name,
    this.jenisSampah,
    required this.weight,
    this.onTap,
  });

  Widget _row(String icon, String text) {
    return Row(
      children: [
        SvgPicture.asset(
          icon,
          width: 16,
          height: 16,
          colorFilter: ColorFilter.mode(blue1, BlendMode.srcIn),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: regular12.copyWith(color: textblack),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: bordergrey),
        ),
        child: Row(
          children: [
            /// TIME
            SizedBox(
              width: 40,
              child: Text(
                time,
                style: medium12.copyWith(color: textblack),
              ),
            ),
            const SizedBox(width: 12),

            /// DETAIL
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _row('assets/icons/calendar.svg', date),
                  const SizedBox(height: 6),
                  if (name != null) ...[
                      _row('assets/icons/person.svg', name!),
                      const SizedBox(height: 6),
                    ],
                  _row('assets/icons/weight.svg', '${weight.toStringAsFixed(0)} karung'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}