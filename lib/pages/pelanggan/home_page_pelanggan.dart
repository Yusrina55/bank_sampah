import 'package:bank_sampah/theme.dart';
import 'package:flutter/material.dart';
import '../../widgets/schedule_card.dart';
import '../../widgets/blue_balanced_card.dart';
import 'create_schedule_page.dart';
import '../../pages/pelanggan/mahasiswa/detail_schedule_page.dart';
import '../../models/schedule_model.dart';
import '../../pages/pelanggan/warga/detail_schedule_masyarakat_page.dart';
import 'profile_pelanggan.dart';
import '../../pages/pelanggan/notification_screen.dart';
import 'riwayat_page.dart';

enum HomeViewMode { list, detail }

class HomePagePelanggan extends StatefulWidget {
  const HomePagePelanggan({super.key});

  @override
  State<HomePagePelanggan> createState() => _HomePagePelangganState();
}

class _HomePagePelangganState extends State<HomePagePelanggan> {
  HomeViewMode _mode = HomeViewMode.list;
  ScheduleModel? _selectedSchedule;

  // ===== JADWAL MASYARAKAT (perlu verifikasi) =====
  final List<ScheduleModel> jadwalAjuanList = const [
    ScheduleModel(
      name: "Budi",
      kecamatan: "Sumbersari",
      alamat: "Jl. Mawar No.5, Sumbersari",
      tanggal: "21/12/2025",
      jadwal: "11.00",
      status: "Menunggu Persetujuan",
      customerType: CustomerType.masyarakat,
      sampahList: [
        SampahItem(jenis: "Plastik", berat: "10 kg"),
      ],
    ),
  ];

  // ===== JADWAL PENJEMPUTAN (mahasiswa langsung masuk sini) =====
  final List<ScheduleModel> jadwalPenjemputanList = const [
    ScheduleModel(
      name: "Rina",
      kecamatan: "Tegalgede",
      alamat: "Perum Kaliurang N11",
      tanggal: "13/12/2025",
      jadwal: "08.00 - 10.00",
      status: "Diproses",
      customerType: CustomerType.mahasiswa,
      sampahList: [
        SampahItem(jenis: "Kertas"),
      ],
    ),
    ScheduleModel(
      name: "Rina Warga",
      kecamatan: "Tegalgede",
      alamat: "Perum Kaliurang N11",
      tanggal: "13/12/2025",
      jadwal: "08.00 - 10.00",
      status: "Diproses",
      customerType: CustomerType.mahasiswa,
      sampahList: [
        SampahItem(jenis: "Kertas"),
      ],
    ),
    ScheduleModel(
      name: "Rina",
      kecamatan: "Tegalgede",
      alamat: "Perum Kaliurang N11",
      tanggal: "21/12/2025",
      jadwal: "08.00 - 10.00",
      status: "Dibayar",
      harga: "15.000",
      customerType: CustomerType.mahasiswa,
      sampahList: [
        SampahItem(jenis: "Plastik"),
      ],
    ),
  ];

  // ===== RIWAYAT =====
  final List<ScheduleModel> riwayatList = const [
    ScheduleModel(
      name: "Budi",
      kecamatan: "Sumbersari",
      alamat: "Jl. Mawar No.5, Sumbersari",
      tanggal: "20/01/2026",
      jadwal: "09.00",
      status: "Dibatalkan",
      harga: "100.000",
      customerType: CustomerType.masyarakat,
      sampahList: [
        SampahItem(jenis: "Plastik", berat: "2 kg"),
        SampahItem(jenis: "Kertas", berat: "1 kg"),
      ],
    ),
    ScheduleModel(
      name: "Rina",
      kecamatan: "Tegalgede",
      alamat: "Perum Kaliurang N11",
      tanggal: "21/12/2025",
      jadwal: "08.00 - 10.00",
      status: "Selesai",
      harga: "20.000",
      customerType: CustomerType.mahasiswa,
      sampahList: [
        SampahItem(jenis: "Kertas"),
      ],
    ),
    ScheduleModel(
      name: "Rina",
      kecamatan: "Tegalgede",
      alamat: "Perum Kaliurang N11",
      tanggal: "21/12/2025",
      jadwal: "08.00 - 10.00",
      status: "Selesai",
      harga: "30.000",
      customerType: CustomerType.mahasiswa,
      sampahList: [
        SampahItem(jenis: "Kertas"),
      ],
    ),
        ScheduleModel(
      name: "Sari",
      kecamatan: "Sumbersari",
      alamat: "Jl. Mawar No.5, Sumbersari",
      tanggal: "21/12/2025",
      jadwal: "11.00",
      status: "Ditolak",
      alasanTolak: "sedang sakit",
      customerType: CustomerType.masyarakat,
      sampahList: [
        SampahItem(jenis: "Plastik", berat: "12 kg"),
      ],
    ),
  ];

