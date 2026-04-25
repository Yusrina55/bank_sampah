import 'package:flutter/material.dart';
import '../../../../theme.dart';
import '../../../../widgets/app_back_button.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/recap_tab.dart';
import '../../../../widgets/mitra_schedule_card.dart';
import '../../../../widgets/mitra_list_card.dart';
import '../../../../widgets/app_search.dart';
import 'create_jadwal_mitra.dart';
import 'detail_jadwal_mitra.dart';
import 'create_mitra.dart';
import 'detail_data_mitra.dart';

class MitraPage extends StatefulWidget {
  const MitraPage({super.key});

  @override
  State<MitraPage> createState() => _MitraPageState();
}

class _MitraPageState extends State<MitraPage> {
  int _selectedTab = 0; // 0 = Ajukan Jadwal, 1 = Data Mitra
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ===== DUMMY DATA TAB 1 =====
  static final List<Map<String, dynamic>> dummyJadwalMitra = [
    {'time': '10.00', 'date': '20/12/2025', 'name': 'Pabrik Kertas', 'weight': 25.0},
  ];

  static final List<Map<String, dynamic>> dummyJadwalDiajukan = [
  {
    'time': '10.00',
    'date': '20/12/2025',
    'name': 'Pabrik Plastik A',
    'weight': 35.0,
    'status': 'Menunggu Persetujuan',                                   
    'alasanTolak': null,                                   
  },
];

  // ===== DUMMY DATA TAB 2 =====
  static final List<Map<String, dynamic>> dummyDaftarMitra = [
    {
      'kategori': 'Kertas',
      'items': ['Pabrik Kertas A'],
    },
    {
      'kategori': 'Plastik',
      'items': ['Pabrik Plastik A', 'Pabrik Plastik B'],
    },
    {
      'kategori': 'Besi dan Logam',
      'items': ['Pabrik Besi A', 'Pabrik Besi B'],
    },
    {
      'kategori': 'Elektronik',
      'items': ['Toko Elektronik A'],
    },
  ];

  // ===== DUMMY DATA HISTORY =====
  static final List<Map<String, dynamic>> dummyRiwayat = [
    {'time': '09.00', 'date': '15/12/2025', 'name': 'Pabrik Kertas A', 'weight': 30.0},
    {'time': '13.00', 'date': '10/12/2025', 'name': 'Pabrik Plastik A', 'weight': 45.0},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: AppBackButton(
            onTap: () => Navigator.pop(context),
          ),
        ),
        title: Text(
          'Mitra',
          style: medium16.copyWith(color: blue1),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Column(
              children: [
                /// ===== TAB BAR (sticky) =====
                RecapTab(
                  tabs: const ['Ajukan Jadwal', 'Data Mitra'],
                  selectedIndex: _selectedTab,
                  onTabChanged: (index) => setState(() => _selectedTab = index),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),

          /// ===== CONTENT =====
          Expanded(
            child: _selectedTab == 0
                ? _buildAjukanJadwal()
                : _buildDataMitra(),
          ),
        ],
      ),
    );
  }

  // ========== TAB 1: AJUKAN JADWAL ==========
  Widget _buildAjukanJadwal() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        AppDatePickerField(          // hanya muncul di tab 1
          controller: _searchController,
          enabled: true,
          onDateSelected: (date) {
            // TODO: filter by date
          },
        ),

        const SizedBox(height: 16),
        /// JADWAL MITRA
        Text('Jadwal Mitra', style: semiBold12),
        const SizedBox(height: 12),
        ...dummyJadwalMitra.map(
          (item) => MitraScheduleCard(
            time: item['time'],
            date: item['date'],
            name: item['name'],
            jenisSampah: item['jenisSampah'], 
            weight: item['weight'],
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailJadwalMitraPage(
                  mode: JadwalDetailMode.jadwalMitra,
                  jenisSampah: 'Plastik',
                  namaMitra: item['name'],
                  berat: '${item['weight'].toStringAsFixed(0)} karung',
                  jadwalAmbil: item['date'],
                  time: item['time'],
                  status: 'Diproses',
                  harga: '100.000',
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),

        /// JADWAL DIAJUKAN
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Jadwal Diajukan', style: semiBold12),
            SizedBox(
              width: 140,
              child: AppButton(
                text: 'Tambah',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CreateJadwalMitraPage()),
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...dummyJadwalDiajukan.map(
          (item) => MitraScheduleCard(
            time: item['time'],
            date: item['date'],
            name: item['name'],
            jenisSampah: item['jenisSampah'],
            weight: item['weight'],
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailJadwalMitraPage(
                  mode: JadwalDetailMode.ajuanJadwal,
                  jenisSampah: 'Plastik',
                  namaMitra: item['name'],
                  berat: '${item['weight'].toStringAsFixed(0)} karung',
                  jadwalAmbil: item['date'],
                  time: item['time'],
                  status: item['status'] ?? 'Menunggu Persetujuan',          
                  alasanTolak: item['alasanTolak'],           
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),

        /// RIWAYAT TERBARU 
        Text('Riwayat Terbaru', style: semiBold12),
        const SizedBox(height: 12),

        ...dummyRiwayat.map(
          (item) => MitraScheduleCard(
            time: item['time'],
            date: item['date'],
            name: item['name'],
            jenisSampah: item['jenisSampah'],  // tambahkan jenisSampah
            weight: item['weight'],
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailJadwalMitraPage(
                  mode: JadwalDetailMode.riwayat,
                  jenisSampah: 'Plastik',
                  namaMitra: item['name'],
                  berat: '${item['weight'].toStringAsFixed(0)} karung',
                  jadwalAmbil: item['date'],
                  time: item['time'],
                  status: 'Selesai',
                  harga: '100.000',
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ========== TAB 2: DATA MITRA ==========
  Widget _buildDataMitra() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Daftar Mitra', style: semiBold14.copyWith(color: textblack)),
            SizedBox(
              width: 140,
              child: AppButton(
                text: 'Tambah',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CreateMitraPage()),
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...dummyDaftarMitra.map(
          (group) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                group['kategori'],
                style: semiBold14.copyWith(color: textblack),
              ),
              const SizedBox(height: 8),
              ...(group['items'] as List<String>).map(
                (nama) => MitraListCard(
                  name: nama,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailMitraPage(
                        jenisSampah: group['kategori'],
                        namaMitra: nama,
                        noTelp: '082123456789',
                        alamat: 'Jl. Mawar No.13, Patrang',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
      ],
    );
  }
}