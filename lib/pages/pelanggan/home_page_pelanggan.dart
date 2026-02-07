import 'package:bank_sampah/theme.dart';
import 'package:flutter/material.dart';
import '../../widgets/schedule_card.dart';
import '../../widgets/blue_balanced_card.dart';
import 'create_schedule_page.dart';

class HomePagePelanggan extends StatelessWidget {
  const HomePagePelanggan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              //header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Selamat Datang,",
                        style: semiBold14.copyWith(
                          color: textblack,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Rina",
                        style: semiBold14.copyWith(
                          color: blue1,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.notifications_none,
                          color: blue1,
                          size: 28,
                          
                        ),
                      ),
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: filledgrey,
                        child: 
                        Text(
                          "R", 
                          style: regular16.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),

              const SizedBox(height: 16),


              // BLUE BALANCE CARD
              BlueBalanceCard(
                onCreateSchedule: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateSchedulePage(),
                    ),
                  );
                },
              ),
              
              const SizedBox(height: 24),
              Text("Jadwal Dibuat",
                  style: semiBold12.copyWith(color: textblack)),
              const SizedBox(height: 12),

              ScheduleCard(
                time: "08.00-10.00",
                date: "13/12/2025",
                name: "Rina",
                location: "Kecamatan Tegalgede, Perum Kaliurang NII",
              ),

              const SizedBox(height: 16),

              Text("Riwayat Terbaru",
                  style: semiBold12.copyWith(color: textblack)),

              const SizedBox(height: 12),

              ScheduleCard(
                time: "08.00-10.00",
                date: "21/12/2025",
                name: "Rina",
                location: "Kecamatan Tegalgede, Perum Kaliurang NII",
              ),
              ScheduleCard(
                time: "08.00-10.00",
                date: "21/12/2025",
                name: "Rina",
                location: "Kecamatan Tegalgede, Perum Kaliurang NII",
              ),
              ScheduleCard(
                time: "08.00-10.00",
                date: "21/12/2025",
                name: "Rina",
                location: "Kecamatan Tegalgede, Perum Kaliurang NII",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
