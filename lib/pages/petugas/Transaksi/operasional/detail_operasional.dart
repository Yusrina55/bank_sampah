import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../theme.dart';
import '../../../../widgets/app_back_button.dart';
import '../../../../widgets/app_input.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_search.dart';
import '../../../../widgets/delete_bottom_sheet.dart';

class DetailOperasionalPage extends StatefulWidget {
  final String tanggal;
  final String operasional;
  final String harga;

  const DetailOperasionalPage({
    super.key,
    required this.tanggal,
    required this.operasional,
    required this.harga,
  });

  @override
  State<DetailOperasionalPage> createState() =>
      _DetailOperasionalPageState();
}

class _DetailOperasionalPageState
    extends State<DetailOperasionalPage> {

  late TextEditingController tanggalController;
  late TextEditingController operasionalController;
  late TextEditingController hargaController;

  bool isEditMode = false;

  void showDeleteBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => DeleteConfirmBottomSheet(
        title: "Yakin hapus operasional?",
        onCancel: () {
          Navigator.pop(context);
        },
        onConfirm: () {
          Navigator.pop(context); // tutup bottom sheet
          Navigator.pop(context); // kembali ke OperasionalPage
        },
      ),
    );
  }

  void handleSave() {
    setState(() {
      isEditMode = false; // kembali ke readonly
    });
  }

  @override
  void initState() {
    super.initState();
    tanggalController =
        TextEditingController(text: widget.tanggal);
    operasionalController =
        TextEditingController(text: widget.operasional);
    hargaController =
        TextEditingController(text: widget.harga);
  }

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
          "Detail Operasional",
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
              Text("Tanggal",
                  style: medium12),
              const SizedBox(height: 8),

              AppDatePickerField(
                controller: tanggalController,
                enabled: isEditMode,
              ),

              const SizedBox(height: 20),

              /// ===== OPERASIONAL =====
              AppInput(
                label: "Operasional",
                hint: "",
                controller: operasionalController,
                readOnly: !isEditMode,
              ),

              const SizedBox(height: 20),

              /// ===== HARGA =====
              AppInput(
                label: "Harga",
                hint: "",
                controller: hargaController,
                readOnly: !isEditMode,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),

              const SizedBox(height: 40),

              /// ===== BUTTON SECTION =====
              isEditMode
                  ? SizedBox(
                      width: double.infinity,
                      child: AppButton(
                        text: "Simpan",
                        onPressed: handleSave,
                      ),
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            text: "Hapus",
                            isOutlined: true,
                            onPressed: showDeleteBottomSheet,
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