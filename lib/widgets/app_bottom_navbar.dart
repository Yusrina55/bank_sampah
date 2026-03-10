import 'package:flutter/material.dart';
import '../theme.dart';

class AppBottomNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AppBottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: bordergrey),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildItem(
            icon: Icons.home,
            label: "Beranda", 
            index: 0,
          ),
          _buildItem(
            icon: Icons.calendar_today,
            label: "Jadwal",
            index: 1,
          ),
          _buildItem(
            icon: Icons.payments,
            label: "Transaksi",
            index: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final bool isActive = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 26,
            color: isActive ? blue1 : Colors.grey,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: regular12.copyWith(
              color: isActive ? blue1 : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
