import 'package:flutter/material.dart';
import '../theme.dart';

class JadwalTabBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const JadwalTabBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = ["Pengaturan", "Penjemputan", "Pengajuan"];

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: filledgrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: List.generate(
          tabs.length,
          (index) => Expanded(
            child: GestureDetector(
              onTap: () => onTap(index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: selectedIndex == index ? blue1 : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    tabs[index],
                    style: medium12.copyWith(
                      color: selectedIndex == index
                          ? Colors.white
                          : textgrey2,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
