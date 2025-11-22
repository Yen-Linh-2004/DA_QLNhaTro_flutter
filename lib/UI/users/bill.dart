import 'package:flutter/material.dart';
import 'package:flutter_application/UI/shared/buildCard.dart';

class BillPage extends StatelessWidget {
  const BillPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1f4f9),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------------- HEADER ----------------
            Text('Hóa Đơn Tháng 10, 2025', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            Text('Ngày lập: 1/11/2025'),
            SizedBox(height: 4),
            Text('Hạn thanh toán: 5/11/2025'),

            SizedBox(height: 22),

            // ---------------- ITEMS -----------------
            _buildBillItems(),

            SizedBox(height: 25),
            Divider(),
            SizedBox(height: 12),

            _buildRow("Tạm tính", "3,207,500 đ", isBold: true),
            SizedBox(height: 10),
            _buildRow("Công nợ kỳ trước", "0 đ"),
            SizedBox(height: 10),
            _buildRow("Giảm trừ", "0 đ"),
            SizedBox(height: 10),
            _buildRow("Phí trễ hạn", "0 đ"),

            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 10),

            _buildRow("Cần thanh toán", "3,207,500 đ", isBold: true),

            SizedBox(height: 30),

            // ---------------- BUTTONS ----------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildActionBtn(Icons.payment, "Thanh toán ngay", Colors.blue, () {}),
                SizedBox(width: 15),
                buildActionBtn(Icons.picture_as_pdf, "Tải PDF", Colors.green, () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ===================== BILL ITEMS LIST ======================
  Widget _buildBillItems() {
    final items = [
      {"title": "Tiền thuê phòng", "unit": "Tháng", "price": 2600000},
      {"title": "Điện", "unit": "kWh", "price": 297500},
      {"title": "Nước", "unit": "Người", "price": 120000},
      {"title": "Internet", "unit": "Phòng", "price": 50000},
      {"title": "Rác", "unit": "Phòng", "price": 40000},
      {"title": "Gửi xe", "unit": "Phòng", "price": 100000},
    ];

    return Column(
      children: items.map((e) {
        return _billItem(
          icon: Icons.receipt_long,
          title: e["title"].toString(),
          unit: e["unit"].toString(),
          price: e["price"] as int,
        );
      }).toList(),
    );
  }

  // ===================== BILL ITEM CARD ======================
  Widget _billItem({
    required IconData icon,
    required String title,
    required String unit,
    required int price,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 26),
          SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                Text(unit, style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),

          Text(
            "${price.toString()} đ",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // ===================== ROW TEXT ======================
  Widget _buildRow(String left, String right, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(left,
            style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        Text(right,
            style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
      ],
    );
  }
}
