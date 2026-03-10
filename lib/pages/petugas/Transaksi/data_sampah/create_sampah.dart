import 'package:flutter/material.dart';
import '../../../../theme.dart';
import '../../../../widgets/app_input.dart';
import '../../../../widgets/app_button.dart';

class CreateSampahBottomSheet extends StatefulWidget {
  const CreateSampahBottomSheet({super.key});

  @override
  State<CreateSampahBottomSheet> createState() =>
      _CreateSampahBottomSheetState();
}

class _CreateSampahBottomSheetState extends State<CreateSampahBottomSheet> {
  final TextEditingController _jenisSampahController = TextEditingController();

  @override
  void dispose() {
    _jenisSampahController.dispose();
    super.dispose();
  }

  void _onSimpan() {
    // TODO: save logic here
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.only(
        top: 12,
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ===== DRAG HANDLE =====
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),

          /// ===== TITLE =====
          Text(
            'Tambah Jenis Sampah',
            style: semiBold14.copyWith(color: textblack),
          ),
          const SizedBox(height: 24),

          /// ===== INPUT =====
          AppInput(
            label: 'Jenis Sampah',
            hint: 'Masukkan jenis sampah',
            controller: _jenisSampahController,
          ),
          const SizedBox(height: 24),

          /// ===== BUTTON =====
          AppButton(
            text: 'Simpan',
            onPressed: _onSimpan,
          ),
        ],
      ),
    );
  }
}

/// Helper function to show the bottom sheet
void showCreateSampahSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const CreateSampahBottomSheet(),
  );
}