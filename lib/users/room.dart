import 'package:flutter/material.dart';

class RoomPage extends StatelessWidget {
  const RoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fb),
      appBar: AppBar(
        title: const Text(
          "Quản lý thông tin phòng trọ",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRoomInfoCard(),

            const SizedBox(height: 16),

            // --- Người thuê chính ---
            _buildMainTenantCard(),

            const SizedBox(height: 16),

            // --- Thành viên ---
            _buildMembersCard(),
          ],
        ),
      ),
    );
  }

  // ===== CARD THÔNG TIN PHÒNG =====
  Widget _buildRoomInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Thông tin phòng",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _infoRow("Số phòng:", "A401"),
          _infoRow("Tầng:", "Tầng 4"),
          _infoRow("Giá thuê:", "2.500.000 VND/tháng",
              color: Colors.green, isBold: true),
          _infoRow("Tiền cọc:", "2.500.000 VND",
              color: Colors.redAccent, isBold: true),
          _infoRow("Diện tích:", "25m²"),
          _infoRow("Ngày vào ở:", "2024-01-15"),
          _infoRow("Loại phòng:", "Studio"),
          _infoRow("Trạng thái:", "Đang hiệu lực",
              color: Colors.green, isBold: true),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 10),

          // Tiện nghi & Dịch vụ
          LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFeatureList("Tiện nghi", [
                    "Giường + nệm",
                    "Tủ quần áo",
                    "Máy lạnh",
                    "WC riêng",
                    "Bàn làm việc",
                  ]),
                  const SizedBox(height: 12),
                  _buildFeatureList(
                    "Dịch vụ",
                    [
                      "Điện (theo công tơ)",
                      "Nước (theo số người)",
                      "Internet (Gói chung)",
                      "Thu gom rác",
                      "Gửi xe",
                    ],
                    icon: Icons.favorite_border,
                    color: Colors.purple,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _infoRow(
    String label,
    String value, {
    Color? color,
    bool isBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(color: Colors.black54, fontSize: 16),
            ),
          ),
          Expanded(
            child: Text(
              value,
              softWrap: true,
              style: TextStyle(
                color: color ?? Colors.black87,
                fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureList(
    String title,
    List<String> items, {
    IconData icon = Icons.check_circle,
    Color color = Colors.blue,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(width: 6),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: color,
                fontSize: 18,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ...items.map(
          (e) => Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.circle, size: 6, color: Colors.black45),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    e,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    style:
                        const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ===== NGƯỜI THUÊ CHÍNH =====
  Widget _buildMainTenantCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _boxDecoration(color: const Color(0xffeef3ff)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Người thuê chính",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const Chip(
                label: Text(
                  "Chủ hợp đồng",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                backgroundColor: Colors.blue,
              ),
            ],
          ),
          const SizedBox(height: 12),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const CircleAvatar(
              radius: 24,
              backgroundColor: Colors.blueAccent,
              child: Text("A", style: TextStyle(color: Colors.white)),
            ),
            title: const Text(
              "Nguyễn Văn An",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(height: 4),
                Text("0912345678"),
                Text("nguyenvan.an@email.com"),
                Text("Vào ở: 2024-01-15"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===== THÀNH VIÊN =====
  Widget _buildMembersCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Thành viên trong phòng (2)",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          _memberTile(
            "Trần Thị B",
            "0987654321",
            "tranthib@email.com",
            "2024-02-01",
          ),
          const Divider(),
          _memberTile(
            "Lê Văn C",
            "0923456789",
            "levanc@email.com",
            "2024-02-15",
          ),
        ],
      ),
    );
  }

  Widget _memberTile(
    String name,
    String phone,
    String email,
    String dateJoined,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: Colors.deepPurple.shade100,
        child: Text(
          name[0],
          style: const TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(phone),
          Text(email),
          Text(
            "Vào ở: $dateJoined",
            style: const TextStyle(color: Colors.black54, fontSize: 12),
          ),
        ],
      ),
      trailing: const Text(
        "Thành viên",
        style: TextStyle(color: Colors.grey, fontSize: 12),
      ),
    );
  }

  // ===== BO GÓC + BÓNG ĐỔ =====
  BoxDecoration _boxDecoration({Color color = Colors.white}) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }
}
