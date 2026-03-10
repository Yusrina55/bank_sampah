import 'package:bank_sampah/theme.dart';
import 'package:flutter/material.dart';
import '../petugas/Beranda/home_page_petugas.dart';
import '../petugas/Jadwal/main_schedule.dart';
import '../petugas/Transaksi/transaksi_page.dart';
import '../../../widgets/app_bottom_navbar.dart';

class MainPetugasPage extends StatefulWidget {
  const MainPetugasPage({super.key});

  @override
  State<MainPetugasPage> createState() => _MainPetugasPageState();
}

class _MainPetugasPageState extends State<MainPetugasPage> {
  int _currentIndex = 0;

  // List halaman yang akan ditampilkan
  final List<Widget> _pages = [
    HomePetugasPage(),
    SchedulePage(),
    TransaksiPage(), 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: _pages[_currentIndex],
      bottomNavigationBar: AppBottomNavbar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}