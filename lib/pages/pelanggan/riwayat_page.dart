import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets/app_back_button.dart';
import '../../widgets/schedule_card.dart';
import '../../models/schedule_model.dart';

class RiwayatPage extends StatelessWidget {
  final List<ScheduleModel> riwayatList;
  final ValueChanged<ScheduleModel> onCardTap;

  const RiwayatPage({
    super.key,
    required this.riwayatList,
    required this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: AppBackButton(
            onTap: () => Navigator.pop(context),
          ),
        ),
        title: Text(
          'Riwayat',
          style: medium16.copyWith(color: blue1),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: riwayatList.length,
        itemBuilder: (context, index) {
          final schedule = riwayatList[index];
          return ScheduleCard(
            time: schedule.jadwal,
            date: schedule.tanggal,
            name: schedule.name,
            location: '${schedule.kecamatan}, ${schedule.alamat}',
            onTap: () {
              // Kembali ke home dulu, lalu navigate ke detail
              Navigator.pop(context);
              onCardTap(schedule);
            },
          );
        },
      ),
    );
  }
}