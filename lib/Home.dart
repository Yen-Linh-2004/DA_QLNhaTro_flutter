import 'package:flutter/material.dart';
import 'package:flutter_application/Rooms/Room.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF007BFF), Color(0xFF5AA9FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.2),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(
                        "https://cdn-icons-png.flaticon.com/512/3135/3135715.png"),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Xin chào 👋",
                            style: TextStyle(color: Colors.white70, fontSize: 14)),
                        Text(
                          "Nguyễn Văn Minh",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      Icon(Icons.notifications_none, color: Colors.white, size: 30),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle),
                          child: Center(
                            child: Text('3', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            // Stats Cards
            GridView.count(
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.2,
              children: [
                StatCard(
                  icon: Icons.trending_up,
                  color: Color(0xFF4CAF50),
                  value: "45.2M",
                  title: "Doanh thu tháng",
                  subtitle: "+12.5% so với tháng trước",
                ),
                StatCard(
                  icon: Icons.home_work_outlined,
                  color: Color(0xFF2196F3),
                  value: "85%",
                  title: "Tỷ lệ lấp đầy",
                  subtitle: "34/40 phòng",
                ),
                StatCard(
                  icon: Icons.receipt_long_outlined,
                  color: Color(0xFFFF9800),
                  value: "12",
                  title: "Hóa đơn chưa thu",
                  subtitle: "8.5M VND",
                ),
                StatCard(
                  icon: Icons.warning_amber_rounded,
                  color: Color(0xFFE53935),
                  value: "7",
                  title: "Yêu cầu xử lý",
                  subtitle: "3 khẩn cấp",
                ),
              ],
            ),
            SizedBox(height: 28),
            Text("Hoạt động gần đây", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            ActivityItem(
              icon: Icons.check_circle_outline,
              color: Colors.green,
              title: "Thanh toán hóa đơn phòng A201",
              amount: "+3.2M",
              subtitle: "Trần Thị Lan • 2 phút trước",
            ),
            ActivityItem(
              icon: Icons.login,
              color: Colors.blueAccent,
              title: "Check-in phòng B105",
              subtitle: "Lê Văn Đức • 15 phút trước",
            ),
            ActivityItem(
              icon: Icons.electrical_services_outlined,
              color: Colors.orangeAccent,
              title: "Yêu cầu sửa chữa điện",
              subtitle: "Phòng C302 • 1 giờ trước",
            ),
            ActivityItem(
              icon: Icons.assignment_outlined,
              color: Colors.purple,
              title: "Ký hợp đồng mới",
              subtitle: "Phạm Minh Tuấn • 2 giờ trước",
            ),
          ],
        ),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String value;
  final String title;
  final String subtitle;

  const StatCard({
    super.key,
    required this.icon,
    required this.color,
    required this.value,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.15),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(radius: 18, backgroundColor: color.withOpacity(0.1), child: Icon(icon, color: color, size: 22)),
          SizedBox(height: 10),
          Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text(title, style: TextStyle(color: Colors.black54)),
          SizedBox(height: 4),
          Text(subtitle, style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class ActivityItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final String amount;

  const ActivityItem({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    this.amount = '',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          CircleAvatar(radius: 20, backgroundColor: color.withOpacity(0.1), child: Icon(icon, color: color, size: 22)),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                SizedBox(height: 2),
                Text(subtitle, style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          if (amount.isNotEmpty)
            Text(amount, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }
}
