import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme.dart';

class ScheduleCard extends StatelessWidget {
  final String time;
  final String date;
  final String name;
  final String location;

  const ScheduleCard({
    super.key,
    required this.time,
    required this.date,
    required this.name,
    required this.location,
  });

  Widget _row(String icon, String text) {
    return Row(
      children: [
        SvgPicture.asset(
          icon,
          width: 16,
          height: 16,
          colorFilter: ColorFilter.mode(
            blue1,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: regular12.copyWith(color: textblack),
          ),
        )
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
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: bordergrey),
      ),
      child: Row(
        children: [
          // JAM
          Column(
            children: [
              Text(
                time.split('-')[0],
                style: medium12.copyWith(color: textblack),
              ),
              const Text('-'),
              Text(
                time.split('-')[1],
                style: medium12.copyWith(color: textblack),
              ),
            ],
          ),
          const SizedBox(width: 12),

          // DETAIL
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _row('assets/icons/calendar.svg', date),
                const SizedBox(height: 6),
                _row('assets/icons/person.svg', name),
                const SizedBox(height: 6),
                _row('assets/icons/location.svg', location),
              ],
            ),
          )
        ],
      ),
    );
  }
}
