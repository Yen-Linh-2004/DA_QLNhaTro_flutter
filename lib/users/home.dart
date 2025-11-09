// import 'package:flutter/material.dart';

// class UserHomePage extends StatelessWidget {
//   const UserHomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xfff9f9f9),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: const Text(
//           "Dashboard",
//           style: TextStyle(
//             color: Colors.black87,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: false,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Tổng quan hệ thống quản lý phòng trọ",
//               style: TextStyle(fontSize: 15, color: Colors.black54),
//             ),
//             const SizedBox(height: 16),

//             // ==== Tổng quan ====
//             Wrap(
//               spacing: 12,
//               runSpacing: 12,
//               children: [
//                 _summaryCard(Icons.home, "Tổng số phòng", "48", "+2 so với tháng trước", Colors.blue),
//                 _summaryCard(Icons.person, "Phòng đã thuê", "42", "+5 so với tháng trước", Colors.green),
//                 _summaryCard(Icons.lock_open, "Phòng trống", "6", "-3 so với tháng trước", Colors.amber),
//                 _summaryCard(Icons.attach_money, "Doanh thu tháng", "125.5M", "+12% so với tháng trước", Colors.purple),
//               ],
//             ),

//             const SizedBox(height: 20),

//             // ==== Tình trạng phòng ====
//             const Text(
//               "Tình trạng phòng theo tầng",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             ),
//             const SizedBox(height: 10),

//             _floorStatus("Tầng 1", 10, 12),
//             _floorStatus("Tầng 2", 11, 12),
//             _floorStatus("Tầng 3", 9, 12),
//             _floorStatus("Tầng 4", 12, 12),

//             const SizedBox(height: 10),
//             _fillRate(0.875),

//             const SizedBox(height: 24),

//             // ==== Hoạt động gần đây ====
//             const Text(
//               "Hoạt động gần đây",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             ),
//             const SizedBox(height: 10),

//             _activityTile(Icons.payment, "Thanh toán tiền phòng", "Nguyễn Văn A - Phòng 101", "2 giờ trước", Colors.green),
//             _activityTile(Icons.add_box, "Đặt phòng mới", "Trần Thị B - Phòng 205", "4 giờ trước", Colors.blue),
//             _activityTile(Icons.build, "Yêu cầu bảo trì", "Sửa chữa điều hòa - Phòng 303", "6 giờ trước", Colors.orange),
//             _activityTile(Icons.description, "Gia hạn hợp đồng", "Lê Văn C - Phòng 102", "1 ngày trước", Colors.purple),
//             _activityTile(Icons.warning, "Vi phạm nội quy", "Tiếng ồn - Phòng 401", "2 ngày trước", Colors.red),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _summaryCard(IconData icon, String title, String value, String change, Color color) {
//     return Container(
//       width: 170,
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12.withOpacity(0.05),
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, color: color, size: 28),
//           const SizedBox(height: 8),
//           Text(title, style: const TextStyle(color: Colors.black54)),
//           Text(
//             value,
//             style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//           ),
//           Text(
//             change,
//             style: TextStyle(fontSize: 13, color: color),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _floorStatus(String name, int rented, int total) {
//     final percent = rented / total;
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("$name: $rented/$total phòng đã thuê"),
//           const SizedBox(height: 6),
//           ClipRRect(
//             borderRadius: BorderRadius.circular(6),
//             child: LinearProgressIndicator(
//               value: percent,
//               color: Colors.green,
//               backgroundColor: Colors.grey[300],
//               minHeight: 8,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _fillRate(double rate) {
//     return Container(
//       margin: const EdgeInsets.only(top: 12),
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12.withOpacity(0.05),
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const Text("Tỷ lệ lấp đầy", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
//           Text("${(rate * 100).toStringAsFixed(1)}%", style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
//         ],
//       ),
//     );
//   }

//   Widget _activityTile(IconData icon, String title, String subtitle, String time, Color color) {
//     return ListTile(
//       contentPadding: EdgeInsets.zero,
//       leading: CircleAvatar(
//         backgroundColor: color.withOpacity(0.15),
//         child: Icon(icon, color: color),
//       ),
//       title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
//       subtitle: Text("$subtitle\n$time", style: const TextStyle(fontSize: 12, color: Colors.black54)),
//       isThreeLine: true,
//     );
//   }
// }


import 'package:flutter/material.dart';

class TenantHomePage extends StatelessWidget {
  const TenantHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: const Text('Hello, Tenant!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
      body: SingleChildScrollView(
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
            _notificationCard("Cắt điện bảo trì", "Ngày 12/11 sẽ cắt điện từ 8h-10h sáng."),
            _notificationCard("Lịch thu tiền phòng", "Thu tiền phòng vào ngày 5 hàng tháng."),
          ],
        ),
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
                  Text("Phòng 101A",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text("Tình trạng: Đang thuê",
                      style: TextStyle(color: Colors.green)),
                  SizedBox(height: 4),
                  Text("Hợp đồng hết hạn: 10/12/2025",
                      style: TextStyle(color: Colors.black54)),
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
        "onTap": () {}
      },
      {
        "icon": Icons.build_circle,
        "label": "Yêu cầu sửa chữa",
        "color": Colors.red[400],
        "onTap": () {}
      },
      {
        "icon": Icons.payments,
        "label": "Thanh toán",
        "color": Colors.green[400],
        "onTap": () {}
      },
      {
        "icon": Icons.message,
        "label": "Tin nhắn",
        "color": Colors.blue[400],
        "onTap": () {}
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
                      fontSize: 16),
                )
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
        title: Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Text(content),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }
}
