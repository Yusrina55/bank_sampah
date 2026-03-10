import 'package:flutter/material.dart';
import '../../../theme.dart';
import '../../../widgets/app_input.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_back_button.dart';

class DetailTransaksiJadwal extends StatefulWidget {
  final String time;
  final String date;
  final double weight;
  final double? harga;

  const DetailTransaksiJadwal({
    super.key,
    required this.time,
    required this.date,
    required this.weight,
    this.harga,
  });

  @override
  State<DetailTransaksiJadwal> createState() =>
      _DetailTransaksiJadwalState();

}

class _DetailTransaksiJadwalState extends State<DetailTransaksiJadwal> {

  late TextEditingController dateController;
  late TextEditingController timeController;
  late TextEditingController weightController;
  late TextEditingController statusController;
  late TextEditingController hargaController;

  @override
  void initState() {
    super.initState();

    dateController =
        TextEditingController(text: widget.date);

    timeController =
        TextEditingController(text: widget.time);

    weightController = TextEditingController(
      text: "${widget.weight.toStringAsFixed(0)} kg",
    );

    statusController =
        TextEditingController(text: "Menunggu Pembayaran");

    hargaController = TextEditingController(
      text: widget.harga != null
          ? widget.harga!.toStringAsFixed(0)
          : "",
    );
  }

  @override
  void dispose() {
    dateController.dispose();
    timeController.dispose();
    weightController.dispose();
    statusController.dispose();
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
          "Detail Jadwal Mitra",
          style: medium16.copyWith(color: blue1),
        ),
        centerTitle: true,
      ),

      /// ===== BODY (SCROLLABLE FORM) =====
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            AppInput(
              label: "Tanggal",
              hint: "",
              controller: dateController,
              readOnly: true,
            ),

            const SizedBox(height: 16),

            AppInput(
              label: "Jam",
              hint: "",
              controller: timeController,
              readOnly: true,
            ),

            const SizedBox(height: 16),

            AppInput(
              label: "Berat Sampah",
              hint: "",
              controller: weightController,
              readOnly: true,
            ),

            const SizedBox(height: 16),

            AppInput(
              label: "Status",
              hint: "",
              controller: statusController,
              readOnly: true,
            ),

            const SizedBox(height: 16),

            AppInput(
              label: "Harga",
              hint: "Masukkan harga jika sudah dihitung",
              controller: hargaController,
              readOnly: false,
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 100), // space supaya tidak ketutup button
          ],
        ),
      ),

      /// ===== STICKY BUTTON =====
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: AppButton(
              text: "Bayar",
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Pembayaran berhasil"),
                  ),
                );
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
    );
  }
} 