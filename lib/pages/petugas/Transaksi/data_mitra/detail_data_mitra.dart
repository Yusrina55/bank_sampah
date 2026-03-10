import 'package:flutter/material.dart';
import '../../../../../theme.dart';
import '../../../../../widgets/app_back_button.dart';
import '../../../../../widgets/app_input.dart';
import '../../../../../widgets/app_button.dart';
import '../../../../../widgets/app_dropdown.dart';
import '../../../../../widgets/delete_bottom_sheet.dart';

class DetailMitraPage extends StatefulWidget {
  final String jenisSampah;
  final String namaMitra;
  final String noTelp;
  final String alamat;

  const DetailMitraPage({
    super.key,
    required this.jenisSampah,
    required this.namaMitra,
    required this.noTelp,
    required this.alamat,
  });

  @override
  State<DetailMitraPage> createState() => _DetailMitraPageState();
}

class _DetailMitraPageState extends State<DetailMitraPage> {
  bool _isEditing = false;

  late TextEditingController _jenisSampahController;
  late TextEditingController _namaMitraController;
  late TextEditingController _noTelpController;
  late TextEditingController _alamatController;
  final TextEditingController _kataSandiController =
      TextEditingController(text: '•••••••');

  static const List<String> _jenisSampahList = [
    'Plastik', 'Elektronik', 'Kertas', 'Besi dan Logam', 'Kaca',
  ];

  @override
  void initState() {
    super.initState();
    _jenisSampahController = TextEditingController(text: widget.jenisSampah);
    _namaMitraController = TextEditingController(text: widget.namaMitra);
    _noTelpController = TextEditingController(text: widget.noTelp);
    _alamatController = TextEditingController(text: widget.alamat);
  }

  @override
  void dispose() {
    _jenisSampahController.dispose();
    _namaMitraController.dispose();
    _noTelpController.dispose();
    _alamatController.dispose();
    _kataSandiController.dispose();
    super.dispose();
  }

  void _onUbah() => setState(() => _isEditing = true);

  void _onSimpan() => setState(() => _isEditing = false);

  void _onHapus() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => DeleteConfirmBottomSheet(
        title: 'Yakin hapus data mitra?',
        cancelText: 'Kembali',
        confirmText: 'Hapus',
        onCancel: () => Navigator.pop(context), // tutup bottom sheet, kembali ke view
        onConfirm: () {
          Navigator.pop(context); // tutup bottom sheet
          Navigator.pop(context); // kembali ke mitra page tab data mitra
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
          'Detail Mitra',
          style: medium16.copyWith(color: blue1),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /// JENIS SAMPAH
          AppDropdown(
            controller: _jenisSampahController,
            label: 'Jenis Sampah',
            hint: 'pilih jenis',
            items: _jenisSampahList,
            readOnly: !_isEditing,
          ),
          const SizedBox(height: 16),

          /// NAMA MITRA
          AppInput(
            label: 'Nama Mitra',
            hint: 'masukkan nama mitra',
            controller: _namaMitraController,
            readOnly: !_isEditing,
          ),
          const SizedBox(height: 16),

          /// NO TELEPON
          AppInput(
            label: 'No Telepon',
            hint: 'masukkan no telp',
            controller: _noTelpController,
            readOnly: !_isEditing,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),

          /// ALAMAT
          AppInput(
            label: 'Alamat',
            hint: 'masukkan alamat',
            controller: _alamatController,
            readOnly: !_isEditing,
          ),
          const SizedBox(height: 16),

          /// KATA SANDI — selalu readonly & invisible
          AppInput(
            label: 'Kata Sandi',
            hint: 'masukkan kata sandi',
            controller: _kataSandiController,
            readOnly: true,
            obscureText: true,
            suffixIcon: const Icon(
              Icons.visibility_off_outlined,
              size: 20,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 32),

          /// BUTTONS
          Row(
            children: [
              Expanded(
                child: AppButton(
                  text: 'Hapus',
                  isOutlined: true,
                  onPressed: _onHapus,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppButton(
                  text: _isEditing ? 'Simpan' : 'Ubah',
                  onPressed: _isEditing ? _onSimpan : _onUbah,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}