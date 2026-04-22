import 'package:flutter/material.dart';
import '../../../../theme.dart';
import '../../../../widgets/app_back_button.dart';
import '../../../../widgets/app_search.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/operational_card.dart';
import 'package:bank_sampah/data/transaksi_repository.dart'; // ✅ tambah
import 'create_operasional.dart';
import 'detail_operasional.dart';

class OperasionalPage extends StatefulWidget {
  const OperasionalPage({super.key});

  @override
  State<OperasionalPage> createState() => _OperasionalPageState();
}

class _OperasionalPageState extends State<OperasionalPage> {
  final TextEditingController searchDateController = TextEditingController();

  // ✅ Data dari repository, bukan hardcode
  List<Map<String, dynamic>> filteredData = [];

  @override
  void initState() {
    super.initState();
    filteredData = TransaksiRepository.operasional;
  }

  @override
  void dispose() {
    searchDateController.dispose();
    super.dispose();
  }

  // ✅ Filter berdasarkan tanggal yang dipilih
  void _onDateSelected(DateTime? date) {
    if (date == null) {
      setState(() {
        filteredData = TransaksiRepository.operasional;
      });
      return;
    }

    // Format date jadi "dd/MM/yyyy" untuk dicocokkan dengan data
    final formatted =
        "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";

    setState(() {
      filteredData = TransaksiRepository.operasional
          .where((item) => item['date'] == formatted)
          .toList();
    });
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
          child: AppBackButton(
            onTap: () => Navigator.pop(context),
          ),
        ),
        title: Text(
          "Operasional",
          style: medium16.copyWith(color: blue1),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /// SEARCH
          AppDatePickerField(
            controller: searchDateController,
            enabled: true,
            onDateSelected: _onDateSelected, // ✅ filter saat tanggal dipilih
          ),
          const SizedBox(height: 16),

          /// HEADER ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Catatan Operasional",
                style: semiBold14.copyWith(color: textblack),
              ),
              SizedBox(
                width: 140,
                child: AppButton(
                  text: "Tambah",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CreateOperasionalPage(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          /// LIST CARD
          if (filteredData.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Text(
                  "Tidak ada data operasional",
                  style: regular12.copyWith(color: Colors.grey),
                ),
              ),
            )
          else
            ...filteredData.map(
              (item) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailOperasionalPage(
                        tanggal: item["date"] as String,
                        operasional: item["note"] as String,
                        harga: TransaksiRepository.formatRupiah(
                          item["amount"] as num,
                        ), 
                      ),
                    ),
                  );
                },
                child: OperationalCard(
                  date: item["date"] as String,
                  note: item["note"] as String,
                  amount: TransaksiRepository.formatRupiah(
                    item["amount"] as num,
                  ), 
                ),
              ),
            ),
        ],
      ),
    );
  }
}