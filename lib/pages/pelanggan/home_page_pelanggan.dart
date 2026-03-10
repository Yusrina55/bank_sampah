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

enum HomeViewMode { list, detail }

class HomePagePelanggan extends StatefulWidget {
  const HomePagePelanggan({super.key});

  @override
  State<HomePagePelanggan> createState() => _HomePagePelangganState();
}

class _HomePagePelangganState extends State<HomePagePelanggan> {

  HomeViewMode _mode = HomeViewMode.list;
  ScheduleModel? _selectedSchedule;

  final List<ScheduleModel> jadwalList = const [
    ScheduleModel(
      name: "Rina",
      kecamatan: "Tegalgede",
      tanggal: "13-02-2026",
      jadwal: "08.00 - 10.00",
      status: "Diproses",
      customerType: CustomerType.mahasiswa,
      sampahList: [
        SampahItem(jenis: "Kertas"),
      ],
    ),
    ScheduleModel(
      name: "Budi",
      kecamatan: "Sumbersari",
      tanggal: "20-01-2026",
      jadwal: "11.00",
      status: "Diproses",
      harga: "-",
      customerType: CustomerType.masyarakat,
      sampahList: [
        SampahItem(jenis: "Plastik", berat: "2 kg"),
        SampahItem(jenis: "Kertas", berat: "1 kg"),
      ],
    ),
  ];

  final List<ScheduleModel> riwayatList = const [
    ScheduleModel(
      name: "Rina",
      kecamatan: "Tegalgede",
      tanggal: "13-01-2026",
      jadwal: "08.00 - 10.00",
      status: "Dijemput",
      harga: "15.000",
      customerType: CustomerType.mahasiswa,
      sampahList: [
        SampahItem(jenis: "Plastik"),
      ],
    ),
    ScheduleModel(
      name: "Budi",
      kecamatan: "Sumbersari",
      tanggal: "20-01-2026",
      jadwal: "09.00",
      status: "Dijemput",
      harga: "100.000",
      customerType: CustomerType.masyarakat,
      sampahList: [
        SampahItem(jenis: "Plastik", berat: "2 kg"),
        SampahItem(jenis: "Kertas", berat: "1 kg"),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    if (_mode == HomeViewMode.list) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                //header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Selamat Datang,",
                          style: semiBold14.copyWith(
                            color: textblack,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Rina",
                          style: semiBold14.copyWith(
                            color: blue1,
                          ),
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
                    )
                  ],
                ),

                const SizedBox(height: 16),


                // BLUE BALANCE CARD
                BlueBalanceCard(
                  balance: "450.000",
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

                Text("Jadwal Dibuat",
                  style: semiBold12.copyWith(color: textblack)),
                const SizedBox(height: 12),

                ...jadwalList.map((schedule) {
                  return ScheduleCard(
                    time: schedule.jadwal,
                    date: schedule.tanggal,
                    name: schedule.name,
                    location: schedule.kecamatan,
                    onTap: () {
                      setState(() {
                        _mode = HomeViewMode.detail;
                        _selectedSchedule = schedule;
                      });
                    },
                  );
                }).toList(),

                const SizedBox(height: 16),

                Text("Riwayat Terbaru",
                    style: semiBold12.copyWith(color: textblack)),

                const SizedBox(height: 12),

                ...riwayatList.map((schedule) {
                  return ScheduleCard(
                    time: schedule.jadwal,
                    date: schedule.tanggal,
                    name: schedule.name,
                    location: schedule.kecamatan,
                    onTap: () {
                      setState(() {
                        _mode = HomeViewMode.detail;
                        _selectedSchedule = schedule;
                      });
                    },
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      );
    } 
    if (_selectedSchedule!.customerType == CustomerType.mahasiswa) {
      return DetailSchedulePage(
        schedule: _selectedSchedule!,
        isHistory: riwayatList.contains(_selectedSchedule),
        onBack: () {
          setState(() {
            _mode = HomeViewMode.list;
            _selectedSchedule = null;
          });
        },
      );
    } else {
      return DetailScheduleMasyarakatPage(
        schedule: _selectedSchedule!,
        isHistory: riwayatList.contains(_selectedSchedule),
        onBack: () {
          setState(() {
            _mode = HomeViewMode.list;
            _selectedSchedule = null;
          });
        },
      );
    }

  }
}
