class MitraScheduleModel {
  final String time;
  final String date;
  final String? name;
  final String? jenisSampah;  
  final double weight;
  final double? harga;

  const MitraScheduleModel({
    required this.time,
    required this.date,
    this.name,
    this.jenisSampah,
    required this.weight,
    this.harga,
  });
}
