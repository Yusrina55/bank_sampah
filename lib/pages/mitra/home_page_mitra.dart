import 'package:bank_sampah/pages/mitra/detail_schedule_mitra.dart';
import 'package:bank_sampah/pages/mitra/profile_mitra.dart';
import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets/mitra_schedule_model.dart';
import '../../widgets/mitra_schedule_card.dart';
import '../../widgets/blue_balanced_card.dart';
import 'notification_page.dart';
import 'detail_schedule_mitra.dart';
import 'detail_riwayat_mitra.dart';

class HomePageMitra extends StatefulWidget {
  const HomePageMitra({super.key});

  @override
  State<HomePageMitra> createState() => _HomePageMitraState();
}

class _HomePageMitraState extends State<HomePageMitra> {

  final List<MitraScheduleModel> jadwalPengajuan = const [
    MitraScheduleModel(
      time: "10.00",
      date: "20/12/2025",
      weight: 50,
    ),
  ];

  final List<MitraScheduleModel> riwayatPengambilan = const [
    MitraScheduleModel(
      time: "12.00",
      date: "11/12/2025",
      weight: 50.5,
      harga: 150000,
    ),
    MitraScheduleModel(
      time: "13.00",
      date: "06/12/2025",
      weight: 50.0,
      harga: 250000,
    ),
  ];

  // ✅ Getter untuk menghitung total harga dari semua riwayat
  int get totalBalance {
    return riwayatPengambilan.fold<int>(0, (sum, item) => sum + (item.harga ?? 0).toInt());
  }

  // ✅ Format angka menjadi "400.000" (format Indonesia)
  String get formattedBalance {
    final formatted = totalBalance.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]}.',
    );
    return formatted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [

              /// ===== HEADER =====
              Row(
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
                        "Pabrik Kertas A",
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
                              builder: (context) => const NotificationPage(),
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
                              builder: (context) => const ProfileMitra(),
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
                  )
                ],
              ),

              const SizedBox(height: 16),

              // ✅ Balance sekarang dihitung otomatis
              BlueBalanceCard(
                balance: formattedBalance,
              ),

              const SizedBox(height: 24),

              /// ===== JADWAL PENGAJUAN =====
              Text(
                "Jadwal Pengajuan",
                style: semiBold12.copyWith(color: textblack),
              ),
              const SizedBox(height: 12),

              ...jadwalPengajuan.map((item) =>
                MitraScheduleCard(
                  time: item.time,
                  date: item.date,
                  weight: item.weight,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailJadwalMitraPage(
                          time: item.time,
                          date: item.date,
                          weight: item.weight,
                          harga: item.harga,
                        ),
                      ),
                    );
                  },
                )
              ),

              const SizedBox(height: 16),

              /// ===== RIWAYAT =====
              Text(
                "Riwayat Pengambilan",
                style: semiBold12.copyWith(color: textblack),
              ),
              const SizedBox(height: 12),

              ...riwayatPengambilan.map((item) =>
                MitraScheduleCard(
                  time: item.time,
                  date: item.date,
                  weight: item.weight,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailRiwayatMitra(
                          date: item.date,
                          time: item.time,
                          weight: item.weight,
                          status: "Selesai",
                          harga: item.harga,
                        ),
                      ),
                    );
                  },
                )
              ),

            ],
          ),
        ),
      ),
    );
  }
}