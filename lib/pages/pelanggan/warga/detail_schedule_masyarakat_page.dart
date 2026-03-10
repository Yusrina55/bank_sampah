import 'package:flutter/material.dart';
import '../../../widgets/app_input.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_back_button.dart';
import '../../../widgets/app_kecamatan_dropdown.dart';
import '../../../widgets/app_berat_jenis.dart';
import '../../../models/schedule_model.dart';
import '../../../theme.dart';

enum DetailMode { view, edit }

class DetailScheduleMasyarakatPage extends StatefulWidget {
  final ScheduleModel schedule;
  final bool isHistory;
  final VoidCallback onBack;

  const DetailScheduleMasyarakatPage({
    super.key,
    required this.schedule,
    required this.isHistory,
    required this.onBack,
  });

  @override
  State<DetailScheduleMasyarakatPage> createState() =>
      _DetailScheduleMasyarakatPageState();
}

class _DetailScheduleMasyarakatPageState
    extends State<DetailScheduleMasyarakatPage> {

  late DetailMode mode;

  late TextEditingController namaC;
  late TextEditingController kecamatanC;
  late TextEditingController tanggalC;
  late TextEditingController jadwalC;
  late TextEditingController statusC;
  late TextEditingController hargaC;

  late List<TextEditingController> jenisControllers;
  late List<TextEditingController> jumlahControllers;

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            alwaysUse24HourFormat: true,
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final hour = picked.hour.toString().padLeft(2, '0');
      final minute = picked.minute.toString().padLeft(2, '0');

      setState(() {
        jadwalC.text = "$hour:$minute";
      });
    }
  }

  @override
  void initState() {
    super.initState();

    mode = DetailMode.view;

    namaC = TextEditingController(text: widget.schedule.name);
    kecamatanC =
        TextEditingController(text: widget.schedule.kecamatan);
    tanggalC =
        TextEditingController(text: widget.schedule.tanggal);
    jadwalC =
        TextEditingController(text: widget.schedule.jadwal);
    statusC =
        TextEditingController(text: widget.schedule.status);
    hargaC =
        TextEditingController(text: widget.schedule.harga ?? "");

    jenisControllers = widget.schedule.sampahList
        .map((e) => TextEditingController(text: e.jenis))
        .toList();

    jumlahControllers = widget.schedule.sampahList
        .map((e) => TextEditingController(text: e.berat ?? ""))
        .toList();
  }

  bool get isReadOnly =>
      widget.isHistory || mode == DetailMode.view;
  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        tanggalC.text =
            "${picked.day}-${picked.month}-${picked.year}";
      });
    }
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

  // ================= BUTTON SECTION =================

  Widget buildBottomButton() {

    /// HISTORY MODE (FULL READ ONLY)
    if (widget.isHistory) {
      return Row(
        children: [
          Expanded(
            child: AppButton(
              text: "Tidak",
              isOutlined: true,
              onPressed: widget.onBack,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: AppButton(
              text: "Sesuai",
              onPressed: widget.onBack,
            ),
          ),
        ],
      );
    }

    /// VIEW MODE
    if (mode == DetailMode.view) {
      return Row(
        children: [
          Expanded(
            child: AppButton(
              text: "Ubah",
              onPressed: () {
                setState(() {
                  mode = DetailMode.edit;
                });
              },
            ),
          ),
        ],
      );
    }

    /// EDIT MODE
    return Row(
      children: [
        Expanded(
          child: AppButton(
            text: "Kembali",
            isOutlined: true,
            onPressed: () {
              setState(() {
                mode = DetailMode.view;
              });
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: AppButton(
            text: "Simpan",
            onPressed: () {
              setState(() {
                mode = DetailMode.view;
              });
            },
          ),
        ),
      ],
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
                        readOnly: isReadOnly,
                      ),

                      const SizedBox(height: 16),

                      /// KECAMATAN
                      AppKecamatanDropdown(
                      controller: kecamatanC,
                      readOnly: isReadOnly,
                    ),

                      const SizedBox(height: 16),

                      /// TANGGAL
                      AppInput(
                        label: "Tanggal",
                        hint: "",
                        controller: tanggalC,
                        readOnly: true,
                        suffixIcon: isReadOnly
                            ? null
                            : const Icon(Icons.calendar_today),
                        onTap: isReadOnly ? null : _pickDate,
                      ),

                      const SizedBox(height: 16),

                      /// JADWAL
                      AppInput(
                        label: "Ajuan Jadwal",
                        hint: "",
                        controller: jadwalC,
                        readOnly: true, // selalu true supaya tidak bisa ketik
                        suffixIcon: (!isReadOnly)
                            ? const Icon(Icons.access_time)
                            : null,
                        onTap: (!isReadOnly)
                            ? _pickTime
                            : null,
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
                            showDelete: !isReadOnly,
                            readOnly: isReadOnly, // ✅ TAMBAHAN
                            onDelete: isReadOnly
                                ? null
                                : () {
                                    setState(() {
                                      jenisControllers.removeAt(index);
                                      jumlahControllers.removeAt(index);
                                    });
                                  },
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

                      /// HARGA
                      if (widget.isHistory) ...[
                        const SizedBox(height: 16),

                        AppInput(
                          label: "Harga",
                          hint: "",
                          controller: hargaC,
                          readOnly: true,
                        ),
                      ],

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
