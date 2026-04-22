// lib/data/transaksi_repository.dart

class TransaksiRepository {
  // ===== UANG MASUK (dari Mitra/Pabrik) =====
  static final List<Map<String, dynamic>> uangMasuk = [
    {'date': '27/12/2025', 'bulan': 'Desember', 'tahun': '2025', 'name': 'Pabrik Kertas A',    'amount': 100000},
    {'date': '20/12/2025', 'bulan': 'Desember', 'tahun': '2025', 'name': 'Pabrik Plastik A',   'amount': 200000},
    {'date': '16/12/2025', 'bulan': 'Desember', 'tahun': '2025', 'name': 'Pabrik Besi A',      'amount': 150000},
    {'date': '08/12/2025', 'bulan': 'Desember', 'tahun': '2025', 'name': 'Pabrik Elektronik A','amount': 250000},
    {'date': '10/11/2025', 'bulan': 'November', 'tahun': '2025', 'name': 'Pabrik Kertas A',    'amount': 300000},
    {'date': '05/11/2025', 'bulan': 'November', 'tahun': '2025', 'name': 'Pabrik Plastik A',   'amount': 400000},
  ];

  // ===== UANG KELUAR (pembayaran ke pelanggan) =====
  static final List<Map<String, dynamic>> uangKeluar = [
    {'date': '27/12/2025', 'bulan': 'Desember', 'tahun': '2025', 'name': 'Pelanggan',        'amount': 30000},
    {'date': '27/12/2025', 'bulan': 'Desember', 'tahun': '2025', 'name': 'Pelanggan',        'amount': 30000},
    {'date': '27/12/2025', 'bulan': 'Desember', 'tahun': '2025', 'name': 'Pelanggan',        'amount': 20000},
    {'date': '25/12/2025', 'bulan': 'Desember', 'tahun': '2025', 'name': 'Warga dan Usaha',  'amount': 50000},
    {'date': '25/12/2025', 'bulan': 'Desember', 'tahun': '2025', 'name': 'Warga dan Usaha',  'amount': 50000},
    {'date': '25/12/2025', 'bulan': 'Desember', 'tahun': '2025', 'name': 'Warga dan Usaha',  'amount': 50000},
    {'date': '08/11/2025', 'bulan': 'November', 'tahun': '2025', 'name': 'Pelanggan',        'amount': 50000},
    {'date': '05/11/2025', 'bulan': 'November', 'tahun': '2025', 'name': 'Warga dan Usaha',  'amount': 150000},
  ];

  // ===== OPERASIONAL =====
  static final List<Map<String, dynamic>> operasional = [
    {'date': '20/12/2025', 'bulan': 'Desember', 'tahun': '2025', 'note': 'Service tossa', 'amount': 250000},
    {'date': '19/12/2025', 'bulan': 'Desember', 'tahun': '2025', 'note': 'Beli karung',   'amount': 30000},
    {'date': '19/12/2025', 'bulan': 'Desember', 'tahun': '2025', 'note': 'Beli karung',   'amount': 30000},
    {'date': '19/12/2025', 'bulan': 'Desember', 'tahun': '2025', 'note': 'Beli karung',   'amount': 30000},
    {'date': '01/11/2025', 'bulan': 'November', 'tahun': '2025', 'note': 'Bensin',        'amount': 100000},
  ];

  // ===== HELPER: total per bulan & tahun =====
  static int totalMasukPerBulan(String bulan, String tahun) {
    return uangMasuk
        .where((e) => e['bulan'] == bulan && e['tahun'] == tahun)
        .fold<int>(0, (sum, e) => sum + (e['amount'] as int));
  }

  static int totalKeluarPerBulan(String bulan, String tahun) {
    return uangKeluar
        .where((e) => e['bulan'] == bulan && e['tahun'] == tahun)
        .fold<int>(0, (sum, e) => sum + (e['amount'] as int));
  }

  static int totalOperasionalPerBulan(String bulan, String tahun) {
    return operasional
        .where((e) => e['bulan'] == bulan && e['tahun'] == tahun)
        .fold<int>(0, (sum, e) => sum + (e['amount'] as int));
  }

  // ===== REKAPITULASI PER BULAN =====
  // hasil = uang masuk - uang keluar - operasional
  static int rekapPerBulan(String bulan, String tahun) {
    return totalMasukPerBulan(bulan, tahun) -
           totalKeluarPerBulan(bulan, tahun) -
           totalOperasionalPerBulan(bulan, tahun);
  }

  // ===== TOTAL BALANCE (semua bulan dijumlah) =====
  static int get totalBalance {
    final allPeriodes = <String>{};
    for (final e in [...uangMasuk, ...uangKeluar, ...operasional]) {
      allPeriodes.add('${e['bulan']}|${e['tahun']}');
    }
    return allPeriodes.fold<int>(0, (sum, periodeKey) {
      final parts = periodeKey.split('|');
      return sum + rekapPerBulan(parts[0], parts[1]);
    });
  }

  // ===== FORMAT RUPIAH =====
  static String formatRupiah(num amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]}.',
    );
  }

  // ===== DAFTAR SEMUA PERIODE untuk RekapitulasiPage =====
  static List<Map<String, String>> get semuaRekap {
    final allPeriodes = <String>{};
    for (final e in [...uangMasuk, ...uangKeluar, ...operasional]) {
      allPeriodes.add('${e['bulan']}|${e['tahun']}');
    }

    final list = allPeriodes.map((key) {
      final parts = key.split('|');
      final bulan = parts[0];
      final tahun = parts[1];
      final total = rekapPerBulan(bulan, tahun);
      return {
        'periode': '$tahun, $bulan',
        'bulan': bulan,
        'tahun': tahun,
        'total': formatRupiah(total),
      };
    }).toList();

    // Sort terbaru dulu
    list.sort((a, b) => b['periode']!.compareTo(a['periode']!));
    return list;
  }
}