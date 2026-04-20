import 'package:flutter/material.dart';
import '../theme.dart';
import 'app_button.dart';

class CancelBottomSheet extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const CancelBottomSheet({
    super.key,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// HANDLE
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          const SizedBox(height: 20),

          /// ICON
          Image.asset(
            "assets/images/warning.png",
            width: 80,
          ),

          const SizedBox(height: 16),

          /// TEXT
          Text(
            "Yakin membatalkan jadwal?",
            style: semiBold14.copyWith(color: textblack),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 24),

          /// BUTTONS
          Row(
            children: [
              Expanded(
                child: AppButton(
                  text: "Kembali",
                  isOutlined: true,
                  onPressed: onCancel,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppButton(
                  text: "Batalkan",
                  onPressed: onConfirm,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }
}