import 'package:flutter/material.dart';
import '../theme.dart';

class BlueBalanceCard extends StatelessWidget {
  final String balance;
  final VoidCallback? onCreateSchedule;

  const BlueBalanceCard({
    super.key,
    required this.balance,
    this.onCreateSchedule,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: blue1,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Opacity(
              opacity: 1,
              child: Image.asset(
                'assets/images/banner.png',
                width: 115,
                fit: BoxFit.contain,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Total Riwayat Transaksi",
                  style: medium12.copyWith(color: white),
                ),

                const SizedBox(height: 8),

                Text(
                  balance,
                  style: semiBold24.copyWith(color: white),
                ),

                /// Tombol hanya muncul jika ada onCreateSchedule
                if (onCreateSchedule != null) ...[
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 130,
                    height: 38,
                    child: ElevatedButton(
                      onPressed: onCreateSchedule,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: blue2,
                        foregroundColor: blue1,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: const Text(
                        "Buat Jadwal",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          )
        ],
      ),
    );
  }
}
