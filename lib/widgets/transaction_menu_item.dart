import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme.dart';

class TransactionMenuItem extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;

  const TransactionMenuItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: bordergrey),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// ICON BACKGROUND
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: blue2,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: SvgPicture.asset(
                  icon,
                  width: 18,
                  height: 18,
                ),
              ),
            ),

            const SizedBox(width: 8),

            /// TEXT
            Text(
              label,
              style: medium12.copyWith(color: textblack),
            ),
          ],
        ),
      ),
    );
  }
}