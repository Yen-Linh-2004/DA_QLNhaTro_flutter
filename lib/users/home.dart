import 'package:flutter/material.dart';
import 'package:flutter_application/users/RepairRequestDetail/RepairRequest.dart';
import 'package:flutter_application/users/contact.dart';
import 'package:flutter_application/users/room.dart';

// Giả sử bạn đã có các trang khác

class TenantHomePage extends StatefulWidget {
  const TenantHomePage({super.key});
  State<TenantHomePage> createState() => _TenantHomePage();
}

class _TenantHomePage extends State<TenantHomePage> {
  int _selectedIndex = 0;

  // Danh sách các trang
  final List<Widget> _pages = [
    const TenantHomeContentPage(), // Trang Home (hiện tại nội dung bạn viết)
    const RoomPage(),        // Trang Phòng trọ
    const ContractPage(),    // Trang Hợp đồng
    const RepairRequestPage(),    // Trang Bảo trì
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: const Text(
          'Hello, Tenant!',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.meeting_room_outlined, color: Colors.black),
            label: 'Phòng trọ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_emergency, color: Colors.black),
            label: 'Hợp đồng',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.request_page, color: Colors.black),
            label: 'Bảo trì',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

// ================= Nội dung trang Home =================
class TenantHomeContentPage extends StatelessWidget {
  const TenantHomeContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Thông tin phòng ---
          _roomInfoCard(),

          const SizedBox(height: 16),

          // --- Các chức năng chính ---
          const Text(
            "Chức năng nhanh",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _quickActionGrid(context),

          const SizedBox(height: 20),

          // --- Thông báo ---
          const Text(
            "Thông báo gần đây",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _notificationCard(
            "Cắt điện bảo trì",
            "Ngày 12/11 sẽ cắt điện từ 8h-10h sáng.",
          ),
          _notificationCard(
            "Lịch thu tiền phòng",
            "Thu tiền phòng vào ngày 5 hàng tháng.",
          ),
        ],
      ),
    );
  }

  // ====== Widget Components ======
  Widget _roomInfoCard() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.meeting_room, size: 50, color: Colors.teal),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Phòng 101A",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Tình trạng: Đang thuê",
                    style: TextStyle(color: Colors.green),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Hợp đồng hết hạn: 10/12/2025",
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _quickActionGrid(BuildContext context) {
    final List<Map<String, dynamic>> actions = [
      {
        "icon": Icons.receipt_long,
        "label": "Hóa đơn",
        "color": Colors.orange[400],
        "onTap": () {},
      },
      {
        "icon": Icons.build_circle,
        "label": "Yêu cầu sửa chữa",
        "color": Colors.red[400],
        "onTap": () {},
      },
      {
        "icon": Icons.payments,
        "label": "Thanh toán",
        "color": Colors.green[400],
        "onTap": () {},
      },
      {
        "icon": Icons.message,
        "label": "Tin nhắn",
        "color": Colors.blue[400],
        "onTap": () {},
      },
    ];

    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: actions.map((action) {
        return GestureDetector(
          onTap: action["onTap"],
          child: Container(
            decoration: BoxDecoration(
              color: action["color"],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(action["icon"], size: 40, color: Colors.white),
                const SizedBox(height: 8),
                Text(
                  action["label"],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _notificationCard(String title, String content) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        leading: const Icon(Icons.notifications, color: Colors.teal),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(content),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }
}
