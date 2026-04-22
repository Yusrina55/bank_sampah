import 'package:flutter/material.dart';
import '../../../../theme.dart';
import '../../../../widgets/app_back_button.dart';
import '../../../../widgets/recap_tab.dart';
import '../../../../widgets/recap_detail_card.dart';
import 'package:bank_sampah/data/transaksi_repository.dart';

class DetailRekapitulasiPage extends StatefulWidget {
  final String bulan;
  final String tahun;

  const DetailRekapitulasiPage({
    super.key,
    required this.bulan,
    required this.tahun,
  });

  @override
  State<DetailRekapitulasiPage> createState() => _DetailRekapitulasiPageState();
}

class _DetailRekapitulasiPageState extends State<DetailRekapitulasiPage> {
  int _selectedTab = 0;

  List<Map<String, dynamic>> get _uangMasuk =>
      TransaksiRepository.uangMasuk
          .where((e) => e['bulan'] == widget.bulan && e['tahun'] == widget.tahun)
          .toList();

  List<Map<String, dynamic>> get _uangKeluar =>
      TransaksiRepository.uangKeluar
          .where((e) => e['bulan'] == widget.bulan && e['tahun'] == widget.tahun)
          .toList();

  List<Map<String, dynamic>> get _operasional =>
      TransaksiRepository.operasional
          .where((e) => e['bulan'] == widget.bulan && e['tahun'] == widget.tahun)
          .map((e) => {
                'date': e['date'],
                'name': e['note'],
                'amount': e['amount'],
              })
          .toList();

  // Uang Keluar = pembayaran pelanggan + operasional digabung
  List<Map<String, dynamic>> get _currentList =>
      _selectedTab == 0 ? _uangMasuk : [..._uangKeluar, ..._operasional];

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
          'Detail - ${widget.bulan} ${widget.tahun}',
          style: medium16.copyWith(color: blue1),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          /// ===== TAB BAR =====
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: RecapTab(
              tabs: const ['Uang Masuk', 'Uang Keluar'],
              selectedIndex: _selectedTab,
              onTabChanged: (index) => setState(() => _selectedTab = index),
            ),
          ),
          const SizedBox(height: 16),

          /// ===== LIST CARD =====
          Expanded(
            child: _currentList.isEmpty
                ? Center(
                    child: Text(
                      'Tidak ada data',
                      style: regular12.copyWith(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _currentList.length,
                    itemBuilder: (context, index) {
                      final item = _currentList[index];
                      return RekapDetailCard(
                        date: item['date'] as String,
                        name: item['name'] as String,
                        amount: TransaksiRepository.formatRupiah(
                          item['amount'] as num,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}