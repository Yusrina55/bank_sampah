import 'package:flutter/material.dart';
import '../../../../../theme.dart';
import '../../../../../widgets/app_back_button.dart';
import '../../../../../widgets/app_input.dart';
import '../../../../../widgets/app_button.dart';
import '../../../../../widgets/app_dropdown.dart';
import '../../../../../widgets/app_search.dart';

class CreateJadwalMitraPage extends StatefulWidget {
  const CreateJadwalMitraPage({super.key});

  @override
  State<CreateJadwalMitraPage> createState() =>
      _CreateJadwalMitraPageState();
}

class _CreateJadwalMitraPageState extends State<CreateJadwalMitraPage> {
  final TextEditingController _jenisSampahController = TextEditingController();
  final TextEditingController _namaMitraController = TextEditingController();
  final TextEditingController _beratController = TextEditingController();
  final TextEditingController _jadwalController = TextEditingController();

  static const List<String> _jenisSampahList = [
    'Plastik',
    'Elektronik',
    'Kertas',
    'Besi dan Logam',
    'Kaca',
  ];

  static const List<String> _mitraList = [
    'Pabrik Kertas A',
    'Pabrik Plastik A',
    'Pabrik Plastik B',
    'Pabrik Besi A',
    'Pabrik Besi B',
    'Toko Elektronik A',
  ];

  @override
  void dispose() {
    _jenisSampahController.dispose();
    _namaMitraController.dispose();
    _beratController.dispose();
    _jadwalController.dispose();
    super.dispose();
  }

  void _onAjukan() {
    // TODO: submit logic
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
          'Tambah Jadwal Mitra',
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
          AppDropdown(
            controller: _namaMitraController,
            label: 'Nama Mitra',
            hint: 'pilih mitra',
            items: _mitraList,
          ),
          const SizedBox(height: 16),

          /// BERAT / JUMLAH
          AppInput(
            label: 'Berat/Jumlah',
            hint: 'masukkan berat',
            controller: _beratController,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),

          /// JADWAL AMBIL
          Text('Jadwal Ambil', style: medium12), 
          const SizedBox(height: 8),
          AppDatePickerField(
            controller: _jadwalController,
            enabled: true,
            onDateSelected: (date) {},
          ),
          const SizedBox(height: 32),

          /// BUTTON AJUKAN
          AppButton(
            text: 'Ajukan',
            onPressed: _onAjukan,
          ),
        ],
      ),
    );
  }
}