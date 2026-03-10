import 'package:flutter/material.dart';
import '../../../theme.dart';
import '../../../widgets/app_input.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_back_button.dart';
import '../../../widgets/app_kecamatan_dropdown.dart';

class DetailJadwalPage extends StatefulWidget {
  final String kecamatan;
  final String tanggal;

  const DetailJadwalPage({
    super.key,
    required this.kecamatan,
    required this.tanggal,
  });

  @override
  State<DetailJadwalPage> createState() => _DetailJadwalPageState();
}

class _DetailJadwalPageState extends State<DetailJadwalPage> {
  late TextEditingController kecamatanController;
  late TextEditingController tanggalController;

  bool isEditMode = false;

  @override
  void initState() {
    super.initState();
    kecamatanController =
        TextEditingController(text: widget.kecamatan);
    tanggalController =
        TextEditingController(text: widget.tanggal);
  }

  @override
  void dispose() {
    kecamatanController.dispose();
    tanggalController.dispose();
    super.dispose();
  }

  /// =========================
  /// PICK DATE AND TIME
  /// ========================
  Future<void> _pickDateTime() async {
    if (!isEditMode) return;

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (pickedDate == null) return;

    TimeOfDay? startTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (startTime == null) return;

    TimeOfDay? endTime = await showTimePicker(
      context: context,
      initialTime: startTime,
    );

    if (endTime == null) return;

    final formatted =
        "${pickedDate.day.toString().padLeft(2, '0')}-"
        "${pickedDate.month.toString().padLeft(2, '0')}-"
        "${pickedDate.year} "
        "${startTime.format(context)} - "
        "${endTime.format(context)}";

    setState(() {
      tanggalController.text = formatted;
    });
  }

  /// =========================
  /// DELETE CONFIRMATION
  /// =========================
  void _showDeleteConfirmation() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              Image.asset(
                "assets/images/warning.png",
                width: 80,
                height: 80,
              ),

              const SizedBox(height: 20),

              Text(
                "Yakin hapus set jadwal?",
                style: semiBold14,
              ),

              const SizedBox(height: 30),

              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      text: "Kembali",
                      isOutlined: true,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AppButton(
                      text: "Hapus",
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// HEADER
              Row(
                children: [
                  AppBackButton(
                    onTap: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  Text(
                    "Detail Jadwal",
                    style: semiBold14.copyWith(color: blue1),
                  ),
                  const Spacer(),
                  const SizedBox(width: 40),
                ],
              ),

              const SizedBox(height: 30),

              /// KECAMATAN
              AppKecamatanDropdown(
                controller: kecamatanController,
                readOnly: !isEditMode,
              ),

              const SizedBox(height: 20),

              /// TANGGAL
              GestureDetector(
                onTap: _pickDateTime,
                child: AbsorbPointer(
                  child: AppInput(
                    label: "Tanggal dan Jam",
                    hint: "",
                    controller: tanggalController,
                    readOnly: true,
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                ),
              ),

              const Spacer(),

              /// BUTTON AREA
              isEditMode
                  ? AppButton(
                      text: "Simpan",
                      onPressed: () {
                        setState(() {
                          isEditMode = false;
                        });
                      },
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            text: "Hapus",
                            isOutlined: true,
                            onPressed: () {
                              _showDeleteConfirmation();
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: AppButton(
                            text: "Ubah",
                            onPressed: () {
                              setState(() {
                                isEditMode = true;
                              });
                            },
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