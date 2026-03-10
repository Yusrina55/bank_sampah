import 'package:flutter/material.dart';
import '../theme.dart';
import 'app_input.dart';
import 'app_button.dart';

class RejectBottomSheet extends StatefulWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const RejectBottomSheet({
    super.key,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  State<RejectBottomSheet> createState() => _RejectBottomSheetState();
}

class _RejectBottomSheetState extends State<RejectBottomSheet> {

  final TextEditingController alasanController = TextEditingController();

  @override
  void dispose() {
    alasanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            const SizedBox(height: 20),

            Image.asset(
              "assets/images/warning.png",
              width: 80,
            ),

            const SizedBox(height: 16),

            Text(
              "Yakin tolak jadwal?",
              style: semiBold14.copyWith(color: textblack),
            ),

            const SizedBox(height: 16),

            AppInput(
              label: "Alasan",
              hint: "Masukkan alasan penolakan",
              controller: alasanController,
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: AppButton(
                    text: "Kembali",
                    isOutlined: true,
                    backgroundColor: blue2,
                    onPressed: widget.onCancel,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: AppButton(
                    text: "Tolak",
                    onPressed: widget.onConfirm,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
