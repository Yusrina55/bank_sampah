import 'package:flutter/material.dart';
import '../../../../../theme.dart';
import '../../../../../widgets/app_back_button.dart';
import '../../../../../widgets/app_input.dart';
import '../../../../../widgets/app_button.dart';
import '../../../../../widgets/app_dropdown.dart';

class CreateMitraPage extends StatefulWidget {
  const CreateMitraPage({super.key});

  @override
  State<CreateMitraPage> createState() => _CreateMitraPageState();
}

class _CreateMitraPageState extends State<CreateMitraPage> {
  final TextEditingController _jenisSampahController = TextEditingController();
  final TextEditingController _namaMitraController = TextEditingController();
  final TextEditingController _noTelpController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _kataSandiController = TextEditingController();

  bool _isPasswordVisible = false;

  static const List<String> _jenisSampahList = [
    'Plastik', 'Elektronik', 'Kertas', 'Besi dan Logam', 'Kaca',
  ];

  @override
  void dispose() {
    _jenisSampahController.dispose();
    _namaMitraController.dispose();
    _noTelpController.dispose();
    _alamatController.dispose();
    _kataSandiController.dispose();
    super.dispose();
  }

  void _onSimpan() {
    // TODO: save logic
    Navigator.pop(context);
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
          'Tambah Mitra',
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
          ),
          const SizedBox(height: 16),

          /// NAMA MITRA
          AppInput(
            label: 'Nama Mitra',
            hint: 'masukkan nama mitra',
            controller: _namaMitraController,
          ),
          const SizedBox(height: 16),

          /// NO TELEPON
          AppInput(
            label: 'No Telepon',
            hint: 'masukkan no telp',
            controller: _noTelpController,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),

          /// ALAMAT
          AppInput(
            label: 'Alamat',
            hint: 'masukkan alamat',
            controller: _alamatController,
          ),
          const SizedBox(height: 16),

          /// KATA SANDI
          AppInput(
            label: 'Kata Sandi',
            hint: 'masukkan kata sandi',
            controller: _kataSandiController,
            obscureText: !_isPasswordVisible,
            suffixIcon: GestureDetector(
              onTap: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
              child: Icon(
                _isPasswordVisible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                size: 20,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 32),

          /// BUTTON SIMPAN
          AppButton(
            text: 'Simpan',
            onPressed: _onSimpan,
          ),
        ],
      ),
    );
  }
}