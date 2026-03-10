import 'package:flutter/material.dart';
import '../../../../theme.dart';
import '../../../../widgets/app_back_button.dart';
import '../../../../widgets/recap_card.dart';

class RekapitulasiPage extends StatefulWidget {
  const RekapitulasiPage({super.key});

  @override
  State<RekapitulasiPage> createState() => _RekapitulasiPageState();
}

class _RekapitulasiPageState extends State<RekapitulasiPage> {
  String? selectedTahun;
  String? selectedBulan;

  final List<String> tahunList = ['2023', '2024', '2025'];
  final List<String> bulanList = [
    'Januari', 'Februari', 'Maret', 'April',
    'Mei', 'Juni', 'Juli', 'Agustus',
    'September', 'Oktober', 'November', 'Desember',
  ];

  static final List<Map<String, String>> dummyRekap = [
    {'periode': '2025, Desember', 'total': '700.000,00'},
    {'periode': '2025, November', 'total': '500.000,00'},
    {'periode': '2025, Oktober', 'total': '400.000,00'},
    {'periode': '2025, September', 'total': '300.000,00'},
    {'periode': '2025, Agustus', 'total': '400.000,00'},
  ];

  List<Map<String, String>> filteredRekap = [];

  @override
  void initState() {
    super.initState();
    filteredRekap = dummyRekap;
  }

  void _onCari() {
    setState(() {
      filteredRekap = dummyRekap.where((item) {
        final periode = item['periode']!.toLowerCase();
        final matchTahun = selectedTahun == null ||
            periode.contains(selectedTahun!.toLowerCase());
        final matchBulan = selectedBulan == null ||
            periode.contains(selectedBulan!.toLowerCase());
        return matchTahun && matchBulan;
      }).toList();
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
          'Rekapitulasi',
          style: medium16.copyWith(color: blue1),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /// ===== FILTER ROW =====
          Row(
            children: [
              /// TAHUN DROPDOWN
              Expanded(
                child: _DropdownInput(
                  hint: 'tahun',
                  value: selectedTahun,
                  items: tahunList,
                  onChanged: (val) => setState(() => selectedTahun = val),
                ),
              ),
              const SizedBox(width: 10),

              /// BULAN DROPDOWN
              Expanded(
                child: _DropdownInput(
                  hint: 'bulan',
                  value: selectedBulan,
                  items: bulanList,
                  onChanged: (val) => setState(() => selectedBulan = val),
                ),
              ),
              const SizedBox(width: 10),

              /// CARI BUTTON
              SizedBox(
                width: 48,
                height: 48,
                child: ElevatedButton(
                  onPressed: _onCari,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blue1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.zero,
                    elevation: 0,
                  ),
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          /// ===== LIST REKAP =====
          ...filteredRekap.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: RekapCard(
                periode: item['periode']!,
                total: item['total']!,
                onTap: () {
                  // TODO: navigate to detail rekapitulasi
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ===== PRIVATE DROPDOWN WIDGET =====
class _DropdownInput extends StatelessWidget {
  final String hint;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _DropdownInput({
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(hint, style: regular12.copyWith(color: Colors.grey)),
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down, size: 20),
          style: regular12.copyWith(color: textblack),
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}