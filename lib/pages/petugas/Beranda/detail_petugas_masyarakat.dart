import 'package:flutter/material.dart';
import '../../../widgets/app_input.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_back_button.dart';
import '../../../widgets/app_kecamatan_dropdown.dart';
import '../../../widgets/app_berat_jenis.dart';
import '../../../models/schedule_model.dart';
import '../../../theme.dart';

class DetailPetugasMasyarakat extends StatefulWidget {
  final ScheduleModel schedule;
  final bool isHistory;
  final VoidCallback onBack;

  const DetailPetugasMasyarakat({
    super.key,
    required this.schedule,
    required this.isHistory,
    required this.onBack,
  });

  @override
  State<DetailPetugasMasyarakat> createState() =>
      _DetailPetugasMasyarakatPageState();
}

class _DetailPetugasMasyarakatPageState
    extends State<DetailPetugasMasyarakat> {

  late TextEditingController namaC;
  late TextEditingController kecamatanC;
  late TextEditingController tanggalC;
  late TextEditingController jadwalC;
  late TextEditingController statusC;
  late TextEditingController hargaC;

  late List<TextEditingController> jenisControllers;
  late List<TextEditingController> jumlahControllers;

  /// SEMUA READ ONLY (KHUSUS MASYARAKAT)
  bool get isReadOnly => true;

  @override
  void initState() {
    super.initState();

    namaC = TextEditingController(text: widget.schedule.name);
    kecamatanC = TextEditingController(text: widget.schedule.kecamatan);
    tanggalC = TextEditingController(text: widget.schedule.tanggal);
    jadwalC = TextEditingController(text: widget.schedule.jadwal);
    statusC = TextEditingController(text: widget.schedule.status);
    hargaC = TextEditingController(text: widget.schedule.harga ?? "");

    jenisControllers = widget.schedule.sampahList
        .map((e) => TextEditingController(text: e.jenis))
        .toList();

    jumlahControllers = widget.schedule.sampahList
        .map((e) => TextEditingController(text: e.berat ?? ""))
        .toList();
  }

  @override
  void dispose() {
    namaC.dispose();
    kecamatanC.dispose();
    tanggalC.dispose();
    jadwalC.dispose();
    statusC.dispose();
    hargaC.dispose();

    for (var c in jenisControllers) {
      c.dispose();
    }
    for (var c in jumlahControllers) {
      c.dispose();
    }

    super.dispose();
  }

  // ================= BUTTON =================

  Widget buildBottomButton() {
    return AppButton(
      text: "Bayar",
      onPressed: () {
        final harga = hargaC.text;

        if (harga.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Harga harus diisi")),
          );
          return;
        }
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

                      /// TANGGAL
                      AppInput(
                        label: "Tanggal",
                        hint: "",
                        controller: tanggalC,
                        readOnly: true,
                      ),

                      const SizedBox(height: 16),

                      /// JADWAL
                      AppInput(
                        label: "Ajuan Jadwal",
                        hint: "",
                        controller: jadwalC,
                        readOnly: true,
                      ),

                      const SizedBox(height: 16),

                      /// JENIS SAMPAH
                      Text(
                        "Jenis Sampah",
                        style: medium12,
                      ),

                      const SizedBox(height: 8),

                      ...List.generate(
                        jenisControllers.length,
                        (index) {
                          return AppBeratJenisField(
                            jenisController: jenisControllers[index],
                            jumlahController: jumlahControllers[index],
                            readOnly: true,
                            showDelete: false,
                          );
                        },
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