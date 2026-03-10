class MitraScheduleModel {
  final String time;
  final String date;
  final double weight;
  final double? harga;

  const MitraScheduleModel({
    required this.time,
    required this.date,
    required this.weight,
    this.harga,
  });
}
