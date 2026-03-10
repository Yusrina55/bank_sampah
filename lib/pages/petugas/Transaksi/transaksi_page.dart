import 'package:flutter/material.dart';
import '../../../theme.dart';
import '../../../widgets/blue_balanced_card.dart';
import '../../../widgets/transaction_chart.dart';
import '../../../widgets/mitra_schedule_section.dart';
import '../../../widgets/transaction_menu_grid.dart';

class TransaksiPage extends StatelessWidget {
  const TransaksiPage({super.key});

  /// ================== DUMMY DATA ==================
  static final List<Map<String, dynamic>> dummyMitraSchedules = [
    {
      "time": "10.00",
      "date": "11/12/2025",
      "weight": 25.0,
    },
    {
      "time": "13.00",
      "date": "12/12/2025",
      "weight": 40.0,
    },
    {
      "time": "15.00",
      "date": "13/12/2025",
      "weight": 18.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [

            /// ===== BALANCE =====
            const BlueBalanceCard(
              balance: "350.000,00",
            ),

            const SizedBox(height: 16),

            /// ===== MENU GRID (NANTI) =====
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