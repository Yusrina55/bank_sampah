import 'package:flutter/material.dart';
import '../../../theme.dart';
import '../../../widgets/summary_card.dart';
import '../../../widgets/section_header.dart';
import '../../../widgets/pickup_chart.dart';
import '../../../widgets/schedule_card.dart';
import '../../../models/schedule_model.dart';
import 'notification_petugas.dart';
import 'profile_petugas.dart';
import 'detail_petugas_mahasiswa.dart';
import 'detail_petugas_masyarakat.dart';

class HomePetugasPage extends StatefulWidget {
  const HomePetugasPage({super.key});

  @override
  State<HomePetugasPage> createState() => _HomePetugasPageState();
}

class _HomePetugasPageState extends State<HomePetugasPage> {

  static final List<Map<String, String>> dummyJadwal = [
    {
      'time': '08.00 - 10.00',
      'date': '21/12/2025',
      'name': 'Rina',
      'jenisSampah': 'Plastik',
      'kecamatan': 'Tegalgede',   // ✅ pisah
      'alamat': 'Perum Kaliurang N11', 
    },
    {
      'time': '12.00',
      'date': '21/12/2025',
      'name': 'Budi',
      'jenisSampah': 'Kertas',
      'berat': '3 kg',
      'kecamatan': 'Tegalgede',   // ✅ pisah
      'alamat': 'Perum Kaliurang N11', 
    },
  ];

  void _onCardTap(Map<String, String> item) {
    final isRentang = item['time']!.contains('-');

    final schedule = ScheduleModel(
      name: item['name']!,
      kecamatan: item['kecamatan']!,
      alamat: item['alamat']!,
      tanggal: item['date']!,
      jadwal: item['time']!,
      status: 'Dijemput',
      customerType: isRentang ? CustomerType.mahasiswa : CustomerType.masyarakat,
      sampahList: isRentang
          ? [
              SampahItem(
                jenis: item['jenisSampah'] ?? '',
              ),
            ]
          : [
              SampahItem(
                jenis: item['jenisSampah'] ?? '',
                berat: item['berat'],
              ),
            ],
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => isRentang
            ? DetailPetugasMahasiswa(
                schedule: schedule,
                isHistory: false,
                onBack: () => Navigator.pop(context),
              )
            : DetailPetugasMasyarakat(
                schedule: schedule,
                isHistory: false,
                onBack: () => Navigator.pop(context),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [

          /// ===== HEADER =====
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Selamat Datang,",
                      style: semiBold14.copyWith(color: textblack),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Petugas Abang Recycle",
                      style: semiBold14.copyWith(color: blue1),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NotificationPetugas(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.notifications_none,
                        color: blue1,
                        size: 28,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfilePetugas(),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: filledgrey,
                        child: Text(
                          "P",
                          style: regular16.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          /// ===== SCROLLABLE AREA =====
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// SUMMARY
                  Row(
                    children: const [
                      Expanded(
                        child: SummaryCard(
                          title: "Mahasiswa",
                          total: "12",
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: SummaryCard(
                          title: "Warga dan Usaha",
                          total: "32",
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// CHART
                  const PickupChartSection(),

                  const SizedBox(height: 20),

                  /// TITLE
                  const SectionHeader(
                    title: "Jadwal Jemput Hari Ini",
                  ),

                  const SizedBox(height: 12),

                  /// LIST JADWAL
                  ...dummyJadwal.map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: ScheduleCard(
                        time: item['time']!,
                        date: item['date']!,
                        name: item['name']!,
                        location: '${item['kecamatan']}, ${item['alamat']}',
                        onTap: () => _onCardTap(item),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}