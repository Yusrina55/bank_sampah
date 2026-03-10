import 'package:flutter/material.dart';
import '../../../theme.dart';
import '../../../models/schedule_model.dart';
import '../../../widgets/schedule_card.dart';
import '../../../widgets/app_search.dart';
import 'detail_schedule_mahasiswa.dart';
import 'detail_schedule_masyarakat.dart';

class PickupSchedule extends StatelessWidget {
  const PickupSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController =
        TextEditingController();

    /// ================= DUMMY DATA =================
    final List<ScheduleModel> schedules = [
      const ScheduleModel(
        name: "Rina",
        kecamatan: "Tegalgede",
        tanggal: "21/12/2025",
        jadwal: "09.00 - 10.00",
        status: "Menunggu",
        customerType: CustomerType.mahasiswa,
        sampahList: [
          SampahItem(jenis: "Plastik"),
        ],
      ),
      const ScheduleModel(
        name: "Budi",
        kecamatan: "Sumbersari",
        tanggal: "22/12/2025",
        jadwal: "10.00",
        status: "Menunggu",
        customerType: CustomerType.masyarakat,
        sampahList: [
          SampahItem(jenis: "Kertas", berat: "2 kg"),
          SampahItem(jenis: "Botol", berat: "1 kg"),
        ],
      ),
    ];

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        const SizedBox(height: 10),

        /// ================= HEADER =================
        Text(
          "Jadwal Penjemputan",
          style: semiBold14.copyWith(color: textblack),
        ),

        const SizedBox(height: 12),

        /// ================= SEARCH DATE =================
        AppDatePickerField(
          controller: searchController,
          enabled: true,
          onDateSelected: (date) {
            // nanti bisa filter by tanggal di sini
          },
        ),

        const SizedBox(height: 16),

        /// ================= LIST SCHEDULE =================
        ...schedules.map((schedule) {
          return ScheduleCard(
            time: schedule.jadwal,
            date: schedule.tanggal,
            name: schedule.name,
            location: schedule.kecamatan,
            onTap: () {
              /// routing berdasarkan tipe customer
              if (schedule.customerType ==
                  CustomerType.mahasiswa) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailSchedulePage(
                      schedule: schedule,
                      isHistory: false,
                      onBack: () => Navigator.pop(context),
                    ),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        DetailScheduleMasyarakatPage(
                      schedule: schedule,
                      isHistory: false,
                      onBack: () => Navigator.pop(context),
                    ),
                  ),
                );
              }
            },
          );
        }).toList(),

        const SizedBox(height: 30),
      ],
    );
  }
}