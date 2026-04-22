import 'package:flutter/material.dart';
import '../../../widgets/app_input.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_back_button.dart';
import '../../../widgets/app_kecamatan_dropdown.dart';
import '../../../widgets/app_berat_jenis.dart';
import '../../../models/schedule_model.dart';
import '../../../theme.dart';
import '../../../widgets/reject_bottom_sheet.dart';

class DetailRequestedSchedulePage extends StatelessWidget {
  final ScheduleModel schedule;
  final VoidCallback onBack;

  const DetailRequestedSchedulePage({
    super.key,
    required this.schedule,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final namaC = TextEditingController(text: schedule.name);
    final kecamatanC = TextEditingController(text: schedule.kecamatan);
    final alamatC = TextEditingController(text: schedule.alamat);
    final tanggalC = TextEditingController(text: schedule.tanggal);
    final jadwalC = TextEditingController(text: schedule.jadwal);
    final statusC = TextEditingController(text: schedule.status);

    final jenisControllers = schedule.sampahList
        .map((e) => TextEditingController(text: e.jenis))
        .toList();

    final beratControllers = schedule.sampahList
        .map((e) => TextEditingController(text: e.berat ?? ""))
        .toList();

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
                  AppBackButton(onTap: onBack),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Detail Permintaan",
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
                      readOnly: true,
                    ),

                    const SizedBox(height: 16),

                    AppKecamatanDropdown(
                      controller: kecamatanC,
                      readOnly: true,
                    ),

                    const SizedBox(height: 16),

                    AppInput(
                      label: "Alamat",
                      hint: "",
                      controller: alamatC,
                      readOnly: true,
                    ),

                    const SizedBox(height: 16),

                    AppInput(
                      label: "Tanggal",
                      hint: "",
                      controller: tanggalC,
                      readOnly: true,
                    ),

                    const SizedBox(height: 16),

                    AppInput(
                      label: "Jam Penjemputan",
                      hint: "",
                      controller: jadwalC,
                      readOnly: true,
                    ),

                    const SizedBox(height: 16),

                    Text("Jenis Sampah", style: medium12),
                    const SizedBox(height: 8),

                    ...List.generate(jenisControllers.length, (index) {
                      return AppBeratJenisField(
                        jenisController: jenisControllers[index],
                        jumlahController: beratControllers[index],
                        readOnly: true,
                        showDelete: false,
                      );
                    }),

                    const SizedBox(height: 16),

                    AppInput(
                      label: "Status",
                      hint: "",
                      controller: statusC,
                      readOnly: true,
                    ),
                  ],
                ),
              ),

              /// ACTION BUTTON
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      text: "Tolak",
                      isOutlined: true,
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) {
                            return RejectBottomSheet(
                              onCancel: () {
                                Navigator.pop(context); // tutup bottom sheet
                              },
                              onConfirm: () {
                                Navigator.pop(context); // tutup bottom sheet
                                Navigator.pop(context); // kembali ke list request
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AppButton(
                      text: "Setuju",
                      onPressed: onBack,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}