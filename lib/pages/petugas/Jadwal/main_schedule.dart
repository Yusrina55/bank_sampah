import 'package:flutter/material.dart';
import '../../../theme.dart';
import '../../../widgets/jadwal_tabbar.dart';
import 'schedule_setting.dart';
import 'pickup_schedule.dart';
import 'requested_schedule.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 16),

          Text(
            "Jadwal",
            style: semiBold14.copyWith(color: blue1),
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: JadwalTabBar(
              selectedIndex: selectedTab,
              onTap: (index) {
                setState(() {
                  selectedTab = index;
                });
              },
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: Builder(
              builder: (_) {
                if (selectedTab == 0) {
                  return const ScheduleSetting();
                } else if (selectedTab == 1) {
                  return const PickupSchedule();
                } else {
                  return const RequestedSchedulePage();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}