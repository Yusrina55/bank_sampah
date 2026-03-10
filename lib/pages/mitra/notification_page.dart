import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets/app_back_button.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> notifications = [
      {
        "title": "Jadwal Diproses",
        "message": "Jadwal penjemputan kamu sedang diproses.",
        "time": "2 menit lalu"
      },
      {
        "title": "Jadwal Dijemput",
        "message": "Sampah kamu berhasil dijemput.",
        "time": "1 hari lalu"
      },
      {
        "title": "Jadwal Disetujui",
        "message": "Ajuan jadwal penjemputan kamu telah disetujui.",
        "time": "1 hari lalu"
      },  
    ];

    return Scaffold(
      backgroundColor: blue1,
      body: SafeArea(
        child: Column(
          children: [

            // ===== HEADER =====
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
              child: Row(
                children: [
                  const AppBackButton(),
                  const SizedBox(width: 16),
                  Text(
                    "Notifikasi",
                    style: semiBold24.copyWith(color: white),
                  ),
                ],
              ),
            ),

            // ===== CONTENT =====
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
                child: notifications.isEmpty
                    ? Center(
                        child: Text(
                          "Belum ada notifikasi",
                          style: medium14.copyWith(color: textgrey1),
                        ),
                      )
                    : ListView.separated(
                        itemCount: notifications.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          final notif = notifications[index];

                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: filledgrey,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  notif["title"]!,
                                  style: semiBold14.copyWith(
                                    color: textblack,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  notif["message"]!,
                                  style: regular12.copyWith(
                                    color: textgrey1,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  notif["time"]!,
                                  style: regular12.copyWith(
                                    color: textgrey2,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
