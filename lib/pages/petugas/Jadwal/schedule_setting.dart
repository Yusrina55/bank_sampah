import 'package:flutter/material.dart';
import '../../../theme.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/jadwal_section.dart';
import 'create_schedule_setting.dart';
import 'detail_set_schedule.dart';

class ScheduleSetting extends StatelessWidget {
  const ScheduleSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [

        const SizedBox(height: 10),

        /// HEADER
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Set Jadwal",
              style: semiBold14.copyWith(color: textblack),
            ),
            SizedBox(
              width: 150,
              child: AppButton(
                text: "Tambah",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CreateScheduleSetting(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        /// SECTION 1
        JadwalSection(
          title: "Patrang",
          schedules: const [
            "12-01-2026 08.00 - 10.00",
            "21-01-2026 14.00 - 16.00",
          ],
          onTap: (value) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailJadwalPage(
                  kecamatan: "Patrang",
                  tanggal: value,
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 20),

        /// SECTION 2
        JadwalSection(
          title: "Sumbersari",
          schedules: const [
            "12-01-2026 08.00 - 10.00",
            "21-01-2026 14.00 - 16.00",
          ],
          onTap: (value) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailJadwalPage(
                  kecamatan: "Sumbersari",
                  tanggal: value,
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 20),

        /// SECTION 3
        JadwalSection(
          title: "Tegalgede",
          schedules: const [
            "12-01-2026 08.00 - 10.00",
            "21-01-2026 14.00 - 16.00",
          ],
          onTap: (value) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailJadwalPage(
                  kecamatan: "Tegalgede",
                  tanggal: value,
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 30),
      ],
    );
  }
}