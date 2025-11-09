import 'package:flutter/material.dart';
import 'package:flutter_application/generalPage/register.dart';
import 'package:flutter_application/main_page.dart';

const kPrimary = Color(0xFF4F46E5);

class HomeMobilePage extends StatelessWidget {
  const HomeMobilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [_hero(context), _features(context)],
        ),
      ),
    );
  }

  // Hero Mobile
  Widget _hero(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 32),
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
            "Hệ thống quản lý",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const Text(
            "phòng trọ thông minh",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: kPrimary,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            "Giải pháp toàn diện cho chủ trọ",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.black54),
          ),
          const SizedBox(height: 18),

          Column(
            children: [
              FilledButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    ),
                  );
                },
                style: FilledButton.styleFrom(
                  backgroundColor: kPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text("Bắt đầu ngay", style: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainPage(),
                          ),
                        );
                      },
                      child: Text("Demo Admin"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const RegisterPage(),
                        //   ),
                        // );
                      },
                      child: const Text("Demo Khách"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Features Mobile
  Widget _features(BuildContext context) {
    final items = [
      {
        "icon": Icons.meeting_room_outlined,
        "title": "Quản lý phòng",
        "desc": "Theo dõi tình trạng",
      },
      {
        "icon": Icons.person_outline,
        "title": "Khách thuê",
        "desc": "Lưu trữ thông tin",
      },
      {
        "icon": Icons.calendar_month,
        "title": "Đặt phòng",
        "desc": "Giữ chỗ online",
      },
      {
        "icon": Icons.payments_outlined,
        "title": "Thanh toán",
        "desc": "Tự động tính hóa đơn",
      },
      {
        "icon": Icons.build_circle_outlined,
        "title": "Bảo trì",
        "desc": "Theo dõi sửa chữa",
      },
      {"icon": Icons.bar_chart, "title": "Thống kê", "desc": "Xem doanh thu"},
    ];
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            "Tính năng nổi bật",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          const Text(
            "Quản lý phòng trọ dễ dàng hơn",
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 16),

          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.95,
            children: items
                .map(
                  (e) => _featureCard(
                    e["icon"] as IconData,
                    e["title"] as String,
                    e["desc"] as String,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _featureCard(IconData icon, String title, String desc) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFFEDEBFF),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Icon(icon, size: 28, color: kPrimary),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 4),
            Text(
              desc,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black54, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
