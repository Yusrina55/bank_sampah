import 'package:flutter/material.dart';
import '../../../theme.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_input.dart';
import '../../../widgets/app_back_button.dart';
import '../../../widgets/app_kecamatan_dropdown.dart';

class CreateScheduleSetting extends StatefulWidget {
  const CreateScheduleSetting({super.key});

  @override
  State<CreateScheduleSetting> createState() =>
      _CreateScheduleSettingState();
}

class _CreateScheduleSettingState
    extends State<CreateScheduleSetting> {
  final TextEditingController kecamatanController =
      TextEditingController();

  List<TextEditingController> tanggalControllers = [];

  @override
  void initState() {
    super.initState();
    _addField(); // otomatis 1 field awal
  }

  void _addField() {
    setState(() {
      tanggalControllers.add(TextEditingController());
    });
  }

  void _removeField(int index) {
    setState(() {
      tanggalControllers[index].dispose();
      tanggalControllers.removeAt(index);
    });
  }

  Future<void> _pickDateTime(int index) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
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
        "${startTime.hour.toString().padLeft(2, '0')}:"
        "${startTime.minute.toString().padLeft(2, '0')} - "
        "${endTime.hour.toString().padLeft(2, '0')}:"
        "${endTime.minute.toString().padLeft(2, '0')}";

    setState(() {
      tanggalControllers[index].text = formatted;
    });
  }

  @override
  void dispose() {
    for (var controller in tanggalControllers) {
      controller.dispose();
    }
    kecamatanController.dispose();
    super.dispose();
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

              /// ===== HEADER =====
              Row(
                children: [
                  AppBackButton(
                    onTap: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  Text(
                    "Tambah Jadwal",
                    style: medium14.copyWith(color: blue1),
                  ),
                  const Spacer(),
                  const SizedBox(width: 40),
                ],
              ),

              const SizedBox(height: 30),

              /// ===== KECAMATAN =====
              AppKecamatanDropdown(
                controller: kecamatanController,
              ),

              const SizedBox(height: 24),

              /// ===== LABEL =====
              Text(
                "Tanggal dan Jam",
                style: semiBold12,
              ),

              const SizedBox(height: 12),

              /// ===== DYNAMIC FIELD AREA =====
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      ...List.generate(
                        tanggalControllers.length,
                        (index) => Padding(
                          padding:
                              const EdgeInsets.only(bottom: 16),
                          child: 
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: 
                                AppInput(
                                   label: "",
                                  hint:
                                      "dd-mm-yyyy hh:mm - hh:mm",
                                  controller:
                                      tanggalControllers[index],
                                  readOnly: true,
                                  suffixIcon: const Icon(
                                      Icons.calendar_today),
                                  onTap: () =>
                                      _pickDateTime(index),
                                ),
                              ),

                              const SizedBox(width: 8),

                              if (tanggalControllers.length > 1)
                                GestureDetector(
                                  onTap: () =>
                                      _removeField(index),
                                  child: Container(
                                    padding:
                                        const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.red
                                          .withOpacity(0.1),
                                      borderRadius:
                                          BorderRadius.circular(
                                              12),
                                    ),
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),

                      /// ===== TAMBAH + =====
                      GestureDetector(
                        onTap: _addField,
                        child: Container(
                          width: double.infinity,
                          padding:
                              const EdgeInsets.symmetric(
                                  vertical: 12),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: blue2,
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                          child: Text(
                            "Tambah +",
                            style: regular12.copyWith(
                                color: blue1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16),

              /// ===== BUTTON SIMPAN =====
              SizedBox(
                width: double.infinity,
                child: AppButton(
                  text: "Simpan",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}