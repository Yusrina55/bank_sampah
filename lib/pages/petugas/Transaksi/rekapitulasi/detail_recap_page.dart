import 'package:flutter/material.dart';
import '../../../../theme.dart';
import '../../../../widgets/app_back_button.dart';
import '../../../../widgets/recap_tab.dart';
import '../../../../widgets/recap_detail_card.dart';

class DetailRekapitulasiPage extends StatefulWidget {
  const DetailRekapitulasiPage({super.key});

  @override
  State<DetailRekapitulasiPage> createState() => _DetailRekapitulasiPageState();
}

class _DetailRekapitulasiPageState extends State<DetailRekapitulasiPage> {
  int _selectedTab = 0; // 0 = Uang Masuk, 1 = Uang Keluar

  static final List<Map<String, String>> dummyUangMasuk = [
    {'date': '27/12/2025', 'name': 'Pabrik Kertas A', 'amount': '100.000'},
    {'date': '20/12/2025', 'name': 'Pabrik Plastik A', 'amount': '200.000'},
    {'date': '16/12/2025', 'name': 'Pabrik Besi A', 'amount': '150.000'},
    {'date': '8/12/2025', 'name': 'Pabrik Elektronik A', 'amount': '250.000'},
  ];

  static final List<Map<String, String>> dummyUangKeluar = [
    {'date': '27/12/2025', 'name': 'Pelanggan', 'amount': '30.000'},
    {'date': '27/12/2025', 'name': 'Pelanggan', 'amount': '30.000'},
    {'date': '27/12/2025', 'name': 'Pelanggan', 'amount': '20.000'},
    {'date': '25/12/2025', 'name': 'Warga dan Usaha', 'amount': '100.000'},
    {'date': '25/12/2025', 'name': 'Warga dan Usaha', 'amount': '100.000'},
    {'date': '25/12/2025', 'name': 'Warga dan Usaha', 'amount': '100.000'},
    {'date': '25/12/2025', 'name': 'Operasional', 'amount': '150.000'},
  ];

  List<Map<String, String>> get _currentList =>
      _selectedTab == 0 ? dummyUangMasuk : dummyUangKeluar;

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
          'Detail Rekapitulasi',
          style: medium16.copyWith(color: blue1),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          /// ===== TAB BAR (sticky) =====
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: RecapTab(
              tabs: const ['Uang Masuk', 'Uang Keluar'],
              selectedIndex: _selectedTab,
              onTabChanged: (index) => setState(() => _selectedTab = index),
            ),
          ),
          const SizedBox(height: 16),

          /// ===== LIST CARD (scrollable) =====
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _currentList.length,
              itemBuilder: (context, index) {
                final item = _currentList[index];
                return RekapDetailCard(
                  date: item['date']!,
                  name: item['name']!,
                  amount: item['amount']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}