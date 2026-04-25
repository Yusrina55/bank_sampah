class MitraScheduleModel {
  final String time;
  final String date;
  final String? name;
  final String? jenisSampah;  
  final double weight;
  final double? harga;
  final String status;
  final String? alasanTolak;

  const MitraScheduleModel({
    required this.time,
    required this.date,
    this.name,
    this.jenisSampah,
    required this.weight,
    this.harga,
    required this.status,
    this.alasanTolak,
  });
}
