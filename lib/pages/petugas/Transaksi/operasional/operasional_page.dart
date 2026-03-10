import 'package:flutter/material.dart';
import '../../../../theme.dart';
import '../../../../widgets/app_back_button.dart';
import '../../../../widgets/app_search.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/operational_card.dart';
import 'create_operasional.dart';
import 'detail_operasional.dart';

class OperasionalPage extends StatefulWidget {
  const OperasionalPage({super.key});

  @override
  State<OperasionalPage> createState() => _OperasionalPageState();
}

class _OperasionalPageState extends State<OperasionalPage> {
  final TextEditingController searchDateController = TextEditingController();

  @override
  void dispose() {
    searchDateController.dispose();
    super.dispose();
  }

  static final List<Map<String, String>> dummyData = [
    {
      "date": "20/12/2025",
      "note": "Service tossa",
      "amount": "250.000",
    },
    {
      "date": "19/12/2025",
      "note": "Beli karung",
      "amount": "30.000",
    },
    {
      "date": "19/12/2025",
      "note": "Beli karung",
      "amount": "30.000",
    },
    {
      "date": "19/12/2025",
      "note": "Beli karung",
      "amount": "30.000",
    },
  ];

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
            onDateSelected: (date) {},
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
              )
            ],
          ),

          const SizedBox(height: 16),

          /// LIST CARD
          ...dummyData.map(
            (item) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailOperasionalPage(
                      tanggal: item["date"]!,
                      operasional: item["note"]!,
                      harga: item["amount"]!,
                    ),
                  ),
                );
              },
              child: OperationalCard(
                date: item["date"]!,
                note: item["note"]!,
                amount: item["amount"]!,
              ),
            ),
          ),
        ],
      ),
    );
  }
}