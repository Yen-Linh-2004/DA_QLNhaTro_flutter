import 'package:flutter/material.dart';
import 'package:flutter_application/UI/admin/main_page.dart';
import 'package:flutter_application/UI/admin/room_entity/room_entity.dart';
import 'package:flutter_application/UI/users/usemain.dart';

class HomeMobilePage extends StatefulWidget {
  const HomeMobilePage({super.key});

  @override
  State<HomeMobilePage> createState() => _HomeMobilePage();
}

class _HomeMobilePage extends State<HomeMobilePage> {
  final List<Room> rooms = [
    Room(
      id: "R001",
      name: "Phòng 101",
      description: "Phòng ban công - dãy 2",
      area: 20,
      price: 2500000,
      imageUrl: "lib/assets/images/room1.jpg",
      isAvailable: true,
    ),
    Room(
      id: "R002",
      name: "Phòng 102",
      description: "Phòng thường - dãy 3",
      area: 18,
      price: 2200000,
      imageUrl: "lib/assets/images/room2.jpg",
      isAvailable: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            /// Hero Section — bọc thêm Container nền trắng + bóng
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: _hero(context),
            ),

            SizedBox(height: 16),

            /// Danh sách phòng — thêm title + spacing đẹp hơn
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Phòng còn trống", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            SizedBox(height: 10),

            /// Room Enity List
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: List.generate(
                  rooms.length,
                  (index) => Container(
                    margin: EdgeInsets.only(bottom: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: RoomCard(room: rooms[index]),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            _features(context),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Hero Mobile
  Widget _hero(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFEFF6FF), Color(0xFFEDEBFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Text(
            "Tìm phòng trọ lý tưởng",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          Text(
            "An toàn - Tiện nghi - nhanh chóng",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4F46E5),
            ),
          ),
          SizedBox(height: 14),
          Text(
            "Hệ thống phòng trọ chuyên nghiệp với nhiều lựa chọn đã được xác thực. Tìm tổ ấm của bạn ngay hôm nay.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.black54),
          ),
          SizedBox(height: 18),

          Column(
            children: [
              FilledButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TenantHomePage()),
                  );
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Color(0xFF4F46E5),
                  padding: EdgeInsets.symmetric(vertical: 18),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  "Xem trải nghiệm khách thuê",
                  style: TextStyle(fontSize: 14),
                ),
              ),
              SizedBox(height: 10),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 18),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text("Bạn là chủ trọ?", style: TextStyle(fontSize: 14)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Features Mobile
  Widget _features(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final aspectRatio = screenWidth < 360 ? 0.85 : 1.05;

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
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Text("An tâm sống cùng Hệ thống", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          SizedBox(height: 6),
          Text("Trải nghiệm dịch vụ phòng trọ chuyên nghiệp, \nminh bạch và an toàn.", style: TextStyle(color: Colors.black54), textAlign: TextAlign.center),
          SizedBox(height: 18),
          /// GRID
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: aspectRatio,
            ),
            itemBuilder: (context, index) {
              final e = items[index];
              return _featureCard(
                e["icon"] as IconData,
                e["title"] as String,
                e["desc"] as String,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _featureCard(IconData icon, String title, String desc) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Color(0xFFEDEBFF),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Icon(icon, size: 26, color: Color(0xFF4F46E5)),
          ),
          SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4),
          Text(
            desc,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54, fontSize: 14),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
