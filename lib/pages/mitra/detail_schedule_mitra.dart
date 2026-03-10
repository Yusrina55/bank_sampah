import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets/app_input.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_back_button.dart';
import 'home_page_mitra.dart';
import '../../widgets/reject_bottom_sheet.dart';


class DetailJadwalMitraPage extends StatefulWidget {
  final String time;
  final String date;
  final double weight;
  final double? harga;

  const DetailJadwalMitraPage({
    super.key,
    required this.time,
    required this.date,
    required this.weight,
    this.harga,
  });

  @override
  State<DetailJadwalMitraPage> createState() =>
      _DetailJadwalMitraPageState();
}



class _DetailJadwalMitraPageState
    extends State<DetailJadwalMitraPage> {

  late TextEditingController dateController;
  late TextEditingController timeController;
  late TextEditingController weightController;
  late TextEditingController statusController;

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
        TextEditingController(text: "Diproses");
  }

  @override
  void dispose() {
    dateController.dispose();
    timeController.dispose();
    weightController.dispose();
    statusController.dispose();
    super.dispose();
  }

    void _showRejectBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return RejectBottomSheet(
          onCancel: () {
            Navigator.pop(context);
          },
          onConfirm: () {
            Navigator.pop(context);

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePageMitra(),
              ),
              (route) => false,
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: AppBackButton(),
        ),
        title: Text(
          "Detail Pengajuan Mitra",
          style: medium16.copyWith(color: blue1),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            AppInput(
              label: "Ajuan Jadwal",
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

            const Spacer(),

            Row(
              children: [
                Expanded(
                  child: AppButton(
                    text: "Tolak",
                    isOutlined: true,
                    backgroundColor: blue2,
                    onPressed: _showRejectBottomSheet, // ✅ pakai ini
                  ),
                ),

                const SizedBox(width: 16),
                Expanded(
                  child: AppButton(
                    text: "Setuju",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePageMitra(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
