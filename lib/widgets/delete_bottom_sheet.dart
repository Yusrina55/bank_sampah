import 'package:flutter/material.dart';
import '../theme.dart';
import 'app_button.dart';

class DeleteConfirmBottomSheet extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final String title;
  final String cancelText;
  final String confirmText;

  const DeleteConfirmBottomSheet({
    super.key,
    required this.onConfirm,
    required this.onCancel,
    this.title = "Yakin Hapus Data?",
    this.cancelText = "Batal",
    this.confirmText = "Hapus",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            /// Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            const SizedBox(height: 24),

            /// Icon
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.delete_outline,
                color: Colors.red,
                size: 36,
              ),
            ),

            const SizedBox(height: 22),

            /// Title
            Text(
              title,
              style: semiBold14.copyWith(color: textblack),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 22),

            /// Buttons
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    text: cancelText,
                    isOutlined: true,
                    onPressed: onCancel,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppButton(
                    text: confirmText,
                    onPressed: onConfirm,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}