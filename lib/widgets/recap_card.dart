import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme.dart';
import '../pages/petugas/Transaksi/rekapitulasi/detail_recap_page.dart';

class RekapCard extends StatelessWidget {
  final String periode; // e.g. "2025, Desember"
  final String total;   // e.g. "700.000,00"
  final VoidCallback? onTap;

  const RekapCard({
    super.key,
    required this.periode,
    required this.total,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const DetailRekapitulasiPage()),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE0E0E0)),
        ),
        child: Row(
          children: [
            /// ===== CONTENT =====
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    periode,
                    style: regular12.copyWith(color: textgrey1),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/uang.svg',
                        width: 18,
                        height: 18,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        total,
                        style: semiBold14.copyWith(color: blue1),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// ===== ARROW =====
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}