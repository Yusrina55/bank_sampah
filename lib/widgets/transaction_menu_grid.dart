import 'package:flutter/material.dart';
import 'transaction_menu_item.dart';
import '../pages/petugas/Transaksi/operasional/operasional_page.dart';
import '../pages/petugas/Transaksi/data_sampah/sampah_page.dart';
import '../pages/petugas/Transaksi/rekapitulasi/rekapitulasi_page.dart';
import '../pages/petugas/Transaksi/data_mitra/mitra_page.dart';

class TransactionMenuGrid extends StatelessWidget {
  const TransactionMenuGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 2.5, 
      ),
      itemBuilder: (context, index) {
        final items = [
          {
            'icon': 'assets/icons/recap.svg',
            'label': 'Rekapitulasi',
          },
          {
            'icon': 'assets/icons/person.svg',
            'label': 'Data Mitra',
          },
          {
            'icon': 'assets/icons/operational.svg',
            'label': 'Operasional',
          },
          {
            'icon': 'assets/icons/weight.svg',
            'label': 'Data Sampah',
          },
        ];

        return TransactionMenuItem(
          icon: items[index]['icon']!,
          label: items[index]['label']!,
          onTap: () {
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const RekapitulasiPage(),
                ),
              );
            } else if (index == 1) {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (_) => const MitraPage(),
                )
              );
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const OperasionalPage(),
                ),
              );
            } else if (index == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SampahPage(),
                ),
              );
            }
          },
        );
      },
    );
  }
}