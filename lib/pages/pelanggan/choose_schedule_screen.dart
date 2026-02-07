import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_back_button.dart';
import '../../widgets/app_jenis_sampah_dropdown.dart';
import 'home_page_pelanggan.dart';

class ChooseScheduleScreen extends StatefulWidget {
  const ChooseScheduleScreen({super.key});

  @override
  State<ChooseScheduleScreen> createState() =>
      _ChooseScheduleScreenState();
}

class _ChooseScheduleScreenState extends State<ChooseScheduleScreen> {

  /// RADIO SCHEDULE
  String? selectedSchedule;

  final List<String> scheduleList = [
    "08.00 - 10.00",
    "14.00 - 16.00",
  ];

  /// DYNAMIC JENIS SAMPAH
  List<TextEditingController> jenisSampahControllers = [
    TextEditingController()
  ];

  @override
  void initState() {
    super.initState();

    /// Listen perubahan text supaya button update
    for (var controller in jenisSampahControllers) {
      controller.addListener(_onFormChanged);
    }
  }

  void _onFormChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    for (var controller in jenisSampahControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  /// VALIDASI FORM
  bool isFormValid() {
    if (selectedSchedule == null) return false;

    for (var controller in jenisSampahControllers) {
      if (controller.text.trim().isEmpty) return false;
    }

    return true;
  }

  /// SUCCESS NOTIFICATION (TOP BANNER)
  void _showSuccessDialog() {

    final messenger = ScaffoldMessenger.of(context);

    messenger.showMaterialBanner(
      MaterialBanner(
        content: Text(
          "Jadwal berhasil dibuat",
          style: TextStyle(color: blue1),
        ),

        backgroundColor: blue2,
        surfaceTintColor: Colors.transparent,
        elevation: 0,

        leading: Icon(
          Icons.check_circle,
          color: blue1,
        ),

        actions: [
          TextButton(
            onPressed: () {
              messenger.hideCurrentMaterialBanner();
            },
            child: Text(
              "Tutup",
              style: TextStyle(color: blue1),
            ),
          ),
        ],
      ),
    );

    Future.delayed(const Duration(seconds: 1), () {

      messenger.hideCurrentMaterialBanner();

      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePagePelanggan(),
        ),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: white,

        /// APP BAR
        appBar: AppBar(
          backgroundColor: white,
          elevation: 0,
          leading: const Padding(
            padding: EdgeInsets.only(left: 16),
            child: AppBackButton(),
          ),
          title: Text("Buat Jadwal",
              style: medium16.copyWith(color: blue1)),
          centerTitle: true,
        ),

        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// ========================
              /// PILIH JADWAL
              /// ========================
              Text("Pilihan Jadwal", style: semiBold14),
              const SizedBox(height: 16),

              ...scheduleList.map((schedule) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: RadioListTile<String>(
                    value: schedule,
                    groupValue: selectedSchedule,
                    title: Text(schedule),
                    onChanged: (value) {
                      setState(() {
                        selectedSchedule = value;
                      });
                    },
                  ),
                );
              }).toList(),

              const SizedBox(height: 24),

              /// ========================
              /// JENIS SAMPAH
              /// ========================
              Text("Jenis Sampah", style: semiBold14),
              const SizedBox(height: 16),

              Column(
                children: List.generate(
                  jenisSampahControllers.length,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [

                          /// DROPDOWN
                          Expanded(
                            child: AppJenisSampahDropdown(
                              label:
                                  "Jenis Sampah ${index + 1}",
                              controller:
                                  jenisSampahControllers[index],
                            ),
                          ),

                          /// DELETE BUTTON
                          if (jenisSampahControllers.length > 1)
                            IconButton(
                              icon: const Icon(Icons.delete,
                                  color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  jenisSampahControllers[index]
                                      .dispose();
                                  jenisSampahControllers
                                      .removeAt(index);
                                });
                              },
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              /// TAMBAH FIELD
              GestureDetector(
                onTap: () {
                  setState(() {

                    final controller = TextEditingController();
                    controller.addListener(_onFormChanged);

                    jenisSampahControllers.add(controller);
                  });
                },
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: blue2,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "Tambah +",
                    style: regular12.copyWith(color: blue1),
                  ),
                ),
              ),

              const Spacer(),

              /// ========================
              /// BUTTON BUAT
              /// ========================
              AppButton(
                text: "Buat",
                onPressed:
                    isFormValid() ? _showSuccessDialog : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
