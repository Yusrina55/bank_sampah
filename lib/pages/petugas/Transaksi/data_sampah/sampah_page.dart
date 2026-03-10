import 'package:flutter/material.dart';
import '../../../../theme.dart';
import '../../../../widgets/app_back_button.dart';
import '../../../../widgets/app_input.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/delete_bottom_sheet.dart'; 
import 'create_sampah.dart';

class SampahPage extends StatelessWidget {
  const SampahPage({super.key});

  static final List<String> dummyJenisSampah = [
    'Plastik',
    'Kertas',
    'Besi dan Logam',
    'Elektronik',
  ];

  // tambah method ini
  void _showDeleteSheet(BuildContext context, String jenis) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => DeleteConfirmBottomSheet(
        title: 'Yakin hapus data sampah?',
        onCancel: () => Navigator.pop(context),
        onConfirm: () {
          Navigator.pop(context);
          // TODO: delete logic untuk $jenis
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: AppBackButton(
            onTap: () => Navigator.pop(context),
          ),
        ),
        title: Text(
          'Data Sampah',
          style: medium16.copyWith(color: blue1),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /// ===== HEADER ROW =====
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Jenis Sampah',
                style: semiBold14.copyWith(color: textblack),
              ),
              SizedBox(
                width: 140,
                child: AppButton(
                  text: 'Tambah',
                  onPressed: () => showCreateSampahSheet(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          /// ===== LIST JENIS SAMPAH =====
          ...dummyJenisSampah.map(
            (jenis) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Expanded(
                    child: AppInput(
                      label: '',
                      hint: jenis,
                      readOnly: true,
                      controller: TextEditingController(text: jenis),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => _showDeleteSheet(context, jenis), // isi onTap ini
                    child: Container(
                      width: 44,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEE2E2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.delete,
                        color: Color(0xFFDC2626),
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}