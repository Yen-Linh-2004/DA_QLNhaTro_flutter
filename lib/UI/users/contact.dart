import 'package:flutter/material.dart';

class ContractPage extends StatelessWidget {
  const ContractPage({super.key});

  static Color primaryColor = Colors.teal;
  static Color highlightColor = Colors.deepOrange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildContractInfo(),
            SizedBox(height: 20),
            _buildImportantNotice(), 
            SizedBox(height: 5),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {},
      //   backgroundColor: Colors.blue,
      //   label: Text("Xem hơp đồng đầy đủ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      // ),
    );
  }

  Widget _buildContractInfo() {
    return Container(
      padding: EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(Icons.description_outlined, "Thông tin cơ bản"),
          Divider(height: 16, color: Colors.black12),
          _infoRow("Số hợp đồng:", "HD001-2024"),
          _infoRow("Phòng:", "A401"),
          _infoRow("Người thuê:", "Nguyễn Văn An", isBold: true),
          _infoRow("Số điện thoại:", "0912345678"),
          Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Text("Trạng thái: ", style: TextStyle(color: Colors.black54)),
                Chip(
                  label: Text("Đang hiệu lực", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)),
                  backgroundColor: Colors.green.shade600,
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          _contractDuration(),
          SizedBox(height: 20),
          _monthlyCost(),
          SizedBox(height: 20),
          _depositSection(),
        ],
      ),
    );
  }

  Widget _contractDuration() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.calendar_month, color: primaryColor, size: 20),
              SizedBox(width: 6),
              Text("Thời hạn hợp đồng", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: primaryColor)),
            ],
          ),
          Divider(color: Colors.black12, height: 16),
          _durationRow("Ngày ký:", "2024-01-10"),
          _durationRow("Bắt đầu:", "2024-01-15"),
          _durationRow("Kết thúc:", "2025-01-14"),
          _durationRow("Gia hạn tiếp theo:", "2025-01-14", highlight: highlightColor),
        ],
      ),
    );
  }

  Widget _monthlyCost() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.payments_outlined, color: Colors.green.shade700, size: 20),
              SizedBox(width: 6),
              Text("Chi phí hàng tháng", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green.shade700, fontSize: 16)),
            ],
          ),
          Divider(color: Colors.black12, height: 16),
          _infoRow("Tiền thuê phòng:", "2.500.000 ₫", color: Colors.black87, isBold: true),
          SizedBox(height: 10),
          _serviceSection(),
        ],
      ),
    );
  }

  Widget _serviceSection() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Dịch vụ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87)),
          Divider(height: 10, color: Colors.black12),
          _infoRow("Điện:", "3.500đ × 120kWh = 420.000đ", isSmall: true),
          _infoRow("Nước:", "60.000đ / người × 1 = 60.000đ", isSmall: true),
          _infoRow("Internet:", "50.000đ / phòng", isSmall: true),
          _infoRow("Rác:", "40.000đ / phòng", isSmall: true),
          _infoRow("Gửi xe:", "100.000đ / xe × 1 = 100.000đ", isSmall: true),
          Divider(height: 20),
          _infoRow("Tổng dịch vụ:", "670.000đ", color: primaryColor, isBold: true),
          _infoRow("TỔNG CỘNG / THÁNG:", "3.170.000đ",
              color: primaryColor, isLarge: true),
        ],
      ),
    );
  }

  Widget _depositSection() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: highlightColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.account_balance_wallet_outlined, color: highlightColor, size: 20),
              SizedBox(width: 6),
              Text("Tiền cọc", style: TextStyle(fontWeight: FontWeight.bold, color: highlightColor, fontSize: 16)),
            ],
          ),
         Divider(height: 16, color: Colors.black12),
          _infoRow("Số tiền:", "2.500.000 ₫", color: highlightColor, isBold: true),
          SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.lightbulb_outline, size: 14, color: Colors.black54),
              SizedBox(width: 4),
              Text("Tiền cọc = 1 tháng tiền thuê", style: TextStyle(fontSize: 12, color: Colors.black54)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImportantNotice() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 250, 235), 
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber.shade200, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning_amber_outlined, color: Colors.orange.shade700),
              SizedBox(width: 8),
              Text("Lưu ý quan trọng", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange.shade700, fontSize: 16)),
            ],
          ),
          Divider(height: 15, color: Colors.amberAccent), 
          _notePoint("Hợp đồng sẽ hết hạn vào 2025-01-14"),
          _notePoint("Liên hệ quản lý trước 30 ngày để gia hạn"),
          _notePoint("Tiền cọc được hoàn trả khi kết thúc hợp đồng (trừ phát sinh)"),
          _notePoint("Mọi thay đổi cần có văn bản xác nhận"),
        ],
      ),
    );
  }

  Widget _notePoint(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("• ", style: TextStyle(color: Colors.black87)),
          Expanded(child: Text(text, style: TextStyle(fontSize: 14, height: 1.4, color: Colors.black87))),
        ],
      ),
    );
  }

  static Widget _infoRow(String label, String value,
      {Color? color, bool isBold = false, bool isSmall = false, bool isLarge = false}) {
    double fontSize = isSmall ? 14 : (isLarge ? 17 : 16);
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 140, child: Text(label, style: TextStyle(color: Colors.black54, fontSize: fontSize))),
          Expanded(
            child: Text(value, style: TextStyle(color: color ?? Colors.black87, fontWeight: isBold ? FontWeight.bold : FontWeight.normal, fontSize: fontSize)),
          ),
        ],
      ),
    );
  }

  static Widget _durationRow(String label, String value, {Color? highlight}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(width: 140, child: Text(label, style: TextStyle(color: Colors.grey.shade700, fontSize: 15))),
          Text(value,
           style: TextStyle(color: highlight ?? Colors.black87, fontWeight: highlight != null ? FontWeight.bold : FontWeight.normal, fontSize: 15)),
        ],
      ),
    );
  }

  Widget _sectionTitle(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, size: 20, color: primaryColor),
        SizedBox(width: 6),
        Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: primaryColor)),
      ],
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10, offset: Offset(0, 4)),
      ],
    );
  }
}