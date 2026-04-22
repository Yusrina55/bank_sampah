enum CustomerType { mahasiswa, masyarakat }

class SampahItem {
  final String jenis;
  final String? berat;

  const SampahItem({
    required this.jenis,
    this.berat,
  });
}

class ScheduleModel {
  final String name;
  final String kecamatan;
  final String alamat; 
  final String tanggal;
  final String jadwal;
  final String status;
  final String? harga;
  final String? alasanTolak;
  final CustomerType customerType;
  final List<SampahItem> sampahList;

  const ScheduleModel({
    required this.name,
    required this.kecamatan,
    this.alamat = '',
    required this.tanggal,
    required this.jadwal,
    required this.status,
    this.harga,
    this.alasanTolak,
    required this.customerType,
    this.sampahList = const [],
  });
}