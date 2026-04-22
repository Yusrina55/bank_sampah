import 'package:flutter/material.dart';
import '../../../../../theme.dart';
import '../../../../../widgets/app_back_button.dart';
import '../../../../../widgets/app_input.dart';
import '../../../../../widgets/app_button.dart';
import '../../../../../widgets/app_dropdown.dart';
import '../../../../../widgets/app_search.dart';
import '../../../../../widgets/delete_bottom_sheet.dart';

enum JadwalDetailMode {
  jadwalMitra,
  ajuanJadwal,
  riwayat,
}

class DetailJadwalMitraPage extends StatefulWidget {
  final JadwalDetailMode mode;
  final String jenisSampah;
  final String namaMitra;
  final String berat;
  final String jadwalAmbil;
  final String time;
  final String status;
  final String? alasanTolak;
  final String? harga;

  const DetailJadwalMitraPage({
    super.key,
    required this.mode,
    required this.jenisSampah,
    required this.namaMitra,
    required this.berat,
    required this.jadwalAmbil,
    required this.time,
    required this.status,
    this.alasanTolak,
    this.harga,
  });

  @override
  State<DetailJadwalMitraPage> createState() => _DetailJadwalMitraPageState();
}

class _DetailJadwalMitraPageState extends State<DetailJadwalMitraPage> {
  late bool _isEditing;

  late TextEditingController _jenisSampahController;
  late TextEditingController _namaMitraController;
  late TextEditingController _beratController;
  late TextEditingController _jadwalController;
  late TextEditingController _timeController;
  late TextEditingController _statusController;
  late TextEditingController _alasanTolakController;
  late TextEditingController _hargaController;

  static const List<String> _jenisSampahList = [
    'Plastik', 'Elektronik', 'Kertas', 'Besi dan Logam', 'Kaca',
  ];

  static const List<String> _mitraList = [
    'Pabrik Kertas A', 'Pabrik Plastik A', 'Pabrik Plastik B',
    'Pabrik Besi A', 'Pabrik Besi B', 'Toko Elektronik A',
  ];

  static const List<String> _statusList = [
    'Menunggu Persetujuan', 'Setuju', 'Selesai', 'Ditolak',
  ];

  // ✅ cek ditolak dari widget.status
  bool get _isDitolak =>
      widget.status == "Ditolak" ||
      (widget.alasanTolak != null && widget.alasanTolak!.isNotEmpty);

  @override
  void initState() {
    super.initState();
    _isEditing = false;
    _jenisSampahController = TextEditingController(text: widget.jenisSampah);
    _namaMitraController = TextEditingController(text: widget.namaMitra);
    _beratController = TextEditingController(text: widget.berat);
    _jadwalController = TextEditingController(text: widget.jadwalAmbil);
    _timeController = TextEditingController(text: widget.time);
    _statusController = TextEditingController(text: widget.status);
    _alasanTolakController = TextEditingController(text: widget.alasanTolak ?? "");
    _hargaController = TextEditingController(text: widget.harga ?? "");
  }

  @override
  void dispose() {
    _jenisSampahController.dispose();
    _namaMitraController.dispose();
    _beratController.dispose();
    _jadwalController.dispose();
    _timeController.dispose();
    _statusController.dispose();
    _alasanTolakController.dispose();
    _hargaController.dispose();
    super.dispose();
  }

  String get _title {
    switch (widget.mode) {
      case JadwalDetailMode.jadwalMitra:
        return 'Detail Jadwal Mitra';
      case JadwalDetailMode.ajuanJadwal:
        return 'Detail Ajuan Jadwal';
      case JadwalDetailMode.riwayat:
        return 'Detail Jadwal Mitra';
    }
  }

  bool get _isFieldEditable {
    if (widget.mode == JadwalDetailMode.ajuanJadwal) return _isEditing;
    return false;
  }

  void _onUbah() => setState(() => _isEditing = true);
  void _onSimpan() => setState(() => _isEditing = false);

  void _onBatalkan() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => DeleteConfirmBottomSheet(
        title: 'Yakin membatalkan ajuan jadwal mitra?',
        cancelText: 'Kembali',
        confirmText: 'Batalkan',
        onCancel: () => Navigator.pop(context),
        onConfirm: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _onBayar() {
    if (_hargaController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harga harus diisi')),
      );
      return;
    }
    Navigator.pop(context);
  }

  // ================= BOTTOM BUTTON =================

  Widget _buildBottomButton() {
    /// Jadwal Mitra: tombol Bayar
    if (widget.mode == JadwalDetailMode.jadwalMitra) {
      return AppButton(
        text: 'Bayar',
        onPressed: _onBayar,
      );
    }

    /// Ajuan Jadwal: sembunyikan jika ditolak ✅
    if (widget.mode == JadwalDetailMode.ajuanJadwal) {
      if (_isDitolak) return const SizedBox.shrink();
      return Row(
        children: [
          Expanded(
            child: AppButton(
              text: 'Batalkan',
              isOutlined: true,
              onPressed: _onBatalkan,
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
      );
    }

    /// Riwayat: tidak ada tombol
    return const SizedBox.shrink();
  }

  // ================= UI =================

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
          _title,
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
            readOnly: true,
          ),
          const SizedBox(height: 16),

          /// NAMA MITRA
          AppDropdown(
            controller: _namaMitraController,
            label: 'Nama Mitra',
            hint: 'pilih mitra',
            items: _mitraList,
            readOnly: true,
          ),
          const SizedBox(height: 16),

          /// TANGGAL
          Text('Tanggal', style: medium12),
          const SizedBox(height: 8),
          AppDatePickerField(
            controller: _jadwalController,
            enabled: _isFieldEditable,
            onDateSelected: (date) {},
          ),
          const SizedBox(height: 16),

          /// JAM
          AppInput(
            label: 'Jam',
            hint: 'masukkan jam',
            controller: _timeController,
            readOnly: true, // atau false kalau mau editable
          ),
          const SizedBox(height: 16),

          /// BERAT / JUMLAH
          AppInput(
            label: 'Berat Sampah',
            hint: 'masukkan berat',
            controller: _beratController,
            readOnly: !_isFieldEditable,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),

          /// STATUS
          AppDropdown(
            controller: _statusController,
            label: 'Status',
            hint: 'pilih status',
            items: _statusList,
            readOnly: true,
          ),

          // ✅ ALASAN PENOLAKAN — tampil jika ditolak
          if (_isDitolak) ...[
            const SizedBox(height: 16),
            AppInput(
              label: 'Alasan Penolakan',
              hint: '',
              controller: _alasanTolakController,
              readOnly: true,
            ),
          ],

          /// HARGA — hanya untuk jadwalMitra & riwayat
          if (widget.mode == JadwalDetailMode.jadwalMitra ||
              widget.mode == JadwalDetailMode.riwayat) ...[
            const SizedBox(height: 16),
            AppInput(
              label: 'Harga',
              hint: 'masukkan harga',
              controller: _hargaController,
              readOnly: widget.mode == JadwalDetailMode.riwayat,
              keyboardType: TextInputType.number,
            ),
          ],

          const SizedBox(height: 32),

          /// BUTTONS
          _buildBottomButton(),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}