import 'package:flutter/material.dart';
import '../../../widgets/app_back_button.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_input.dart';
import '../../../widgets/app_berat_jenis.dart';
import '../../../theme.dart';
import '../home_page_pelanggan.dart';
import '../create_schedule_page.dart';

class RequestSchedulePage extends StatefulWidget {
  const RequestSchedulePage({super.key});

  @override
  State<RequestSchedulePage> createState() =>
      _RequestSchedulePageState();
}

class _RequestSchedulePageState
    extends State<RequestSchedulePage> {

  List<TextEditingController> jenisControllers = [];
  List<TextEditingController> beratControllers = [];

  TextEditingController tanggalController =
      TextEditingController();
  TextEditingController jamController =
    TextEditingController();

  Future<void> pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final hour = picked.hour.toString().padLeft(2, '0');
      final minute = picked.minute.toString().padLeft(2, '0');

      jamController.text = "$hour.$minute";
      setState(() {});
    }
  }


  @override
  void initState() {
    super.initState();
    _addField();
  }

  void _addField() {
    setState(() {
      jenisControllers.add(TextEditingController());
      beratControllers.add(TextEditingController());
    });
  }

  void _removeField(int index) {
    setState(() {
      jenisControllers[index].dispose();
      beratControllers[index].dispose();

      jenisControllers.removeAt(index);
      beratControllers.removeAt(index);
    });
  }

  bool isFormValid() {
    if (tanggalController.text.isEmpty) return false;
    if (jamController.text.isEmpty) return false;

    for (int i = 0; i < jenisControllers.length; i++) {
      if (jenisControllers[i].text.isEmpty ||
          beratControllers[i].text.isEmpty) {
        return false;
      }
    }
    return true;
  }

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
      setState(() {});
    }
  }

  void _showSuccessDialog() {
    final messenger = ScaffoldMessenger.of(context);

    messenger.showMaterialBanner(
      MaterialBanner(
        content: Text(
          "Jadwal berhasil dibuat",
          style: TextStyle(color: blue1),
        ),
        backgroundColor: blue2,
        leading: Icon(Icons.check_circle, color: blue1),
        actions: [
          TextButton(
            onPressed: () =>
                messenger.hideCurrentMaterialBanner(),
            child:
                Text("Tutup", style: TextStyle(color: blue1)),
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
          builder: (_) => const HomePagePelanggan(),
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

        /// ================= APPBAR =================
        appBar: AppBar(
          backgroundColor: white,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: AppBackButton(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const CreateSchedulePage(),
                  ),
                );
              },
            ),
          ),
          title: Text("Buat Jadwal",
              style: medium16.copyWith(color: blue1)),
          centerTitle: true,
        ),

        /// ================= BODY =================
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [

              /// ===== JENIS SAMPAH =====
              Text("Jenis Sampah", style: semiBold14),
              Column(
                children: List.generate(
                  jenisControllers.length,
                  (index) => AppBeratJenisField(
                    jenisController: jenisControllers[index],
                    jumlahController: beratControllers[index],
                    onDelete: () => _removeField(index),
                    showDelete: jenisControllers.length > 1,
                  ),
                ),
              ),

              /// TAMBAH FIELD
              GestureDetector(
                onTap: _addField,
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

              const SizedBox(height: 24),

              /// ===== AJUAN JADWAL =====
              Text("Ajuan Jadwal", style: semiBold14),
              const SizedBox(height: 16),
              AppInput(
                label: "Tanggal",
                hint: "dd-mm-yyyy",
                controller: tanggalController,
                readOnly: true,
                onTap: pickDate,
                suffixIcon:
                    const Icon(Icons.calendar_today),
              ),
              const SizedBox(height: 16),

              AppInput(
                label: "Jam",
                hint: "hh.mm",
                controller: jamController,
                readOnly: true,
                onTap: pickTime,
                suffixIcon: const Icon(Icons.access_time),
              ),

              const SizedBox(height: 32),

              /// ===== BUTTON =====
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
