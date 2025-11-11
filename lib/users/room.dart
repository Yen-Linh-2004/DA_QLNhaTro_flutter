import 'package:flutter/material.dart';

class RoomPage extends StatelessWidget {
  const RoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      // appBar: AppBar(
      //   title: const Text(
      //     "Phòng của tôi", 
      //     style: TextStyle(
      //       fontWeight: FontWeight.bold,
      //       color: Colors.black87,
      //       fontSize: 20,
      //     ),
      //   ),
      //   backgroundColor: Colors.white,
      //   centerTitle: true,
      //   elevation: 1, 
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.edit_outlined, color: Colors.blueAccent),
      //       onPressed: () {
      //       },
      //     ),
      //   ],
      // ),
     
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- THÔNG TIN PHÒNG ---
            _buildSectionTitle(context, "Thông tin phòng", Icons.home_outlined),
            SizedBox(height: 8),
            _buildRoomInfoCard(),

            SizedBox(height: 20),

            // --- NGƯỜI THUÊ CHÍNH ---
            _buildSectionTitle(context, "Người thuê chính", Icons.person_pin_outlined),
            SizedBox(height: 8),
            _buildMainTenantCard(),

            SizedBox(height: 20),

            // --- THÀNH VIÊN ---
            _buildSectionTitle(context, "Thành viên trong phòng (2)", Icons.group_outlined),
            const SizedBox(height: 8),
            _buildMembersCard(),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
      // --- NÚT HÀNH ĐỘNG NỔI BẬT ---
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     // Xử lý xem hợp đồng hoặc các hành động khác
      //   },
      //   icon: const Icon(Icons.article_outlined),
      //   label: const Text("Xem Hợp Đồng"),
      //   backgroundColor: Colors.blueAccent,
      // ),
    );
  }

  // ===== TIÊU ĐỀ PHẦN (MỚI) =====
  Widget _buildSectionTitle(BuildContext context, String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.blueAccent, size: 24),
        SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  // ===== CARD THÔNG TIN PHÒNG (CẢI TIẾN) =====
  Widget _buildRoomInfoCard() {
    return Container(
      padding: EdgeInsets.all(18),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Số phòng & Trạng thái
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Phòng A401",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800]),
              ),
              Chip(
                label: Text("Đang hiệu lực", style: TextStyle(color: Colors.white, fontSize: 13)),
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              ),
            ],
          ),
          SizedBox(height: 10),
          Divider(height: 1, color: Colors.black12),
          SizedBox(height: 10),

          // Thông tin cơ bản 2 cột
        //  _buildInfoGrid([
            _infoRow("Tầng:", "Tầng 4", Icons.layers_outlined),
            _infoRow("Diện tích:", "25m²", Icons.aspect_ratio),
            _infoRow("Loại phòng:", "Studio", Icons.house_outlined),
            _infoRow("Ngày vào ở:", "2024-01-15", Icons.date_range),
         // ]),

          SizedBox(height: 15),
          // Giá thuê & Tiền cọc (Làm nổi bật hơn)
          _infoRow("Giá thuê:", "2.500.000 VND/tháng", Icons.attach_money,
              color: Colors.green.shade700, isBold: true),
          _infoRow("Tiền cọc:", "2.500.000 VND", Icons.money_off,
              color: Colors.redAccent, isBold: true),

          SizedBox(height: 15),
          Divider(height: 1, color: Colors.black12),
          SizedBox(height: 15),

          // Tiện nghi & Dịch vụ (Đã sửa lại bố cục)
          LayoutBuilder(
            builder: (context, constraints) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildFeatureList(
                      "Tiện nghi",
                      [
                        "Giường + nệm", "Tủ quần áo", "Máy lạnh",
                        "WC riêng", "Bàn làm việc",
                      ],
                      icon: Icons.ac_unit,
                      color: Colors.cyan,
                    ),
                  ),
                  Expanded(
                    child: _buildFeatureList(
                      "Dịch vụ",
                      [
                        "Điện (theo công tơ)", "Nước (theo số người)",
                        "Internet (Gói chung)", "Thu gom rác", "Gửi xe",
                      ],
                      icon: Icons.electrical_services_outlined,
                      color: Colors.purple,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // Hỗ trợ chia 2 cột cho thông tin cơ bản
  Widget _buildInfoGrid(List<Widget> children) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3.5, // Tăng chiều cao của mỗi item
        crossAxisSpacing: 10,
        mainAxisSpacing: 0,
      ),
      itemCount: children.length,
      itemBuilder: (context, index) => children[index],
    );
  }

  // Cải tiến _infoRow
  Widget _infoRow(
    String label,
    String value,
    IconData icon, {
    Color? color,
    bool isBold = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.black54),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: TextStyle(color: Colors.black54, fontSize: 15),
            ),
          ),
          Text(
            value,
            softWrap: true,
            style: TextStyle(
              color: color ?? Colors.black87,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  // Cải tiến _buildFeatureList
  Widget _buildFeatureList(
    String title,
    List<String> items, {
    IconData icon = Icons.check_circle_outline,
    Color color = Colors.blue,
  }) {
    return Padding(
      padding: EdgeInsets.only(right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              SizedBox(width: 4),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          ...items.map(
            (e) => Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check, size: 14, color: color.withOpacity(0.8)), // Icon Check nhỏ
                  SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      e,
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===== NGƯỜI THUÊ CHÍNH (CẢI TIẾN) =====
  Widget _buildMainTenantCard() {
    return Container(
      padding: EdgeInsets.all(18),
      decoration: _boxDecoration(color: Colors.blue.shade50), // Nền xanh nhạt
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Nguyễn Văn An", // Tên lên làm tiêu đề chính
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black87),
              ),
              Chip(
                label: Text(
                  "Chủ hợp đồng",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              ),
            ],
          ),
          Divider(height: 20),
          // Thông tin liên hệ chi tiết
          _detailInfoRow(Icons.phone_outlined, "0912345678"),
          _detailInfoRow(Icons.mail_outline, "nguyenvan.an@email.com"),
          _detailInfoRow(Icons.calendar_month, "Vào ở: 2024-01-15"),
        ],
      ),
    );
  }

  // Hỗ trợ hiển thị thông tin chi tiết
  Widget _detailInfoRow(IconData icon, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.black54),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 15, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  // ===== THÀNH VIÊN (CẢI TIẾN) =====
  Widget _buildMembersCard() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: _boxDecoration(),
      child: Column(
        children: [
          _memberTile(
            "Trần Thị B",
            "0987654321",
            "tranthib@email.com",
            "2024-02-01",
            color: Colors.orange.shade100,
            textColor: Colors.orange.shade800,
          ),
          Divider(indent: 12, endIndent: 12),
          _memberTile(
            "Lê Văn C",
            "0923456789",
            "levanc@email.com",
            "2024-02-15",
            color: Colors.green.shade100,
            textColor: Colors.green.shade800,
          ),
        ],
      ),
    );
  }

  // Cải tiến _memberTile
  Widget _memberTile(
    String name,
    String phone,
    String email,
    String dateJoined, {
    required Color color,
    required Color textColor,
  }) {
    return ListTile(
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: color,
        child: Text(
          name[0],
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(name, style: TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(
        "$phone - Vào ở: $dateJoined",
        style: TextStyle(fontSize: 13, color: Colors.black54),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: () {
        // Xử lý xem chi tiết thành viên
      },
    );
  }

  // ===== BO GÓC + BÓNG ĐỔ (ĐẸP HƠN) =====
  BoxDecoration _boxDecoration({Color color = Colors.white}) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(15), // Tăng độ bo tròn
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 10,
          offset: Offset(0, 4),
        ),
      ],
    );
  }
}