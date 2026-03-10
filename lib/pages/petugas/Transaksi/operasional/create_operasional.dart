import 'package:flutter/material.dart';
import '../../../../theme.dart';
import '../../../../widgets/app_back_button.dart';
import '../../../../widgets/app_input.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_search.dart';
import 'package:flutter/services.dart';

class CreateOperasionalPage extends StatefulWidget {
  const CreateOperasionalPage({super.key});

  @override
  State<CreateOperasionalPage> createState() =>
      _CreateOperasionalPageState();
}

class _CreateOperasionalPageState
    extends State<CreateOperasionalPage> {

  final TextEditingController tanggalController =
      TextEditingController();
  final TextEditingController operasionalController =
      TextEditingController();
  final TextEditingController hargaController =
      TextEditingController();

  @override
  void dispose() {
    tanggalController.dispose();
    operasionalController.dispose();
    hargaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: AppBackButton(
            onTap: () => Navigator.pop(context),
          ),
        ),
        title: Text(
          "Tambah Operasional",
          style: medium16.copyWith(color: blue1),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// ===== TANGGAL =====
              Text(
                "Tanggal",
                style: medium12,
              ),
              const SizedBox(height: 8),

              AppDatePickerField(
                controller: tanggalController,
                enabled: true,
              ),

              const SizedBox(height: 20),

              /// ===== OPERASIONAL =====
              AppInput(
                label: "Operasional",
                hint: "masukkan operasional",
                controller: operasionalController,
                readOnly: false,
              ),

              const SizedBox(height: 20),

              /// ===== HARGA =====
              AppInput(
                label: "Harga",
                hint: "masukkan harga",
                controller: hargaController,
                readOnly: false,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),

              const SizedBox(height: 40),

              /// ===== BUTTON =====
              SizedBox(
                width: double.infinity,
                child: AppButton(
                  text: "Simpan",
                  onPressed: () {
                    Navigator.pop(context); // kembali ke operasional page
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