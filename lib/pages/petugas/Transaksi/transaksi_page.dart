import 'package:flutter/material.dart';
import '../../../theme.dart';
import '../../../widgets/blue_balanced_card.dart';
import '../../../widgets/transaction_chart.dart';
import '../../../widgets/mitra_schedule_section.dart';
import '../../../widgets/transaction_menu_grid.dart';
import '../../../widgets/mitra_schedule_model.dart'; 
import 'package:bank_sampah/data/transaksi_repository.dart';

class TransaksiPage extends StatelessWidget {
  const TransaksiPage({super.key});

  // ✅ Tambahkan kembali dummy data mitra schedules
  static final List<Map<String, dynamic>> dummyMitraSchedules = [
    {
      "jenisSampah": "Kertas",
      "time": "10.00",
      "date": "20/12/2025",
      "name": "Pabrik Kertas",
      "weight": 50.0,
      "harga": 150000,
    },
    {
      "jenisSampah": "Plastik",
      "time": "12.00",
      "date": "21/12/2025",
      "name": "Pabrik Plastik",
      "weight": 30.0,
      "harga": 100000,
    },
  ];
  

  String get formattedBalance => TransaksiRepository.formatRupiah(
        TransaksiRepository.totalBalance,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            /// ===== BALANCE =====
            BlueBalanceCard(
              balance: formattedBalance,
            ),
            const SizedBox(height: 16),

            /// ===== MENU GRID =====
            const TransactionMenuGrid(),
            const SizedBox(height: 16),

            /// ===== CHART =====
            const TransactionChartSection(),
            const SizedBox(height: 16),

            /// ===== JADWAL MITRA =====
            MitraScheduleSection(
              schedules: dummyMitraSchedules,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}