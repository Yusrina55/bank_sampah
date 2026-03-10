import 'package:flutter/material.dart';
import '../theme.dart';

class MitraListCard extends StatelessWidget {
  final String name;
  final VoidCallback? onTap;

  const MitraListCard({
    super.key,
    required this.name,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: bordergrey),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: regular12.copyWith(color: textblack),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}