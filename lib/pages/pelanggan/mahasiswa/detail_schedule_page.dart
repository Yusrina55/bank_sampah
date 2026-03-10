import 'package:flutter/material.dart';
import '../../../widgets/app_input.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_back_button.dart';
import '../../../widgets/app_jenis_sampah_dropdown.dart';
import '../../../widgets/app_kecamatan_dropdown.dart';
import '../../../widgets/app_schedule_field.dart';
import '../../../theme.dart';
import '../../../models/schedule_model.dart';

enum DetailMode { view, edit }

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

  late DetailMode mode;

  late TextEditingController namaC;
  late TextEditingController kecamatanC;
  late TextEditingController tanggalC;
  late TextEditingController jadwalC;
  late TextEditingController statusC;
  late TextEditingController hargaC;
  late TextEditingController jenisC;

  /// LIST JADWAL
  final List<String> scheduleList = [
    "08.00 - 10.00",
    "14.00 - 16.00",
  ];

  @override
  void initState() {
    super.initState();

    mode = DetailMode.view;

    namaC = TextEditingController(text: widget.schedule.name);
    kecamatanC = TextEditingController(text: widget.schedule.kecamatan);
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

  bool get isReadOnly =>
      widget.isHistory || mode == DetailMode.view;

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(tanggalC.text) ?? DateTime.now(),
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
  Widget build(BuildContext context) {
    return Scaffold(
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

                    AppInput(
                      label: "Nama",
                      hint: "",
                      controller: namaC,
                      readOnly: isReadOnly,
                    ),

                    const SizedBox(height: 16),

                    AppKecamatanDropdown(
                      controller: kecamatanC,
                      readOnly: isReadOnly,
                    ),

                    const SizedBox(height: 16),

                    AppInput(
                      label: "Tanggal",
                      hint: "",
                      controller: tanggalC,
                      readOnly: true, // selalu true supaya tidak bisa ketik manual
                      suffixIcon: isReadOnly
                          ? null
                          : const Icon(Icons.calendar_today),
                      onTap: isReadOnly ? null : _pickDate,
                    ),

                    const SizedBox(height: 16),

                    AppScheduleField(
                      controller: jadwalC,
                      scheduleList: scheduleList,
                      readOnly: isReadOnly,
                    ),

                    const SizedBox(height: 16),

                    AppJenisSampahDropdown(
                      controller: jenisC,
                      label: "Jenis Sampah",
                      readOnly: isReadOnly,
                    ),

                    const SizedBox(height: 16),

                    AppInput(
                      label: "Status",
                      hint: "",
                      controller: statusC,
                      readOnly: true,
                    ),

                    if (widget.isHistory) ...[
                      const SizedBox(height: 16),
                      AppInput(
                        label: "Harga",
                        hint: "",
                        controller: hargaC,
                        readOnly: true,
                      ),
                    ],
                  ],
                ),
              ),

              /// BUTTON
              if (widget.isHistory)
                Row(
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
                )
              else if (mode == DetailMode.view)
                Row(
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
                )
              else
                Row(
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
                )
            ],
          ),
        ),
      ),
    );
  }
}
