import 'package:flutter/material.dart';
import '../../../widgets/schedule_card.dart';
import '../../../theme.dart';
import '../../../models/schedule_model.dart';
import 'detail_requested_schedule.dart';

class RequestedSchedulePage extends StatelessWidget {
  const RequestedSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ScheduleModel> dummyRequests = [
      ScheduleModel(
        name: "Budi",
        kecamatan: "Tegalgede",
        alamat: "Perum Kaliurang N11",
        tanggal: "22/12/2025",
        jadwal: "10.00",
        status: "Menunggu Persetujuan",
        customerType: CustomerType.masyarakat,
        sampahList: const [
          SampahItem(jenis: "Plastik", berat: "2 kg"),
          SampahItem(jenis: "Kertas", berat: "1 kg"),
        ],
      ),
      ScheduleModel(
        name: "Sari",
        kecamatan: "Ambulu",
        alamat: "Jl. Raya Ambulu No. 45",
        tanggal: "23/12/2025",
        jadwal: "14.00",
        status: "Menunggu Persetujuan",
        customerType: CustomerType.masyarakat,
        sampahList: const [
          SampahItem(jenis: "Logam", berat: "3 kg"),
        ],
      ),
    ];

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        const SizedBox(height: 10),

        Text(
          "Permintaan Penjemputan",
          style: semiBold14.copyWith(color: textblack),
        ),

        const SizedBox(height: 16),

        ...dummyRequests.map(
          (schedule) => ScheduleCard(
            time: schedule.jadwal,
            date: schedule.tanggal,
            name: schedule.name,
            location: '${schedule.kecamatan}, ${schedule.alamat}',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailRequestedSchedulePage(
                    schedule: schedule,
                    onBack: () => Navigator.pop(context),
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 30),
      ],
    );
  }
}