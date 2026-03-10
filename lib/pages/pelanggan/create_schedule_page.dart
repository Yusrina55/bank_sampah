import 'package:flutter/material.dart';
import '../../widgets/app_input.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_back_button.dart';
import '../../widgets/app_kecamatan_dropdown.dart';
import 'mahasiswa/choose_schedule_screen.dart';
import 'warga/request_schedule.dart';
import '../../theme.dart';

class CreateSchedulePage extends StatefulWidget {
  const CreateSchedulePage({super.key});

  @override
  State<CreateSchedulePage> createState() => _CreateSchedulePageState();
}

class _CreateSchedulePageState extends State<CreateSchedulePage> {
  String selectedJenis = "Mahasiswa";

  final namaController = TextEditingController();
  final kecamatanController = TextEditingController();
  final alamatController = TextEditingController();
  final tanggalController = TextEditingController();

  // ================= DATE PICKER =================
  Future<void> pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );

    if (picked != null) {
      tanggalController.text =
          "${picked.day.toString().padLeft(2, '0')}-"
          "${picked.month.toString().padLeft(2, '0')}-"
          "${picked.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const Padding(
            padding: EdgeInsets.only(left: 20),
            child: AppBackButton(),
          ),
          centerTitle: true,
          title: Text(
            "Buat Jadwal",
            style: medium16.copyWith(color: blue1),
          ),
        ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // ================= DROPDOWN =================
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Jenis Pelanggan", style: medium12),
                  const SizedBox(height: 8),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<String>(
                      value: selectedJenis,
                      isExpanded: true,
                      underline: const SizedBox(),
                      items: ["Mahasiswa", "Masyarakat dan Usaha"]
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e, style: regular12),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedJenis = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // ================= COMMON FIELD =================
              AppInput(
                label: "Nama",
                hint: "masukkan nama",
                controller: namaController,
              ),

              const SizedBox(height: 16),

              AppKecamatanDropdown(
                controller: kecamatanController,
              ),

              const SizedBox(height: 16),

              AppInput(
                label: "Alamat Lengkap",
                hint: "masukkan alamat",
                controller: alamatController,
              ),

              const SizedBox(height: 16),

              // ================= FIELD KHUSUS MASYARAKAT =================
              if (selectedJenis == "Mahasiswa") ...[
                AppInput(
                  label: "Tanggal",
                  hint: "dd-mm-yyyy",
                  controller: tanggalController,
                  readOnly: true,
                  onTap: pickDate,
                  suffixIcon: const Icon(Icons.calendar_today),
                ),

                const SizedBox(height: 24),
              ] else
                const SizedBox(height: 24),

              // ================= BUTTON =================
              AppButton(
                text: selectedJenis == "Mahasiswa"
                    ? "Cari Jadwal"
                    : "Lanjut",

                onPressed: () {
                  if (selectedJenis == "Mahasiswa") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChooseScheduleScreen(),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RequestSchedulePage(),
                      ),
                    );
                    // Navigasi lain kalau bukan mahasiswa
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
