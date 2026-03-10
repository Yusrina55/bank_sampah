import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets/app_input.dart';
import '../../widgets/app_back_button.dart';
import '../../widgets/app_button.dart'; 

class DetailRiwayatMitra extends StatefulWidget {
  final String time;
  final String date;
  final double weight;
  final String status;
  final double? harga;

  const DetailRiwayatMitra({
    super.key,
    required this.time,
    required this.date,
    required this.weight,
    required this.status,
    this.harga,
  });

  @override
  State<DetailRiwayatMitra> createState() =>
      _DetailRiwayatMitraState();
}

class _DetailRiwayatMitraState
    extends State<DetailRiwayatMitra> {

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
        text: "${widget.weight.toStringAsFixed(0)} kg");

    statusController =
        TextEditingController(text: widget.status);

    hargaController = TextEditingController(
      text: widget.harga != null
          ? "Rp ${widget.harga!.toStringAsFixed(0)}"
          : "-",
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
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.only(left: 16),
          child: AppBackButton(),
        ),
        title: Text(
          "Detail Riwayat",
          style: medium16.copyWith(color: blue1),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
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
              label: "Berat/Jumlah",
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
              hint: "",
              controller: hargaController,
              readOnly: true,
            ),

            const Spacer(),

            Row(
              children: [
                Expanded(
                  child: AppButton(
                    text: "Tidak",
                    isOutlined: true,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: AppButton(
                    text: "Sesuai",
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
