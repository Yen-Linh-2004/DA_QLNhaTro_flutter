import 'package:flutter/material.dart';
import 'package:flutter_application/Rooms/Room.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => DashboardPage();
// }

// class _HomePageState extends State<HomePage> {
//   int _selectedIndex = 0;

//   final List<Widget> _pages = const [
//     DashboardPage(),
//     RoomPage(),
//     Placeholder(),
//     Placeholder(),
//     Placeholder(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF3F6FA),
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         selectedItemColor: const Color(0xFF007BFF),
//         unselectedItemColor: Colors.grey,
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: Colors.white,
//         elevation: 8,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Trang chủ"),
//           BottomNavigationBarItem(icon: Icon(Icons.meeting_room_outlined), label: "Phòng"),
//           BottomNavigationBarItem(icon: Icon(Icons.receipt_long_outlined), label: "Hóa đơn"),
//           BottomNavigationBarItem(icon: Icon(Icons.analytics_outlined), label: "Thống kê"),
//           BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Tài khoản"),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         backgroundColor: const Color(0xFF007BFF),
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF007BFF), Color(0xFF5AA9FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(
                        "https://cdn-icons-png.flaticon.com/512/3135/3135715.png"),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
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
                      const Icon(Icons.notifications_none,
                          color: Colors.white, size: 30),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: const BoxDecoration(
                            color: Colors.redAccent,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Text('3',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Stats Cards
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.2,
              children: const [
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

            const SizedBox(height: 28),

            const Text(
              "Hoạt động gần đây",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            const ActivityItem(
              icon: Icons.check_circle_outline,
              color: Colors.green,
              title: "Thanh toán hóa đơn phòng A201",
              amount: "+3.2M",
              subtitle: "Trần Thị Lan • 2 phút trước",
            ),
            const ActivityItem(
              icon: Icons.login,
              color: Colors.blueAccent,
              title: "Check-in phòng B105",
              subtitle: "Lê Văn Đức • 15 phút trước",
            ),
            const ActivityItem(
              icon: Icons.electrical_services_outlined,
              color: Colors.orangeAccent,
              title: "Yêu cầu sửa chữa điện",
              subtitle: "Phòng C302 • 1 giờ trước",
            ),
            const ActivityItem(
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
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: color.withOpacity(0.1),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(color: Colors.black54)),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
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
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: color.withOpacity(0.1),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          if (amount.isNotEmpty)
            Text(amount,
                style: TextStyle(
                    color: color, fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }
}
