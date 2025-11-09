import 'package:flutter/material.dart';

class ContractPage extends StatelessWidget {
  const ContractPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fb),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Thông tin hợp đồng thuê",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        elevation: 0,
        // actions: [
        //   TextButton.icon(
        //     onPressed: () {},
        //     icon: const Icon(Icons.file_copy_outlined, color: Colors.indigo),
        //     label: const Text("Xem hợp đồng đầy đủ",
        //         style: TextStyle(color: Colors.indigo, fontSize: 13)),
        //   )
        // ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildContractInfo(),
            const SizedBox(height: 16),
            _buildImportantNotice(),
          ],
        ),
      ),
    );
  }

  // ===== Thông tin hợp đồng =====
  Widget _buildContractInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(Icons.description_outlined, "Thông tin cơ bản"),
          const SizedBox(height: 8),
          _infoRow("Số hợp đồng:", "HD001-2024"),
          _infoRow("Phòng:", "A401"),
          _infoRow("Người thuê:", "Nguyễn Văn An", isBold: true),
          _infoRow("Số điện thoại:", "0912345678"),
          Row(
            children: [
              Text("Trạng thái: "),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text("Đang hiệu lực",
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _contractDuration(),
          const SizedBox(height: 16),
          _monthlyCost(),
          const SizedBox(height: 16),
          _depositSection(),
        ],
      ),
    );
  }

  // ===== Thời hạn hợp đồng =====
  Widget _contractDuration() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xffeef3ff),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Thời hạn hợp đồng",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 15, color: Colors.indigo)),
          SizedBox(height: 8),
          _durationRow("Ngày ký:", "2024-01-10"),
          _durationRow("Bắt đầu:", "2024-01-15"),
          _durationRow("Kết thúc:", "2025-01-14"),
          _durationRow("Gia hạn tiếp theo:", "2025-01-14",
              highlight: Colors.redAccent),
        ],
      ),
    );
  }

  // ===== Chi phí hàng tháng =====
  Widget _monthlyCost() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xfff0faf2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Chi phí hàng tháng",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.teal, fontSize: 15)),
          const SizedBox(height: 6),
          _infoRow("Tiền thuê phòng:", "2.500.000 ₫",
              color: Colors.green, isBold: true),
          const SizedBox(height: 10),
          _serviceSection(),
        ],
      ),
    );
  }

  Widget _serviceSection() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Dịch vụ",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87)),
          const SizedBox(height: 6),
          _infoRow("Điện:", "3.500đ × 120kWh = 420.000đ"),
          _infoRow("Nước:", "60.000đ / người × 1 = 60.000đ"),
          _infoRow("Internet:", "50.000đ / phòng"),
          _infoRow("Rác:", "40.000đ / phòng"),
          _infoRow("Gửi xe:", "100.000đ / xe × 1 = 100.000đ"),
          const Divider(),
          _infoRow("Tổng dịch vụ:", "670.000đ"),
          _infoRow("TỔNG CỘNG / THÁNG:", "3.170.000đ",
              color: Colors.indigo, isBold: true),
        ],
      ),
    );
  }

  // ===== Tiền cọc =====
  Widget _depositSection() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xfffff6ed),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Tiền cọc",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.deepOrange)),
          SizedBox(height: 6),
          _infoRow("Số tiền:", "2.500.000 ₫",
              color: Colors.redAccent, isBold: true),
          SizedBox(height: 4),
          Text("💡 Tiền cọc = 1 tháng tiền thuê (tự động theo giá phòng)",
              style: TextStyle(fontSize: 12, color: Colors.black54)),
        ],
      ),
    );
  }

  // ===== Lưu ý =====
  Widget _buildImportantNotice() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xfffff9eb),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.amber.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("⚠️ Lưu ý quan trọng",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.orange)),
          SizedBox(height: 8),
          Text("• Hợp đồng sẽ hết hạn vào 2025-01-14"),
          Text("• Liên hệ quản lý trước 30 ngày để gia hạn"),
          Text("• Tiền cọc được hoàn trả khi kết thúc hợp đồng (trừ phát sinh)"),
          Text("• Mọi thay đổi cần có văn bản xác nhận"),
        ],
      ),
    );
  }

  // ===== Tiện ích tái sử dụng =====
  static Widget _infoRow(String label, String value,
      {Color? color, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 130, child: Text(label, style: const TextStyle(color: Colors.black54))),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: color ?? Colors.black87,
                fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _durationRow(String label, String value, {Color? highlight}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(width: 130, child: Text(label, style: TextStyle(color: Colors.grey.shade700))),
          Text(value,
              style: TextStyle(
                color: highlight ?? Colors.black87,
                fontWeight: highlight != null ? FontWeight.bold : FontWeight.normal,
              )),
        ],
      ),
    );
  }

  Widget _sectionTitle(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.indigo),
        const SizedBox(width: 6),
        Text(title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, color: Colors.indigo)),
      ],
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
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