  /// Hitung total balance dari seluruh harga di riwayat
  String get totalBalance {
    double total = 0;
    for (final item in riwayatList) {
      if (item.harga != null && item.harga != '-') {
        final cleaned = item.harga!.replaceAll('.', '').replaceAll(',', '');
        total += double.tryParse(cleaned) ?? 0;
      }
    }
    // Format ke rupiah dengan titik ribuan
    final formatted = total.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]}.',
    );
    return formatted;
  }

  void _navigateToDetail(ScheduleModel schedule) {
    setState(() {
      _mode = HomeViewMode.detail;
      _selectedSchedule = schedule;
    });
  }

  void _onBack() {
    setState(() {
      _mode = HomeViewMode.list;
      _selectedSchedule = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ===== DETAIL VIEW =====
    if (_mode == HomeViewMode.detail && _selectedSchedule != null) {
      if (_selectedSchedule!.customerType == CustomerType.mahasiswa) {
        return DetailSchedulePage(
          schedule: _selectedSchedule!,
          onBack: _onBack,
        );
      } else {
        return DetailScheduleMasyarakatPage(
          schedule: _selectedSchedule!,
          onBack: _onBack,
        );
      }
    }

    // ===== LIST VIEW =====
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
                        "Rina",
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
                              builder: (context) => const NotificationScreen(),
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
                              builder: (context) => const ProfileScreen(),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: filledgrey,
                          child: Text(
                            "R",
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

              const SizedBox(height: 16),

              /// ===== BALANCE CARD (computed dari riwayat) =====
              BlueBalanceCard(
                balance: totalBalance,
                onCreateSchedule: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateSchedulePage(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              /// ===== JADWAL AJUAN (masyarakat saja) =====
              if (jadwalAjuanList.isNotEmpty) ...[
                Text(
                  "Jadwal Ajuan",
                  style: semiBold12.copyWith(color: textblack),
                ),
                const SizedBox(height: 12),
                ...jadwalAjuanList.map(
                  (schedule) => ScheduleCard(
                    time: schedule.jadwal,
                    date: schedule.tanggal,
                    name: schedule.name,
                    location: '${schedule.kecamatan}, ${schedule.alamat}',
                    onTap: () => _navigateToDetail(schedule),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              /// ===== JADWAL PENJEMPUTAN (mahasiswa langsung masuk sini) =====
              if (jadwalPenjemputanList.isNotEmpty) ...[
                Text(
                  "Jadwal Penjemputan",
                  style: semiBold12.copyWith(color: textblack),
                ),
                const SizedBox(height: 12),
                ...jadwalPenjemputanList.map(
                  (schedule) => ScheduleCard(
                    time: schedule.jadwal,
                    date: schedule.tanggal,
                    name: schedule.name,
                    location: '${schedule.kecamatan}, ${schedule.alamat}',
                    onTap: () => _navigateToDetail(schedule),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              /// ===== RIWAYAT TERBARU =====
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Riwayat Terbaru",
                    style: semiBold12.copyWith(color: textblack),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RiwayatPage(
                            riwayatList: riwayatList,
                            onCardTap: _navigateToDetail,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Lihat Semua",
                      style: regular12.copyWith(color: blue1),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // tampilkan max 2 item di home
              ...riwayatList.take(2).map(
                (schedule) => ScheduleCard(
                  time: schedule.jadwal,
                  date: schedule.tanggal,
                  name: schedule.name,
                  location: '${schedule.kecamatan}, ${schedule.alamat}',
                  onTap: () => _navigateToDetail(schedule),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}