import 'package:flutter/material.dart';
import 'package:flutter_application/UI/admin/main_page.dart';
import 'package:flutter_application/UI/admin/room_entity/room_entity.dart';
import 'package:flutter_application/UI/users/usemain.dart';
import 'package:flutter_application/provider/PhongTroProvider.dart';
import 'package:provider/provider.dart';
class HomeMobilePage extends StatefulWidget {
  const HomeMobilePage({super.key});

  @override
  State<HomeMobilePage> createState() => _HomeMobilePage();
}

class _HomeMobilePage extends State<HomeMobilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _hero(context),
            const SizedBox(height: 20),
            const RoomListWidget(),
            const SizedBox(height: 20),
            _features(context),
          ],
        ),
      ),
    );
  }

  // ------ HERO ------
  Widget _hero(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 32),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFEFF6FF), Color(0xFFEDEBFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          const Text(
            "Tìm phòng trọ lý tưởng",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const Text(
            "An toàn - Tiện nghi - nhanh chóng",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4F46E5),
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            "Hệ thống phòng trọ chuyên nghiệp với nhiều lựa chọn đã được xác thực.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.black54),
          ),
          const SizedBox(height: 18),

          FilledButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TenantHomePage()));
            },
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF4F46E5),
              padding: const EdgeInsets.symmetric(vertical: 18),
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text("Xem trải nghiệm khách thuê"),
          ),

          const SizedBox(height: 10),

          OutlinedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => MainPage()));
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 18),
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text("Bạn là chủ trọ?"),
          ),
        ],
      ),
    );
  }

//===================== FEATURES =====================
  Widget _features(BuildContext context) {
    final items = [
      {
        "icon": Icons.meeting_room_outlined,
        "title": "An ninh 24/7",
        "desc": "Camera, cửa vân tay, bảo vệ an toàn.",
      },
      {
        "icon": Icons.person_outline,
        "title": "Minh bạch hợp đồng",
        "desc": "Hợp đồng điện tử rõ ràng.",
      },
      {
        "icon": Icons.calendar_month,
        "title": "Tiện ích đầy đủ",
        "desc": "Wifi, nội thất, giặt sấy tiện lợi.",
      },
      {
        "icon": Icons.build_circle_outlined,
        "title": "Hỗ trợ kỹ thuật",
        "desc": "Xử lý sự cố nhanh chóng.",
      },
      {
        "icon": Icons.bar_chart,
        "title": "Dịch vụ chuyên nghiệp",
        "desc": "Quản lý thân thiện.",
      },
      {
        "icon": Icons.payments_outlined,
        "title": "Vị trí thuận lợi",
        "desc": "Gần trường & văn phòng.",
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          const Text("An tâm sống cùng hệ thống",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1,
            ),
            itemBuilder: (_, i) {
              return Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(items[i]["icon"] as IconData,
                        size: 28, color: Color(0xFF4F46E5)),
                    const SizedBox(height: 8),
                    Text(
                      items[i]["title"] as String,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

//===================== ROOM LIST WIDGET ============================
class RoomListWidget extends StatefulWidget {
  const RoomListWidget({super.key});

  @override
  State<RoomListWidget> createState() => _RoomListWidgetState();
}

class _RoomListWidgetState extends State<RoomListWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PhongTroProvider>(context, listen: false).fetchPhongTrong();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PhongTroProvider>(context);

    if (provider.isLoading) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (provider.phongTrongList.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: Center(child: Text("Không có phòng trống")),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: provider.phongTrongList.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, index) {
        return RoomCard(room: provider.phongTrongList[index]);
      },
    );
  }
}
