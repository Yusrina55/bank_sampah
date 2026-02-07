import 'package:flutter/material.dart';
import '../theme.dart';

class BlueBalanceCard extends StatelessWidget {
  final VoidCallback onCreateSchedule;
  const BlueBalanceCard({
    super.key,
    required this.onCreateSchedule,
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
          // Pattern image
          Align(
            alignment: Alignment.centerRight,
            child: Opacity(
              opacity: 1,
              child: Image.asset(
                'assets/images/banner.png',
                width: 120,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // CONTENT
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Total Riwayat Saldo",
                  style: medium12.copyWith(
                    color: white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "45.000,00",
                  style: semiBold24.copyWith(
                    color: white,
                  ),
                ),

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
            ),
          )
        ],
      ),
    );
  }
}
