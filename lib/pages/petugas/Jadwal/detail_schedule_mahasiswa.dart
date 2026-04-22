import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../widgets/app_input.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_back_button.dart';
import '../../../widgets/app_jenis_sampah_dropdown.dart';
import '../../../widgets/app_kecamatan_dropdown.dart';
import '../../../widgets/app_schedule_field.dart';
import '../../../theme.dart';
import '../../../models/schedule_model.dart';

class DetailSchedulePage extends StatefulWidget {
  final ScheduleModel schedule;
  final bool isHistory;
  final VoidCallback onBack;

  const DetailSchedulePage({
    super.key,
    required this.schedule,
    required this.isHistory,
    required this.onBack,
  });

  @override
  State<DetailSchedulePage> createState() =>
      _DetailScheduleMahasiswaPageState();
}

class _DetailScheduleMahasiswaPageState
    extends State<DetailSchedulePage> {

  late TextEditingController namaC;
  late TextEditingController kecamatanC;
  late TextEditingController alamatC;
  late TextEditingController tanggalC;
  late TextEditingController jadwalC;
  late TextEditingController statusC;
  late TextEditingController hargaC;
  late TextEditingController jenisC;

  /// LIST JADWAL (tetap dipakai hanya untuk display)
  final List<String> scheduleList = [
    "08.00 - 10.00",
    "14.00 - 16.00",
  ];

  /// SEMUA READ ONLY (KHUSUS MAHASISWA)
  bool get isReadOnly => true;

  @override
  void initState() {
    super.initState();

    namaC = TextEditingController(text: widget.schedule.name);
    kecamatanC = TextEditingController(text: widget.schedule.kecamatan);
    alamatC = TextEditingController(text: widget.schedule.alamat);
    tanggalC = TextEditingController(text: widget.schedule.tanggal);
    jadwalC = TextEditingController(text: widget.schedule.jadwal);
    statusC = TextEditingController(text: widget.schedule.status);
    hargaC = TextEditingController(text: widget.schedule.harga ?? "");
    jenisC = TextEditingController(
      text: widget.schedule.sampahList.isNotEmpty
          ? widget.schedule.sampahList.first.jenis
          : "",
    );
  }

  @override
  void dispose() {
    namaC.dispose();
    kecamatanC.dispose();
    alamatC.dispose();
    tanggalC.dispose();
    jadwalC.dispose();
    statusC.dispose();
    hargaC.dispose();
    jenisC.dispose();
    super.dispose();
  }

  // ================= BUTTON =================

  Widget buildBottomButton() {
    return AppButton(
      text: "Bayar",
      onPressed: () {
        if (hargaC.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Harga harus diisi")),
          );
          return;
        }

        // ✅ Tutup keyboard dulu, lalu back
        FocusScope.of(context).unfocus();
        Navigator.pop(context);
      },
    );
  }

  // ================= UI =================

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [

                /// HEADER
                Row(
                  children: [
                    AppBackButton(onTap: widget.onBack),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Center(
                        child: Text(
                          "Detail Jadwal",
                          style: medium16.copyWith(color: blue1),
                        ),
                      ),
                    ),
                    const SizedBox(width: 36),
                  ],
                ),

                const SizedBox(height: 24),

                Expanded(
                  child: ListView(
                    children: [

                      /// NAMA
                      AppInput(
                        label: "Nama",
                        hint: "",
                        controller: namaC,
                        readOnly: true,
                      ),

                      const SizedBox(height: 16),

                      /// KECAMATAN
                      AppKecamatanDropdown(
                        controller: kecamatanC,
                        readOnly: true,
                      ),

                      const SizedBox(height: 16),

                      /// ALAMAT
                      AppInput(
                        label: "Alamat",
                        hint: "",
                        controller: alamatC,
                        readOnly: true,
                      ),

                      const SizedBox(height: 16),

                      /// TANGGAL
                      AppInput(
                        label: "Tanggal",
                        hint: "",
                        controller: tanggalC,
                        readOnly: true,
                      ),

                      const SizedBox(height: 16),

                      /// JADWAL
                      AppScheduleField(
                        controller: jadwalC,
                        scheduleList: scheduleList,
                        readOnly: true,
                      ),

                      const SizedBox(height: 16),

                      /// JENIS SAMPAH
                      AppJenisSampahDropdown(
                        controller: jenisC,
                        label: "Jenis Sampah",
                        readOnly: true,
                      ),

                      const SizedBox(height: 16),

                      /// STATUS
                      AppInput(
                        label: "Status",
                        hint: "",
                        controller: statusC,
                        readOnly: true,
                      ),

                      const SizedBox(height: 16),

                      /// HARGA (SATU-SATUNYA EDITABLE)
                      AppInput(
                        label: "Harga",
                        hint: "Masukkan harga",
                        controller: hargaC,
                        readOnly: false,
                        keyboardType: TextInputType.number,          // ✅ keyboard angka
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,    // ✅ hanya angka, no huruf/simbol
                        ],
                      ),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),

                buildBottomButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}