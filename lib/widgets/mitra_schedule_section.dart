import 'package:flutter/material.dart';
import '../../../theme.dart';
import '../../../widgets/mitra_schedule_card.dart';
import '../pages/petugas/Transaksi/transaksi_detail_schedule.dart';

class MitraScheduleSection extends StatelessWidget {
  final List<Map<String, dynamic>> schedules;

  const MitraScheduleSection({
    super.key,
    required this.schedules,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// TITLE
        Text(
          "Jadwal Mitra",
          style: semiBold14.copyWith(color: textblack),
        ),

        const SizedBox(height: 12),

        /// LIST CARD
        ...schedules.map((item) {
          return MitraScheduleCard(
            time: item["time"],
            date: item["date"],
            name: item["name"] ,
            jenisSampah: item["jenisSampah"],
            weight: item["weight"],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailTransaksiJadwal(
                    time: item["time"],
                    date: item["date"],
                    name: item["name"],
                    jenisSampah: item["jenisSampah"],
                    weight: item["weight"],
                  ),
                ),
              );
            },
          );
        }).toList(),
      ],
    );
  }
}